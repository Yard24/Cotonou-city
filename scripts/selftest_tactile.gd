extends RefCounted
# Test automatique des commandes tactiles (tactile.gd), avec de faux touchers d'écran.
# run() : tout dans la même image (appelé par systemes.gd), en faisant avancer le compteur
# d'images de tactile.gd à la main. live : quelques secondes de vrai jeu au doigt, image par
# image, lancées par selftest.gd à la fin (monter sur la moto, tourner en accélérant).

const DT := 1.0 / 60.0
# Textes du jeu qui citent une touche (hud.gd, main.gd, zem.gd, embarquement.gd, interaction.gd).
const TEXTES := [
	"Flèches ou ZQSD : bouger · E : monter/descendre · Espace : sauter (frein en véhicule) · Maj : courir · C : s'accroupir · Échap : pause",
	"E pour descendre", "M : déposer le client ici (course non payée)", "Tu nages — Maj : nager plus vite",
	"E : acheter de l'eau fraîche (100 FCFA)", "E : relever la moto", "Appuie sur E pour monter sur la moto",
	"Appuie sur E pour monter dans la voiture", "Une touche de direction pour te lever", "Moto relevée — E pour remonter",
	"Baignade autorisée jusqu'aux bouées orange. Monte sur le ponton (Espace) et plonge au bout !",
	"Les caisses montent jusqu'au toit : Espace devant chaque caisse. Attention, une chute de plus de 3 mètres fait mal.",
	"Tu te reposes : la santé remonte. Une touche de direction pour te lever.",
	"Mission 1/3 — Romaric te prête sa moto : monte dessus (touche E), puis roule jusqu'au Marché Dantokpa (colonne jaune).",
	"Chute ! Relève la moto avec E, puis remonte dessus.", "Caméra proche (V pour changer)",
	"« Place de l'Amazone, 300 francs ? » — M : accepter la course", "Chute ! Ton client repart à pied : course perdue. Relève la moto avec E.",
	"60 images/s · Graphismes : Bas (F4)", "Jouer (Entrée)", "Retour (Échap)", "Niveau graphique (F4 en jeu)", "Afficher les images par seconde (F3 en jeu)"]
const RESTE := "(^|[\\s(—·])(E|M|V|H|L|J|K|C|Espace|Maj|Échap|Entrée|F3|F4|ZQSD)(?=$|[\\s):,.])"
# Téléphones simulés : [nom, écran en pixels (paysage), points par pouce, zone sûre en pixels g/h/d/b]
const TELEPHONES := [
	["6,5 pouces 720 × 1600 (entrée de gamme)", Vector2(1600, 720), 268.0, [0, 0, 0, 0]],
	["6,7 pouces 1080 × 2400", Vector2(2400, 1080), 393.0, [0, 0, 0, 0]],
	["5 pouces 480 × 854", Vector2(854, 480), 196.0, [0, 0, 0, 0]],
	["tablette 10 pouces 800 × 1280", Vector2(1280, 800), 149.0, [0, 0, 0, 0]],
	["encoche à gauche", Vector2(1600, 720), 268.0, [80, 0, 0, 0]],
	["encoche à droite, barre en bas", Vector2(1600, 720), 268.0, [0, 0, 80, 24]]]
const EN_VEHICULE := ["pause", "gaz", "frein", "frein_main", "enter", "course", "klaxon", "camera", "phares", "clign_g", "clign_d"]
const A_PIED := ["pause", "jump", "run", "crouch", "enter", "course"]

var t
var image := 1000000          # compteur d'images simulé (run)
var moto_depart := []         # place de la moto de Romaric, rendue à la fin

# La moto sur la plage, tournée vers l'est : terrain plat, sans circulation.
static func sur_la_plage(m) -> void:
	var mo = m.moto_romaric
	mo.global_position = Vector3(-60, 0, -178)
	mo.heading = PI / 2
	mo.rotation.y = mo.heading
	mo.speed = 0.0

func run(m) -> String:
	t = m.sys.tactile
	moto_depart = [m.moto_romaric.global_position, m.moto_romaric.heading]
	for f in [_sans_ecran, _disposition, _textes, _manette, _boutons, _contexte, _menus_et_android, _vraie_entree]:
		var e: String = f.call(m)
		if e != "":
			_remettre(m)
			return e
	_remettre(m)
	return ""

# Une image de jeu pour tactile.gd (sans faire tourner le reste du jeu).
func _image(m) -> void:
	image += 1
	t.image_test = image
	t.step(m, DT)

func _toucher(i: int, p: Vector2, pose := true) -> bool:
	var ev := InputEventScreenTouch.new()
	ev.index = i
	ev.position = p
	ev.pressed = pose
	return t.traiter(ev)

func _glisser(i: int, p: Vector2) -> bool:
	var ev := InputEventScreenDrag.new()
	ev.index = i
	ev.position = p
	return t.traiter(ev)

func _taper(m, id: String) -> void:
	var c: Vector2 = t.boutons[id].rect.get_center()
	_toucher(5, c)
	_toucher(5, c, false)
	_image(m)

func _forcer(m, on: bool) -> void:
	m.sys.options.regler(m, "tactile_force", on)
	_image(m)

func _remettre(m) -> void:
	t.tout_lacher()
	for a in ["up", "down", "left", "right", "enter", "course", "jump", "run", "crouch", "brake", "horn", "cam", "lights", "blink_l", "blink_r", "quit"]:
		Input.action_release(a)
	m.sys.options.regler(m, "tactile_force", false)
	t.image_test = -1
	t.step(m, DT)
	if m.cur_car:
		m.cur_car.speed = 0.0
		m.toggle_car()
		m.emb.step(m, 5.0)
	if not moto_depart.is_empty():
		m.moto_romaric.global_position = moto_depart[0]
		m.moto_romaric.heading = moto_depart[1]
		m.moto_romaric.rotation.y = moto_depart[1]

# ---------------- sur PC, sans écran tactile ----------------
func _sans_ecran(m) -> String:
	_image(m)
	if t.reel or t.mode or t.actif or t.visible:
		return "tactile : commandes affichées sur un PC sans écran tactile"
	if t.adapter("Appuie sur E pour monter sur la moto") != "Appuie sur E pour monter sur la moto" or m.hud.l_aide.text != m.hud.aide_clavier:
		return "tactile : au clavier, les textes ne doivent pas changer"
	if _toucher(0, Vector2(200, 600)):
		return "tactile : un toucher est pris alors que les commandes sont cachées"
	_forcer(m, true)
	if not t.mode or not t.actif or not t.visible:
		return "tactile : l'option ne force pas l'affichage des commandes"
	print("commandes tactiles : cachées sur PC sans écran tactile, affichées par l'option « forcer »")
	return ""

# ---------------- tailles et places ----------------
func _disposition(m) -> String:
	var vue0: Vector2 = t.ecran
	var mini := INF
	for tel in TELEPHONES:
		var px: Vector2 = tel[1]
		# étirement « canvas_items » + « expand » : 720 unités de haut au moins, 1280 de large au moins
		var k := minf(px.x / 1280.0, px.y / 720.0)
		var vue := px / k
		var u: float = tel[2] / 25.4 / k
		var zs := []
		for z in tel[3]:
			zs.append(z / k)
		for facteur in [0.7, 1.0, 1.5]:
			t.disposer(vue, u, zs, facteur)
			var e := _verifier_place(tel[0] + " · taille %d %%" % int(facteur * 100), vue, u, zs)
			if e != "":
				return e
			for id in t.boutons:
				mini = minf(mini, minf(t.boutons[id].rect.size.x, t.boutons[id].rect.size.y) / u)
	t.disposer(vue0, t.unite_mm(vue0), [0.0, 0.0, 0.0, 0.0])
	t._hud(m)
	# l'aide, la vitesse et la mission ne passent pas sous les commandes
	var aide := _rect_ecran(m.l_hint)
	var vitesse := _rect_ecran(m.l_speed)
	var mission := _rect_ecran(m.l_mission)
	var tous: Array = EN_VEHICULE + A_PIED
	for id in tous:
		var r: Rect2 = t.boutons[id].rect
		if r.intersects(aide) or r.intersects(vitesse) or r.intersects(mission):
			return "tactile : le bouton %s cache l'aide, la vitesse ou la mission" % id
	if _rect_manette().intersects(aide) or _rect_manette().intersects(vitesse):
		return "tactile : la manette cache l'aide ou la vitesse"
	print("disposition tactile : %d téléphones simulés (encoche à gauche, à droite), tailles 70 à 150 %% ; plus petit bouton %.1f mm ; rien ne se chevauche ; mini-carte, étoiles, argent, santé, messages, aide et mission dégagés" % [TELEPHONES.size(), mini])
	return ""

func _rect_ecran(c: Control) -> Rect2:
	var xf: Transform2D = c.get_global_transform_with_canvas()
	return Rect2(xf.origin, c.size * xf.get_scale())

func _rect_manette() -> Rect2:
	var r: float = t.manette.rayon
	return Rect2(t.manette.base - Vector2(r, r), Vector2(2 * r, 2 * r))

func _verifier_place(nom: String, vue: Vector2, u: float, zs: Array) -> String:
	var utile := Rect2(zs[0], zs[1], vue.x - zs[0] - zs[2], vue.y - zs[1] - zs[3])
	var hud := func(r: Rect2) -> Rect2: return Rect2(t.vers_ecran(r.position), r.size * t.echelle)
	# affichage existant, dans les unités de hud.gd : mini-carte, étoiles, argent et santé, notifications
	var interdits := {"la mini-carte": hud.call(Rect2(vue.x - 206, 16, 190, 190)), "les étoiles": hud.call(Rect2(vue.x - 201, 214, 180, 34)),
		"l'argent et la santé": hud.call(Rect2(18, 12, 280, 66)), "les messages": hud.call(Rect2(18, 156, 360, 120))}
	for groupe in [EN_VEHICULE, A_PIED]:
		for i in groupe.size():
			var r: Rect2 = t.boutons[groupe[i]].rect
			if r.size.x < 9.0 * u or r.size.y < 9.0 * u:
				return "tactile (%s) : bouton %s trop petit (%.1f mm)" % [nom, groupe[i], minf(r.size.x, r.size.y) / u]
			if not utile.encloses(r):
				return "tactile (%s) : bouton %s hors de la zone sûre" % [nom, groupe[i]]
			for z in interdits:
				if r.intersects(interdits[z]):
					return "tactile (%s) : le bouton %s cache %s" % [nom, groupe[i], z]
			if r.intersects(_rect_manette()):
				return "tactile (%s) : le bouton %s est sur la manette" % [nom, groupe[i]]
			for j in range(i + 1, groupe.size()):
				if r.intersects(t.boutons[groupe[j]].rect):
					return "tactile (%s) : les boutons %s et %s se chevauchent" % [nom, groupe[i], groupe[j]]
	if not utile.encloses(_rect_manette()):
		return "tactile (%s) : manette hors de la zone sûre" % nom
	return ""

# ---------------- textes ----------------
func _textes(m) -> String:
	var re := RegEx.create_from_string(RESTE)
	for s in TEXTES:
		var a: String = t.adapter(s)
		if re.search(a) != null:
			return "tactile : le texte « %s » cite encore une touche du clavier" % a
	if t.adapter("Appuie sur E pour monter sur la moto") != "Appuie sur « Monter » pour monter sur la moto":
		return "tactile : « %s »" % t.adapter("Appuie sur E pour monter sur la moto")
	if not ("bouton « Monter »" in t.adapter(m.missions[0].t)) or t.adapter("Jouer (Entrée)") != "Jouer":
		return "tactile : mission 1 ou bouton Jouer mal adaptés"
	for s in ["M. Fortuné salue Koffi. L'avion décolle.", "C'est l'heure : J'arrive !"]:
		if t.adapter(s) != s:
			return "tactile : texte sans touche modifié : « %s »" % t.adapter(s)
	if m.hud.l_aide.text != t.AIDE:
		return "tactile : aide de l'accueil non remplacée"
	print("textes au doigt : %d messages qui citent une touche citent le bouton tactile (« Appuie sur « Monter » pour monter sur la moto ») ; les autres ne changent pas" % TEXTES.size())
	return ""

# ---------------- manette ----------------
func _manette(m) -> String:
	var b: Vector2 = t.manette.base
	var r: float = t.manette.rayon
	_toucher(0, b)
	_glisser(0, b + Vector2(0, -0.95 * r))
	_image(m)
	if not Input.is_action_pressed("up") or Input.get_action_strength("up") < 0.9 or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return "manette : pousser vers le haut doit appuyer sur « avancer » seulement"
	_glisser(0, b + Vector2(-0.5 * r, -0.1 * r))
	_image(m)
	var g := Input.get_action_strength("left")
	if g < 0.3 or g > 0.5 or Input.is_action_pressed("up") or Input.is_action_pressed("right"):
		return "manette : à mi-course à gauche, « gauche » à moitié et rien d'autre (%.2f, avancer %s)" % [g, Input.is_action_pressed("up")]
	_glisser(0, b + Vector2(0.1 * r, 0.1 * r))
	_image(m)
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("down"):
		return "manette : la zone morte ne marche pas"
	_toucher(0, b, false)
	# pouce posé ailleurs dans la zone : la manette se centre dessous
	var ailleurs: Vector2 = b + Vector2(1.2 * r, -0.6 * r)
	_toucher(1, ailleurs)
	if t.manette.centre.distance_to(ailleurs) > 0.1:
		return "manette : elle ne se centre pas sous le pouce"
	_glisser(1, ailleurs + Vector2(0, 0.9 * r))
	_image(m)
	if not Input.is_action_pressed("down"):
		return "manette : tirer vers le bas doit appuyer sur « reculer »"
	_toucher(1, ailleurs, false)
	_image(m)
	if Input.is_action_pressed("down") or t.manette.centre != b:
		return "manette : relâchée, elle doit tout lâcher et revenir à sa place"
	print("manette virtuelle : avancer à 100 %%, gauche à %d %% à mi-course, zone morte, reculer ; elle se centre sous le pouce et revient à sa place" % int(g * 100))
	return ""

# ---------------- boutons ----------------
func _boutons(m) -> String:
	var pl = m.player
	var mo = m.moto_romaric
	# à pied, à côté de la moto de Romaric : le bouton d'action dit « Monter »
	pl.teleport(mo.global_position + Vector3(1.6, 0, 0), 0.0)
	_image(m)
	var e: Dictionary = t.boutons.enter
	if not e.vu or e.texte != "Monter" or t.boutons.gaz.vu or t.boutons.frein_main.vu or not t.boutons.jump.vu or not t.boutons.pause.vu:
		return "boutons à pied : « Monter », Sauter et Pause attendus, pas les pédales (%s, %s)" % [e.vu, e.texte]
	if m.sys.adapter("Appuie sur E pour monter sur la moto") != "Appuie sur « Monter » pour monter sur la moto":
		return "boutons : le message ne cite pas le bouton affiché"
	# un toucher très bref : l'action « monter » est vue par le jeu à cette image, lâchée à la suivante
	var c: Vector2 = e.rect.get_center()
	_toucher(3, c)
	_toucher(3, c, false)
	_image(m)
	# (Godot ne signale un appui « tout neuf » qu'à l'image suivante : la partie live vérifie l'effet)
	if not Input.is_action_pressed("enter"):
		return "boutons : un toucher bref de « Monter » n'appuie pas sur l'action « enter »"
	_image(m)
	if Input.is_action_pressed("enter"):
		return "boutons : « enter » reste appuyée après le toucher"
	# courir : un appui l'allume, le suivant l'éteint
	_taper(m, "run")
	if not t.boutons.run.on or not Input.is_action_pressed("run"):
		return "boutons : « Courir » ne s'allume pas"
	_taper(m, "run")
	_image(m)
	if t.boutons.run.on or Input.is_action_pressed("run"):
		return "boutons : « Courir » ne s'éteint pas"
	# Pause, toujours là : l'action « quit », comme Échap
	_taper(m, "pause")
	if not Input.is_action_pressed("quit"):
		return "boutons : Pause n'appuie pas sur l'action « quit »"
	_image(m)
	# sur la moto : tourner et accélérer en même temps, avec deux doigts
	m.mount(mo)
	m.emb.step(m, 5.0)
	sur_la_plage(m)
	_image(m)
	if not t.boutons.gaz.vu or not t.boutons.frein.vu or t.boutons.jump.vu or t.boutons.enter.texte != "Descendre":
		return "boutons à moto : pédales et « Descendre » attendus"
	var b: Vector2 = t.manette.base
	_toucher(0, b)
	_glisser(0, b + Vector2(0.8 * t.manette.rayon, -0.3 * t.manette.rayon))
	_toucher(1, t.boutons.gaz.rect.get_center())
	_image(m)
	if not Input.is_action_pressed("up") or not Input.is_action_pressed("right") or Input.is_action_pressed("down"):
		return "plusieurs doigts : tourner à droite et accélérer ensemble ne marche pas"
	var p0: Vector3 = mo.global_position
	var h0: float = mo.heading
	for i in 90:
		mo.drive(DT)
	var d: float = mo.global_position.distance_to(p0)
	var dh: float = angle_difference(h0, mo.heading)
	if d < 8.0 or dh > -0.2:
		return "plusieurs doigts : la moto doit avancer en tournant à droite (%.1f m, %.2f rad)" % [d, dh]
	# le doigt glisse de l'accélérateur au frein
	_glisser(1, t.boutons.frein.rect.get_center())
	_image(m)
	if Input.is_action_pressed("up") or not Input.is_action_pressed("down"):
		return "pédales : glisser d'Accélérer à Freiner doit changer de pédale"
	_toucher(1, t.boutons.frein.rect.get_center(), false)
	_toucher(0, b, false)
	_image(m)
	_image(m)
	for a in ["up", "down", "left", "right"]:
		if Input.is_action_pressed(a):
			return "plusieurs doigts : « %s » reste appuyée après avoir levé les doigts" % a
	mo.speed = 0.0
	print("boutons : « Monter » au toucher bref (vu par le jeu une image, puis lâché) ; Courir s'allume et s'éteint ; Pause = Échap ; deux doigts : la moto fait %.1f m en tournant de %d° ; d'une pédale à l'autre en glissant" % [d, int(rad_to_deg(-dh))])
	return ""

# ---------------- boutons qui n'apparaissent que quand ils servent ----------------
func _contexte(m) -> String:
	var mo = m.cur_car
	if mo == null:
		return "contexte : le héros devrait être sur la moto"
	mo.speed = 0.0
	_image(m)
	if t.boutons.frein_main.vu:
		return "contexte : frein arrière affiché à l'arrêt"
	mo.speed = 10.0
	_image(m)
	if not t.boutons.frein_main.vu or t.boutons.frein_main.texte != "Frein\narrière" or t.boutons.enter.texte != "Sauter\nen marche":
		return "contexte : à 36 km/h, frein arrière et « Sauter en marche » attendus"
	mo.speed = 0.0
	var pietons: Array = m.npcs
	var circulation: Array = m.traffic
	m.npcs = []
	m.traffic = []
	var seul: bool = t._klaxon_utile(m, mo)
	m.npcs = pietons
	m.traffic = circulation
	var gens := false
	if not pietons.is_empty():
		mo.global_position = pietons[0].n.position + Vector3(3, 0, 0)
		gens = t._klaxon_utile(m, mo)
	if seul or not gens:
		return "contexte : le klaxon doit apparaître avec quelqu'un près, pas sans personne"
	var z = m.zem
	if t.boutons.course.vu:
		return "contexte : bouton Course affiché sans client"
	z.offer = {"cl": null, "dest": 0, "prix": 300}
	t.contexte(m)
	var acc: bool = t.boutons.course.vu and t.boutons.course.texte.begins_with("Accepter")
	z.offer = {}
	if not acc:
		return "contexte : un client propose sa course, le bouton « Accepter la course » doit apparaître"
	print("boutons utiles seulement : frein arrière en roulant, « Sauter en marche » au-dessus de 22 km/h, klaxon avec du monde autour, « Accepter la course » quand un client propose")
	return ""

# ---------------- menus, bouton Retour, arrière-plan ----------------
func _menus_et_android(m) -> String:
	m.open_menu("PAUSE", "Reprendre")
	_image(m)
	if t.actif or t.visible or Input.is_action_pressed("up"):
		return "menus : les commandes tactiles restent affichées pendant la pause"
	# bouton Retour d'Android pendant la pause : comme Échap
	t._notification(Node.NOTIFICATION_WM_GO_BACK_REQUEST)
	if not Input.is_action_pressed("quit"):
		return "Retour d'Android : n'agit pas comme Échap dans le menu"
	_image(m)
	_image(m)
	if Input.is_action_pressed("quit"):
		return "Retour d'Android : « quit » reste appuyée"
	m._play()
	_image(m)
	if not t.actif:
		return "menus : les commandes ne reviennent pas après la pause"
	t._notification(Node.NOTIFICATION_WM_GO_BACK_REQUEST)
	_image(m)
	if not Input.is_action_pressed("quit"):
		return "Retour d'Android : n'ouvre pas la pause en jeu"
	_image(m)
	# mise en arrière-plan : pause et sauvegarde automatique
	var s = m.sys.sauvegarde
	s.supprimer(s.AUTO)
	t._notification(Node.NOTIFICATION_APPLICATION_FOCUS_OUT)
	if m.menu.visible or FileAccess.file_exists(s.chemin(s.AUTO)):
		return "arrière-plan : sur PC, perdre le focus ne doit rien changer"
	t._notification(Node.NOTIFICATION_APPLICATION_PAUSED)
	if not m.menu.visible or m.menu_title.text != "PAUSE" or s.lire(s.AUTO).is_empty():
		return "arrière-plan : le jeu doit se mettre en pause et sauvegarder"
	s.supprimer(s.AUTO)
	m.open_menu("MARINA CITY", "Jouer (Entrée)")
	if m.menu_play.text != "Jouer":
		return "accueil au doigt : « Jouer » sans « (Entrée) » attendu (%s)" % m.menu_play.text
	if t.mise_de_cote() or FileAccess.file_exists(s.chemin(s.AUTO)):
		return "arrière-plan : rien ne doit être sauvegardé depuis l'écran d'accueil"
	m._play()
	# options au doigt : onglet Tactile, boutons plus hauts, contenu qui défile si besoin
	var mn = m.sys.menus
	mn.onglet = mn.ONGLETS.size() - 1
	mn.ouvrir("options")
	var haut := INF
	for b in mn.boutons:
		if b is BaseButton:
			haut = minf(haut, b.custom_minimum_size.y)
		elif b is HSlider:
			haut = minf(haut, b.custom_minimum_size.y + 28.0)   # curseur dans une ligne de 76
	var ok: bool = mn.boutons.size() == mn.ONGLETS.size() + 3 and haut >= mn.HAUTEUR_DOIGT and mn.b_retour.text == "Retour"
	mn.onglet = 0
	mn.ouvrir("options")
	var defile: bool = mn.defile.custom_minimum_size.y <= m.get_viewport().get_visible_rect().size.y
	mn.fermer()
	_image(m)
	if not ok or not defile:
		return "options au doigt : onglet Tactile (3 réglages), boutons de %d unités au moins, « Retour » sans « (Échap) »" % mn.HAUTEUR_DOIGT
	print("menus et Android : commandes cachées pendant la pause ; Retour = Échap (pause, reprise) ; arrière-plan : pause et sauvegarde automatique (rien depuis l'accueil, rien sur PC) ; onglet Tactile, boutons de menu agrandis au doigt")
	return ""

# ---------------- le vrai chemin des événements ----------------
func _vraie_entree(m) -> String:
	t.dernier = ""
	var ev := InputEventScreenTouch.new()
	ev.index = 7
	ev.position = t.boutons.pause.rect.get_center()
	ev.pressed = true
	Input.parse_input_event(ev)
	Input.flush_buffered_events()
	var ev2: InputEventScreenTouch = ev.duplicate()
	ev2.pressed = false
	Input.parse_input_event(ev2)
	Input.flush_buffered_events()
	var recu: bool = t.dernier == "pause"
	_image(m)
	_image(m)
	print("événements du moteur : un toucher envoyé par Input.parse_input_event %s" % ("arrive aux commandes tactiles" if recu else "n'arrive pas sans écran (test sans affichage) : vérifié par appel direct"))
	return ""

# ---------------- au doigt, en vrai jeu ----------------
var etape := 0
var n := 0
var p0 := Vector3.ZERO
var h0 := 0.0

# Appelé à chaque image par selftest.gd ; "" tant que ce n'est pas fini, "OK" à la fin.
func live(m) -> String:
	t = m.sys.tactile
	n += 1
	match etape:
		0:
			# un appui simulé par run() est encore vu « tout neuf » à cette image (règle de
			# Godot 4.3) : on attend qu'elle passe, puis on repart à pied
			if n == 2:
				if m.cur_car:
					m.cur_car.speed = 0.0
					m.toggle_car()
					m.emb.step(m, 5.0)
				m.sys.options.regler(m, "tactile_force", true)
				moto_depart = [m.moto_romaric.global_position, m.moto_romaric.heading]
				sur_la_plage(m)
				m.player.teleport(m.moto_romaric.global_position + Vector3(0, 0, 1.6), PI / 2)
				etape = 1
				n = 0
		1:
			if n == 3:
				if not t.actif or not t.boutons.enter.vu:
					return "au doigt : pas de bouton « Monter » près de la moto"
				var c: Vector2 = t.boutons.enter.rect.get_center()
				_toucher(2, c)
				_toucher(2, c, false)
			elif n == 6:
				if m.cur_car != m.moto_romaric:
					return "au doigt : le bouton « %s » ne fait pas monter sur la moto (vrai jeu) ; véhicule %s, message « %s »" % [t.boutons.enter.texte, m.cur_car, m.info_text]
				p0 = m.cur_car.global_position
				h0 = m.cur_car.heading
				var b: Vector2 = t.manette.base
				_toucher(0, b)
				_glisser(0, b + Vector2(0.45 * t.manette.rayon, 0))
				_toucher(1, t.boutons.gaz.rect.get_center())
			elif n == 126:
				var d: float = m.cur_car.global_position.distance_to(p0)
				var dh: float = angle_difference(h0, m.cur_car.heading)
				var fm: bool = t.boutons.frein_main.vu
				_toucher(0, Vector2.ZERO, false)
				_toucher(1, Vector2.ZERO, false)
				if d < 12.0 or dh > -0.2 or not fm:
					return "au doigt : 2 s de gaz en tournant à droite (%.1f m, %.2f rad, frein arrière %s)" % [d, dh, fm]
				print("au doigt, en vrai jeu : « Monter », puis 2 s d'accélérateur en tournant à droite avec deux doigts : %.1f m, virage de %d°, frein arrière apparu en roulant" % [d, int(rad_to_deg(-dh))])
			elif n == 130:
				_remettre(m)
				return "OK"
	return ""
