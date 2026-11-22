extends Control
# Commandes tactiles : manette virtuelle à gauche, boutons d'action à droite, bouton Pause.
# Les boutons ne font qu'appuyer sur les mêmes actions d'entrée que le clavier (« up »,
# « enter », « course »…) : il n'y a qu'une logique de jeu, la même au doigt et au clavier.
# Aussi ici : bouton Retour d'Android, mise en arrière-plan, zone sûre (encoche), textes
# qui citent le bouton tactile au lieu de la touche.
# Fonctionnement attendu : docs/systemes/commandes_tactiles.md. Vérifications : selftest_tactile.gd.

# Boutons : [identifiant, action d'entrée, façon d'appuyer, texte]
# « tenir » : l'action reste appuyée tant que le doigt est posé ; « bascule » : un appui
# l'allume, le suivant l'éteint (courir, s'accroupir).
const BOUTONS := [
	["pause", "quit", "tenir", "Pause"],
	["enter", "enter", "tenir", "Monter"],
	["course", "course", "tenir", "Course"],
	["jump", "jump", "tenir", "Sauter"],
	["run", "run", "bascule", "Courir"],
	["crouch", "crouch", "bascule", "S'accrou-\npir"],
	["gaz", "up", "tenir", "Accélérer"],
	["frein", "down", "tenir", "Freiner"],
	["frein_main", "brake", "tenir", "Frein\nà main"],
	["klaxon", "horn", "tenir", "Klaxon"],
	["camera", "cam", "tenir", "Caméra"],
	["phares", "lights", "tenir", "Phares"],
	["clign_g", "blink_l", "tenir", "◄ Clign."],
	["clign_d", "blink_r", "tenir", "Clign. ►"]]
const DIRECTIONS := ["up", "down", "left", "right"]
const MM_BOUTON := 11.0       # côté visé d'un grand bouton, en millimètres…
const MM_MIN := 9.5           # … et jamais moins (consigne : 9 mm au moins)
const BOUTON_BASE := 104.0    # côté d'un grand bouton en unités d'écran (écran de 720 de haut)
const MARGE := 20.0           # du bord de l'écran ou de la zone sûre
const MARGE_COINS := 14.0     # en plus sur téléphone : coins arrondis
const ECART := 12.0           # entre deux boutons
const ZONE_MORTE := 0.18      # manette : rien sous 18 % de la course
const SEUIL_VEHICULE := 0.55  # en véhicule, la manette n'accélère et ne freine qu'au-delà de 55 %
const KLAXON_PIETON := 25.0   # le klaxon n'apparaît qu'avec quelqu'un à moins de 25 m…
const KLAXON_VEHICULE := 30.0 # … ou un véhicule à moins de 30 m devant
const AIDE := "Manette à gauche : avancer, reculer, tourner ; à moto ou en voiture, diriger\nÀ pied — boutons Sauter, Courir et S'accroupir à droite\nEn véhicule — Accélérer et Freiner à droite, la manette pour tourner : les deux en même temps\nMonter, Descendre, Utiliser, Course, Frein à main et Klaxon apparaissent quand ils servent\nSous la mini-carte — Caméra · Phares · Clignotants\nZémidjan — arrête ta moto près d'un client qui lève le bras, « Course » pour accepter, puis conduis-le à la colonne bleue\nOptions > Graphismes : niveau graphique et images par seconde · Pause : bouton en haut à droite"
# Touches citées dans les textes du jeu, et leur équivalent tactile (voir adapter()).
const TOUCHES := "E|M|V|H|L|J|K|C|Espace|Maj|Échap|Entrée|F3|F4"
const PHRASES := [
	["Flèches ou ZQSD : bouger · E : monter/descendre · Espace : sauter (frein en véhicule) · Maj : courir · C : s'accroupir · Échap : pause",
		"Manette à gauche : bouger · boutons à droite : agir · Pause : en haut à droite"],
	["Une touche de direction pour te lever", "Pousse la manette pour te lever"],
	[" (Entrée)", ""], [" (Échap)", ""], [" (F4 en jeu)", ""], [" (F3 en jeu)", ""], [" (F4)", " (Options)"]]

var main
var options
var reel := false             # vrai écran tactile (téléphone, tablette)
var actif := false            # commandes affichées en ce moment
var mode := false             # jeu au doigt : textes adaptés (actif, ou affichable)
var boutons := {}             # id -> {action, facon, texte, rect, vu, on}
var unite := 4.0              # unités d'écran par millimètre
var grand := BOUTON_BASE      # côté d'un grand bouton
var petit := 80.0             # côté d'un petit bouton
var marges := [0.0, 0.0, 0.0, 0.0]   # zone sûre : gauche, haut, droite, bas
var ecran := Vector2.ZERO     # taille de l'écran pour laquelle la disposition est faite
var echelle := 1.0            # réduction de l'affichage pour tenir dans la zone sûre
var taille_vue := -1
var manette := {"base": Vector2.ZERO, "centre": Vector2.ZERO, "rayon": 100.0, "zone": Rect2(), "doigt": -1, "v": Vector2.ZERO}
var doigts := {}              # numéro du doigt -> id du bouton, ou "manette"
var nouveaux: Array = []      # boutons touchés depuis la dernière image
var presses := {}             # action -> image où nous l'avons appuyée
var forces := {}              # action -> force voulue à cette image
var dernier := ""             # dernier bouton touché (pour le test)
var image_test := -1          # test automatique : compteur d'images simulé (-1 : le vrai)
var hud_origine := {}
var hauteurs := {}            # hauteur d'origine des boutons de l'écran d'accueil
var t_zone := 0.0
var t_klaxon := 0
var klaxon_utile := false
var police: Font
var re_touches: RegEx
var fond: StyleBoxFlat

func build(m, opt) -> void:
	main = m
	options = opt
	reel = OS.has_feature("mobile") and DisplayServer.is_touchscreen_available()
	var couche := CanvasLayer.new()
	couche.layer = 2   # au-dessus de l'affichage, sous les panneaux des menus
	m.add_child(couche)
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	couche.add_child(self)
	police = ThemeDB.fallback_font
	fond = StyleBoxFlat.new()
	fond.set_corner_radius_all(18)
	fond.set_border_width_all(3)
	for b in BOUTONS:
		boutons[b[0]] = {"action": b[1], "facon": b[2], "texte": b[3], "rect": Rect2(), "vu": false, "on": false}
	for l in [m.l_hint, m.l_speed, m.l_mission]:
		hud_origine[l] = [l.anchor_left, l.anchor_right, l.offset_left, l.offset_right, l.offset_top, l.offset_bottom, l.horizontal_alignment]
	visible = false

# Les commandes s'affichent sur un écran tactile, ou partout si l'option les force.
func voulu() -> bool:
	return reel or (options != null and options.v.get("tactile_force", false))

# ---------------- à chaque image ----------------
func step(m, delta: float) -> void:
	var nouveau_mode := voulu()
	if nouveau_mode != mode:
		mode = nouveau_mode
		_textes(m)
	var montrer: bool = mode and not m.menu.visible and not m.sys.menus.ouvert()
	if montrer != actif:
		actif = montrer
		visible = actif
		if not actif:
			tout_lacher()
		_hud(m)
	t_zone -= delta
	var vue := get_viewport().get_visible_rect().size if is_inside_tree() else Vector2(1280, 720)
	var taille: int = options.v.get("tactile_taille", 100) if options else 100
	if t_zone <= 0.0 or vue != ecran or taille != taille_vue:
		t_zone = 0.5   # l'écran peut tourner (paysage dans l'autre sens) : on revérifie souvent
		zone_sure(m)
		disposer(vue, unite_mm(vue), marges, taille / 100.0)
		taille_vue = taille
		_hud(m)
	if not actif:
		_relacher_vieux()   # bouton Retour pendant un menu : « quit » est lâché à l'image suivante
		return
	contexte(m)
	appliquer()
	queue_redraw()

# Unités d'écran par millimètre, d'après la densité de l'écran.
func unite_mm(vue: Vector2) -> float:
	var fen := DisplayServer.window_get_size()
	var dpi := float(DisplayServer.screen_get_dpi())
	if fen.y <= 0 or vue.y <= 0.0 or dpi <= 0.0:
		return 4.0
	return dpi / 25.4 / (fen.y / vue.y)

# Zone de l'écran sans encoche ni bords arrondis. Sur téléphone, l'affichage et les menus
# sont resserrés dedans (légère réduction) ; sur PC rien ne change.
func zone_sure(m) -> void:
	marges = [0.0, 0.0, 0.0, 0.0]
	if not OS.has_feature("mobile") or not is_inside_tree():
		return
	var fen := DisplayServer.window_get_size()
	var sa := DisplayServer.get_display_safe_area()
	var vue := get_viewport().get_visible_rect().size
	if fen.x <= 0 or sa.size.x <= 0:
		return
	var k: float = vue.x / fen.x
	marges = [maxf(0.0, sa.position.x * k), maxf(0.0, sa.position.y * k), maxf(0.0, (fen.x - sa.end.x) * k), maxf(0.0, (fen.y - sa.end.y) * k)]
	var s := reduction(vue, marges)
	for couche in [m.l_money.get_parent(), m.sys.menus.racine.get_parent()]:
		couche.offset = Vector2(marges[0], marges[1])
		couche.scale = Vector2(s, s)

static func reduction(vue: Vector2, zs: Array) -> float:
	return minf((vue.x - zs[0] - zs[2]) / vue.x, (vue.y - zs[1] - zs[3]) / vue.y)

# Point de l'affichage (hud.gd, écran de 1280 × 720 étiré) vers l'écran, et l'inverse.
func vers_ecran(p: Vector2) -> Vector2:
	return Vector2(marges[0], marges[1]) + p * echelle

func depuis_ecran(p: Vector2) -> Vector2:
	return (p - Vector2(marges[0], marges[1])) / echelle

# ---------------- disposition ----------------
# Place les boutons pour un écran de taille « vue » (unités d'écran), « u » unités par mm,
# et des marges de zone sûre [gauche, haut, droite, bas].
func disposer(vue: Vector2, u: float, zs: Array, facteur := 1.0) -> void:
	ecran = vue
	unite = u
	marges = zs.duplicate()
	echelle = reduction(vue, zs)
	grand = maxf(BOUTON_BASE, MM_BOUTON * u) * facteur
	grand = minf(grand, vue.y * 0.2)
	grand = maxf(grand, MM_MIN * u)
	petit = maxf(grand * 0.72, MM_MIN * u)
	var coins := MARGE_COINS if OS.has_feature("mobile") else 0.0
	var g: float = zs[0] + MARGE + coins
	var h: float = zs[1] + MARGE
	var d: float = vue.x - zs[2] - MARGE - coins
	var bas: float = vue.y - zs[3] - MARGE
	var G := grand
	# trois colonnes à droite, de la plus à droite à la plus à gauche
	var x1 := d - G
	var x2 := x1 - ECART - G
	var x3 := x2 - ECART - G
	var haut_pedale := bas - 1.5 * G
	_pose("gaz", Rect2(x1, haut_pedale, G, 1.5 * G))
	_pose("frein", Rect2(x2, bas - 1.15 * G, G, 1.15 * G))
	_pose("frein_main", Rect2(x3, bas - G, G, G))
	# à pied, aux mêmes places
	_pose("jump", Rect2(x1, bas - 1.2 * G, G, 1.2 * G))
	_pose("run", Rect2(x2, bas - G, G, G))
	_pose("crouch", Rect2(x3, bas - G, G, G))
	# rangée au-dessus : monter ou descendre, course, klaxon
	var y2 := haut_pedale - ECART - G
	_pose("enter", Rect2(x1, y2, G, G))
	_pose("course", Rect2(x2, y2, G, G))
	_pose("klaxon", Rect2(x3, y2, G, G))
	# sous la mini-carte et les étoiles de recherche : caméra, phares, clignotants
	var S := petit
	var y_petits: float = vers_ecran(Vector2(0, 248.0)).y + ECART
	var x := d
	if y_petits + S > y2 - ECART:
		# pas la place sous les étoiles (grands boutons) : sur la ligne d'action, à gauche du klaxon
		# (et plus petits s'il le faut pour ne pas toucher la manette, jamais sous 9,5 mm)
		var place: float = x3 - ECART - (g + 2.0 * 0.95 * G + 10.0 + ECART)
		S = maxf(MM_MIN * u, minf(S, place / 4.0 - ECART))
		petit = S
		y_petits = y2 + G - S
		x = x3 - ECART
	for id in ["clign_d", "clign_g", "phares", "camera"]:
		x -= S
		_pose(id, Rect2(x, y_petits, S, S))
		x -= ECART
	# Pause : en haut, juste à gauche de la mini-carte (206 unités du bord droit)
	_pose("pause", Rect2(vers_ecran(Vector2(vue.x - 206.0, 0)).x - ECART - S, h, S, S))
	# manette : en bas à gauche ; on peut poser le pouce n'importe où dans sa zone
	var r := 0.95 * G
	manette.rayon = r
	manette.base = Vector2(g + r + 10.0, bas - r - 10.0)
	if manette.doigt < 0:
		manette.centre = manette.base
	manette.zone = Rect2(g, vue.y * 0.38, maxf(vue.x * 0.42, 2.0 * r + 40.0) - g, bas - vue.y * 0.38)

func _pose(id: String, r: Rect2) -> void:
	boutons[id].rect = r

# ---------------- ce qui est utile maintenant ----------------
func contexte(m) -> void:
	var pl = m.player
	var c = m.cur_car
	for id in boutons:
		boutons[id].vu = false
	boutons.pause.vu = true
	if c:
		var v: float = abs(c.speed)
		for id in ["gaz", "frein", "camera", "phares", "clign_g", "clign_d"]:
			boutons[id].vu = true
		boutons.enter.vu = true
		boutons.enter.texte = "Sauter\nen marche" if v > m.emb.V_DESCENTE else "Descendre"
		boutons.frein_main.vu = v > 2.0
		boutons.frein_main.texte = "Frein\narrière" if c.moto else "Frein\nà main"
		t_klaxon -= 1
		if t_klaxon <= 0:
			t_klaxon = 15
			klaxon_utile = _klaxon_utile(m, c)
		boutons.klaxon.vu = klaxon_utile
		boutons.run.on = false
		boutons.crouch.on = false
	else:
		var occupe: bool = pl.ko_t > 0.0 or pl.down_t > 0.0 or pl.mantle_t > 0.0
		boutons.run.vu = not occupe and not pl.sitting
		boutons.run.texte = "Nager\nvite" if pl.swimming else "Courir"
		boutons.jump.vu = not occupe and not pl.sitting and not pl.swimming
		boutons.crouch.vu = boutons.jump.vu
		if pl.swimming:
			boutons.crouch.on = false
		var t := texte_action(m)
		boutons.enter.vu = t != "" and not occupe
		if t != "":
			boutons.enter.texte = t
	var z = m.zem
	if not z.offer.is_empty():
		boutons.course.vu = true
		boutons.course.texte = "Accepter\nla course"
	elif not z.fare.is_empty() and c and abs(c.speed) < 1.5:
		boutons.course.vu = true
		boutons.course.texte = "Déposer\nle client"

# Texte du bouton d'action à pied (le même choix que press_e() dans main.gd) ; "" : rien à faire.
func texte_action(m) -> String:
	var pl = m.player
	if pl.sitting:
		return ""
	var it: Dictionary = m.inter.nearest(m)
	var c = m._nearest_car()
	if not it.is_empty() and (c == null or it.d <= c.global_position.distance_to(pl.global_position)):
		match it.kind:
			"eau":
				return "Acheter"
			"banc":
				return "S'asseoir"
			"panneau":
				return "Lire"
		return "Utiliser"
	if c != null:
		return "Relever" if c.moto and c.fallen else "Monter"
	return ""

# Le klaxon sert quand quelqu'un est près, ou un véhicule devant.
func _klaxon_utile(m, c) -> bool:
	var p: Vector3 = c.global_position
	for n in m.npcs:
		if n.n.position.distance_to(p) < KLAXON_PIETON:
			return true
	var avant := Vector3(sin(c.heading), 0, cos(c.heading))
	for t in m.traffic:
		var d: Vector3 = t.global_position - p
		if t != c and d.length() < KLAXON_VEHICULE and d.dot(avant) > 0.0:
			return true
	return false

# ---------------- toucher ----------------
func _input(ev: InputEvent) -> void:
	if traiter(ev):
		get_viewport().set_input_as_handled()

# Reçoit un toucher (ou, sur PC sans écran tactile, la souris comme un doigt).
# Renvoie true si l'événement touchait une commande.
func traiter(ev: InputEvent) -> bool:
	if not actif:
		return false
	if ev is InputEventScreenTouch:
		return _doigt(ev.index, ev.position, ev.pressed)
	if ev is InputEventScreenDrag:
		return _glisse(ev.index, ev.position)
	if not reel:
		if ev is InputEventMouseButton and ev.button_index == MOUSE_BUTTON_LEFT:
			return _doigt(0, ev.position, ev.pressed)
		if ev is InputEventMouseMotion and (ev.button_mask & MOUSE_BUTTON_MASK_LEFT):
			return _glisse(0, ev.position)
	return false

func _doigt(i: int, p: Vector2, pose: bool) -> bool:
	if not pose:
		if not doigts.has(i):
			return false
		if doigts[i] == "manette":
			manette.doigt = -1
			manette.v = Vector2.ZERO
			manette.centre = manette.base
		doigts.erase(i)
		return true
	var id := bouton_sous(p)
	if id != "":
		doigts[i] = id
		dernier = id
		var b: Dictionary = boutons[id]
		if b.facon == "bascule":
			b.on = not b.on
		nouveaux.append(id)
		return true
	if manette.zone.has_point(p) and manette.doigt < 0:
		doigts[i] = "manette"
		manette.doigt = i
		# la manette se centre sous le pouce, sans sortir de l'écran
		var r: float = manette.rayon
		manette.centre = Vector2(clampf(p.x, r, ecran.x - r), clampf(p.y, r, ecran.y - r))
		manette.v = Vector2.ZERO
		return true
	return false

func _glisse(i: int, p: Vector2) -> bool:
	if not doigts.has(i):
		return false
	if doigts[i] == "manette":
		manette.v = ((p - manette.centre) / manette.rayon).limit_length(1.0)
		return true
	# un doigt qui glisse d'une pédale à l'autre change de pédale
	var id := bouton_sous(p)
	if id != "" and id != doigts[i] and boutons[id].facon == "tenir" and boutons[doigts[i]].facon == "tenir":
		doigts[i] = id
		nouveaux.append(id)
	return true

# Bouton visible sous ce point (un peu plus large que le dessin, pour le pouce).
func bouton_sous(p: Vector2) -> String:
	for id in boutons:
		var b: Dictionary = boutons[id]
		if b.vu and b.rect.grow(ECART * 0.5).has_point(p):
			return id
	return ""

# Doigt posé sur ce bouton en ce moment.
func tenu(id: String) -> bool:
	return doigts.values().has(id)

# ---------------- vers les actions d'entrée ----------------
# Calcule la force voulue de chaque action, puis appuie ou relâche comme le ferait le clavier.
# Un toucher très bref reste appuyé une image au moins, pour que le jeu le voie.
func appliquer() -> void:
	forces = {}
	var v: Vector2 = manette.v
	var en_vehicule: bool = main.cur_car != null
	var fx := _force(absf(v.x))
	if v.x < 0.0:
		forces["left"] = fx
	else:
		forces["right"] = fx
	var fy := _force(absf(v.y))
	if en_vehicule and absf(v.y) < SEUIL_VEHICULE:
		fy = 0.0
	if v.y < 0.0:
		forces["up"] = fy
	else:
		forces["down"] = fy
	for id in boutons:
		var b: Dictionary = boutons[id]
		var appui: bool = (b.facon == "bascule" and b.on and b.vu) or (b.facon == "tenir" and b.vu and tenu(id))
		if nouveaux.has(id) and b.facon == "tenir":
			appui = true
		if appui:
			forces[b.action] = 1.0
	nouveaux = []
	var image := _image()
	for a in forces:
		if forces[a] > 0.0:
			Input.action_press(a, forces[a])
			if not presses.has(a):
				presses[a] = image
	for a in presses.keys():
		if forces.get(a, 0.0) <= 0.0 and image > presses[a]:
			Input.action_release(a)
			presses.erase(a)

func _image() -> int:
	return image_test if image_test >= 0 else Engine.get_physics_frames()

func _relacher_vieux() -> void:
	var image := _image()
	for a in presses.keys():
		if image > presses[a]:
			Input.action_release(a)
			presses.erase(a)

func _force(x: float) -> float:
	return 0.0 if x < ZONE_MORTE else clampf((x - ZONE_MORTE) / (1.0 - ZONE_MORTE) * 1.1, 0.0, 1.0)

# Tout relâcher : menu ouvert, commandes cachées, jeu mis de côté.
func tout_lacher() -> void:
	for a in presses:
		Input.action_release(a)
	presses = {}
	doigts = {}
	nouveaux = []
	manette.doigt = -1
	manette.v = Vector2.ZERO
	manette.centre = manette.base
	for id in boutons:
		boutons[id].on = false

# ---------------- Android : bouton Retour, arrière-plan ----------------
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_GO_BACK_REQUEST:
			retour_android()
		NOTIFICATION_APPLICATION_PAUSED:
			mise_de_cote()
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			if OS.has_feature("mobile"):
				mise_de_cote()

# Le bouton Retour fait comme Échap : pause, reprise, ou retour dans un panneau de menu.
func retour_android() -> void:
	nouveaux.append("pause")
	if main and not actif:
		# commandes cachées (menu ouvert) : l'action est appuyée ici pour une image
		Input.action_press("quit")
		presses["quit"] = _image()

# Appel, autre application : le jeu se met en pause et sauvegarde (emplacement automatique).
# Rien n'est sauvegardé depuis l'écran d'accueil : la partie n'a pas commencé.
func mise_de_cote() -> bool:
	if main == null:
		return false
	tout_lacher()
	var accueil: bool = main.menu.visible and main.menu_title.text != "PAUSE"
	if accueil:
		return false
	if not main.menu.visible:
		main.open_menu("PAUSE", "Reprendre")
	return main.sys.sauvegarde.sauver_auto(main)

# ---------------- textes ----------------
# Nom tactile d'une touche citée dans un texte.
func nom_bouton(touche: String) -> String:
	var en_vehicule: bool = main != null and main.cur_car != null
	match touche:
		"E":
			if boutons.has("enter") and boutons.enter.vu:
				return boutons.enter.texte.replace("\n", " ")
			return "Descendre" if en_vehicule else "Monter"
		"M":
			return "Course"
		"Espace":
			return "Frein à main" if en_vehicule else "Sauter"
		"Maj":
			return "Courir"
		"C":
			return "S'accroupir"
		"H":
			return "Klaxon"
		"L":
			return "Phares"
		"J":
			return "◄ Clign."
		"K":
			return "Clign. ►"
		"V":
			return "Caméra"
		"Échap":
			return "Pause"
		"Entrée":
			return "Jouer"
	return "Options"   # F3, F4

# Un texte qui cite une touche du clavier cite le bouton tactile quand on joue au doigt.
# Au clavier, il ne change pas.
func adapter(t: String) -> String:
	if not mode or t == "":
		return t
	for p in PHRASES:
		t = t.replace(p[0], p[1])
	if re_touches == null:
		re_touches = RegEx.create_from_string("(^|[\\s(—·])(" + TOUCHES + ")(?=$|[\\s):,]|\\.(?!\\s*[A-ZÀ-Ý]))")
	var out := ""
	var debut := 0
	for r in re_touches.search_all(t):
		out += t.substr(debut, r.get_start(2) - debut) + "« %s »" % nom_bouton(r.get_string(2))
		debut = r.get_end(2)
	out += t.substr(debut)
	return out.replace("touche «", "bouton «").replace("touches «", "boutons «")

# Mode changé : textes de l'accueil, de la mission et des menus.
func _textes(m) -> void:
	m.hud.l_aide.text = AIDE if mode else m.hud.aide_clavier
	m.menu_play.text = adapter(m.menu_play_texte)
	# boutons de l'écran d'accueil et de pause : plus hauts au doigt
	for b in _boutons_accueil(m.menu_play.get_parent()):
		if not hauteurs.has(b):
			hauteurs[b] = b.custom_minimum_size.y
		b.custom_minimum_size.y = maxf(hauteurs[b], 70.0) if mode else hauteurs[b]
	m._set_mission()

func _boutons_accueil(n: Node) -> Array:
	var out := []
	for c in n.get_children():
		if c is Button:
			out.append(c)
		else:
			out.append_array(_boutons_accueil(c))
	return out

# Au doigt, l'aide et la vitesse se placent entre la manette et les boutons.
func _hud(m) -> void:
	for l in hud_origine:
		var o: Array = hud_origine[l]
		l.anchor_left = o[0]
		l.anchor_right = o[1]
		l.offset_left = o[2]
		l.offset_right = o[3]
		l.offset_top = o[4]
		l.offset_bottom = o[5]
		l.horizontal_alignment = o[6]
	if not actif:
		return
	# bornes à l'écran, ramenées dans les unités de l'affichage
	var gauche: float = depuis_ecran(Vector2(manette.base.x + manette.rayon + 24.0, 0)).x
	var droite: float = ecran.x - depuis_ecran(Vector2(boutons.frein_main.rect.position.x - 16.0, 0)).x
	m.l_hint.offset_left = gauche
	m.l_hint.offset_right = -droite
	m.l_hint.offset_top = -150.0
	m.l_speed.anchor_left = 0.0
	m.l_speed.anchor_right = 1.0
	m.l_speed.offset_left = gauche
	m.l_speed.offset_right = -droite
	m.l_speed.offset_top = -210.0
	m.l_speed.offset_bottom = -152.0
	m.l_speed.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	m.l_mission.offset_right = -(206.0 + (2.0 * ECART + petit + 8.0) / echelle)
	m.l_mission.offset_left = 300.0   # pas collée au chiffre de la santé

# ---------------- dessin ----------------
func _draw() -> void:
	if not actif:
		return
	var op: float = (options.v.get("tactile_opacite", 70) if options else 70) / 100.0
	# manette
	var c: Vector2 = manette.centre
	var r: float = manette.rayon
	draw_circle(c, r, Color(0, 0, 0, 0.35 * op))
	draw_arc(c, r, 0.0, TAU, 48, Color(1, 1, 1, 0.6 * op), 3.0, true)
	draw_circle(c + manette.v * r, r * 0.42, Color(1, 1, 1, 0.55 * op) if manette.doigt >= 0 else Color(1, 1, 1, 0.35 * op))
	# boutons
	for id in boutons:
		var b: Dictionary = boutons[id]
		if not b.vu:
			continue
		var allume: bool = tenu(id) or (b.facon == "bascule" and b.on)
		fond.bg_color = Color(0.99, 0.82, 0.09, 0.75 * op) if allume else Color(0, 0, 0, 0.45 * op)
		fond.border_color = Color(1, 1, 1, 0.7 * op)
		draw_style_box(fond, b.rect)
		var lignes: PackedStringArray = b.texte.split("\n")
		var fs := int(clampf(b.rect.size.x * 0.19, 15.0, 30.0))
		var hl := fs * 1.15
		var y0: float = b.rect.get_center().y - hl * lignes.size() * 0.5 + fs * 0.85
		for i in lignes.size():
			var w := police.get_string_size(lignes[i], HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
			var pos := Vector2(b.rect.get_center().x - w * 0.5, y0 + i * hl)
			draw_string_outline(police, pos, lignes[i], HORIZONTAL_ALIGNMENT_LEFT, -1, fs, 4, Color(0, 0, 0, op))
			draw_string(police, pos, lignes[i], HORIZONTAL_ALIGNMENT_LEFT, -1, fs, Color(0.1, 0.07, 0.0, op) if allume else Color(1, 1, 1, op))
