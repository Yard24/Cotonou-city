extends RefCounted
# Circulation : règles suivies par les véhicules de la circulation. trafic.gd les fait avancer
# le long de leur trajet ; ce fichier décide quand ils s'arrêtent, ralentissent ou s'écartent :
# feux tricolores, priorité à droite, priorité à l'anneau du rond-point, dépassements,
# embouteillages des heures de pointe, réactions au klaxon, accidents, nombre de véhicules
# selon l'heure, apparition et disparition hors de la vue du joueur.
# Fonctionnement attendu : docs/systemes/circulation.md ; test : scripts/selftest_circulation.gd.

const CarFx := preload("res://scripts/car_fx.gd")

# ---------------- horloge ----------------
const JOUR_S := 2880.0        # une journée de jeu = 48 minutes réelles (décision 89)
const HEURE_DEPART := 10.0
# nombre de véhicules selon l'heure : 1 = journée normale, 1,5 = heures de pointe, 0,3 = nuit
const H_DENSITE := [0.0, 5.0, 7.0, 9.0, 10.0, 16.5, 17.0, 20.0, 20.5, 22.0, 24.0]
const V_DENSITE := [0.3, 0.3, 1.5, 1.5, 1.0, 1.0, 1.5, 1.5, 1.0, 0.3, 0.3]
# heures de pointe : 7 h-9 h et 17 h-20 h (décision 60), un quart d'heure pour s'installer
const H_POINTE := [0.0, 6.75, 7.0, 9.0, 9.25, 16.75, 17.0, 20.0, 20.25, 24.0]
const V_POINTE := [0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0]
var heure := HEURE_DEPART
var t := 0.0                  # secondes écoulées : cadence des feux

# ---------------- carrefours ----------------
const FEUX := 0
const PRIORITE := 1
const ROND := 2
const VERT := 0
const ORANGE := 1
const ROUGE := 2
const VERT_S := 14.0          # durée du vert pour un axe
const ORANGE_S := 3.0
const ROUGE_TOUT_S := 2.0     # tout le monde au rouge, le temps de vider le carrefour
const CYCLE_S := 2.0 * (VERT_S + ORANGE_S + ROUGE_TOUT_S)
const DEMI := 7.0             # demi-largeur d'un carrefour (routes de 14 m)
const RAYON_ROND := 23.5      # zone de l'anneau de la place de l'Amazone
const RECUL := 2.5            # arrêt à 2,5 m de l'entrée du carrefour…
const RECUL_ROND := 4.5       # … et à 4,5 m de l'anneau
const VUE := 30.0             # un conducteur regarde le carrefour 30 m avant
const DECEL := 4.0            # freinage tranquille avant une ligne d'arrêt (m/s²)
const QUEUE := 3.0            # le carrefour est libéré 3 m après la sortie
const PATIENCE := 5.0         # carrefour bloqué : après 5 s, le plus ancien s'avance
const GARDE_ROND := 22.0      # on n'entre pas devant un véhicule de l'anneau à moins de 22 m
const PAS := 0.5
var carrefours: Array = []
var routes: Array = []
var infos := {}               # état de chaque véhicule de la circulation
var cache := {}

# ---------------- embouteillages ----------------
const BOUCHON_M := 70.0       # longueur du bouchon avant un grand carrefour
const V_BOUCHON := 2.5        # 9 km/h : les voitures au pas
const V_BOUCHON_MOTO := 5.0   # 18 km/h : les motos avancent quand même (décision 61)

# ---------------- klaxon ----------------
const KLAXON_M := 25.0        # portée devant le véhicule du joueur
const SERRE := 1.5            # la voiture se serre de 1,5 m vers le trottoir
const SERRE_MOTO := 1.0
const SERRE_S := 5.0          # pendant 5 secondes
var klax_src = null
var klax_n := 0

# ---------------- accidents ----------------
const CHOC_MIN := 5.0         # m/s : en dessous, un frottement sans suite
const CONSTAT_S := 8.0        # arrêt après un petit accident
const CONSTAT_GROS_S := 20.0  # dégâts de 50 ou plus
const PANNE := 80.0           # dégâts de 80 ou plus : le véhicule ne repart pas
var nb_accidents := 0

# ---------------- dépassements ----------------
const PATIENCE_DEP := 2.5     # secondes d'attente derrière un obstacle qui ne repartira pas
const ECART_DEP := 2.8        # déport vers la gauche
const V_DEPASSE := 6.0        # 22 km/h le long de l'obstacle
const FIN_DEP := 6.0          # se rabat 6 m après l'obstacle
const EN_FACE_M := 30.0       # personne en face à moins de 30 m après l'obstacle

# ---------------- apparition et disparition ----------------
const PRES := 40.0            # jamais à moins de 40 m du joueur
const DEMI_CHAMP := 0.5       # cosinus de 60° : au-delà, hors de l'image
const ESPACE := 14.0          # place libre autour du véhicule qui apparaît
var densite_auto := true
var tick := 0.0
var rng := RandomNumberGenerator.new()

static func _interp(hs: Array, vs: Array, h: float) -> float:
	h = fposmod(h, 24.0)
	for k in range(1, hs.size()):
		if h <= hs[k]:
			return lerp(float(vs[k - 1]), float(vs[k]), (h - hs[k - 1]) / (hs[k] - hs[k - 1]))
	return vs[0]

# Nombre de véhicules voulu à cette heure, par rapport à une journée normale.
static func densite(h: float) -> float:
	return _interp(H_DENSITE, V_DENSITE, h)

# 1 en pleine heure de pointe, 0 en dehors.
static func pointe(h: float) -> float:
	return _interp(H_POINTE, V_POINTE, h)

# ---------------- construction ----------------
func build(m) -> void:
	rng.seed = 60117
	var n := 0
	for x in [-120.0, 0.0, 120.0]:
		for z in [-160.0, -120.0, 0.0, 120.0]:
			var j := {"c": Vector2(x, z), "type": PRIORITE, "phase": 0.0, "lampes": [[], []], "vu": [-1, -1]}
			if x == 0.0 and z == 0.0:
				j.type = ROND
			elif abs(x) == 120.0 and (z == -120.0 or z == 0.0):
				j.type = FEUX
				j.phase = n * 9.0
				n += 1
				for h in [0.0, PI / 2, PI, -PI / 2]:
					_poteau(m, j, h)
			carrefours.append(j)
	_feux_maj(m)

# Un feu sur le trottoir de droite, face aux véhicules qui arrivent avec le cap h.
func _poteau(m, j: Dictionary, h: float) -> void:
	var f := Vector2(sin(h), cos(h))
	var l := Vector2(cos(h), -sin(h))
	var p: Vector2 = j.c - f * 8.6 - l * 8.0
	m.cyl(0.09, 0.11, 3.2, Color("3a3a3d"), Vector3(p.x, 1.6, p.y), null, 6)
	m.post(p.x, p.y, 0.15)
	var tete := Node3D.new()
	tete.position = Vector3(p.x, 3.7, p.y)
	tete.rotation.y = h
	m.add_child(tete)
	m.box(Vector3(0.38, 1.14, 0.3), Color("1c1c1e"), Vector3.ZERO, tete)
	var trio := []
	for k in 3:
		trio.append(m.box(Vector3(0.24, 0.24, 0.06), Color("222222"), Vector3(0, 0.36 - 0.36 * k, -0.17), tete))
	j.lampes[axe(h)].append(trio)

static func axe(h: float) -> int:
	return 0 if abs(cos(h)) > 0.7 else 1

# Couleur du feu de ce carrefour pour un axe (0 : véhicules qui roulent le long de z ; 1 : le long de x).
func etat_feu(j: Dictionary, a: int, tt := -1.0) -> int:
	if tt < 0.0:
		tt = t
	var u: float = fposmod(tt + j.phase - (CYCLE_S / 2 if a == 1 else 0.0), CYCLE_S)
	if u < VERT_S:
		return VERT
	return ORANGE if u < VERT_S + ORANGE_S else ROUGE

const LAMPES := [["22dd55", "0a3516"], ["ffa200", "40300a"], ["ff2a1a", "401010"]]
func _feux_maj(m) -> void:
	for j in carrefours:
		if j.type != FEUX:
			continue
		for a in 2:
			var e := etat_feu(j, a)
			if e == j.vu[a]:
				continue
			j.vu[a] = e
			for trio in j.lampes[a]:
				# de haut en bas : rouge, orange, vert
				for k in 3:
					var c: int = 2 - k
					trio[k].material_override = CarFx.lum_mat(Color(LAMPES[c][0])) if c == e else m.mat(Color(LAMPES[c][1]))

# Numéro du carrefour qui contient ce point, -1 en pleine rue.
func zone(p: Vector2) -> int:
	for k in carrefours.size():
		var j: Dictionary = carrefours[k]
		if j.type == ROND:
			if (p - j.c).length() < RAYON_ROND:
				return k
		elif abs(p.x - j.c.x) < DEMI and abs(p.y - j.c.y) < DEMI:
			return k
	return -1

func carrefour_en(c: Vector2) -> int:
	for k in carrefours.size():
		if carrefours[k].c == c:
			return k
	return -1

# ---------------- trajets ----------------
func route(nom: String, pts: Array, n_jour: int, vmax: float) -> Dictionary:
	var r := {"id": routes.size(), "nom": nom, "pts": pts, "n_jour": n_jour, "vmax": vmax, "veh": [], "d_init": [], "trav": null, "v": null}
	routes.append(r)
	return r

func route_nommee(nom: String) -> Dictionary:
	for r in routes:
		if r.nom == nom:
			return r
	return {}

func _neuf(r, actif: bool) -> Dictionary:
	return {"r": r, "actif": actif, "T": null, "rel": 0.0, "att": 0.0, "stop": false, "acc": 0.0, "panne": false,
		"dmg": 0.0, "serre": 0.0, "dep": null, "bloq": 0.0, "bloq_d": 0.0, "par": null}

func inscrit(a, r: Dictionary, d: float, actif: bool) -> void:
	r.veh.append(a)
	r.d_init.append(d)
	if r.v == null:
		r.v = a
	infos[a.get_instance_id()] = _neuf(r, actif)

# État d'un véhicule ; un véhicule inconnu (posé par un test, par exemple) est rattaché à son trajet.
func info(a) -> Dictionary:
	var i = infos.get(a.get_instance_id())
	if i == null or (i.r != null and not is_same(i.r.pts, a.path)):
		var r = null
		if a.path_len > 0.0:
			for x in routes:
				if is_same(x.pts, a.path):
					r = x
			if r == null:
				r = route("", a.path, 0, a.vmax)
			if r.v == null:
				r.v = a
		i = _neuf(r, true)
		i.dmg = a.damage
		infos[a.get_instance_id()] = i
	return i

# Trajets ajoutés à ceux de trafic.gd : ils croisent les autres, ce qui donne leur rôle aux feux,
# aux priorités et à l'anneau de la place. Tous roulent à droite.
func _nouveaux() -> Array:
	var est := [Vector2(3.5, 116.5), Vector2(3.5, 26)]
	var ouest := [Vector2(-3.5, -116.5), Vector2(-3.5, -26)]
	var a0 := atan2(20.5, 3.5)
	for k in 17:
		var a := a0 - 2.0 * a0 * k / 16.0
		est.append(Vector2(cos(a), sin(a)) * 21.0)
		ouest.append(Vector2(-cos(a), -sin(a)) * 21.0)
	est.append_array([Vector2(3.5, -26), Vector2(3.5, -116.5), Vector2(116.5, -116.5), Vector2(116.5, 116.5)])
	ouest.append_array([Vector2(-3.5, 26), Vector2(-3.5, 116.5), Vector2(-116.5, 116.5), Vector2(-116.5, -116.5)])
	# [nom, points, véhicules en journée, vitesse, dont motos]
	return [
		["boucle_marina", [Vector2(116.5, -156.5), Vector2(116.5, 116.5), Vector2(-116.5, 116.5), Vector2(-116.5, -156.5)], 5, 13.0, 2],
		["place_a", est, 3, 12.0, 1],
		["place_b", ouest, 3, 12.0, 1]]

func _cree(m, trafic, r: Dictionary, is_moto: bool):
	var taxi: bool = (not is_moto) and rng.randf() < 0.45
	var col := Color(["aa1111", "1144aa", "111111"][rng.randi() % 3]) if is_moto else (Color("f2c200") if taxi else Color(m.CARC[rng.randi() % m.CARC.size()]))
	var c = trafic.make(m, col, taxi, is_moto)
	c.ai = true
	c.set_path(r.pts)
	c.vmax = r.vmax
	c.speed = r.vmax
	return c

# Appelé par trafic.gd après ses propres trajets : nouveaux trajets, puis véhicules de réserve
# (heures de pointe). Tirages au hasard à part : la ville reste la même d'un lancement à l'autre.
func complete(m, trafic) -> void:
	for N in _nouveaux():
		var r := route(N[0], N[1], N[2], N[3])
		for k in N[2]:
			var a = _cree(m, trafic, r, k < N[4])
			var d: float = a.path_len * (k + 0.37) / N[2]
			for essai in 30:
				var q: Vector3 = a.pos_on(d)
				var libre := true
				for o in m.traffic:
					if o.global_position.distance_to(Vector3(q.x, 0, q.y)) < 11.0:
						libre = false
				if libre and zone(Vector2(q.x, q.y)) < 0:
					break
				d += 9.0
			a.dist = d
			a.place_on_path()
			m.traffic.append(a)
			inscrit(a, r, d, true)
	for r in routes:
		for k in int(ceil(r.n_jour * 0.5)):
			var a = _cree(m, trafic, r, rng.randf() < 0.35)
			inscrit(a, r, 0.0, false)
			_range(a)

# Passages du trajet dans les carrefours : pour chacun, où il entre, où il sort, par où il passe.
func traversees(r: Dictionary) -> Array:
	if r.trav != null:
		return r.trav
	var out := []
	r.trav = out
	var v = r.v
	if v == null or v.path_len <= 0.0:
		return out
	var n := int(ceil(v.path_len / PAS))
	var zs := PackedInt32Array()
	zs.resize(n)
	var k0 := -1
	for k in n:
		var q: Vector3 = v.pos_on(k * PAS)
		zs[k] = zone(Vector2(q.x, q.y))
		if zs[k] < 0 and k0 < 0:
			k0 = k
	if k0 < 0:
		return out
	var k := 0
	while k < n:
		var j: int = zs[(k0 + k) % n]
		if j < 0:
			k += 1
			continue
		var kk := k
		var pts := PackedVector2Array()
		while kk < n and zs[(k0 + kk) % n] == j:
			var q: Vector3 = v.pos_on(((k0 + kk) % n) * PAS)
			pts.append(Vector2(q.x, q.y))
			kk += 1
		var d0: float = ((k0 + k) % n) * PAS
		var lg: float = (kk - k) * PAS
		var h_in: float = v.pos_on(d0 - 1.0).z
		var h_out: float = v.pos_on(d0 + lg + 1.0).z
		out.append({"j": j, "d0": d0, "lg": lg, "h_in": h_in, "h_out": h_out, "p_in": pts[0], "pts": pts,
			"tourne": abs(angle_difference(h_in, h_out)) > 0.5, "cle": "%d/%d" % [r.id, out.size()]})
		k = kk
	return out

# Passage de ce trajet dans le carrefour de centre c (le premier trouvé).
func traversee(r: Dictionary, c: Vector2) -> Dictionary:
	var j := carrefour_en(c)
	for T in traversees(r):
		if T.j == j:
			return T
	return {}

# Où en est ce véhicule : son prochain carrefour (T) et sa distance à l'entrée (rel < 0 : avant).
func _situe(a, i: Dictionary) -> void:
	i.T = null
	if i.r == null:
		return
	var tr: Array = traversees(i.r)
	if tr.is_empty() or a.path_len <= 0.0:
		return
	var dm: float = fposmod(a.dist, a.path_len)
	var best := INF
	for T in tr:
		var reste: float = fposmod(T.d0 + T.lg + QUEUE - dm, a.path_len)
		if reste < best:
			best = reste
			i.T = T
	i.rel = i.T.lg + QUEUE - best

# ---------------- à chaque image, avant de faire avancer les véhicules ----------------
func avant(m, delta: float) -> void:
	t += delta
	heure = fposmod(heure + delta * 24.0 / JOUR_S, 24.0)
	_feux_maj(m)
	if m.cur_car != null:
		var h: int = m.cur_car.fx.honks
		if klax_src == m.cur_car and h > klax_n:
			klaxon(m, m.cur_car)
		klax_n = h
	klax_src = m.cur_car
	var clign: bool = fmod(t * 1.5, 1.0) < 0.5
	for a in m.traffic:
		var i: Dictionary = info(a)
		_situe(a, i)
		if a.damage > i.dmg + 0.01:
			_accidente(a, i)
		i.dmg = a.damage
		if i.panne:
			_detresse(a, clign)
		elif i.acc > 0.0:
			i.acc -= delta
			_detresse(a, clign and i.acc > 0.0)
	_contacts(m)
	tick -= delta
	if tick <= 0.0:
		tick = 0.5
		if densite_auto:
			_population(m)

# Ce véhicule doit-il s'arrêter pour une règle de circulation ? Plafonne aussi sa vitesse
# (approche d'une ligne d'arrêt, bouchon, dépassement). b : résultat de trafic.blocked_by().
func regle(m, a, i: Dictionary, b: Array, delta: float) -> bool:
	i.stop = false
	i.par = b[2]
	i.bloq = i.bloq + delta if b[0] else 0.0
	if i.acc > 0.0 or i.panne:
		return true
	# deux véhicules qui s'attendent l'un l'autre : le premier inscrit repart
	if b[0] and b[2] != null and b[2].ai and i.bloq > 3.0:
		var io = infos.get(b[2].get_instance_id())
		if io != null and io.par == a and a.get_instance_id() < b[2].get_instance_id():
			b[0] = false
	if i.serre > 0.0:
		i.serre -= delta
		a.speed = min(a.speed, a.vmax * 0.6)
	if i.dep != null:
		a.speed = min(a.speed, V_DEPASSE)
	var T = i.T
	if T == null:
		return false
	var j: Dictionary = carrefours[T.j]
	var p := pointe(heure)
	if p > 0.0 and j.type != PRIORITE and i.rel < 0.0 and i.rel > -BOUCHON_M:
		var vb: float = V_BOUCHON_MOTO if a.moto else V_BOUCHON
		if a.vmax > vb:
			a.speed = min(a.speed, lerp(a.vmax, vb, p))
	var ligne: float = -i.rel - (RECUL_ROND if j.type == ROND else RECUL)
	if ligne < -0.8 or ligne > VUE:
		i.att = 0.0
		return false   # déjà engagé, ou encore loin
	if _peut_passer(m, a, i, T, j, ligne):
		i.att = 0.0
		return false
	a.speed = min(a.speed, sqrt(2.0 * DECEL * max(0.0, ligne - 0.3)) + 0.3)
	if ligne < 0.6:
		i.att += delta
		i.stop = true
		return true
	return false

func attend(o) -> bool:
	var i = infos.get(o.get_instance_id())
	return i != null and i.stop

func double(a, o) -> bool:
	var i = infos.get(a.get_instance_id())
	return i != null and i.dep == o

func _peut_passer(m, a, i: Dictionary, T: Dictionary, j: Dictionary, ligne: float) -> bool:
	if j.type == FEUX:
		var e := etat_feu(j, axe(T.h_in))
		if e == ROUGE:
			return false
		# à l'orange, on s'arrête si on en a la place, quitte à freiner un peu plus fort
		if e == ORANGE and ligne > a.speed * a.speed / (3.2 * DECEL) + 0.5:
			return false
	var patient: bool = i.att > PATIENCE + (a.get_instance_id() % 5) * 0.8
	# on ne s'engage pas si la sortie du carrefour est occupée
	if j.type != ROND and ligne < 8.0 and not patient:
		var q: Vector3 = a.pos_on(T.d0 + T.lg + 4.5)
		for o in m.traffic + m.cars:
			if o != a and abs(o.speed) < 1.0 and o.global_position.distance_to(Vector3(q.x, 0, q.y)) < 4.0:
				return false
	for b in m.traffic:
		if b == a:
			continue
		var ib = infos.get(b.get_instance_id())
		if ib == null or ib.T == null or ib.T.j != T.j:
			continue
		var Tb: Dictionary = ib.T
		if T.p_in.distance_to(Tb.p_in) < 1.5 and abs(angle_difference(T.h_in, Tb.h_in)) < 0.4:
			continue   # même file : c'est la distance de sécurité qui joue
		if j.type == ROND:
			# priorité à l'anneau : on laisse passer celui qui va couper notre entrée
			if ib.rel > -2.0 and ib.rel <= Tb.lg:
				var dp := _passe(Tb, T)
				if dp >= 0.0 and ib.rel < dp + 5.0 and ib.rel > dp - GARDE_ROND:
					return false
			continue
		if not _conflit(T, Tb):
			continue
		var ligne_b: float = -ib.rel - RECUL
		if ligne_b < -0.8:
			if ib.rel < Tb.lg + QUEUE:
				return false   # il est dans le carrefour
			continue
		if ligne_b > 14.0 or patient or ib.acc > 0.0 or ib.panne:
			continue
		if j.type == FEUX and etat_feu(j, axe(Tb.h_in)) != VERT:
			continue
		if _prioritaire(a, T, b, Tb):
			return false
	return true

# b passe-t-il avant a ? Priorité à droite ; face à face, celui qui tourne laisse passer celui qui va tout droit.
func _prioritaire(a, T: Dictionary, b, Tb: Dictionary) -> bool:
	var la := Vector2(cos(T.h_in), -sin(T.h_in))    # la gauche de a
	var fb := Vector2(sin(Tb.h_in), cos(Tb.h_in))
	var c := fb.dot(la)
	if c > 0.7:
		return true    # b va vers la gauche de a : il vient de sa droite
	if c < -0.7:
		return false
	if cos(T.h_in - Tb.h_in) < -0.7 and T.tourne != Tb.tourne:
		return T.tourne
	return b.get_instance_id() < a.get_instance_id()

# Les deux passages se coupent-ils ou se rejoignent-ils ?
func _conflit(T: Dictionary, Tb: Dictionary) -> bool:
	var cle: String = T.cle + "|" + Tb.cle
	if not cache.has(cle):
		var c := false
		for k in range(0, T.pts.size(), 2):
			for kb in range(0, Tb.pts.size(), 2):
				if T.pts[k].distance_to(Tb.pts[kb]) < 2.6:
					c = true
					break
			if c:
				break
		cache[cle] = c
	return cache[cle]

# Distance, depuis son entrée dans l'anneau, où le passage Tb frôle l'entrée de T ; -1 s'il n'y passe pas.
func _passe(Tb: Dictionary, T: Dictionary) -> float:
	var cle: String = Tb.cle + ">" + T.cle
	if not cache.has(cle):
		var best := 5.0
		var d := -1.0
		for k in Tb.pts.size():
			var e: float = Tb.pts[k].distance_to(T.p_in)
			if e < best:
				best = e
				d = k * PAS
		cache[cle] = d
	return cache[cle]

# ---------------- dépassements et écarts ----------------
# Écart à prendre par une voiture : à gauche pour dépasser un obstacle qui ne repartira pas
# (véhicule accidenté, en panne, garé ou laissé sur la voie), à droite si on la klaxonne.
func ecart(m, a, i: Dictionary, bl, delta: float) -> float:
	if i.acc > 0.0 or i.panne:
		i.dep = null
		return a.side
	var f := Vector3(sin(a.heading), 0, cos(a.heading))
	if i.dep != null:
		var o = i.dep
		if not _durable(o) or (o.global_position - a.global_position).dot(f) < -FIN_DEP or o.global_position.distance_to(a.global_position) > 30.0:
			i.dep = null
		else:
			return ECART_DEP
	i.bloq_d = i.bloq_d + delta if (bl != null and _durable(bl)) else 0.0
	if i.bloq_d > PATIENCE_DEP:
		var pres_carrefour: bool = i.T != null and i.rel > -15.0 and i.rel < i.T.lg + 6.0
		if not pres_carrefour and zone(Vector2(bl.global_position.x, bl.global_position.z)) < 0 and _voie_libre(m, a, bl, f):
			i.dep = bl
			i.bloq_d = 0.0
			return ECART_DEP
	return -SERRE if i.serre > 0.0 else 0.0

func _durable(o) -> bool:
	if not is_instance_valid(o):
		return false
	if o.ai:
		var io = infos.get(o.get_instance_id())
		return io != null and (io.acc > 0.0 or io.panne)
	return abs(o.speed) < 1.0

# Le couloir de dépassement est-il libre, et personne n'arrive-t-il en face ?
func _voie_libre(m, a, o, f: Vector3) -> bool:
	var l := Vector3(f.z, 0, -f.x)
	var long: float = o.global_position.distance_to(a.global_position) + 14.0
	for v in m.traffic + m.cars:
		if v == a or v == o:
			continue
		var dv: Vector3 = v.global_position - a.global_position
		var lon: float = dv.dot(f)
		var lat: float = dv.dot(l)
		if lon > 0.0 and lon < long and lat > 0.9 and lat < 4.8:
			return false
		if lon > 0.0 and lon < long + EN_FACE_M and lat > 3.5 and lat < 9.0 and v.speed > 1.0 and cos(v.heading - a.heading) < -0.7:
			return false
	return true

# ---------------- klaxon ----------------
# Coup de klaxon du véhicule src : les véhicules de la circulation qui roulent devant lui, dans
# sa file, se serrent à droite et ralentissent. Renvoie le nombre de véhicules qui réagissent.
func klaxon(m, src) -> int:
	var f := Vector3(sin(src.heading), 0, cos(src.heading))
	var l := Vector3(f.z, 0, -f.x)
	var n := 0
	for a in m.traffic:
		var dv: Vector3 = a.global_position - src.global_position
		var lon: float = dv.dot(f)
		if lon < 2.0 or lon > KLAXON_M or abs(dv.dot(l)) > 3.0 or cos(a.heading - src.heading) < 0.5:
			continue
		var i: Dictionary = info(a)
		# arrêté à un feu, à une priorité, derrière un autre ou accidenté : il ne peut rien faire
		if i.stop or i.acc > 0.0 or i.panne or i.dep != null or (i.par != null and i.par != src):
			continue
		i.serre = SERRE_S
		n += 1
	return n

# ---------------- accidents ----------------
func _accidente(a, i: Dictionary) -> void:
	nb_accidents += 1
	a.speed = 0.0
	i.dep = null
	i.serre = 0.0
	if a.damage >= PANNE:
		i.panne = true
	i.acc = max(i.acc, CONSTAT_GROS_S if a.damage >= 50.0 else CONSTAT_S)

func accidente(a) -> bool:
	var i = infos.get(a.get_instance_id())
	return i != null and (i.acc > 0.0 or i.panne)

# Feux de détresse : les quatre clignotants ensemble.
func _detresse(a, on: bool) -> void:
	for s in a.fx.ind:
		for n in a.fx.ind[s]:
			n.visible = on

static func _demi(v) -> Vector2:
	return Vector2(0.4, 0.9) if v.moto else Vector2(1.0, 2.2)   # demi-largeur, demi-longueur

# Deux véhicules de la circulation qui se touchent à plus de 18 km/h d'écart : accident.
func _contacts(m) -> void:
	var n: int = m.traffic.size()
	var x := 0
	while x < n:
		var a = m.traffic[x]
		var pa: Vector3 = a.global_position
		var y := x + 1
		x += 1
		while y < n:
			var b = m.traffic[y]
			y += 1
			var dv: Vector3 = b.global_position - pa
			if abs(dv.x) > 5.5 or abs(dv.z) > 5.5:
				continue
			var fa := Vector3(sin(a.heading), 0, cos(a.heading))
			var fb := Vector3(sin(b.heading), 0, cos(b.heading))
			var lon: float = dv.dot(fa)
			var lat: float = dv.dot(Vector3(fa.z, 0, -fa.x))
			var c: float = abs(fa.dot(fb))
			var s: float = sqrt(max(0.0, 1.0 - c * c))
			var ha := _demi(a)
			var hb := _demi(b)
			if abs(lon) >= ha.y + c * hb.y + s * hb.x - 0.4 or abs(lat) >= ha.x + s * hb.y + c * hb.x - 0.2:
				continue
			var rel: Vector3 = fa * a.speed - fb * b.speed
			var impact := rel.length()
			if rel.dot(dv) <= 0.0 or impact < CHOC_MIN:
				continue
			a.hit(impact * 0.7, lon > 0.0)
			b.hit(impact * 0.7, dv.dot(fb) < 0.0)
			for v in [a, b]:
				var i: Dictionary = info(v)
				_accidente(v, i)
				i.dmg = v.damage
			nb_accidents -= 1   # un seul accident pour les deux

# ---------------- nombre de véhicules, apparition et disparition ----------------
# Ce point est-il hors de la vue du joueur ? Loin de lui et hors de l'image, ou au-delà de la brume.
func hors_champ(m, p: Vector3) -> bool:
	var foc: Vector3 = m.focus_pos()
	if Vector2(p.x - foc.x, p.z - foc.z).length() < PRES:
		return false
	var c: Vector3 = m.cam.global_position
	var dv := Vector3(p.x - c.x, 0, p.z - c.z)
	var d := dv.length()
	if d > m.cam.far * 0.85:
		return true
	var fwd: Vector3 = -m.cam.global_transform.basis.z
	fwd.y = 0.0
	if fwd.length() < 0.01 or d < 0.01:
		return false
	return dv.dot(fwd.normalized()) / d < DEMI_CHAMP

func _range(a) -> void:
	a.visible = false
	a.global_position = Vector3(0, -200, 0)
	a.speed = 0.0
	a.side = 0.0
	a.side_want = 0.0

func _retire(m, a) -> void:
	m.traffic.erase(a)
	_detresse(a, false)
	_range(a)
	var i: Dictionary = infos[a.get_instance_id()]
	infos[a.get_instance_id()] = _neuf(i.r, false)

func _pose(m, a, d: float) -> void:
	var i: Dictionary = infos[a.get_instance_id()]
	if a.damage > 0.0:
		a.repair()
	var neuf := _neuf(i.r, true)
	infos[a.get_instance_id()] = neuf
	a.vmax = i.r.vmax
	a.speed = a.vmax
	a.side = 0.0
	a.side_want = 0.0
	a.dist = d
	a.place_on_path()
	a.visible = true
	_detresse(a, false)
	if not m.traffic.has(a):
		m.traffic.append(a)

func _apparait(m, r: Dictionary, a) -> bool:
	for essai in 8:
		var d: float = rng.randf() * a.path_len
		var q: Vector3 = a.pos_on(d)
		var p := Vector3(q.x, 0, q.y)
		if not hors_champ(m, p) or zone(Vector2(q.x, q.y)) >= 0:
			continue
		var libre := true
		for o in m.traffic + m.cars:
			if o.global_position.distance_to(p) < ESPACE:
				libre = false
				break
		if libre:
			_pose(m, a, d)
			return true
	return false

func nombre_voulu(r: Dictionary, h: float) -> int:
	return clamp(int(round(r.n_jour * densite(h))), 1, r.veh.size())

# Deux fois par seconde : un véhicule de plus ou de moins par trajet, toujours hors de la vue.
func _population(m) -> void:
	for r in routes:
		if r.n_jour <= 0:
			continue
		var actifs := []
		var reserve := []
		for a in r.veh.duplicate():
			var i: Dictionary = infos[a.get_instance_id()]
			if i.actif and not a.ai:
				# emprunté par le joueur : il ne fait plus partie de la circulation
				var k: int = r.veh.find(a)
				r.veh.remove_at(k)
				r.d_init.remove_at(k)
				infos.erase(a.get_instance_id())
				continue
			(actifs if i.actif else reserve).append(a)
		if r.veh.is_empty():
			continue
		var cible := nombre_voulu(r, heure)
		var sort = null
		for a in actifs:
			# une panne est enlevée dès que le joueur ne la voit plus
			if infos[a.get_instance_id()].panne and hors_champ(m, a.global_position):
				sort = a
				break
		if sort == null and actifs.size() > cible:
			for k in range(actifs.size() - 1, -1, -1):
				if infos[actifs[k].get_instance_id()].acc <= 0.0 and hors_champ(m, actifs[k].global_position):
					sort = actifs[k]
					break
		if sort != null:
			_retire(m, sort)
		elif actifs.size() < cible and not reserve.is_empty():
			_apparait(m, r, reserve[0])

# Tout remettre comme au lancement : véhicules de la journée à leur place de départ, les autres
# en réserve, 10 heures du matin. Sert au test automatique.
func remet_en_place(m) -> void:
	heure = HEURE_DEPART
	t = 0.0
	tick = 0.0
	nb_accidents = 0
	klax_src = null
	for r in routes:
		for k in r.veh.size():
			var a = r.veh[k]
			if not a.ai:
				continue
			if k < r.n_jour:
				_pose(m, a, r.d_init[k])
			elif infos[a.get_instance_id()].actif:
				_retire(m, a)
	var ordre := []
	for r in routes:
		for k in min(r.n_jour, r.veh.size()):
			if r.veh[k].ai:
				ordre.append(r.veh[k])
	m.traffic.assign(ordre)
	_feux_maj(m)
