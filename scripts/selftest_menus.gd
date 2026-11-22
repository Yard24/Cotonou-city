extends RefCounted
# Test automatique des menus : écran d'accueil et de pause, panneaux Sauvegarder et Charger,
# options graphiques, audio, touches et manette. Appelé par systemes.gd, tout dans la même
# image, avec un fichier d'options réservé au test.

const DT := 1.0 / 60.0

func run(m) -> String:
	for t in [_accueil, _panneaux, _graphismes, _audio, _touches, _manette]:
		var e: String = t.call(m, m.sys.menus, m.sys.options)
		if e != "":
			return e
	# on rend le jeu comme on l'a trouvé
	for k in m.sys.options.DEFAUT:
		m.sys.options.v[k] = m.sys.options.DEFAUT[k]
	m.sys.options.touches_defaut_remettre()
	m.sys.options.appliquer(m)
	for i in m.sys.sauvegarde.NB_MANUELS + 1:
		m.sys.sauvegarde.supprimer(i)
	m.sys.menus.fermer()
	m._play()
	return ""

func _fichier(o) -> Dictionary:
	return JSON.parse_string(FileAccess.get_file_as_string(o.fichier))

func _presse(b: Button) -> void:
	b.pressed.emit()

func _accueil(m, mn, _o) -> String:
	var s = m.sys.sauvegarde
	for i in s.NB_MANUELS + 1:
		s.supprimer(i)
	var vb: Node = m.menu_play.get_parent()
	var textes := []
	for c in vb.get_children():
		if c is Button or c is Label:
			textes.append(c.text)
	m.open_menu("MARINA CITY", "Jouer (Entrée)")
	if m.sys.step(m, DT):
		return "accueil : aucun panneau ne devrait être ouvert"
	if not m.menu.visible or not textes.has("Cotonou, 2017-2026") or not textes.has("Quitter le jeu") or m.menu_play.text != "Jouer (Entrée)":
		return "accueil : titre, sous-titre, Jouer ou Quitter manquant"
	if mn.b_continuer.visible or mn.b_sauver.visible or not mn.b_charger.disabled or not mn.b_options.visible:
		return "accueil : sans sauvegarde, ni Continuer ni Sauvegarder, et Charger grisé"
	if mn.b_charger.get_parent().get_index() != m.menu_play.get_index() + 1 or mn.b_options.get_parent() != mn.b_charger.get_parent():
		return "accueil : Charger, Sauvegarder et Options doivent être sur la ligne sous « Jouer »"
	m._play()
	if m.menu.visible:
		return "accueil : Jouer ne ferme pas l'écran"
	# en pause : Sauvegarder apparaît, Continuer non
	m.player.on_ground = true
	m.player.swimming = false
	m.open_menu("PAUSE", "Reprendre")
	m.sys.step(m, DT)
	if not mn.b_sauver.visible or mn.b_continuer.visible:
		return "pause : Sauvegarder devrait être proposé, pas Continuer"
	# avec une sauvegarde : Continuer sur l'écran d'accueil la recharge
	m.money = 4321
	if not s.sauver(m, 2):
		return "accueil : sauvegarde de préparation impossible (%s)" % s.erreur
	m.money = 0
	m.open_menu("MARINA CITY", "Jouer (Entrée)")
	m.sys.step(m, DT)
	if not mn.b_continuer.visible or mn.b_charger.disabled or mn.b_sauver.visible:
		return "accueil : avec une sauvegarde, Continuer et Charger devraient être proposés"
	_presse(mn.b_continuer)
	if m.money != 4321 or m.menu.visible:
		return "accueil : Continuer ne recharge pas la dernière partie"
	print("menu principal : titre, sous-titre, Jouer, Charger, Options, Quitter ; Continuer seulement s'il y a une sauvegarde (il recharge la plus récente) ; Sauvegarder seulement en pause")
	return ""

func _panneaux(m, mn, _o) -> String:
	var s = m.sys.sauvegarde
	m.open_menu("PAUSE", "Reprendre")
	m.player.on_ground = true   # le héros vient d'être rechargé : on le pose
	_presse(mn.b_sauver)
	if mn.ecran != "sauver" or not mn.racine.visible or mn.boutons.size() != 3:
		return "panneau Sauvegarder : il doit proposer les 3 emplacements manuels"
	if not m.sys.step(m, DT):
		return "panneau : main.gd devrait attendre tant qu'il est ouvert"
	# emplacement vide : sauvegarde directe ; emplacement occupé : confirmation
	m.money = 111
	mn.clic_sauver(1)
	if mn.ecran != "sauver" or s.lire(1).is_empty() or s.lire(1).argent != 111 or not mn.l_message.text.begins_with("Partie sauvegardée"):
		return "panneau Sauvegarder : emplacement vide non sauvegardé"
	m.money = 222
	mn.clic_sauver(1)
	if mn.ecran != "confirmer" or mn.boutons.size() != 2 or s.lire(1).argent != 111:
		return "panneau Sauvegarder : pas de confirmation avant de remplacer"
	_presse(mn.boutons[0])   # Non
	if mn.ecran != "sauver" or s.lire(1).argent != 111:
		return "panneau Sauvegarder : « Non » a quand même remplacé"
	mn.clic_sauver(1)
	_presse(mn.boutons[1])   # Oui
	if mn.ecran != "sauver" or s.lire(1).argent != 222:
		return "panneau Sauvegarder : « Oui » ne remplace pas"
	# refus affiché dans le panneau
	m.player.ko_t = 1.0
	mn.clic_sauver(3)
	m.player.ko_t = 0.0
	if not s.lire(3).is_empty() or not mn.l_message.text.contains("évanoui"):
		return "panneau Sauvegarder : le refus n'est pas expliqué"
	mn.retour()
	if mn.ecran != "" or mn.racine.visible or m.sys.step(m, DT):
		return "panneau : Retour ne le ferme pas"
	# charger : 4 emplacements, les vides grisés ; en pause, confirmation
	_presse(mn.b_charger)
	if mn.ecran != "charger" or mn.boutons.size() != 4 or not mn.boutons[0].disabled or mn.boutons[1].disabled or mn.boutons[2].disabled or not mn.boutons[3].disabled:
		return "panneau Charger : 4 emplacements attendus, les vides grisés"
	m.money = 999
	mn.clic_charger(1)
	if mn.ecran != "confirmer" or m.money != 999:
		return "panneau Charger : pas de confirmation en pause"
	_presse(mn.boutons[1])
	if m.money != 222 or mn.ecran != "" or m.menu.visible:
		return "panneau Charger : la partie n'est pas chargée ou le menu reste ouvert"
	# depuis l'écran d'accueil : pas de confirmation
	m.open_menu("MARINA CITY", "Jouer (Entrée)")
	mn.ouvrir("charger")
	m.money = 5
	mn.clic_charger(2)
	if m.money != 4321 or m.menu.visible:
		return "panneau Charger : chargement direct depuis l'écran d'accueil impossible"
	print("panneaux Sauvegarder et Charger : 3 emplacements pour sauver, 4 pour charger (vides grisés) ; confirmation avant de remplacer et avant de charger en pause ; refus expliqué ; main.gd attend tant qu'un panneau est ouvert")
	return ""

func _graphismes(m, mn, o) -> String:
	m.open_menu("PAUSE", "Reprendre")
	_presse(mn.b_options)
	mn.choisir_onglet(0)
	if mn.ecran != "options" or mn.boutons.size() != mn.ONGLETS.size() + 5:
		return "options graphiques : %d onglets et 5 réglages attendus (%d)" % [mn.ONGLETS.size(), mn.boutons.size()]
	# le réglage du menu agit tout de suite
	(mn.boutons[mn.ONGLETS.size() + 0] as OptionButton).item_selected.emit(0)
	if o.v.qualite != 0 or m.quality != 0 or m.sun.shadow_enabled or abs(m.get_viewport().scaling_3d_scale - 0.7) > 0.001:
		return "options graphiques : le niveau Bas n'est pas appliqué"
	o.regler(m, "qualite", 3)
	if m.quality != 3 or not m.sun.shadow_enabled or m.cam.far < 800.0:
		return "options graphiques : le niveau Ultra n'est pas appliqué"
	o.regler(m, "qualite", 9)
	if o.v.qualite != 3:
		return "options graphiques : niveau hors limites accepté"
	o.regler(m, "fps_max", 60)
	if Engine.max_fps != 60:
		return "options graphiques : limite d'images par seconde non appliquée"
	o.regler(m, "fps_max", 45)
	if Engine.max_fps != 0:
		return "options graphiques : limite inconnue acceptée"
	(mn.boutons[mn.ONGLETS.size() + 4] as CheckButton).toggled.emit(false)
	if o.v.voir_fps or m.l_fps.visible:
		return "options graphiques : le compteur d'images reste affiché"
	o.regler(m, "plein_ecran", true)
	if o.mode_fenetre() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		return "options graphiques : plein écran"
	o.regler(m, "plein_ecran", false)
	if o.mode_fenetre() != DisplayServer.WINDOW_MODE_MAXIMIZED:
		return "options graphiques : fenêtre agrandie"
	o.regler(m, "synchro", false)
	# F4 et F3 en jeu : le menu et le fichier suivent
	m.quality = 1
	m._apply_quality()
	m.l_fps.visible = true
	o.step(m)
	var f := _fichier(o)
	if o.v.qualite != 1 or not o.v.voir_fps or int(f.qualite) != 1 or f.synchro != false or f.voir_fps != true:
		return "options graphiques : F4 ou F3 en jeu non enregistré"
	# au prochain lancement : les réglages sont relus
	var o2 = load("res://scripts/options.gd").new()
	o2.fichier = o.fichier
	o2.v = o2.DEFAUT.duplicate()
	o2.lire()
	if o2.v.qualite != 1 or o2.v.synchro or o2.v.plein_ecran:
		return "options graphiques : réglages non relus au lancement"
	o.regler(m, "qualite", 2)
	print("options graphiques : niveau Bas à Ultra appliqué tout de suite, plein écran, synchronisation verticale, limite d'images par seconde, compteur ; F4 et F3 suivis ; réglages relus au lancement")
	return ""

func _audio(m, mn, o) -> String:
	mn.choisir_onglet(1)
	if mn.boutons.size() != mn.ONGLETS.size() + 4:
		return "options audio : 4 curseurs attendus"
	for b in ["Master", "Musique", "Effets", "Voix"]:
		if AudioServer.get_bus_index(b) < 0:
			return "options audio : piste « %s » absente" % b
	var mus := AudioServer.get_bus_index("Musique")
	(mn.boutons[mn.ONGLETS.size() + 1] as HSlider).value = 50
	if o.v.vol_musique != 50 or abs(AudioServer.get_bus_volume_db(mus) + 6.02) > 0.05 or AudioServer.is_bus_mute(mus):
		return "options audio : musique à 50 = %.1f dB (attendu -6)" % AudioServer.get_bus_volume_db(mus)
	o.regler(m, "vol_musique", 0)
	if not AudioServer.is_bus_mute(mus):
		return "options audio : volume 0 non muet"
	o.regler(m, "vol_musique", 150)
	if o.v.vol_musique != 100 or abs(AudioServer.get_bus_volume_db(mus)) > 0.01 or AudioServer.is_bus_mute(mus):
		return "options audio : volume au-dessus de 100 accepté"
	o.regler(m, "vol_general", 25)
	o.regler(m, "vol_effets", 60)
	o.regler(m, "vol_voix", 40)
	if abs(AudioServer.get_bus_volume_db(0) + 12.04) > 0.05 or abs(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voix")) - linear_to_db(0.4)) > 0.01:
		return "options audio : volume général ou voix non appliqué"
	var f := _fichier(o)
	if int(f.vol_general) != 25 or int(f.vol_effets) != 60 or int(f.vol_voix) != 40 or int(f.vol_musique) != 100:
		return "options audio : réglages non enregistrés"
	# le klaxon passe par la piste « Bruitages »
	var c = m.cars[0]
	m.mount(c)
	c.fx.honk(0.1)
	m.sys.bus_klaxons(m)
	if c.fx.horn_player == null or c.fx.horn_player.bus != &"Effets":
		return "options audio : le klaxon n'est pas réglé par « Bruitages »"
	c.fx.horn_player.stop()
	c.speed = 0.0
	m._get_off()
	print("options audio : général, musique, bruitages et voix de 0 à 100 (50 = -6 dB, 0 = muet), appliqués tout de suite et enregistrés ; le klaxon suit le réglage des bruitages")
	return ""

func _a(k: int) -> InputEventKey:
	var e := InputEventKey.new()
	e.physical_keycode = k
	e.pressed = true
	return e

func _touches(m, mn, o) -> String:
	mn.choisir_onglet(2)
	if mn.boutons.size() != mn.ONGLETS.size() + o.ACTIONS.size() + 1:
		return "touches : une ligne par action attendue"
	if o.touches.horn != KEY_H or o.touches.up != KEY_W or o.touches.jump != KEY_SPACE or o.nom_touche(KEY_SPACE) != "Espace":
		return "touches : touches d'origine inattendues"
	# par le menu : on clique sur la touche du klaxon, puis on appuie sur G
	_presse(mn.boutons[mn.ONGLETS.size() + 9])
	if mn.capture != "horn":
		return "touches : le menu n'attend pas la touche du klaxon"
	mn._touche_recue(_a(KEY_G))
	if mn.capture != "" or o.touches.horn != KEY_G or not InputMap.event_is_action(_a(KEY_G), "horn") or InputMap.event_is_action(_a(KEY_H), "horn"):
		return "touches : le klaxon n'est pas passé sur G"
	if mn.boutons[mn.ONGLETS.size() + 9].text != "G":
		return "touches : le menu n'affiche pas la nouvelle touche"
	mn.avale = false
	# même touche pour une autre action du véhicule : les deux échangent
	var msg: String = o.changer_touche("lights", KEY_G)
	if o.touches.lights != KEY_G or o.touches.horn != KEY_L or not InputMap.event_is_action(_a(KEY_L), "horn") or InputMap.event_is_action(_a(KEY_G), "horn") or not msg.contains("Klaxon passe sur L"):
		return "touches : pas d'échange quand la touche est déjà prise (%s)" % msg
	# une action à pied et une action de véhicule peuvent partager une touche
	o.changer_touche("jump", KEY_L)
	if o.touches.jump != KEY_L or o.touches.horn != KEY_L:
		return "touches : saut et klaxon devraient pouvoir partager une touche"
	# touches réservées
	for k in [KEY_ESCAPE, KEY_F4, KEY_UP, KEY_ENTER]:
		if not o.changer_touche("cam", k).begins_with("Refusé") or o.touches.cam != KEY_V:
			return "touches : touche réservée acceptée"
	# Échap annule le choix sans fermer le panneau
	mn.attendre_touche("cam")
	mn._touche_recue(_a(KEY_ESCAPE))
	m.sys.step(m, DT)
	if mn.capture != "" or o.touches.cam != KEY_V or mn.ecran != "options":
		return "touches : Échap devrait annuler le choix et laisser le panneau ouvert"
	# les flèches restent valables quand on change la touche principale
	o.changer_touche("up", KEY_T)
	if not InputMap.event_is_action(_a(KEY_T), "up") or not InputMap.event_is_action(_a(KEY_UP), "up") or InputMap.event_is_action(_a(KEY_W), "up"):
		return "touches : avancer devrait répondre à T et à la flèche, plus à Z"
	# enregistrement et relecture
	var f := _fichier(o)
	if int(f.touches.horn) != KEY_L or int(f.touches.up) != KEY_T:
		return "touches : non enregistrées"
	o.touches_defaut_remettre()
	o.lire()
	if o.touches.horn != KEY_L or o.touches.up != KEY_T or o.touches.lights != KEY_G or not InputMap.event_is_action(_a(KEY_T), "up"):
		return "touches : non relues au lancement"
	_presse(mn.boutons[mn.ONGLETS.size() + o.ACTIONS.size()])
	if o.touches.horn != KEY_H or o.touches.up != KEY_W or o.touches.jump != KEY_SPACE or int(_fichier(o).touches.horn) != KEY_H:
		return "touches : le bouton des touches d'origine ne remet pas tout"
	for a in o.ACTIONS:
		var n := 0
		for e in InputMap.action_get_events(a[0]):
			if e is InputEventKey and e.physical_keycode == o.touches[a[0]]:
				n += 1
		if n != 1:
			return "touches : l'action %s a %d fois sa touche principale" % [a[0], n]
	print("touches : %d actions modifiables par le menu ; touche déjà prise = échange ; à pied et en véhicule peuvent partager ; Échap, Entrée, F3, F4 et flèches réservées ; flèches toujours valables ; enregistrées, relues, remises d'origine" % o.ACTIONS.size())
	return ""

func _bouton(i: int) -> InputEventJoypadButton:
	var e := InputEventJoypadButton.new()
	e.device = 0
	e.button_index = i
	e.pressed = true
	return e

func _axe(axe: int, val: float) -> InputEventJoypadMotion:
	var e := InputEventJoypadMotion.new()
	e.device = 0
	e.axis = axe
	e.axis_value = val
	return e

func _manette(m, mn, o) -> String:
	mn.choisir_onglet(3)
	if mn.boutons.size() != mn.ONGLETS.size() + 3:
		return "manette : 3 réglages attendus"
	var attendu := [[_bouton(JOY_BUTTON_A), "jump"], [_bouton(JOY_BUTTON_A), "brake"], [_bouton(JOY_BUTTON_B), "crouch"], [_bouton(JOY_BUTTON_X), "run"],
		[_bouton(JOY_BUTTON_Y), "enter"], [_bouton(JOY_BUTTON_START), "quit"], [_bouton(JOY_BUTTON_BACK), "cam"], [_bouton(JOY_BUTTON_LEFT_STICK), "horn"],
		[_bouton(JOY_BUTTON_LEFT_SHOULDER), "blink_l"], [_bouton(JOY_BUTTON_RIGHT_SHOULDER), "blink_r"], [_bouton(JOY_BUTTON_DPAD_UP), "lights"],
		[_axe(JOY_AXIS_LEFT_X, -1.0), "left"], [_axe(JOY_AXIS_LEFT_X, 1.0), "right"], [_axe(JOY_AXIS_LEFT_Y, -1.0), "up"], [_axe(JOY_AXIS_LEFT_Y, 1.0), "down"],
		[_axe(JOY_AXIS_TRIGGER_RIGHT, 1.0), "up"], [_axe(JOY_AXIS_TRIGGER_LEFT, 1.0), "down"], [_bouton(JOY_BUTTON_DPAD_LEFT), "left"]]
	for p in attendu:
		if not p[0].is_action_pressed(p[1]):
			return "manette : la commande de « %s » ne répond pas" % o.libelle(p[1])
	if _axe(JOY_AXIS_LEFT_X, 1.0).is_action_pressed("left") or InputMap.event_is_action(_bouton(JOY_BUTTON_A), "enter"):
		return "manette : une commande agit sur la mauvaise action"
	# direction progressive et zone morte
	var demi: float = _axe(JOY_AXIS_LEFT_X, -0.6).get_action_strength("left")
	var fond: float = _axe(JOY_AXIS_LEFT_X, -1.0).get_action_strength("left")
	if _axe(JOY_AXIS_LEFT_X, -0.2).get_action_strength("left") != 0.0 or demi <= 0.2 or demi >= 0.8 or fond < 0.99:
		return "manette : zone morte de 25 %% ou direction progressive incorrecte (%.2f, %.2f)" % [demi, fond]
	(mn.boutons[mn.ONGLETS.size() + 2] as HSlider).value = 10
	if o.v.zone_morte != 10 or _axe(JOY_AXIS_LEFT_X, -0.2).get_action_strength("left") <= 0.0:
		return "manette : la zone morte réglée à 10 % n'est pas appliquée"
	o.regler(m, "zone_morte", 99)
	if o.v.zone_morte != 60:
		return "manette : zone morte hors limites acceptée"
	o.regler(m, "zone_morte", 25)
	# vibrations : selon la blessure, et seulement si elles sont activées
	if not o.vibrer(20.0) or o.vibration.size() != 3 or abs(o.vibration[1] - 0.5) > 0.01 or o.vibrer(2.0):
		return "manette : vibration absente pour une blessure moyenne, ou présente pour une égratignure"
	if not o.vibrer(80.0) or o.vibration[1] != 1.0 or o.vibration[2] > 0.51:
		return "manette : vibration d'un gros choc"
	o.vibration = []
	m.sys.affichage.synchro(m)
	m.player.health = 100.0
	m.sys.affichage.step(m, DT)
	m.player.hurt(30.0)
	m.sys.affichage.step(m, DT)
	if o.vibration.is_empty():
		return "manette : pas de vibration quand le héros est blessé"
	(mn.boutons[mn.ONGLETS.size() + 1] as CheckButton).toggled.emit(false)
	if o.v.vibrations or o.vibrer(40.0):
		return "manette : vibrations coupées mais encore envoyées"
	# manette désactivée : plus aucune commande ; réactivée : tout revient, sans doublon
	(mn.boutons[mn.ONGLETS.size() + 0] as CheckButton).toggled.emit(false)
	for p in attendu:
		if p[0].is_action_pressed(p[1]):
			return "manette : désactivée, « %s » répond encore" % o.libelle(p[1])
	if not InputMap.event_is_action(_a(KEY_E), "enter"):
		return "manette : la désactiver a touché au clavier"
	var f := _fichier(o)
	if f.manette != false or f.vibrations != false:
		return "manette : réglages non enregistrés"
	o.regler(m, "manette", true)
	o.regler(m, "manette", true)
	o.regler(m, "vibrations", true)
	var n := 0
	for e in InputMap.action_get_events("jump"):
		if e is InputEventJoypadButton:
			n += 1
	if n != 1 or not InputMap.event_is_action(_bouton(JOY_BUTTON_A), "jump"):
		return "manette : réactivée, commandes absentes ou en double"
	# menus à la manette : commandes d'origine de Godot
	if not InputMap.event_is_action(_bouton(JOY_BUTTON_A), "ui_accept") or not InputMap.event_is_action(_bouton(JOY_BUTTON_B), "ui_cancel") or not InputMap.event_is_action(_bouton(JOY_BUTTON_DPAD_DOWN), "ui_down"):
		return "manette : les menus ne répondent pas à la manette"
	# Entrée ou A sur un bouton autre que « Jouer » : main.gd ne doit pas lancer le jeu
	m.open_menu("PAUSE", "Reprendre")
	mn.fermer()
	mn.b_options.grab_focus()
	var fo: Control = m.get_viewport().gui_get_focus_owner()
	var avale: bool = fo == mn.b_options and mn.valide_ailleurs(fo, true) and not mn.valide_ailleurs(fo, false)
	m.menu_play.grab_focus()
	var passe: bool = not mn.valide_ailleurs(m.get_viewport().gui_get_focus_owner(), true)
	if not avale or not passe:
		return "manette : valider sur « Options » ne doit pas faire « Reprendre » (%s, %s)" % [avale, passe]
	var sch: String = mn.schema_manette()
	if not sch.contains("Y (haut) : Monter, descendre, utiliser") or not sch.contains("A (bas) : Sauter / Frein à main") or not sch.contains("Start : Pause") or not sch.contains("Manche gauche : Se diriger"):
		return "manette : tableau des commandes incomplet\n" + sch
	m.player.health = 100.0
	m.sys.affichage.synchro(m)
	print("manette : %d commandes (manche, gâchettes, boutons) ; direction progressive, zone morte de 5 à 60 %% ; vibrations selon la blessure ; désactivable sans toucher au clavier ; menus à la manette" % o.MANETTE.size())
	return ""
