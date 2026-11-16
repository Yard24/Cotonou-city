extends RefCounted
# Test automatique de la circulation : réseau de voies, feux tricolores, priorités, rond-point,
# dépassements, embouteillages, klaxon, accidents, densité selon l'heure, apparition et
# disparition hors champ. Appelé par selftest.gd, tout dans la même image : le test fait
# lui-même avancer la circulation. À la fin, tout est remis comme au lancement du jeu.

const CarFx := preload("res://scripts/car_fx.gd")
const DT := 1.0 / 60.0
const LOIN := Vector3(0, 0, -240)   # le joueur, à pied, loin de toute route
var err := ""
var C          # circulation.gd
var M

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	M = m
	C = m.trafic.circ
	for k in ["up", "down", "left", "right", "brake"]:
		Input.action_release(k)
	if m.cur_car != null:
		m.cur_car.speed = 0.0
		m.toggle_car()
	var pl = m.player
	var p0: Vector3 = pl.global_position
	var h0: float = pl.heading
	for t in [_reseau, _feux, _priorites, _rond_point, _depassement, _klaxon, _accidents, _densite, _hors_champ, _bouchons, _fluidite]:
		C.remet_en_place(m)
		C.densite_auto = false
		_joueur(LOIN, PI)
		t.call()
		if err != "":
			break
	C.densite_auto = true
	C.remet_en_place(m)
	pl.global_position = p0
	pl.heading = h0
	pl.rotation.y = h0
	m._camera(0.0, true)
	return err

# ---------------- outils ----------------
func _joueur(p: Vector3, h: float) -> void:
	M.player.global_position = p
	M.player.heading = h
	M.player.rotation.y = h
	M._camera(0.0, true)

func _auto(nom: String, n := 0):
	for a in C.route_nommee(nom).veh:
		if not a.moto:
			if n == 0:
				return a
			n -= 1
	return null

func _moto(nom: String):
	for a in C.route_nommee(nom).veh:
		if a.moto:
			return a
	return null

# Seuls ces véhicules circulent ; les autres restent figés où ils sont.
func _seuls(liste: Array) -> void:
	M.traffic.assign(liste)
	for a in liste:
		C.infos[a.get_instance_id()] = C._neuf(C.infos[a.get_instance_id()].r, true)
		a.visible = true

func _met(a, d: float, v := -1.0) -> void:
	a.dist = d
	a.speed = a.vmax if v < 0.0 else v
	a.side = 0.0
	a.side_want = 0.0
	a.place_on_path()

func _sim(secs: float, chaque := Callable()) -> void:
	for k in int(round(secs * 60.0)):
		M.trafic.step(M, DT, LOIN)
		if chaque.is_valid():
			chaque.call(k * DT)

# Distance, sur le trajet, de la ligne d'arrêt avant le carrefour de centre c.
func _ligne(a, c: Vector2) -> float:
	var T: Dictionary = C.traversee(C.info(a).r, c)
	return T.d0 - (C.RECUL_ROND if C.carrefours[T.j].type == C.ROND else C.RECUL)

# Chemin parcouru depuis d0, sur un trajet fermé.
func _fait(a, d0: float) -> float:
	return a.dist - d0

# Premier instant du cycle où le feu de cet axe prend cette couleur.
func _quand(j: Dictionary, axe: int, etat: int) -> float:
	for k in int(C.CYCLE_S * 10.0):
		var tt := k * 0.1
		if C.etat_feu(j, axe, tt) == etat and C.etat_feu(j, axe, fposmod(tt - 0.1, C.CYCLE_S)) != etat:
			return tt
	return 0.0

func _sur_route(p: Vector2) -> bool:
	if p.length() < 30.0:
		return true
	for x in [-120.0, 0.0, 120.0]:
		if abs(p.x - x) <= 7.0 and p.y >= -167.0 and p.y <= 200.0:
			return true
	for z in [-160.0, -120.0, 0.0, 120.0]:
		if abs(p.y - z) <= 7.0 and abs(p.x) <= 210.0:
			return true
	return false

# ---------------- réseau de voies ----------------
func _reseau() -> void:
	var total := 0.0
	var vus := {}
	var noms := []
	for r in C.routes:
		if r.n_jour <= 0:
			continue
		noms.append(r.nom)
		var v = r.v
		total += v.path_len
		var d := 0.0
		while d < v.path_len:
			var q: Vector3 = v.pos_on(d)
			var p := Vector2(q.x, q.y)
			if not _sur_route(p):
				err = "réseau : le trajet %s sort de la chaussée en %.0f ; %.0f" % [r.nom, p.x, p.y]
				return
			# en ligne droite, hors carrefour : la voie est à droite de l'axe de sa route
			if C.zone(p) < 0 and abs(p.x) < 190.0:
				var ecart := 99.0
				if abs(sin(q.z)) > 0.999:
					for zr in [-160.0, -120.0, 0.0, 120.0]:
						if abs(p.y - zr) < 7.0:
							ecart = (p.y - zr) * sin(q.z)
				elif abs(cos(q.z)) > 0.999:
					for xr in [-120.0, 0.0, 120.0]:
						if abs(p.x - xr) < 7.0:
							ecart = -(p.x - xr) * cos(q.z)
				if ecart != 99.0 and (ecart < 2.0 or ecart > 5.0):
					err = "réseau : le trajet %s ne roule pas à droite en %.0f ; %.0f (%.1f m de l'axe)" % [r.nom, p.x, p.y, ecart]
					return
			d += 2.0
		var tr: Array = C.traversees(r)
		if tr.is_empty():
			err = "réseau : le trajet %s ne passe par aucun carrefour" % r.nom
			return
		for T in tr:
			vus[T.j] = true
	if C.routes.size() < 9 or noms.size() != 9 or C.carrefours.size() != 12 or vus.size() != 12:
		err = "réseau : %d trajets, %d carrefours dont %d traversés (attendu 9, 12, 12)" % [noms.size(), C.carrefours.size(), vus.size()]
		return
	var types := [0, 0, 0]
	for j in C.carrefours:
		types[j.type] += 1
	if types != [4, 7, 1]:
		err = "réseau : %s carrefours à feux, à priorité, rond-point (attendu 4, 7, 1)" % [types]
		return
	# un véhicule seul suit son trajet sans quitter la chaussée
	var a = _auto("grand_tour")
	_seuls([a])
	var d0: float = a.dist
	var dehors := [false]
	_sim(10.0, func(_t): dehors[0] = dehors[0] or not _sur_route(Vector2(a.global_position.x, a.global_position.z)))
	if dehors[0] or _fait(a, d0) < 100.0:
		err = "réseau : un véhicule seul n'avance pas sur son trajet (%.0f m en 10 s)" % _fait(a, d0)
		return
	print("réseau de voies : 9 trajets fermés, %.1f km de voies, tous sur la chaussée et à droite de l'axe ; 12 carrefours tous traversés (4 à feux, 7 à priorité, 1 rond-point)" % (total / 1000.0))

# ---------------- feux tricolores ----------------
func _feux() -> void:
	# cycle : jamais les deux axes ouverts ensemble, vert assez long, orange de 3 s
	var nf := 0
	for j in C.carrefours:
		if j.type != C.FEUX:
			continue
		nf += 1
		if j.lampes[0].size() != 2 or j.lampes[1].size() != 2:
			err = "feux : il manque des poteaux au carrefour %s" % j.c
			return
		for axe in 2:
			var durees := [0.0, 0.0, 0.0]
			for k in int(C.CYCLE_S * 10.0):
				var e: int = C.etat_feu(j, axe, k * 0.1)
				durees[e] += 0.1
				if axe == 0 and e != C.ROUGE and C.etat_feu(j, 1, k * 0.1) != C.ROUGE:
					err = "feux : les deux axes sont ouverts en même temps"
					return
				var suivant: int = C.etat_feu(j, axe, fposmod(k * 0.1 + 0.1, C.CYCLE_S))
				if suivant != e and suivant != (e + 1) % 3:
					err = "feux : les couleurs ne se suivent pas dans l'ordre vert, orange, rouge"
					return
			if abs(durees[C.VERT] - C.VERT_S) > 0.2 or abs(durees[C.ORANGE] - 3.0) > 0.2 or durees[C.ROUGE] < durees[C.VERT] + 6.0:
				err = "feux : durées %s" % [durees]
				return
	if nf != 4:
		err = "feux : %d carrefours à feux (attendu 4)" % nf
		return
	var c := Vector2(120, -120)
	var j: Dictionary = C.carrefours[C.carrefour_en(c)]
	# lampes : vert pour un axe, rouge pour l'autre
	C.t = _quand(j, 0, C.VERT) + 1.0
	C._feux_maj(M)
	for trio in j.lampes[0]:
		if trio[2].material_override != CarFx.lum_mat(Color(C.LAMPES[C.VERT][0])) or trio[0].material_override == CarFx.lum_mat(Color(C.LAMPES[C.ROUGE][0])):
			err = "feux : la lampe verte n'est pas allumée"
			return
	for trio in j.lampes[1]:
		if trio[0].material_override != CarFx.lum_mat(Color(C.LAMPES[C.ROUGE][0])) or trio[2].material_override == CarFx.lum_mat(Color(C.LAMPES[C.VERT][0])):
			err = "feux : la lampe rouge de l'autre axe n'est pas allumée"
			return
	# rouge : la voiture freine et s'arrête avant la ligne, la suivante reste derrière sans doubler
	var a = _auto("boucle_marina", 0)
	var b = _auto("boucle_marina", 1)
	_seuls([a, b])
	var la := _ligne(a, c)
	_met(a, la - 40.0)
	_met(b, la - 58.0)
	C.t = _quand(j, 0, C.ROUGE)
	var frein := [0.0, a.speed]
	_sim(9.0, func(_t):
		if frein[1] > 3.0:   # l'approche ; le dernier mètre, au pas, ne compte pas
			frein[0] = max(frein[0], (frein[1] - a.speed) / DT)
		frein[1] = a.speed)
	var reste: float = la - a.dist
	var ecart: float = a.dist - b.dist
	if a.speed > 0.05 or reste < -0.8 or reste > 1.0 or not C.attend(a):
		err = "feux : la voiture ne s'arrête pas au rouge (%.1f m avant la ligne, %.1f m/s)" % [reste, a.speed]
		return
	if frein[0] > 12.0:
		err = "feux : freinage trop brutal avant le feu (%.0f m/s²)" % frein[0]
		return
	if b.speed > 0.05 or ecart < 5.0 or ecart > 9.0 or b.side != 0.0:
		err = "feux : la voiture suivante ne reste pas dans la file (%.1f m derrière, écart %.1f)" % [ecart, b.side]
		return
	# vert : elles repartent
	C.t = _quand(j, 0, C.VERT)
	_sim(6.0)
	if a.dist < la + 12.0 or b.dist < la - 6.0 or a.speed < 8.0:
		err = "feux : la voiture ne repart pas au vert (%.1f m après la ligne)" % (a.dist - la)
		return
	# orange : on passe si on est trop près pour s'arrêter, sinon on s'arrête
	_seuls([a, b])
	j = C.carrefours[C.carrefour_en(Vector2(120, 0))]
	la = _ligne(a, Vector2(120, 0))
	_met(a, la - 2.0)
	_met(b, la - 30.0)
	C.t = _quand(j, 0, C.ORANGE)
	_sim(5.0)
	if a.dist < la + 20.0 or b.speed > 0.05 or b.dist > la + 0.8:
		err = "feux : à l'orange, la voiture proche est à %.1f m après la ligne, la voiture éloignée à %.1f m/s" % [a.dist - la, b.speed]
		return
	print("feux tricolores : 4 carrefours, 4 poteaux chacun, vert %d s, orange 3 s, jamais deux axes ouverts ; au rouge la voiture s'arrête %.1f m avant la ligne (freinage %.0f m/s² au plus), la suivante attend %.1f m derrière ; elles repartent au vert ; à l'orange on passe à 2 m de la ligne, on s'arrête à 30 m" % [C.VERT_S, reste, frein[0], ecart])

# ---------------- priorités aux carrefours ----------------
# Deux véhicules arrivent ensemble : renvoie [vitesse la plus basse du premier, du second avant
# d'entrer, distance la plus courte entre eux, le second est-il entré pendant que le premier traversait].
func _duel(prio, cede, c: Vector2, avance: float, secs: float) -> Array:
	_seuls([prio, cede])
	var lp := _ligne(prio, c)
	var lc := _ligne(cede, c)
	_met(prio, lp - avance)
	_met(cede, lc - avance)
	var Tp: Dictionary = C.traversee(C.info(prio).r, c)
	var res := [99.0, 99.0, 99.0, false]
	_sim(secs, func(_t):
		var dans: bool = prio.dist > lp + 0.8 and prio.dist < Tp.d0 + Tp.lg
		if prio.dist < Tp.d0 + Tp.lg:
			res[0] = min(res[0], prio.speed)
		if cede.dist < lc + 0.8:
			res[1] = min(res[1], cede.speed)
		elif dans:
			res[3] = true
		res[2] = min(res[2], prio.global_position.distance_to(cede.global_position)))
	if prio.dist < Tp.d0 + Tp.lg or cede.dist < lc + 10.0:
		res[3] = true   # l'un des deux n'a pas traversé
	return res

func _priorites() -> void:
	# priorité à droite : la voiture de la boucle va tout droit, celle du quartier arrive par sa droite
	var c := Vector2(0, 120)
	var r1 := _duel(_auto("quartier_b"), _auto("boucle_marina"), c, 26.0, 14.0)
	if r1[0] < 9.0 or r1[1] > 0.5 or r1[2] < 3.5 or r1[3]:
		err = "priorité à droite : prioritaire à %.1f m/s au plus bas, l'autre à %.1f, %.1f m entre eux, mal passé %s" % r1
		return
	# même règle, rôles inversés : au bout du boulevard de la Marina, c'est la boucle qui arrive par la droite
	var r2 := _duel(_auto("boucle_marina"), _auto("marina"), Vector2(-120, -160), 26.0, 14.0)
	if r2[0] < 9.0 or r2[1] > 0.5 or r2[2] < 3.5 or r2[3]:
		err = "priorité à droite (Marina) : prioritaire à %.1f m/s au plus bas, l'autre à %.1f, %.1f m entre eux, mal passé %s" % r2
		return
	# face à face au feu vert : celui qui tourne à gauche laisse passer celui qui va tout droit
	c = Vector2(120, -120)
	var j: Dictionary = C.carrefours[C.carrefour_en(c)]
	C.t = _quand(j, 0, C.VERT)
	var r3 := _duel(_auto("boucle_marina"), _auto("grand_tour"), c, 26.0, 12.0)
	if r3[0] < 9.0 or r3[1] > 0.5 or r3[2] < 3.5 or r3[3]:
		err = "tourne-à-gauche : celui qui va tout droit à %.1f m/s au plus bas, l'autre à %.1f, %.1f m entre eux, mal passé %s" % r3
		return
	# trajets qui ne se coupent pas : personne ne ralentit
	var r4 := _duel(_auto("grand_tour"), _auto("quartier_b"), Vector2(0, 120), 26.0, 8.0)
	if r4[0] < 13.0 or r4[1] < 11.0:
		err = "priorité : deux véhicules qui ne se coupent pas ralentissent (%.1f et %.1f m/s)" % [r4[0], r4[1]]
		return
	# quatre voitures bloquées ensemble : la patience débloque le carrefour
	var a = _auto("boucle_marina")
	var b = _auto("quartier_b")
	_seuls([a, b])
	_met(a, _ligne(a, Vector2(0, 120)) - 0.3, 0.0)
	_met(b, _ligne(b, Vector2(0, 120)) - 0.3, 0.0)
	var d0: float = a.dist
	_sim(12.0)
	if a.dist < d0 + 20.0 or b.dist < 20.0:
		err = "priorité : deux voitures arrêtées face au carrefour ne repartent pas"
		return
	print("priorités : priorité à droite respectée (le prioritaire passe à %.0f km/h au moins, l'autre s'arrête, %.1f m entre eux au plus près) ; au vert, celui qui tourne à gauche attend celui d'en face ; sans croisement, personne ne ralentit" % [r1[0] * 3.6, min(r1[2], r2[2])])

# ---------------- rond-point ----------------
func _rond_point() -> void:
	var o := Vector2.ZERO
	var n := 0
	for r in C.routes:
		if r.n_jour <= 0:
			continue
		for T in C.traversees(r):
			if C.carrefours[T.j].type != C.ROND:
				continue
			n += 1
			for k in range(1, T.pts.size()):
				var p: Vector2 = T.pts[k]
				var d: Vector2 = p - T.pts[k - 1]
				# sur l'anneau : rayon de 21 m, terre-plein toujours à gauche
				if p.length() < 21.6 and (p.length() < 20.4 or p.x * d.y - p.y * d.x > 0.0):
					err = "rond-point : le trajet %s tourne dans le mauvais sens ou coupe le terre-plein" % r.nom
					return
	if n != 6:
		err = "rond-point : %d trajets passent par la place (attendu 6)" % n
		return
	# priorité à l'anneau : celui qui entre attend que celui de l'anneau soit passé
	var a = _auto("quartier_c")
	var b = _auto("place_a")
	_seuls([a, b])
	var Ta: Dictionary = C.traversee(C.info(a).r, o)
	var Tb: Dictionary = C.traversee(C.info(b).r, o)
	var dp: float = C._passe(Tb, Ta)
	if dp < 0.0:
		err = "rond-point : le trajet de la place ne passe pas devant l'entrée testée"
		return
	var la := _ligne(a, o)
	_met(a, la - 14.0)
	_met(b, Tb.d0 + dp - 18.0)
	var res := [99.0, 99.0, false, 99.0]
	_sim(10.0, func(_t):
		res[0] = min(res[0], b.speed)
		if a.dist < la + 0.8:
			res[1] = min(res[1], a.speed)
		elif b.dist < Tb.d0 + dp + 3.0:
			res[2] = true   # entré avant que l'autre soit passé
		res[3] = min(res[3], a.global_position.distance_to(b.global_position)))
	if res[0] < 10.0 or res[1] > 6.0 or res[2] or res[3] < 3.5 or a.dist < Ta.d0 + 10.0:
		err = "rond-point : véhicule de l'anneau à %.1f m/s au plus bas, entrant à %.1f, entré trop tôt %s, %.1f m entre eux" % res
		return
	# anneau vide : on entre sans s'arrêter
	_seuls([a])
	_met(a, la - 30.0)
	var vmin := [99.0]
	_sim(5.0, func(_t): vmin[0] = min(vmin[0], a.speed))
	if vmin[0] < 11.0 or a.dist < Ta.d0 + 10.0:
		err = "rond-point : anneau vide, la voiture ralentit quand même (%.1f m/s)" % vmin[0]
		return
	print("rond-point : 6 trajets tournent dans le même sens autour de la place, terre-plein à gauche ; priorité à l'anneau : la voiture qui entre freine et laisse passer celle de l'anneau, qui garde ses %.0f km/h, %.1f m entre elles au plus près ; anneau vide : on entre sans s'arrêter" % [res[0] * 3.6, res[3]])

# ---------------- dépassements ----------------
func _depassement() -> void:
	# une voiture laissée sur la voie, sur la boucle (x = 116,5, cap vers +z)
	var obst = M.cars[1]
	var p0: Vector3 = obst.global_position
	var h0: float = obst.heading
	obst.global_position = Vector3(116.5, 0, -60)
	obst.heading = 0.0
	obst.rotation.y = 0.0
	obst.speed = 0.0
	var a = _auto("boucle_marina")
	var en_face = _auto("grand_tour")
	_seuls([a])
	_met(a, 50.0)
	var res := [-1.0, -1.0, 99.0, 0.0, 99.0]   # arrêt, début du déport, écart au plus près, vitesse max déportée, distance min
	_sim(20.0, func(t):
		var dz: float = obst.global_position.z - a.global_position.z
		if res[0] < 0.0 and a.speed < 0.3:
			res[0] = t
		if res[1] < 0.0 and a.side > 0.3:
			res[1] = t
		if abs(dz) < 4.4:
			res[2] = min(res[2], a.global_position.x - 116.5)
		if C.info(a).dep != null:
			res[3] = max(res[3], a.speed)
		res[4] = min(res[4], a.global_position.distance_to(obst.global_position)))
	if res[0] < 0.0 or res[1] < res[0] + 2.0 or res[1] > res[0] + 4.0:
		err = "dépassement : arrêt à %.1f s, déport à %.1f s (attendu 2,5 s d'attente)" % [res[0], res[1]]
	elif res[2] < 2.2 or res[4] < 2.2 or res[3] > C.V_DEPASSE + 0.5:
		err = "dépassement : passe à %.2f m de l'obstacle, à %.1f m/s" % [res[2], res[3]]
	elif a.dist < 96.5 + 15.0 or abs(a.side) > 0.05 or a.speed < 10.0:
		err = "dépassement : la voiture ne se rabat pas ou ne repart pas (%.0f m après, écart %.2f, %.1f m/s)" % [a.dist - 96.5, a.side, a.speed]
	if err == "":
		# quelqu'un arrive en face : elle attend qu'il soit passé
		var j: Dictionary = C.carrefours[C.carrefour_en(Vector2(120, 0))]
		_seuls([a, en_face])
		C.t = _quand(j, 0, C.VERT)
		_met(a, 50.0)
		_met(en_face, 247.0 + 84.5)   # sur x = 123,5, à z = 39, cap vers -z
		var r2 := [false, -1.0]
		_sim(22.0, func(t):
			var lon: float = en_face.global_position.z - a.global_position.z
			if a.side_want > 0.0 and lon > 0.0 and lon < 40.0:
				r2[0] = true
			if r2[1] < 0.0 and a.side > 0.3:
				r2[1] = t)
		if abs(en_face.global_position.x - 123.5) > 0.1 and en_face.dist < 247.0 + 150.0:
			err = "dépassement : la voiture d'en face n'est pas sur sa voie"
		elif r2[0] or r2[1] < res[1] + 1.0 or a.dist < 96.5 + 15.0:
			err = "dépassement : la voiture déboîte alors qu'on arrive en face (déport à %.1f s, sans personne %.1f s)" % [r2[1], res[1]]
		else:
			print("dépassements : derrière une voiture laissée sur la voie, la voiture s'arrête, attend %.1f s, passe à %.1f m sur la gauche à %.0f km/h au plus, puis se rabat ; si quelqu'un arrive en face, elle attend (%.1f s au lieu de %.1f)" % [res[1] - res[0], res[2], res[3] * 3.6, r2[1], res[1]])
	obst.global_position = p0
	obst.heading = h0
	obst.rotation.y = h0

# ---------------- réactions au klaxon ----------------
func _klaxon() -> void:
	var car = M.cars[0]
	var p0: Vector3 = car.global_position
	var h0: float = car.heading
	var n0: int = car.fx.honks
	var a = _auto("boucle_marina")
	var mo = _moto("boucle_marina")
	var derriere = _auto("boucle_marina", 1)
	var en_face = _auto("grand_tour")
	_seuls([a, mo, derriere, en_face])
	C.t = _quand(C.carrefours[C.carrefour_en(Vector2(120, 0))], 0, C.VERT)   # feu vert devant eux
	_met(a, 79.0)
	_met(mo, 65.0)
	_met(derriere, 30.0)
	_met(en_face, 247.0 + 195.0)   # x = 123,5, z = -71,5, cap vers -z
	car.global_position = Vector3(116.5, 0, -100)
	car.heading = 0.0
	car.rotation.y = 0.0
	car.speed = 13.0
	M.cur_car = car
	_sim(0.1)
	if a.side != 0.0 or C.info(a).serre > 0.0:
		err = "klaxon : la voiture se serre sans coup de klaxon"
	car.fx.honk(0.2)   # le joueur klaxonne
	_sim(1.2)
	var v1: float = a.speed
	var s1: float = a.side
	var sm: float = mo.side
	if err == "" and (s1 > -1.2 or v1 > a.vmax * 0.6 + 0.5 or sm > -0.8 or derriere.side != 0.0 or en_face.side != 0.0 or C.info(derriere).serre > 0.0 or C.info(en_face).serre > 0.0):
		err = "klaxon : voiture devant écart %.2f à %.1f m/s, moto %.2f, derrière %.2f, en face %.2f" % [s1, v1, sm, derriere.side, en_face.side]
	_sim(7.0)
	if err == "" and (abs(a.side) > 0.05 or a.speed < 11.0 or abs(mo.side) > 0.05):
		err = "klaxon : la voiture ne reprend pas sa place après 5 s (écart %.2f, %.1f m/s)" % [a.side, a.speed]
	# arrêtée au feu rouge : elle ne bouge pas
	if err == "":
		var c := Vector2(120, 0)
		var j: Dictionary = C.carrefours[C.carrefour_en(c)]
		_seuls([a])
		var la := _ligne(a, c)
		_met(a, la - 12.0)
		C.t = _quand(j, 0, C.ROUGE)
		_sim(4.0)
		car.global_position = a.global_position - Vector3(0, 0, 9)
		var n: int = C.klaxon(M, car)
		car.fx.honk(0.2)
		_sim(1.0)
		if n != 0 or a.side != 0.0 or a.speed > 0.05 or a.dist > la + 0.8:
			err = "klaxon : une voiture arrêtée au feu rouge réagit (%d, écart %.2f)" % [n, a.side]
	M.cur_car = null
	car.fx.honks = n0
	car.global_position = p0
	car.heading = h0
	car.rotation.y = h0
	car.speed = 0.0
	if err == "":
		print("réactions au klaxon : la voiture devant se serre de %.1f m à droite et ralentit à %.0f km/h, la moto de %.1f m, pendant 5 s ; ni celle de derrière, ni celle d'en face, ni celle qui attend au feu rouge ne bougent" % [-s1, v1 * 3.6, -sm])

# ---------------- accidents ----------------
func _accidents() -> void:
	var a = _auto("boucle_marina")
	var b = _auto("boucle_marina", 1)
	# petit choc (le joueur la percute) : arrêt de 8 s, feux de détresse, puis elle repart
	_seuls([a])
	_met(a, 50.0)
	_sim(0.5)
	a.hit(12.0, false)
	var d0: float = a.dist
	var vu := [0, 0]
	_sim(7.0, func(_t): vu[1 if a.fx.ind[1][0].visible and a.fx.ind[-1][0].visible else 0] += 1)
	if a.damage < 15.0 or a.dist - d0 > 1.5 or a.speed > 0.05 or not C.accidente(a) or vu[0] < 100 or vu[1] < 100 or C.nb_accidents != 1:
		err = "accident : la voiture percutée ne s'arrête pas avec ses feux de détresse (dégâts %.0f, %.1f m, détresse %s)" % [a.damage, a.dist - d0, vu]
		return
	_sim(6.0)
	if C.accidente(a) or a.speed < 8.0 or a.fx.ind[1][0].visible and a.fx.ind[-1][0].visible:
		err = "accident : la voiture ne repart pas après le constat (%.1f m/s)" % a.speed
		return
	a.hit(3.0, false)
	_sim(0.2)
	if C.accidente(a):
		err = "accident : un simple frottement arrête la voiture"
		return
	# gros choc : 20 s d'arrêt ; la voiture qui suit attend puis la dépasse
	a.repair()
	_seuls([a, b])
	_met(a, 80.0)
	_met(b, 40.0)
	_sim(0.1)
	a.hit(26.0, false)
	_sim(15.0)
	if not C.accidente(a) or b.dist < a.dist + 8.0:
		err = "accident : la voiture suivante ne dépasse pas la voiture accidentée (%.0f m)" % (b.dist - a.dist)
		return
	_sim(8.0)
	if C.accidente(a) or a.speed < 5.0:
		err = "accident : après un gros choc la voiture ne repart pas au bout de 20 s"
		return
	# épave : elle ne repart plus
	a.repair()
	_seuls([a, b])
	_met(a, 80.0)
	_sim(0.1)
	a.hit(40.0, true)
	_sim(30.0)
	if not C.info(a).panne or a.speed > 0.05 or a.damage < C.PANNE:
		err = "accident : une épave repart (dégâts %.0f)" % a.damage
		return
	# deux véhicules de la circulation qui se rentrent dedans : accident pour les deux ; un contact lent : rien
	var n0: int = C.nb_accidents
	_met(b, a.dist - 4.3, 3.0)
	b.repair()
	_sim(0.05)
	var doux: bool = b.damage == 0.0 and not C.accidente(b)
	_met(b, a.dist - 4.0, 12.0)
	var avant: float = a.damage
	_sim(0.1)
	if not doux or b.damage < 5.0 or a.damage <= avant - 0.01 or not C.accidente(b) or b.speed > 0.05 or C.nb_accidents != n0 + 1:
		err = "accident entre deux véhicules : contact lent sans suite %s, dégâts du second %.0f, accidents comptés %d" % [doux, b.damage, C.nb_accidents - n0]
		return
	var db: float = b.damage
	a.repair()
	b.repair()
	print("accidents : voiture percutée (dégâts 20) arrêtée 8 s avec feux de détresse puis repart ; gros choc 20 s, la voiture suivante la dépasse ; à 80 de dégâts elle ne repart plus ; deux véhicules de la circulation qui se percutent à 43 km/h : accident pour les deux (dégâts %.0f) ; frottement : rien" % db)

# ---------------- densité selon l'heure ----------------
func _actifs() -> int:
	var n := 0
	for r in C.routes:
		if r.n_jour > 0:
			for a in r.veh:
				if C.infos[a.get_instance_id()].actif:
					n += 1
	return n

func _densite() -> void:
	var dn: float = C.densite(3.0)
	var dj: float = C.densite(12.0)
	var dp: float = C.densite(8.0)
	if dn != 0.3 or dj != 1.0 or dp != 1.5 or C.densite(18.5) != 1.5 or C.densite(23.0) != 0.3 or C.densite(6.0) <= dn or C.densite(6.0) >= dp or C.densite(21.0) >= dj:
		err = "densité : valeurs %.2f la nuit, %.2f le jour, %.2f en pointe" % [dn, dj, dp]
		return
	if C.pointe(8.0) != 1.0 or C.pointe(18.0) != 1.0 or C.pointe(12.0) != 0.0 or C.pointe(21.0) != 0.0 or C.pointe(6.9) <= 0.0 or C.pointe(6.9) >= 1.0:
		err = "densité : heures de pointe mal placées"
		return
	# l'horloge : une heure de jeu en deux minutes réelles
	C.heure = 23.5
	for k in 120:
		C.avant(M, 1.0)
	if abs(C.heure - 0.5) > 0.01:
		err = "densité : l'horloge n'avance pas d'une heure en 2 minutes (%.2f h)" % C.heure
		return
	# le joueur est loin : la circulation s'ajuste à l'heure
	var nb := []
	for h in [3.0, 12.0, 8.0, 12.0]:
		C.heure = h
		for k in 80:
			C._population(M)
		var voulu := 0
		for r in C.routes:
			if r.n_jour > 0:
				voulu += C.nombre_voulu(r, h)
		if _actifs() != voulu or M.traffic.size() != voulu:
			err = "densité : %d véhicules à %d h (attendu %d)" % [_actifs(), h, voulu]
			return
		nb.append(voulu)
	if nb[0] > 0.45 * nb[1] or nb[2] < 1.4 * nb[1] or nb[3] != nb[1]:
		err = "densité : %s véhicules la nuit, le jour, en pointe, le jour" % [nb]
		return
	print("densité selon l'heure : %d véhicules à 3 h, %d à midi, %d à 8 h, de nouveau %d à midi ; une heure de jeu = 2 minutes" % nb)

# ---------------- apparition et disparition hors champ ----------------
func _hors_champ() -> void:
	# le joueur regarde vers +z depuis le bord de la route x = 120
	_joueur(Vector3(110, 0, -60), 0.0)
	var loin: float = M.cam.far
	var hc := [C.hors_champ(M, Vector3(116.5, 0, 0)), C.hors_champ(M, Vector3(116.5, 0, -125)), C.hors_champ(M, Vector3(116.5, 0, -85)),
		C.hors_champ(M, Vector3(110, 0, -60 + loin)), C.hors_champ(M, Vector3(40, 0, -60))]
	if hc != [false, true, false, true, true]:
		err = "hors champ : devant %s, derrière %s, tout près derrière %s, au-delà de la brume %s, sur le côté %s" % hc
		return
	# la nuit tombe : seuls des véhicules que le joueur ne voit pas disparaissent
	C.heure = 3.0
	var visibles := []
	for a in M.traffic:
		if not C.hors_champ(M, a.global_position):
			visibles.append([a, a.global_position])
	var n0: int = M.traffic.size()
	for k in 80:
		C._population(M)
	for v in visibles:
		if not M.traffic.has(v[0]) or v[0].global_position != v[1] or not v[0].visible:
			err = "hors champ : un véhicule disparaît sous les yeux du joueur"
			return
	var n_nuit: int = M.traffic.size()
	if visibles.is_empty() or n_nuit >= n0 - 10:
		err = "hors champ : %d véhicules visibles, %d restants sur %d" % [visibles.size(), n_nuit, n0]
		return
	for r in C.routes:
		for a in r.veh:
			if not C.infos[a.get_instance_id()].actif and (a.visible or a.global_position.y > -100.0 or M.traffic.has(a)):
				err = "hors champ : un véhicule retiré reste visible"
				return
	# l'heure de pointe arrive : ils apparaissent hors de la vue, sur leur voie, avec de la place
	C.heure = 8.0
	var apparus := 0
	for k in 160:
		var avant: Array = M.traffic.duplicate()
		C._population(M)
		for a in M.traffic:
			if avant.has(a):
				continue
			apparus += 1
			var p: Vector3 = a.global_position
			if not C.hors_champ(M, p) or C.zone(Vector2(p.x, p.z)) >= 0 or not _sur_route(Vector2(p.x, p.z)) or not a.visible or a.speed < 1.0:
				err = "hors champ : un véhicule apparaît dans la vue du joueur ou hors de sa voie (%.0f ; %.0f)" % [p.x, p.z]
				return
			for o in M.traffic + M.cars:
				if o != a and o.global_position.distance_to(p) < C.ESPACE - 0.1:
					err = "hors champ : un véhicule apparaît à %.1f m d'un autre" % o.global_position.distance_to(p)
					return
	if apparus < 20 or M.traffic.size() < n0 + 10:
		err = "hors champ : %d véhicules apparus, %d en tout" % [apparus, M.traffic.size()]
		return
	# une épave reste tant que le joueur la voit, puis elle est enlevée et revient réparée
	var a = _auto("boucle_marina")
	var r: Dictionary = C.info(a).r
	C.heure = 12.0
	_met(a, 130.0)   # 33 m devant le joueur
	a.hit(40.0, true)
	C.avant(M, DT)
	for k in 20:
		C._population(M)
	var reste: bool = M.traffic.has(a) and C.info(a).panne
	_joueur(LOIN, PI)
	C._population(M)
	var partie: bool = not M.traffic.has(a) and not a.visible
	C.heure = 8.0
	for k in 80:
		C._population(M)
	if not reste or not partie or not M.traffic.has(a) or a.damage != 0.0 or C.accidente(a):
		err = "hors champ : épave visible gardée %s, enlevée ensuite %s, revenue réparée %s" % [reste, partie, M.traffic.has(a) and a.damage == 0.0]
		return
	# une voiture empruntée par le joueur sort de la circulation
	var k0: int = r.veh.find(a)
	var d_init: float = r.d_init[k0]
	var n_veh: int = r.veh.size()
	a.ai = false
	M.traffic.erase(a)
	C._population(M)
	var sortie: bool = r.veh.size() == n_veh - 1 and not C.infos.has(a.get_instance_id())
	a.ai = true
	r.veh.insert(k0, a)
	r.d_init.insert(k0, d_init)
	C.infos[a.get_instance_id()] = C._neuf(r, false)
	if not sortie:
		err = "hors champ : une voiture empruntée reste comptée dans la circulation"
		return
	print("apparition et disparition : %d véhicules en vue restent en place quand la nuit tombe, %d disparaissent ailleurs ; à l'heure de pointe %d apparaissent, tous hors de la vue, sur leur voie, à 14 m au moins des autres ; une épave attend que le joueur soit parti pour être enlevée, et revient réparée" % [visibles.size(), n0 - n_nuit, apparus])

# ---------------- embouteillages aux heures de pointe ----------------
# Fait rouler toute la circulation et mesure, sur les 70 m avant les grands carrefours :
# [vitesse moyenne des voitures, des motos, nombre moyen de voitures, vitesse des voitures ailleurs]
func _mesure(h: float, secs: float) -> Array:
	C.remet_en_place(M)
	C.heure = h
	for k in 120:
		C._population(M)
	var s := [0.0, 0, 0.0, 0, 0.0, 0]
	var n := int(secs * 60.0)
	for k in n:
		M.trafic.step(M, DT, LOIN)
		if k < 600 or k % 6 != 0:
			continue   # dix secondes pour que les files se forment
		for a in M.traffic:
			var i: Dictionary = C.info(a)
			var bouchon: bool = i.T != null and C.carrefours[i.T.j].type != C.PRIORITE and i.rel < 0.0 and i.rel > -C.BOUCHON_M
			var c: int = (2 if a.moto else 0) if bouchon else 4
			if c == 4 and a.moto:
				continue
			s[c] += a.speed
			s[c + 1] += 1
	return [s[0] / max(1, s[1]), s[2] / max(1, s[3]), s[1] / float((n - 600) / 6), s[4] / max(1, s[5])]

func _bouchons() -> void:
	var creux := _mesure(11.0, 40.0)
	var acc_creux: int = C.nb_accidents
	var plein := _mesure(8.0, 40.0)
	if C.nb_accidents != 0 or acc_creux != 0:
		err = "embouteillages : %d accident(s) dans la circulation livrée à elle-même" % (C.nb_accidents + acc_creux)
		return
	if plein[0] > 3.0 or creux[0] < 2.0 * plein[0] or plein[2] < 1.5 * creux[2] or plein[2] < 8.0:
		err = "embouteillages : avant les grands carrefours, %.1f m/s et %.1f voitures en pointe, %.1f m/s et %.1f voitures à 11 h" % [plein[0], plein[2], creux[0], creux[2]]
		return
	if plein[1] < 1.3 * plein[0]:
		err = "embouteillages : les motos n'avancent pas mieux que les voitures (%.1f contre %.1f m/s)" % [plein[1], plein[0]]
		return
	if plein[3] < 7.0:
		err = "embouteillages : la circulation est bloquée partout, pas seulement aux grands carrefours (%.1f m/s ailleurs)" % plein[3]
		return
	# hors des grands carrefours, pas de bouchon : une voiture seule garde sa vitesse à 8 h
	var a = _auto("grand_tour")
	_seuls([a])
	C.heure = 8.0
	_met(a, _ligne(a, Vector2(0, 120)) - 40.0)
	var vmin := [99.0]
	_sim(5.0, func(_t): vmin[0] = min(vmin[0], a.speed))
	if vmin[0] < 13.0:
		err = "embouteillages : bouchon à un petit carrefour (%.1f m/s)" % vmin[0]
		return
	print("embouteillages : à 8 h, avant les grands carrefours, les voitures roulent à %.0f km/h en moyenne (%.0f à 11 h) et y sont %.0f en moyenne (%.0f à 11 h) ; les motos passent à %.0f km/h ; ailleurs on roule à %.0f km/h ; aucun accident" % [plein[0] * 3.6, creux[0] * 3.6, plein[2], creux[2], plein[1] * 3.6, plein[3] * 3.6])

# ---------------- la circulation livrée à elle-même ----------------
func _fluidite() -> void:
	var d0 := {}
	var arret := {}
	var pire := 0.0
	for a in M.traffic:
		d0[a] = a.dist
		arret[a] = 0.0
	for k in 60 * 90:
		M.trafic.step(M, DT, LOIN)
		for a in M.traffic:
			arret[a] = arret[a] + DT if a.speed < 0.3 else 0.0
			pire = max(pire, arret[a])
	var moins := 9999.0
	for a in M.traffic:
		moins = min(moins, a.dist - d0[a])
		var p: Vector3 = a.global_position
		if not _sur_route(Vector2(p.x, p.z)):
			err = "fluidité : un véhicule a quitté la chaussée (%.0f ; %.0f)" % [p.x, p.z]
			return
	if C.nb_accidents != 0 or pire > 32.0 or moins < 250.0:
		err = "fluidité : en 90 s, %d accident(s), arrêt le plus long %.0f s, véhicule le plus lent %.0f m" % [C.nb_accidents, pire, moins]
		return
	print("circulation livrée à elle-même pendant 90 s : %d véhicules, aucun accident, arrêt le plus long %.0f s (feu rouge), au moins %.0f m parcourus par chacun" % [M.traffic.size(), pire, moins])
