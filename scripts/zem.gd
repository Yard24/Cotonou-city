extends RefCounted
# Courses de zémidjan : des clients attendent au bord de la route. Le joueur s'arrête à moto
# près de l'un d'eux, le client annonce sa destination et son prix, le joueur accepte avec M,
# le client monte à l'arrière, et la course est payée à l'arrivée
# (décision 64). Fonctionnement attendu : docs/systemes/conduite_moto.md.

# points d'attente : [x, z, cap du client (il regarde la route), nom du lieu]
const SPOTS := [
	[7.8, -75.0, -PI / 2, "place de l'Amazone"],
	[30.0, 7.8, PI, "marché Dantokpa"],
	[-40.0, -152.2, PI, "boulevard de la Marina"],
	[127.8, 110.0, -PI / 2, "grand carrefour de l'Est"],
	[-127.8, 20.0, PI / 2, "avenue de l'Ouest"],
	[-60.0, 127.8, PI, "bout de la grande avenue"]]
const SHIRTS := ["d94f8a", "2a7de1", "ffffff", "ff7a00", "8e2bd1", "14a3a3"]
const SIGNE := 30.0        # le client lève le bras quand une moto libre approche à moins de 30 m
const PRISE := 6.0         # il propose sa course si la moto s'arrête à moins de 6 m de lui
const DEPOSE := 7.0        # il descend si elle s'arrête à moins de 7 m de l'arrivée
const ARRET := 1.0         # « arrêtée » : moins de 1 m/s
const TARIF_MIN := 100     # FCFA (décision 64 : de 100 à 1 000 selon la distance)
const TARIF_MAX := 1000
const TARIF_PAR_M := 2.0
const ARRONDI := 50
const T_PART := 4.0        # le client descendu reste quelques secondes sur place
const T_TOMBE := 2.0       # tombé avec la moto, il reste 2 secondes par terre
const T_RETOUR := 30.0     # puis un client attend de nouveau au même endroit

var clients: Array = []
var fare := {}             # course en cours : {"cl", "moto", "dest", "prix"} ; vide s'il n'y en a pas
var dest_marker: Node3D
var done := 0              # courses payées
var hint := ""
var touche_tenue := false
var offer := {}            # client qui propose une course à la moto arrêtée : {"cl", "dest", "prix"}

# Touche « course » : la touche marquée M. Les autres touches du jeu sont repérées par leur
# place sur le clavier (ZQSD = WASD) ; à cette façon de compter, le M d'un clavier AZERTY est
# à la place du point-virgule d'un clavier QWERTY (la place du M QWERTY porte la virgule).
# On ajoute aussi la touche qui écrit « m », pour les claviers QWERTY.
const TOUCHE_PLACE := KEY_SEMICOLON
const TOUCHE_LETTRE := KEY_M
func inputs() -> void:
	if InputMap.has_action("course"):
		return
	InputMap.add_action("course")
	var e := InputEventKey.new()
	e.physical_keycode = TOUCHE_PLACE
	InputMap.action_add_event("course", e)
	var e2 := InputEventKey.new()
	e2.keycode = TOUCHE_LETTRE
	InputMap.action_add_event("course", e2)

func build(m) -> void:
	inputs()
	for i in SPOTS.size():
		var n := Node3D.new()
		m.add_child(n)
		var col := Color(SHIRTS[i % SHIRTS.size()])
		var parts: Dictionary = m.make_human(n, col, Color("2b2b40"), Color("5a3622"))
		var cl := {"n": n, "p": parts, "home": i, "state": "attend", "t": 0.0, "col": col}
		clients.append(cl)
		_place(cl, spot_pos(i), SPOTS[i][2])
	dest_marker = Node3D.new()
	m.add_child(dest_marker)
	var bm: MeshInstance3D = m.cyl(2.5, 2.5, 40, Color.WHITE, Vector3(0, 20, 0), dest_marker, 16)
	var mt := StandardMaterial3D.new()
	mt.albedo_color = Color(0.1, 0.75, 1.0, 0.3)
	mt.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mt.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mt.cull_mode = BaseMaterial3D.CULL_DISABLED
	bm.material_override = mt
	dest_marker.visible = false

func spot_pos(i: int) -> Vector3:
	return Vector3(SPOTS[i][0], 0.08, SPOTS[i][1])

# Prix d'une course selon la distance à vol d'oiseau, arrondi à 50 FCFA.
func tarif(d: float) -> int:
	return clampi(int(round((TARIF_MIN + d * TARIF_PAR_M) / ARRONDI)) * ARRONDI, TARIF_MIN, TARIF_MAX)

func _place(cl: Dictionary, pos: Vector3, h: float) -> void:
	cl.n.position = pos
	cl.n.rotation = Vector3(0, h, 0)
	cl.n.visible = true
	cl.p.armR.rotation.x = 0.0

func _dist(a: Vector3, b: Vector3) -> float:
	return Vector2(a.x - b.x, a.z - b.z).length()

# À chaque image.
func step(m, delta: float) -> void:
	hint = ""
	offer = {}
	var c = m.cur_car
	var riding: bool = c != null and c.moto and not c.fallen
	for cl in clients:
		if cl.state == "attend":
			var d: float = _dist(c.global_position, cl.n.position) if riding else INF
			var libre: bool = fare.is_empty() and d < SIGNE
			cl.p.armR.rotation.x = -2.7 if libre else 0.0   # il lève le bras
			if libre:
				cl.n.rotation.y = atan2(c.global_position.x - cl.n.position.x, c.global_position.z - cl.n.position.z)
				if d < PRISE and abs(c.speed) < ARRET:
					# il annonce sa destination et son prix ; le joueur accepte avec M, ou repart
					if offer.is_empty():
						offer = _offer(cl)
						hint = "« %s, %d francs ? » — M : accepter la course" % [_maj(SPOTS[offer.dest][3]), offer.prix]
				elif hint == "":
					hint = "Un client te fait signe : arrête-toi près de lui"
		elif cl.state == "tombe":
			cl.t -= delta
			if cl.t <= 0.0:
				# il se relève (décision 4) et repart à pied
				_place(cl, Vector3(cl.n.position.x, 0.08, cl.n.position.z), cl.n.rotation.y)
				cl.state = "part"
				cl.t = T_PART
		elif cl.state == "part":
			cl.t -= delta
			if cl.t <= 0.0:
				cl.n.visible = false
				cl.state = "absent"
				cl.t = T_RETOUR
		elif cl.state == "absent":
			cl.t -= delta
			if cl.t <= 0.0:
				_place(cl, spot_pos(cl.home), SPOTS[cl.home][2])
				cl.state = "attend"
	# un appui sur M (pas la touche tenue)
	var appui: bool = Input.is_action_pressed("course")
	if appui and not touche_tenue:
		press(m)
	touche_tenue = appui
	if fare.is_empty():
		return
	if c != fare.moto:
		_end(m, false, 1.2)   # le pilote n'est plus sur la moto : le client descend aussi
		if m.info_t <= 0.0:
			m.say("Tu es descendu : ton client aussi. Course non payée.", 4.0)
		return
	var dd: float = _dist(c.global_position, spot_pos(fare.dest))
	if dd < DEPOSE and abs(c.speed) < ARRET:
		var prix: int = fare.prix
		var lieu: String = SPOTS[fare.dest][3]
		m.money += prix
		done += 1
		_end(m, true, 0.0)
		m._banner("COURSE TERMINÉE\n%s · +%d FCFA" % [_maj(lieu), prix])
	elif dd < 25.0:
		hint = "Arrête-toi près de la colonne bleue pour déposer ton client"

# Ce que le client demande : où il va et combien il paie.
func _offer(cl: Dictionary) -> Dictionary:
	var dest: int = (cl.home + 2 + done) % SPOTS.size()
	if dest == cl.home:
		dest = (dest + 1) % SPOTS.size()
	return {"cl": cl, "dest": dest, "prix": tarif(_dist(spot_pos(cl.home), spot_pos(dest)))}

# Touche M : accepter la course proposée ; avec un client à bord, le déposer ici.
# (E ne sert qu'à monter et descendre.)
func press(m) -> void:
	if m.cur_car == null:
		return
	if not offer.is_empty():
		accept(m)
	elif not fare.is_empty():
		drop_here(m)

# Touche M devant un client qui propose sa course : il monte, colonne bleue à l'arrivée.
func accept(m) -> void:
	if offer.is_empty() or not fare.is_empty():
		return
	var cl: Dictionary = offer.cl
	var c = m.cur_car
	var dest: int = offer.dest
	var prix: int = offer.prix
	offer = {}
	hint = ""
	fare = {"cl": cl, "moto": c, "dest": dest, "prix": prix}
	cl.state = "a_bord"
	cl.n.visible = false
	c.set_passenger(true, cl.col)
	dest_marker.position = Vector3(SPOTS[dest][0], 0, SPOTS[dest][1])
	dest_marker.visible = true
	m.say("Le client monte. %s : suis la colonne bleue (%d FCFA à l'arrivée)." % [_maj(SPOTS[dest][3]), prix], 6.0)

func _maj(s: String) -> String:
	return s.substr(0, 1).to_upper() + s.substr(1)

# Fin de la course. arrive : le client est posé sur le trottoir de l'arrivée ; sinon à côté
# de la moto, à sa droite (le pilote descend à gauche).
func _end(_m, arrive: bool, ecart: float) -> void:
	var cl: Dictionary = fare.cl
	var c = fare.moto
	c.set_passenger(false)
	if arrive:
		var h: float = SPOTS[fare.dest][2]
		_place(cl, spot_pos(fare.dest) + Vector3(cos(h), 0, -sin(h)) * 1.4, h)
	else:
		var hm: float = c.heading
		_place(cl, c.global_position - Vector3(cos(hm), 0, -sin(hm)) * ecart + Vector3(0, 0.08, 0), hm)
	cl.state = "part"
	cl.t = T_PART
	fare = {}
	dest_marker.visible = false

# Touche M avec un client à bord : on le dépose ici, la course n'est pas payée.
func drop_here(m) -> void:
	if abs(fare.moto.speed) > 6.0:
		return
	_end(m, false, 1.2)
	m.say("Client déposé avant l'arrivée : course non payée.", 4.0)

# Chute à moto avec un client : il tombe aussi, se relève et repart à pied ; course perdue.
func on_fall(m, _c) -> void:
	if fare.is_empty():
		return
	var cl: Dictionary = fare.cl
	_end(m, false, 1.3)
	cl.n.position.y = 0.3
	cl.n.rotation.x = -PI / 2
	cl.state = "tombe"
	cl.t = T_TOMBE
	m.say("Chute ! Ton client repart à pied : course perdue. Relève la moto avec E.", 5.0)
