extends RefCounted
# Test automatique de « monter et descendre des véhicules » (scripts/embarquement.gd) : sens des
# véhicules garés, portières fermées à clé, entrée côté conducteur et côté passager, animation
# des portières, place libre à la descente, saut en marche, emprunt d'un véhicule occupé.
# Appelé à la fin de selftest_moto_ville.gd, tout dans la même image ; quand il faut voir le jeu
# tourner (voiture qui attend, voiture lâchée en marche), le test fait avancer la boucle de main.gd.

const DT := 1.0 / 60.0
const EST := PI / 2
var err := ""
var faites: Array = []   # voitures posées pour le test, retirées à la fin

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	for t in [_gares, _verrou, _cotes, _portes, _place, _saut, _emprunt]:
		_reset(m)
		t.call(m)
		if err != "":
			break
	_reset(m)
	m.emb.anims.clear()
	m.emb.libres.clear()
	for v in faites:
		m.cars.erase(v)
		v.queue_free()
	return err

func _reset(m) -> void:
	_sortir(m)
	# les voitures des essais précédents sont rangées plus loin sur la plage
	for i in faites.size():
		_put(faites[i], 20.0 + 6.0 * i, -184, EST, 0.0)
	_put(m.moto_romaric, 0, -172, EST, 0.0)

# Le héros se retrouve à pied, en forme ; les véhicules ne bougent pas.
func _sortir(m) -> void:
	for a in ["up", "down", "left", "right", "brake"]:
		Input.action_release(a)
	if m.cur_car != null:
		m.cur_car.speed = 0.0
		m.emb.descendre(m, true)
	m.emb.attente = 0.0
	m.player.reset_pose()
	m.player.health = 100.0
	m.info_t = 0.0

func _put(c, x: float, z: float, h: float, v: float) -> void:
	c.global_position = Vector3(x, 0, z)
	c.heading = h
	c.rotation.y = h
	c.speed = v
	c.prev_speed = v
	c.prev_heading = h
	if c.moto:
		c.lean = 0.0
	c.pitch = 0.0

# Une voiture de plus, garée pour le test.
func _auto(m, x: float, z: float, h: float):
	var v = m.trafic.make(m, Color("3366aa"), false, false)
	_put(v, x, z, h, 0.0)
	m.cars.append(v)
	faites.append(v)
	return v

func _gauche(c) -> Vector3:
	return Vector3(cos(c.heading), 0, -sin(c.heading))

func _avant(c) -> Vector3:
	return Vector3(sin(c.heading), 0, cos(c.heading))

func _d(a: Vector3, b: Vector3) -> float:
	return Vector2(a.x - b.x, a.z - b.z).length()

# Le jeu tourne n images (la vraie boucle de main.gd).
func _boucle(m, n: int) -> void:
	for i in n:
		m._physics_process(DT)

# Le héros se place à côté du véhicule (k = 1 : à sa gauche, côté conducteur) et appuie sur E.
func _e_a_cote(m, c, k: int) -> void:
	m.player.teleport(c.global_position + _gauche(c) * (2.0 * k), c.heading)
	m.press_e()

# Aucun autre véhicule à moins de 9 m : E ne peut viser que celui-là.
func _isolee(m, t) -> bool:
	for o in m.cars + m.traffic:
		if o != t and _d(o.global_position, t.global_position) < 9.0:
			return false
	return m.emb.porte_libre(m, t, 1)

# ---------------- véhicules garés dans le sens de la circulation ----------------
# On roule à droite : un véhicule garé au bord d'une route est tourné comme la voie qu'il longe.
func _cap_attendu(m, x: float, z: float) -> float:
	var best := 999.0
	var cap := 0.0
	for s in m.road_segs:
		var a: Vector2 = s[0]
		var b: Vector2 = s[1]
		if a.x == b.x and z >= min(a.y, b.y) and z <= max(a.y, b.y) and abs(x - a.x) < abs(best):
			best = x - a.x
			cap = PI if best > 0.0 else 0.0            # à l'est de l'axe on roule vers -z
		elif a.y == b.y and x >= min(a.x, b.x) and x <= max(a.x, b.x) and abs(z - a.y) < abs(best):
			best = z - a.y
			cap = PI / 2 if best > 0.0 else -PI / 2    # au sud de l'axe (+z) on roule vers +x
	return cap

func _gares(m) -> void:
	var n := 0
	for p in m.PARK + m.trafic.MOTOS:
		var cap: float = _cap_attendu(m, p[0], p[1])
		if abs(angle_difference(p[2], cap)) > 0.01:
			err = "véhicules garés : celui de (%.0f ; %.0f) est à contresens (cap %.2f, attendu %.2f)" % [p[0], p[1], p[2], cap]
			return
		n += 1
	# les voitures que personne n'a déplacées pendant le test sont bien posées comme dans la liste
	for i in [3, 4]:
		var c = m.cars[i]
		if c.moto or _d(c.global_position, Vector3(m.PARK[i][0], 0, m.PARK[i][1])) > 0.01 or abs(angle_difference(c.heading, m.PARK[i][2])) > 0.01 or abs(angle_difference(c.rotation.y, c.heading)) > 0.01:
			err = "véhicules garés : la voiture %d n'est pas posée comme prévu" % i
			return
	# la règle est la même que pour la circulation : véhicule à droite de l'axe, dans son sens de marche
	var red = m.PARK[0]
	if red[0] <= 0.0 or cos(red[2]) > -0.99:
		err = "véhicules garés : la voiture rouge du départ n'est pas tournée vers -z"
		return
	print("véhicules garés : %d voitures et motos, toutes dans le sens de la circulation (aucune à contresens)" % n)

# ---------------- portières fermées à clé ----------------
func _verrou(m) -> void:
	var e = m.emb
	var pl = m.player
	if not e.pret or not e.verrou(m.cars[3]) or not e.verrou(m.cars[4]) or e.verrou(m.cars[0]) or e.verrou(m.cars[1]) or e.verrou(m.cars[2]) or e.verrou(m.moto_romaric):
		err = "verrouillage : les voitures garées fermées à clé ne sont pas celles prévues"
		return
	var fermees := 0
	var ouvertes := 0
	var t_fermee = null
	for t in m.traffic:
		if e.verrou(t):
			if t.moto or t.col == Color(e.TAXI):
				err = "verrouillage : une moto ou un taxi de la circulation est verrouillé"
				return
			fermees += 1
			if t_fermee == null and _isolee(m, t):
				t_fermee = t
		elif not t.moto:
			ouvertes += 1
	if fermees < 2 or ouvertes < fermees or t_fermee == null:
		err = "verrouillage : %d voitures verrouillées et %d ouvertes dans la circulation" % [fermees, ouvertes]
		return
	# voiture garée fermée à clé : E ne fait pas monter, la poignée résiste, un message le dit
	var a = _auto(m, -130, -178, EST)
	a.set_meta("verrou", true)
	var r0: int = e.refus
	_e_a_cote(m, a, 1)
	if m.cur_car != null or e.raison != "fermee" or e.refus != r0 + 1 or not pl.visible or not ("clé" in m.info_text) or m.info_t <= 0.0:
		err = "verrouillage : on monte dans une voiture fermée à clé (« %s »)" % m.info_text
		return
	var top := 0.0
	for i in 12:
		e.step(m, DT)
		top = max(top, e.angle_porte(a, 1))
	for i in 30:
		e.step(m, DT)
	if top <= 0.01 or top > e.ANGLE_FERMEE + 0.001 or e.angle_porte(a, 1) != 0.0 or e.angle_porte(a, -1) != 0.0:
		err = "verrouillage : la portière fermée à clé s'ouvre (%.2f rad)" % top
		return
	# côté passager : fermée aussi
	_e_a_cote(m, a, -1)
	if m.cur_car != null or e.refus != r0 + 2:
		err = "verrouillage : la portière du passager n'est pas fermée à clé"
		return
	# la même voiture, déverrouillée : on monte
	a.set_meta("verrou", false)
	_e_a_cote(m, a, 1)
	if m.cur_car != a or e.raison != "" or e.refus != r0 + 2:
		err = "verrouillage : on ne monte pas dans la voiture déverrouillée"
		return
	_sortir(m)
	# voiture de la circulation arrêtée, conducteur qui a verrouillé : on ne l'emprunte pas
	var v0: float = t_fermee.speed
	var n_traf: int = m.traffic.size()
	var emp0: int = e.emprunts
	t_fermee.speed = 0.0
	_e_a_cote(m, t_fermee, 1)
	t_fermee.speed = v0
	if m.cur_car != null or e.raison != "fermee" or not t_fermee.ai or m.traffic.size() != n_traf or e.emprunts != emp0 or not ("conducteur" in m.info_text):
		err = "verrouillage : on emprunte une voiture dont le conducteur a verrouillé les portières"
		return
	# les motos n'ont pas de portière : jamais fermées
	m.moto_romaric.set_meta("verrou", true)
	var moto_fermee: bool = e.verrou(m.moto_romaric)
	m.moto_romaric.remove_meta("verrou")
	if moto_fermee:
		err = "verrouillage : une moto peut être fermée à clé"
		return
	print("verrouillage des portes : 2 voitures garées fermées à clé sur 5, %d voitures de la circulation sur %d verrouillées (aucun taxi, aucune moto) ; E : la poignée résiste (%.0f° au plus), message, on reste dehors ; déverrouillée, on monte" % [fermees, fermees + ouvertes, rad_to_deg(top)])

# ---------------- entrée côté conducteur et côté passager ----------------
# Combien d'images, accélérateur enfoncé, avant que la voiture bouge. Vérifie aussi quelle portière s'ouvre.
func _demarre(m, c, k: int) -> int:
	var e = m.emb
	var p0: Vector3 = c.global_position
	var n := 0
	var top := 0.0
	var autre := 0.0
	Input.action_press("up")
	while n < 200 and _d(c.global_position, p0) < 0.02:
		_boucle(m, 1)
		n += 1
		top = max(top, e.angle_porte(c, k))
		autre = max(autre, e.angle_porte(c, -k))
	Input.action_release("up")
	if top < e.ANGLE_PORTE * 0.95 or autre != 0.0:
		err = "entrée : la mauvaise portière s'ouvre (%.2f rad du bon côté, %.2f de l'autre)" % [top, autre]
	return n

func _cotes(m) -> void:
	var e = m.emb
	var pl = m.player
	var a = _auto(m, -130, -178, EST)
	# côté conducteur (à gauche) : on monte tout de suite, la voiture démarre après 0,7 s
	_e_a_cote(m, a, 1)
	if m.cur_car != a or pl.visible or e.cote_entree != 1 or not e.bloque(m) or abs(e.attente - e.T_ENTREE) > 0.001:
		err = "entrée côté conducteur : E à gauche de la voiture ne fait pas monter par la portière du conducteur"
		return
	var n1: int = _demarre(m, a, 1)
	if err != "":
		return
	if abs(n1 - int(e.T_ENTREE * 60.0)) > 6 or e.bloque(m):
		err = "entrée côté conducteur : la voiture démarre après %d images (attendu %d)" % [n1, int(e.T_ENTREE * 60.0)]
		return
	a.speed = 0.0
	m.press_e()
	if m.cur_car != null or e.cote(a, pl.global_position) != 1 or abs(_d(pl.global_position, a.global_position) - e.ECART_VOITURE) > 0.01:
		err = "sortie : le héros ne descend pas à gauche, côté conducteur"
		return
	# côté passager (à droite) : on monte aussi, par l'autre portière, et il faut se glisser au volant
	_put(a, -130, -178, EST, 0.0)
	_e_a_cote(m, a, -1)
	if m.cur_car != a or pl.visible or e.cote_entree != -1 or not e.bloque(m) or abs(e.attente - e.T_ENTREE_PASSAGER) > 0.001 or not ("passager" in m.info_text):
		err = "entrée côté passager : E à droite de la voiture ne fait pas monter par la portière du passager"
		return
	var n2: int = _demarre(m, a, -1)
	if err != "":
		return
	if abs(n2 - int(e.T_ENTREE_PASSAGER * 60.0)) > 6 or n2 < n1 + 30:
		err = "entrée côté passager : la voiture démarre après %d images (attendu %d, côté conducteur %d)" % [n2, int(e.T_ENTREE_PASSAGER * 60.0), n1]
		return
	# une fois installé, c'est bien le héros qui conduit, et il descend côté conducteur
	a.speed = 0.0
	m.press_e()
	if m.cur_car != null or e.cote(a, pl.global_position) != 1:
		err = "entrée côté passager : après être monté à droite, le héros ne descend pas côté conducteur"
		return
	# derrière la voiture : côté conducteur par défaut
	_put(a, -130, -178, EST, 0.0)
	pl.teleport(a.global_position - _avant(a) * 3.2 + _gauche(a) * 0.3, EST)
	m.press_e()
	if m.cur_car != a or e.cote_entree != 1:
		err = "entrée : derrière la voiture, le héros ne passe pas par la portière du conducteur"
		return
	_sortir(m)
	# portière du conducteur contre un mur (bord du monde) : on passe par celle du passager
	var b = _auto(m, 204.6, -178, 0.0)
	if e.porte_libre(m, b, 1) or not e.porte_libre(m, b, -1):
		err = "entrée : la portière collée au mur est comptée comme libre"
		return
	pl.teleport(b.global_position - _avant(b) * 3.2 + _gauche(b) * 0.3, 0.0)
	m.press_e()
	if m.cur_car != b or e.cote_entree != -1:
		err = "entrée côté passager : portière du conducteur bloquée par un mur, le héros ne passe pas par l'autre"
		return
	_sortir(m)
	# les deux portières bloquées (mur d'un côté, voiture collée de l'autre) : on ne monte pas
	var c2 = _auto(m, 202.3, -178, 0.0)
	pl.teleport(b.global_position - _avant(b) * 3.2 + _gauche(b) * 0.3, 0.0)
	m.press_e()
	if m.cur_car != null or e.raison != "bloquee" or not ("portière" in m.info_text):
		err = "entrée : on monte dans une voiture dont les deux portières sont bloquées"
		return
	_put(c2, 150, -178, 0.0, 0.0)
	# moto : pas de portière, pas de côté, pas d'attente
	var mo = m.moto_romaric
	_put(mo, -130, -174, EST, 0.0)
	_e_a_cote(m, mo, -1)
	if m.cur_car != mo or e.cote_entree != 0 or e.bloque(m) or e.attente != 0.0 or mo.has_meta("porte_g") or mo.has_meta("porte_d"):
		err = "entrée : la moto ne se monte pas d'un coup, des deux côtés"
		return
	print("entrée côté conducteur : la voiture démarre après %.2f s ; côté passager : %.2f s (le héros se glisse au volant) ; portière du conducteur contre un mur : il passe par l'autre ; les deux bloquées : il reste dehors ; moto : sans attente" % [n1 * DT, n2 * DT])

# ---------------- animation des portières ----------------
func _portes(m) -> void:
	var e = m.emb
	var pl = m.player
	var a = _auto(m, -130, -178, EST)
	for k in [1, -1]:
		_put(a, -130, -178, EST, 0.0)
		_e_a_cote(m, a, k)
		if m.cur_car != a:
			err = "portières : impossible de monter"
			return
		var pv: Node3D = a.get_meta("porte_g" if k > 0 else "porte_d")
		if pv == null or pv.get_parent() != a.body or pv.get_child_count() < 2:
			err = "portières : la portière n'est pas une pièce de la carrosserie"
			return
		var angles := []
		var bout := 0.0
		for i in int(e.T_ENTREE * 60.0) + 2:
			e.step(m, DT)
			angles.append(e.angle_porte(a, k))
			if i == 20:
				# grande ouverte : le bord arrière de la portière s'écarte de la caisse, vers l'extérieur
				bout = a.to_local(pv.to_global(Vector3(0, 0, -1.1))).x * k
		var n_ouv: int = int(e.T_PORTE * 60.0)
		for i in range(1, n_ouv):
			if angles[i] <= angles[i - 1]:
				err = "portières : l'ouverture n'est pas progressive"
				return
		var n_fin: int = int(e.T_ENTREE * 60.0)
		if angles[0] <= 0.0 or angles[0] > 0.2 or abs(angles[n_ouv] - e.ANGLE_PORTE) > 0.01 or abs(angles[20] - e.ANGLE_PORTE) > 0.01 or angles.max() > e.ANGLE_PORTE + 0.0001 or angles[n_fin - 4] >= angles[n_fin - 8] or angles[-1] != 0.0:
			err = "portières : ouverture %.2f rad, puis %.2f, fermée à %.2f" % [angles[0], angles[n_ouv], angles[-1]]
			return
		if bout < 1.7 or e.angle_porte(a, -k) != 0.0 or not e.anims.is_empty():
			err = "portières : la portière ne s'ouvre pas vers l'extérieur (bord à %.2f m de l'axe)" % bout
			return
		# en descendant : la portière du côté où le héros sort s'ouvre puis se referme
		m.press_e()
		if m.cur_car != null or e.anims.size() != 1 or e.anims[0].k != e.cote(a, pl.global_position):
			err = "portières : rien ne s'ouvre quand le héros descend"
			return
		var kk: int = e.anims[0].k
		var top := 0.0
		for i in int(e.T_SORTIE * 60.0) + 2:
			e.step(m, DT)
			top = max(top, e.angle_porte(a, kk))
		if abs(top - e.ANGLE_PORTE) > 0.01 or e.angle_porte(a, kk) != 0.0 or not e.anims.is_empty():
			err = "portières : à la descente, ouverture %.2f rad, reste à %.2f" % [top, e.angle_porte(a, kk)]
			return
	# la portière penche et roule avec la voiture : elle fait partie de la caisse
	_put(a, -130, -178, EST + 0.5, 0.0)
	var pg: Node3D = a.get_meta("porte_g")
	if _d(pg.global_position, a.global_position) > 1.3 or abs(pg.global_position.y - 0.78) > 0.05:
		err = "portières : la portière ne suit pas la voiture"
		return
	print("animation des portes : ouverture progressive en %.2f s jusqu'à %.0f°, vers l'extérieur, fermeture à la fin (%.1f s en tout) ; la bonne portière à la montée comme à la descente" % [e.T_PORTE, rad_to_deg(e.ANGLE_PORTE), e.T_ENTREE])

# ---------------- place libre à la descente ----------------
func _place(m) -> void:
	var e = m.emb
	var pl = m.player
	var a = _auto(m, -130, -178, EST)
	# la plage dégagée est libre ; pas la mer, pas un mur, pas l'emplacement d'un véhicule
	if not e.place_libre(m, Vector3(-120, 0, -175)) or e.place_libre(m, Vector3(-120, 0, -215)) or e.place_libre(m, Vector3(206.9, 0, -178)) or e.place_libre(m, a.global_position + Vector3(0, 0, 1.3)) or not e.place_libre(m, a.global_position + Vector3(0, 0, 1.3), [a]) or e.place_libre(m, m.traffic[0].global_position):
		err = "place libre : plage, mer, mur ou véhicule mal reconnus"
		return
	# rien autour : à gauche, côté conducteur
	m.mount(a)
	m.press_e()
	if m.cur_car != null or abs(_d(pl.global_position, a.global_position + _gauche(a) * e.ECART_VOITURE)) > 0.01 or not pl.visible or pl.shape.disabled:
		err = "place libre : sans obstacle, le héros ne descend pas à gauche"
		return
	# un mur à gauche (bord du monde) : il descend à droite
	var b = _auto(m, 204.6, -178, 0.0)
	m.mount(b)
	m.press_e()
	if m.cur_car != null or _d(pl.global_position, b.global_position - _gauche(b) * e.ECART_VOITURE) > 0.01 or pl.global_position.x > 205.5:
		err = "place libre : mur à gauche, le héros ne descend pas à droite (x = %.1f)" % pl.global_position.x
		return
	# mur à gauche et voiture collée à droite : il descend par l'arrière
	var c = _auto(m, 202.3, -178, 0.0)
	m.mount(b)
	m.press_e()
	if m.cur_car != null or _d(pl.global_position, b.global_position - _avant(b) * e.BOUT_VOITURE) > 0.01:
		err = "place libre : coincé des deux côtés, le héros ne descend pas derrière (%.1f ; %.1f)" % [pl.global_position.x, pl.global_position.z]
		return
	# une voiture derrière aussi : devant
	var d = _auto(m, 204.6, -183.0, 0.0)
	m.mount(b)
	m.press_e()
	if m.cur_car != null or _d(pl.global_position, b.global_position + _avant(b) * e.BOUT_VOITURE) > 0.01:
		err = "place libre : le héros ne descend pas devant quand le reste est pris"
		return
	# coincé de partout : il reste à bord et le jeu le dit ; la voiture n'est pas arrêtée de force
	var f = _auto(m, 204.6, -173.0, 0.0)
	m.mount(b)
	m.info_t = 0.0
	m.press_e()
	if m.cur_car != b or pl.visible or e.raison != "pas_de_place" or not ("Pas la place" in m.info_text) or e.chercher_place(m, b) != null:
		err = "place libre : le héros descend dans un mur ou dans une voiture"
		return
	# évanoui au volant (sortie obligée) : il est posé au plus près, à un endroit libre
	e.descendre(m, true)
	if m.cur_car != null or not e.place_libre(m, pl.global_position) or _d(pl.global_position, b.global_position) > 7.5 or pl.global_position.x > 206.0:
		err = "place libre : sortie obligée, héros posé en (%.1f ; %.1f)" % [pl.global_position.x, pl.global_position.z]
		return
	var loin: float = _d(pl.global_position, b.global_position)
	for v in [c, d, f]:
		_put(v, 20.0 + 6.0 * faites.find(v), -184, EST, 0.0)
	# moto : à gauche d'habitude, à droite si une voiture longe son côté gauche
	var mo = m.moto_romaric
	_put(mo, -150, -178, EST, 0.0)
	m.mount(mo)
	m.press_e()
	var g_ok: bool = _d(pl.global_position, mo.global_position + _gauche(mo) * e.ECART_MOTO) < 0.01
	_put(a, -150, -179.6, EST, 0.0)
	m.mount(mo)
	m.press_e()
	if not g_ok or m.cur_car != null or _d(pl.global_position, mo.global_position - _gauche(mo) * e.ECART_MOTO) > 0.01:
		err = "place libre : à moto, le héros ne descend pas du côté libre"
		return
	print("place libre à la descente : à gauche d'abord ; mur à gauche : à droite ; coincé des deux côtés : derrière, puis devant ; coincé partout : il reste à bord ; sortie obligée : posé à %.1f m, à un endroit libre ; moto : du côté libre" % loin)

# ---------------- saut en marche ----------------
func _saut(m) -> void:
	var e = m.emb
	var pl = m.player
	var a = _auto(m, -130, -178, EST)
	# sous 22 km/h : descente normale, sans blessure, la voiture s'arrête
	m.mount(a)
	a.speed = 5.0
	m.press_e()
	if m.cur_car != null or pl.health != 100.0 or pl.down_t > 0.0 or a.speed != 0.0 or not e.libres.is_empty():
		err = "saut en marche : à 18 km/h on devrait descendre normalement"
		return
	# à 54 km/h : il saute, roule par terre et se fait mal ; la voiture continue seule
	m.mount(a)
	a.speed = 15.0
	var s0: int = e.sauts
	m.press_e()
	var perdu: float = 100.0 - pl.health
	if m.cur_car != null or not pl.visible or pl.down_t <= 0.0 or e.sauts != s0 + 1 or e.raison != "":
		err = "saut en marche : E à 54 km/h ne fait pas sauter"
		return
	if abs(perdu - (e.SAUT_SANTE_BASE + 9.0 * e.SAUT_SANTE)) > 0.01 or pl.ko_t > 0.0 or _d(pl.global_position, a.global_position) > 3.0:
		err = "saut en marche : %.0f points de santé perdus (attendu 23)" % perdu
		return
	if a.speed != 15.0 or not (a in e.libres) or not ("Saut en marche" in m.info_text):
		err = "saut en marche : la voiture s'arrête net"
		return
	_boucle(m, 20)
	var x20: float = a.global_position.x
	if x20 < -127.5 or a.speed <= 0.0 or a.speed >= 15.0 or abs(e.angle_porte(a, 1) - e.ANGLE_PORTE) > 0.01:
		err = "saut en marche : la voiture ne roule pas sur sa lancée, portière ouverte (x = %.1f)" % x20
		return
	# par terre : aucune action possible ; puis la voiture s'arrête d'elle-même et la portière se referme
	m.press_e()
	if m.cur_car != null:
		err = "saut en marche : le héros remonte alors qu'il est par terre"
		return
	_boucle(m, 160)
	var roule: float = a.global_position.x + 130.0
	if a.speed != 0.0 or roule < 6.0 or roule > 14.0 or abs(a.global_position.z + 178.0) > 0.05 or not e.libres.is_empty() or e.angle_porte(a, 1) != 0.0 or a.damage > 0.0:
		err = "saut en marche : la voiture lâchée roule %.1f m (attendu 9 environ), vitesse %.1f" % [roule, a.speed]
		return
	if pl.down_t > 0.0 or pl.health < 100.0 - perdu:
		err = "saut en marche : le héros ne se relève pas"
		return
	# jamais évanoui pour un saut : il reste toujours 5 points
	_sortir(m)
	_put(a, -130, -178, EST, 0.0)
	m.mount(a)
	a.speed = 30.0
	pl.health = 8.0
	m.press_e()
	if m.cur_car != null or pl.health != e.SAUT_SANTE_MIN or pl.ko_t > 0.0 or pl.down_t <= 0.0:
		err = "saut en marche : avec 8 points de santé, il reste %.0f points" % pl.health
		return
	a.speed = 0.0
	e.step(m, DT)
	_sortir(m)
	# en marche arrière aussi
	_put(a, -130, -178, EST, 0.0)
	m.mount(a)
	a.speed = -9.0
	m.press_e()
	if m.cur_car != null or abs(100.0 - pl.health - 11.0) > 0.01 or a.speed != -9.0:
		err = "saut en marche : pas de saut en marche arrière"
		return
	a.speed = 0.0
	e.step(m, DT)
	_sortir(m)
	# à moto : la moto se couche et glisse ; avec un client à bord, on ne saute pas
	var mo = m.moto_romaric
	mo.repair()
	_put(mo, -130, -174, EST, 15.0)
	m.mount(mo)
	mo.speed = 15.0
	mo.loaded = true
	m.press_e()
	if m.cur_car != mo or e.raison != "client" or mo.fallen:
		err = "saut en marche : on saute d'une moto avec un client à bord"
		return
	mo.loaded = false
	m.press_e()
	if m.cur_car != null or not mo.fallen or mo.speed != 15.0 or abs(100.0 - pl.health - 23.0) > 0.01 or pl.down_t <= 0.0:
		err = "saut en marche : à moto, pas de saut (santé %.0f)" % pl.health
		return
	_boucle(m, 150)
	var glisse: float = mo.global_position.x + 130.0
	if mo.speed != 0.0 or glisse < 5.0 or glisse > 14.0 or not mo.fallen or mo.rider.visible:
		err = "saut en marche : la moto lâchée glisse sur %.1f m" % glisse
		return
	mo.repair()
	print("saut en marche : descente normale sous 22 km/h ; à 54 km/h : -%.0f de santé, 2 s par terre, la voiture roule seule %.1f m portière ouverte puis s'arrête ; jamais moins de 5 points ; marche arrière aussi ; moto : elle se couche et glisse %.1f m ; pas de saut avec un client" % [perdu, roule, glisse])

# ---------------- emprunt d'un véhicule occupé ----------------
func _emprunt(m) -> void:
	var e = m.emb
	var pl = m.player
	var cibles := []
	var moto_t = null
	for t in m.traffic:
		if t.moto:
			if moto_t == null:
				moto_t = t
		elif not e.verrou(t) and _isolee(m, t) and cibles.size() < 2:
			cibles.append(t)
	if cibles.size() < 2 or moto_t == null:
		err = "emprunt : pas assez de voitures isolées dans la circulation"
		return
	var t1 = cibles[0]
	var t2 = cibles[1]
	var emp0: int = e.emprunts
	var sig0: int = e.signalements
	var n_traf: int = m.traffic.size()
	var n_cars: int = m.cars.size()
	# elle roule : on n'ouvre pas la portière d'une voiture lancée
	t1.speed = t1.vmax
	_e_a_cote(m, t1, 1)
	if m.cur_car != null or e.raison != "roule" or not t1.ai or e.emprunts != emp0 or m.info_t <= 0.0:
		err = "emprunt : on monte dans une voiture de la circulation qui roule à %.0f km/h" % (t1.vmax * 3.6)
		return
	# le héros se met devant : elle s'arrête (c'est la circulation qui le décide)
	var devant: Vector3 = t1.global_position + _avant(t1) * 5.0
	var arret: Array = m.trafic.blocked_by(m, t1, devant)
	if not arret[0] or not arret[1]:
		err = "emprunt : la voiture ne s'arrête pas devant le héros"
		return
	# arrêtée : E fait monter, la voiture quitte la circulation et devient celle du joueur
	t1.speed = 0.0
	m.l_banner.text = ""
	_e_a_cote(m, t1, 1)
	if m.cur_car != t1 or t1.ai or (t1 in m.traffic) or not (t1 in m.cars) or m.traffic.size() != n_traf - 1 or m.cars.size() != n_cars + 1 or t1.speed != 0.0:
		err = "emprunt : E près d'une voiture arrêtée de la circulation ne la fait pas emprunter"
		return
	if e.emprunts != emp0 + 1 or e.signalements != sig0 or not ("empruntée" in m.l_banner.text) or e.cote_entree != 1 or not e.bloque(m):
		err = "emprunt : premier emprunt mal compté (%d emprunts, %d signalements)" % [e.emprunts, e.signalements]
		return
	# elle se conduit comme une autre, et la circulation ne la déplace plus
	e.attente = 0.0
	var p0: Vector3 = t1.global_position
	Input.action_press("up")
	for i in 60:
		t1.drive(DT)
	Input.action_release("up")
	if _d(t1.global_position, p0) < 3.0:
		err = "emprunt : la voiture empruntée n'avance pas"
		return
	_sortir(m)
	# remonter dans la même voiture n'est plus un emprunt
	_e_a_cote(m, t1, 1)
	if m.cur_car != t1 or e.emprunts != emp0 + 1:
		err = "emprunt : remonter dans sa voiture compte comme un nouvel emprunt"
		return
	_sortir(m)
	# décision 54 : si le joueur recommence, cela vaut une recherche (comptée pour la police à venir)
	t2.speed = 0.0
	_e_a_cote(m, t2, -1)
	if m.cur_car != t2 or t2.ai or e.emprunts != emp0 + 2 or e.signalements != sig0 + 1 or e.cote_entree != -1:
		err = "emprunt : le deuxième emprunt ne vaut pas un signalement (%d emprunts, %d signalements)" % [e.emprunts, e.signalements]
		return
	_sortir(m)
	# les motos de la circulation ont leur pilote : on ne les prend pas
	moto_t.speed = 0.0
	_e_a_cote(m, moto_t, 1)
	if m.cur_car != null or not moto_t.ai or e.emprunts != emp0 + 2:
		err = "emprunt : on peut prendre la moto d'un zémidjan de la circulation"
		return
	print("emprunt d'un véhicule occupé : impossible tant qu'elle roule (%.0f km/h), elle s'arrête devant le héros ; arrêtée : E, elle quitte la circulation et se conduit ; le deuxième emprunt vaut un signalement ; portières verrouillées et motos : refusé" % (t1.vmax * 3.6))
