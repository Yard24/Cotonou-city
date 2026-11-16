extends RefCounted
# Monter et descendre des véhicules : portière côté conducteur ou côté passager, portières
# fermées à clé, animation des portières, place libre à la descente, saut en marche, emprunt
# d'un véhicule occupé. Fonctionnement attendu : docs/systemes/monter_et_descendre_des_vehicules.md.
# main.gd garde mount() (le héros est assis dans le véhicule) et la touche E ; le reste est ici.
# On roule à droite : le volant, donc la portière du conducteur, est à gauche (côté +X du véhicule).

const V_DESCENTE := 6.0          # m/s (22 km/h) : en dessous on descend, au-dessus on saute en marche
const V_EMPRUNT := 3.0           # on n'ouvre pas la portière d'une voiture qui roule à plus de 11 km/h
const T_PORTE := 0.25            # durée d'ouverture, et de fermeture, d'une portière
const T_ENTREE := 0.7            # côté conducteur : la voiture ne démarre pas avant
const T_ENTREE_PASSAGER := 1.5   # côté passager : le temps de se glisser jusqu'au volant
const T_SORTIE := 0.7            # la portière s'ouvre, le héros sort, elle se referme
const T_POIGNEE := 0.35          # portière fermée à clé : la poignée résiste
const ANGLE_PORTE := 1.1         # portière grande ouverte : 63°
const ANGLE_FERMEE := 0.07       # fermée à clé, elle bouge à peine (3° au plus)
const ECART_PORTE := 1.7         # où il faut de la place pour ouvrir : 0,7 m à côté de la caisse
const ECART_VOITURE := 2.4       # où le héros se retrouve en descendant d'une voiture…
const ECART_MOTO := 1.2          # … et d'une moto
const BOUT_VOITURE := 3.4        # à défaut : derrière ou devant le véhicule
const BOUT_MOTO := 1.9
const RAYON := 0.4               # le héros : même capsule que player.gd
const MARGE := 0.1
const SAUT_SANTE_BASE := 5.0     # saut en marche : 5 points, plus 2 par m/s au-dessus de V_DESCENTE
const SAUT_SANTE := 2.0
const SAUT_SANTE_MIN := 5.0      # comme une chute à moto (décision 53) : jamais évanoui pour ça
const SAUT_T := 2.0              # secondes par terre après le saut
const ROULE_FIN := 0.3           # m/s : le véhicule lâché est considéré arrêté
const GARES_FERMES := [3, 4]     # voitures garées fermées à clé (rang dans main.PARK)
const CIRCULATION_FERMEE := 3    # dans la circulation, un conducteur sur trois verrouille ses portières
const TAXI := "f2c200"           # les taxis ne sont jamais verrouillés : ils prennent des clients

var pret := false
var anims: Array = []      # portières en mouvement : {"car", "k", "t", "dur", "angle", "tenue"}
var libres: Array = []     # véhicules qui roulent seuls après un saut en marche
var attente := 0.0         # secondes avant de pouvoir démarrer : le héros s'installe
var cote_entree := 0       # dernière montée : +1 côté conducteur, -1 côté passager, 0 moto
var emprunts := 0          # véhicules occupés empruntés
var signalements := 0      # emprunts qui valent une recherche (décision 54 : dès le deuxième)
var refus := 0             # portières fermées à clé essayées
var sauts := 0             # sauts en marche
var raison := ""           # pourquoi la dernière demande a été refusée ("" si elle a réussi)
var capsule: CapsuleShape3D

# Au premier passage : quelles portières sont fermées à clé. Aucun tirage au hasard (la ville
# doit rester la même d'un lancement à l'autre) : on prend des rangs fixes.
func prepare(m) -> void:
	pret = true
	for i in GARES_FERMES:
		if i < m.cars.size() and not m.cars[i].moto:
			m.cars[i].set_meta("verrou", true)
	var n := 0
	for c in m.traffic:
		if c.moto or c.col == Color(TAXI):
			continue
		n += 1
		if n % CIRCULATION_FERMEE == 0:
			c.set_meta("verrou", true)

func verrou(c) -> bool:
	return not c.moto and c.has_meta("verrou") and c.get_meta("verrou")

func _gauche(c) -> Vector3:
	return Vector3(cos(c.heading), 0, -sin(c.heading))

func _avant(c) -> Vector3:
	return Vector3(sin(c.heading), 0, cos(c.heading))

# De quel côté du véhicule se trouve ce point : +1 côté conducteur (gauche), -1 côté passager.
func cote(c, pos: Vector3) -> int:
	return 1 if (pos - c.global_position).dot(_gauche(c)) >= 0.0 else -1

# ---------------- place libre ----------------
# Le héros tient-il debout à cet endroit ? Ni dans la mer, ni dans un autre véhicule, ni dans
# un mur ou un objet du décor. « sauf » : véhicules à ne pas compter (celui dont on descend).
func place_libre(m, pos: Vector3, sauf: Array = []) -> bool:
	if m.ground_h(pos.x, pos.z) < -0.2:
		return false
	for v in m.cars + m.traffic:
		if v in sauf:
			continue
		var d: Vector3 = pos - v.global_position
		var lx: float = abs(d.dot(_gauche(v)))
		var lz: float = abs(d.dot(_avant(v)))
		if lx < (0.4 if v.moto else 1.0) + RAYON + MARGE and lz < (0.9 if v.moto else 2.2) + RAYON + MARGE:
			return false
	if capsule == null:
		capsule = CapsuleShape3D.new()
		capsule.radius = RAYON
		capsule.height = 1.8
	var q := PhysicsShapeQueryParameters3D.new()
	q.shape = capsule
	q.transform = Transform3D(Basis(), pos + Vector3(0, 1.0, 0))
	q.collision_mask = 1
	q.exclude = _mobiles(m)
	return m.get_world_3d().direct_space_state.intersect_shape(q, 1).is_empty()

# Rien entre le véhicule et cet endroit (un muret, un mur mince) ?
func acces_libre(m, c, pos: Vector3) -> bool:
	var q := PhysicsRayQueryParameters3D.create(c.global_position + Vector3(0, 1.0, 0), pos + Vector3(0, 1.0, 0), 1, _mobiles(m))
	return m.get_world_3d().direct_space_state.intersect_ray(q).is_empty()

# Les véhicules et le héros sont comptés à part (par le calcul) : on les retire des recherches
# dans le décor.
func _mobiles(m) -> Array:
	var out: Array = [m.player.get_rid()]
	for v in m.cars + m.traffic:
		out.append(v.get_rid())
	return out

# Où descendre : à gauche (côté conducteur), sinon à droite, sinon derrière, sinon devant.
# Renvoie null s'il n'y a de place nulle part.
func chercher_place(m, c):
	var lat: float = ECART_MOTO if c.moto else ECART_VOITURE
	var lon: float = BOUT_MOTO if c.moto else BOUT_VOITURE
	var g := _gauche(c)
	var f := _avant(c)
	for d in [g * lat, -g * lat, -f * lon, f * lon]:
		var pos: Vector3 = c.global_position + d
		if place_libre(m, pos, [c]) and acces_libre(m, c, pos):
			return pos
	return null

# Descente obligée (chute, évanouissement) sans place autour : on cherche plus loin, en cercle.
func _place_forcee(m, c) -> Vector3:
	for r in [3.6, 5.0, 7.0]:
		for i in 8:
			var a: float = c.heading - i * PI / 4.0
			var pos: Vector3 = c.global_position + Vector3(cos(a), 0, -sin(a)) * r
			if place_libre(m, pos, [c]) and acces_libre(m, c, pos):
				return pos
	return c.global_position + _gauche(c) * (ECART_MOTO if c.moto else ECART_VOITURE)

# ---------------- touche E ----------------
# Appelé par main.toggle_car() : descendre si on est à bord, sinon monter dans le véhicule le plus proche.
func toggle(m) -> void:
	if not pret:
		prepare(m)
	var pl = m.player
	if m.cur_car:
		descendre(m, pl.ko_t > 0.0)
		return
	var c = m._nearest_car()
	if c == null or pl.ko_t > 0.0 or pl.down_t > 0.0 or pl.swimming:
		return
	if c.moto and c.fallen:
		# une moto couchée se relève d'abord ; on remonte ensuite
		c.stand_up()
		m.say("Moto relevée — E pour remonter", 3.0)
		return
	entrer(m, c)

# ---------------- monter ----------------
# Le héros monte par la portière du côté où il se tient ; si elle est bloquée, par l'autre.
# Renvoie false (et dit pourquoi) s'il ne peut pas monter.
func entrer(m, c) -> bool:
	if not pret:
		prepare(m)
	raison = ""
	if c.moto:
		cote_entree = 0
		attente = 0.0
		m.mount(c)
		return true
	if c.ai and abs(c.speed) > V_EMPRUNT:
		raison = "roule"
		m.say("Elle roule : mets-toi devant pour l'arrêter, puis ouvre la portière.", 3.0)
		return false
	var k: int = cote(c, m.player.global_position)
	if not porte_libre(m, c, k):
		k = -k
		if not porte_libre(m, c, k):
			raison = "bloquee"
			m.say("Pas la place d'ouvrir une portière.", 3.0)
			return false
	if verrou(c):
		raison = "fermee"
		refus += 1
		_anim(c, k, T_POIGNEE, ANGLE_FERMEE, false)
		m.say("Le conducteur a verrouillé ses portières." if c.ai else "Portière fermée à clé.", 3.0)
		return false
	if c.ai:
		# décision 54 : la première fois passe ; si le joueur recommence, cela vaut une recherche
		emprunts += 1
		if emprunts >= 2:
			signalements += 1
	m.mount(c)
	cote_entree = k
	attente = T_ENTREE if k > 0 else T_ENTREE_PASSAGER
	_anim(c, k, T_ENTREE, ANGLE_PORTE, false)
	if k < 0:
		m.say("Monté côté passager : Koffi se glisse jusqu'au volant.", 2.5)
	return true

# Y a-t-il la place d'ouvrir cette portière et de s'y tenir ?
func porte_libre(m, c, k: int) -> bool:
	return place_libre(m, c.global_position + _gauche(c) * (k * ECART_PORTE), [c])

# Le héros vient de monter : la voiture ne démarre pas tant qu'il s'installe.
func bloque(m) -> bool:
	return attente > 0.0 and m.cur_car != null and not m.cur_car.moto

# ---------------- descendre ----------------
# Renvoie false (et dit pourquoi) si le héros reste à bord. « force » : chute ou évanouissement,
# il sort de toute façon.
func descendre(m, force := false) -> bool:
	var c = m.cur_car
	if c == null:
		return false
	raison = ""
	if not force and abs(c.speed) > V_DESCENTE:
		return sauter(m)
	var p = chercher_place(m, c)
	if p == null:
		if not force:
			raison = "pas_de_place"
			m.say("Pas la place de descendre ici : avance un peu.", 3.0)
			return false
		p = _place_forcee(m, c)
	_poser(m, c, p)
	c.speed = 0.0
	if not c.moto:
		_anim(c, cote(c, p), T_SORTIE, ANGLE_PORTE, false)
	return true

# Saut en marche : le héros roule par terre et se fait mal, le véhicule continue sur sa lancée.
func sauter(m) -> bool:
	var c = m.cur_car
	var pl = m.player
	if c.moto and c.loaded:
		raison = "client"
		m.say("Tu as un client à bord : arrête-toi d'abord.", 3.0)
		return false
	var p = chercher_place(m, c)
	if p == null:
		raison = "pas_de_place"
		m.say("Pas la place de sauter ici.", 3.0)
		return false
	var v: float = c.speed
	_poser(m, c, p)
	var perte: float = min(SAUT_SANTE_BASE + (abs(v) - V_DESCENTE) * SAUT_SANTE, pl.health - SAUT_SANTE_MIN)
	pl.hurt(perte)
	pl.fall_down(SAUT_T)
	if c.moto:
		c.fall()   # sans pilote, la moto se couche et glisse
	else:
		_anim(c, cote(c, p), T_SORTIE, ANGLE_PORTE, true)   # la portière reste ouverte tant que la voiture roule
	c.speed = v
	libres.append(c)
	sauts += 1
	m.say("Saut en marche à %d km/h ! -%d de santé." % [int(abs(v) * 3.6), int(max(perte, 0.0))], 4.0)
	return true

# Le héros se retrouve debout à cet endroit, tourné comme le véhicule.
func _poser(m, c, p: Vector3) -> void:
	var pl = m.player
	pl.global_position = p
	pl.heading = c.heading
	pl.rotation.y = c.heading
	pl.visible = true
	pl.shape.disabled = false
	pl.reset_pose()
	m.cur_car = null
	attente = 0.0

# ---------------- à chaque image ----------------
func step(m, delta: float) -> void:
	if not pret:
		prepare(m)
	attente = max(0.0, attente - delta)
	# véhicules lâchés en marche : ils roulent tout droit sur leur lancée (car.idle() les freine)
	for c in libres.duplicate():
		if c == m.cur_car or abs(c.speed) < ROULE_FIN:
			libres.erase(c)
			for a in anims:
				if a.car == c and a.tenue:
					a.tenue = false
					a.t = a.dur - T_PORTE   # la voiture est arrêtée : la portière se referme
			continue
		c._advance(delta)
		c._spin(delta)
	for a in anims.duplicate():
		a.t += delta
		var x: float = a.t if a.tenue else min(a.t, a.dur - a.t)
		_porte(a.car, a.k).rotation.y = -a.k * a.angle * clamp(x / T_PORTE, 0.0, 1.0)
		if not a.tenue and a.t >= a.dur:
			_porte(a.car, a.k).rotation.y = 0.0
			anims.erase(a)

# ---------------- portières ----------------
# Une portière en mouvement à la fois par côté : la nouvelle remplace l'ancienne.
func _anim(c, k: int, dur: float, angle: float, tenue: bool) -> void:
	for a in anims.duplicate():
		if a.car == c:
			_porte(c, a.k).rotation.y = 0.0
			anims.erase(a)
	_porte(c, k)
	anims.append({"car": c, "k": k, "t": 0.0, "dur": dur, "angle": angle, "tenue": tenue})

# La portière (créée la première fois qu'on s'en sert) : un panneau et sa vitre, articulés à l'avant.
func _porte(c, k: int) -> Node3D:
	var nom: String = "porte_g" if k > 0 else "porte_d"
	if c.has_meta(nom):
		return c.get_meta(nom)
	var pv := Node3D.new()
	pv.position = Vector3(k * 1.02, 0.78, 0.55)
	c.body.add_child(pv)
	var mn = c.main_ref
	mn.box(Vector3(0.06, 0.6, 1.1), c.col.darkened(0.12), Vector3(0, 0, -0.55), pv)
	mn.box(Vector3(0.05, 0.4, 0.9), Color("1e2a33"), Vector3(0, 0.66, -0.6), pv)
	c.set_meta(nom, pv)
	return pv

# Angle d'ouverture d'une portière, en radians (0 : fermée).
func angle_porte(c, k: int) -> float:
	var nom: String = "porte_g" if k > 0 else "porte_d"
	return abs(c.get_meta(nom).rotation.y) if c.has_meta(nom) else 0.0
