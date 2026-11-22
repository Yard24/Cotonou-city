extends RefCounted
# Menus ajoutés à l'écran d'accueil et de pause : Continuer, Charger, Sauvegarder, Options
# (graphismes, audio, touches, manette). L'écran d'accueil lui-même est dans hud.gd.
# Fonctionnement attendu : docs/systemes/menus.md et sauvegarde.md. Vérifications : selftest_menus.gd.

const ONGLETS := ["Graphismes", "Audio", "Touches", "Manette", "Tactile"]
const HAUTEUR_DOIGT := 76     # au doigt, boutons et lignes plus hauts (7 mm environ sur téléphone)
const QUALITES := ["Bas (petits PC)", "Moyen", "Élevé", "Ultra"]

var main
var tactile = null          # tactile.gd : au doigt, textes sans touches et boutons plus grands
var defile: ScrollContainer  # le contenu d'un panneau défile s'il ne tient pas à l'écran
var sauvegarde
var options
var b_continuer: Button
var b_charger: Button
var b_sauver: Button
var b_options: Button
var racine: Control          # panneau par-dessus l'écran d'accueil
var l_titre: Label
var corps: VBoxContainer
var l_message: Label
var b_retour: Button
var ecran := ""              # "" : fermé ; "sauver", "charger", "options", "confirmer"
var onglet := 0
var capture := ""            # action dont on attend la nouvelle touche
var capteur: Control
var confirme: Callable       # ce que fait « Oui » sur l'écran de confirmation
var retour_vers := ""
var etat_accueil := ""
var avale := false
var boutons: Array = []      # boutons de l'écran courant, dans l'ordre (pour le test)

func build(m, sauv, opt) -> void:
	main = m
	sauvegarde = sauv
	options = opt
	# boutons ajoutés sous « Jouer » dans l'écran d'accueil et de pause
	# (sur une seule ligne : l'écran d'accueil doit tenir dans 720 pixels de haut)
	var vb: Node = m.menu_play.get_parent()
	var ligne := HBoxContainer.new()
	ligne.alignment = BoxContainer.ALIGNMENT_CENTER
	ligne.add_theme_constant_override("separation", 14)
	vb.add_child(ligne)
	vb.move_child(ligne, m.menu_play.get_index() + 1)
	b_continuer = _bouton_menu(ligne, "Continuer", continuer)
	b_charger = _bouton_menu(ligne, "Charger une partie", ouvrir.bind("charger"))
	b_sauver = _bouton_menu(ligne, "Sauvegarder", ouvrir.bind("sauver"))
	b_options = _bouton_menu(ligne, "Options", ouvrir.bind("options"))
	# panneau
	var couche := CanvasLayer.new()
	couche.layer = 5
	m.add_child(couche)
	racine = Control.new()
	racine.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	racine.visible = false
	couche.add_child(racine)
	var fond := ColorRect.new()
	fond.color = Color(0.08, 0.04, 0.02, 1.0)
	fond.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	racine.add_child(fond)
	var cc := CenterContainer.new()
	cc.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	racine.add_child(cc)
	var vb2 := VBoxContainer.new()
	vb2.add_theme_constant_override("separation", 12)
	vb2.custom_minimum_size = Vector2(760, 0)
	cc.add_child(vb2)
	l_titre = m.label(44, Color("f5c400"))
	l_titre.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vb2.add_child(l_titre)
	corps = VBoxContainer.new()
	corps.add_theme_constant_override("separation", 8)
	corps.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	defile = ScrollContainer.new()
	defile.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	defile.add_child(corps)
	vb2.add_child(defile)
	l_message = m.label(20, Color("ffe27a"))
	l_message.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l_message.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	l_message.custom_minimum_size = Vector2(760, 30)
	vb2.add_child(l_message)
	b_retour = _bouton("Retour (Échap)", retour)
	vb2.add_child(b_retour)
	# reçoit la touche pendant qu'on en choisit une nouvelle
	capteur = Control.new()
	capteur.focus_mode = Control.FOCUS_ALL
	capteur.gui_input.connect(_touche_recue)
	racine.add_child(capteur)

func au_doigt() -> bool:
	return tactile != null and tactile.mode

# Texte d'un menu : au doigt, sans les touches du clavier entre parenthèses.
func _t(texte: String) -> String:
	return tactile.adapter(texte) if tactile != null else texte

func _bouton(texte: String, action: Callable, taille := 22) -> Button:
	var b := Button.new()
	b.text = _t(texte)
	b.add_theme_font_size_override("font_size", taille + (4 if au_doigt() else 0))
	b.custom_minimum_size = Vector2(360, HAUTEUR_DOIGT if au_doigt() else 44)
	b.pressed.connect(action)
	return b

func _bouton_menu(ligne: Node, texte: String, action: Callable) -> Button:
	var b := _bouton(texte, action)
	b.custom_minimum_size = Vector2(280, 48)
	ligne.add_child(b)
	return b

func en_pause() -> bool:
	return main.menu_title.text == "PAUSE"

func ouvert() -> bool:
	return ecran != ""

# Appelé à chaque image. Renvoie true tant qu'un panneau est ouvert : main.gd ne lit alors
# ni Échap ni Entrée, qui servent au panneau.
func step(m, _delta: float) -> bool:
	var etat := "%s|%s" % [m.menu.visible, m.menu_title.text]
	if etat != etat_accueil:
		etat_accueil = etat
		maj_accueil()
	if ecran == "":
		if m.menu.visible:
			var f: Control = m.get_viewport().gui_get_focus_owner()
			if f == null:
				(b_continuer if b_continuer.visible else m.menu_play).grab_focus()
			elif valide_ailleurs(f, Input.is_action_just_pressed("ui_accept")):
				return true
		return false
	if capture != "" and m.get_viewport().gui_get_focus_owner() != capteur:
		capture = ""   # clic ailleurs pendant le choix d'une touche : on abandonne
		l_message.text = "Annulé."
	if avale:
		avale = false   # l'Échap qui vient d'annuler un choix de touche ne ferme pas le panneau
	elif capture == "" and (Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("quit")):
		retour()
	return true

# Entrée (ou A à la manette) sur un autre bouton que « Jouer » : c'est ce bouton qui répond ;
# main.gd ne doit pas y voir « Jouer ».
func valide_ailleurs(f: Control, valide: bool) -> bool:
	return valide and f is Button and f != main.menu_play

# Met à jour les boutons de l'écran d'accueil : appelé quand il s'ouvre.
func maj_accueil() -> void:
	var pause := en_pause()
	var recent: int = sauvegarde.plus_recent()
	b_continuer.visible = not pause and recent >= 0
	b_charger.disabled = recent < 0
	b_sauver.visible = pause

# ---------------- écrans ----------------
func ouvrir(nom: String) -> void:
	ecran = nom
	capture = ""
	racine.visible = true
	boutons = []
	for c in corps.get_children():
		corps.remove_child(c)
		c.queue_free()
	l_message.text = ""
	b_retour.visible = nom != "confirmer"
	b_retour.text = _t("Retour (Échap)")
	b_retour.custom_minimum_size.y = HAUTEUR_DOIGT if au_doigt() else 44
	match nom:
		"sauver":
			_ecran_emplacements(true)
		"charger":
			_ecran_emplacements(false)
		"options":
			_ecran_options()
	_ajuster_defile()
	if not boutons.is_empty() and racine.is_inside_tree():
		boutons[0].grab_focus()

# Le panneau garde sa taille habituelle ; seul un contenu trop haut pour l'écran défile.
func _ajuster_defile() -> void:
	var haut := corps.get_combined_minimum_size().y
	var place := 720.0 - 230.0
	if racine.is_inside_tree():
		place = racine.get_viewport_rect().size.y - 230.0
	defile.custom_minimum_size = Vector2(760, minf(haut, place))
	defile.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO if haut > place else ScrollContainer.SCROLL_MODE_DISABLED

func fermer() -> void:
	ecran = ""
	capture = ""
	racine.visible = false
	maj_accueil()
	if main.menu.visible and main.menu_play.is_inside_tree():
		main.menu_play.grab_focus()

func retour() -> void:
	if ecran == "confirmer":
		var msg := "Annulé."
		ouvrir(retour_vers)
		l_message.text = msg
	else:
		fermer()

func _ajoute_bouton(texte: String, action: Callable, parent: Node = null) -> Button:
	var b := _bouton(texte, action)
	(parent if parent else corps).add_child(b)
	boutons.append(b)
	return b

# ---------------- sauvegarder / charger ----------------
func _ecran_emplacements(pour_sauver: bool) -> void:
	l_titre.text = "Sauvegarder" if pour_sauver else "Charger une partie"
	for r in sauvegarde.liste(main.missions.size()):
		if pour_sauver and r.slot == sauvegarde.AUTO:
			continue
		var b := _ajoute_bouton(r.texte, (clic_sauver if pour_sauver else clic_charger).bind(r.slot))
		b.custom_minimum_size = Vector2(760, 52)
		b.disabled = not pour_sauver and (r.vide or r.illisible)
	if pour_sauver:
		l_message.text = sauvegarde.refus(main)

func clic_sauver(slot: int) -> void:
	var r: Dictionary = sauvegarde.resume(slot)
	if not r.vide and sauvegarde.refus(main) == "":
		_confirmer("Remplacer la partie de l'emplacement %d ?" % slot, _sauver.bind(slot), "sauver")
	else:
		_sauver(slot)

func _sauver(slot: int) -> void:
	var ok: bool = sauvegarde.sauver(main, slot)
	var e: String = sauvegarde.erreur
	ouvrir("sauver")
	l_message.text = "Partie sauvegardée dans l'emplacement %d." % slot if ok else e

func clic_charger(slot: int) -> void:
	if en_pause():
		_confirmer("Charger cette partie ? Ce qui n'est pas sauvegardé sera perdu.", _charger.bind(slot), "charger")
	else:
		_charger(slot)

func _charger(slot: int) -> void:
	if sauvegarde.charger(main, slot):
		fermer()
		main._play()
	else:
		var e: String = sauvegarde.erreur
		ouvrir("charger")
		l_message.text = e

# Bouton « Continuer » de l'écran d'accueil : la sauvegarde la plus récente.
func continuer() -> void:
	var s: int = sauvegarde.plus_recent()
	if s < 0:
		return
	if sauvegarde.charger(main, s):
		main._play()
	else:
		var e: String = sauvegarde.erreur
		ouvrir("charger")
		l_message.text = e

func _confirmer(question: String, oui: Callable, vers: String) -> void:
	ouvrir("confirmer")
	retour_vers = vers
	confirme = oui
	l_titre.text = question
	l_titre.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_ajoute_bouton("Non", retour)
	_ajoute_bouton("Oui", func() -> void: confirme.call())
	if racine.is_inside_tree():
		boutons[0].grab_focus()

# ---------------- options ----------------
func _ecran_options() -> void:
	l_titre.text = "Options"
	l_titre.autowrap_mode = TextServer.AUTOWRAP_OFF
	var hb := HBoxContainer.new()
	hb.alignment = BoxContainer.ALIGNMENT_CENTER
	corps.add_child(hb)
	for i in ONGLETS.size():
		var b := _ajoute_bouton(ONGLETS[i], choisir_onglet.bind(i), hb)
		b.custom_minimum_size = Vector2(150, HAUTEUR_DOIGT if au_doigt() else 44)
		b.disabled = i == onglet
	match onglet:
		0:
			_choix("Niveau graphique (F4 en jeu)", QUALITES, options.v.qualite, func(i: int) -> void: options.regler(main, "qualite", i))
			if not OS.has_feature("mobile"):
				_coche("Plein écran", "plein_ecran")   # sur téléphone, le jeu occupe toujours tout l'écran
			_coche("Synchronisation verticale", "synchro")
			var noms := []
			for f in options.FPS_CHOIX:
				noms.append("Sans limite" if f == 0 else "%d images par seconde" % f)
			_choix("Images par seconde au plus", noms, options.FPS_CHOIX.find(options.v.fps_max), func(i: int) -> void: options.regler(main, "fps_max", options.FPS_CHOIX[i]))
			_coche("Afficher les images par seconde (F3 en jeu)", "voir_fps")
		1:
			_curseur("Volume général", "vol_general", 0, 100, 5)
			_curseur("Musique et radio", "vol_musique", 0, 100, 5)
			_curseur("Bruitages", "vol_effets", 0, 100, 5)
			_curseur("Voix", "vol_voix", 0, 100, 5)
		2:
			var g := GridContainer.new()
			g.columns = 4
			g.add_theme_constant_override("h_separation", 14)
			corps.add_child(g)
			for a in options.ACTIONS:
				var l: Label = main.label(18, Color.WHITE)
				l.text = a[1]
				g.add_child(l)
				var b := _ajoute_bouton(options.nom_touche(options.touches[a[0]]), attendre_touche.bind(a[0]), g)
				b.custom_minimum_size = Vector2(150, 36)
				b.add_theme_font_size_override("font_size", 18)
			_ajoute_bouton("Remettre les touches d'origine", touches_origine)
			var note: Label = main.label(16, Color(1, 1, 1, 0.8))
			note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			note.text = "Les flèches servent toujours à se diriger · Échap : pause · F3 et F4 ne changent pas"
			corps.add_child(note)
		3:
			var etat: Label = main.label(18, Color("9fd8ff"))
			etat.text = "Manette : " + options.manette_nom()
			corps.add_child(etat)
			_coche("Utiliser la manette", "manette")
			_coche("Vibrations", "vibrations")
			_curseur("Zone morte des manches (%)", "zone_morte", 5, 60, 5)
			# tableau des commandes sur deux colonnes, pour tenir dans 720 pixels de haut
			var lignes := schema_manette().split("\n")
			var g := GridContainer.new()
			g.columns = 2
			g.add_theme_constant_override("h_separation", 30)
			corps.add_child(g)
			for i in lignes.size():
				var l: Label = main.label(16, Color.WHITE)
				l.text = lignes[i]
				if i == lignes.size() - 1:
					corps.add_child(l)
				else:
					g.add_child(l)
		4:
			_coche("Commandes tactiles même sans écran tactile (pour les essayer sur PC)", "tactile_force")
			_curseur("Taille des boutons (%)", "tactile_taille", 70, 150, 10)
			_curseur("Opacité des boutons (%)", "tactile_opacite", 20, 100, 10)
			var note: Label = main.label(16, Color(1, 1, 1, 0.8))
			note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			note.custom_minimum_size = Vector2(760, 0)
			note.text = "Sur un téléphone ou une tablette, les commandes tactiles s'affichent toujours. Sur PC, la souris joue le rôle d'un doigt."
			corps.add_child(note)

func choisir_onglet(i: int) -> void:
	onglet = clampi(i, 0, ONGLETS.size() - 1)
	ouvrir("options")

func _ligne(texte: String) -> HBoxContainer:
	var hb := HBoxContainer.new()
	hb.add_theme_constant_override("separation", 16)
	var l: Label = main.label(20 + (4 if au_doigt() else 0), Color.WHITE)
	l.text = _t(texte)
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if au_doigt():
		l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		l.custom_minimum_size = Vector2(380, HAUTEUR_DOIGT)
		l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	hb.add_child(l)
	corps.add_child(hb)
	return hb

func _coche(texte: String, cle: String) -> void:
	var c := CheckButton.new()
	if au_doigt():
		c.custom_minimum_size = Vector2(110, HAUTEUR_DOIGT)
	c.button_pressed = options.v[cle]
	c.toggled.connect(func(on: bool) -> void: options.regler(main, cle, on))
	_ligne(texte).add_child(c)
	boutons.append(c)

func _choix(texte: String, noms: Array, courant: int, action: Callable) -> void:
	var o := OptionButton.new()
	o.add_theme_font_size_override("font_size", 20)
	for n in noms:
		o.add_item(n)
	o.selected = courant
	o.item_selected.connect(action)
	_ligne(texte).add_child(o)
	boutons.append(o)

func _curseur(texte: String, cle: String, mini: int, maxi: int, pas: int) -> void:
	var hb := _ligne(texte)
	var s := HSlider.new()
	s.min_value = mini
	s.max_value = maxi
	s.step = pas
	s.value = options.v[cle]
	s.custom_minimum_size = Vector2(300, 48 if au_doigt() else 24)
	var val: Label = main.label(20, Color.WHITE)
	val.text = str(options.v[cle])
	val.custom_minimum_size = Vector2(50, 0)
	s.value_changed.connect(func(x: float) -> void:
		options.regler(main, cle, int(x))
		val.text = str(options.v[cle]))
	hb.add_child(s)
	hb.add_child(val)
	boutons.append(s)

# ---------------- touches ----------------
func attendre_touche(action: String) -> void:
	capture = action
	l_message.text = "%s : appuie sur la nouvelle touche (Échap pour annuler)" % options.libelle(action)
	if capteur.is_inside_tree():
		capteur.grab_focus()

func _touche_recue(ev: InputEvent) -> void:
	if capture == "" or not (ev is InputEventKey) or not ev.pressed or ev.echo:
		return
	var action := capture
	avale = true
	var msg := "Annulé."
	if ev.physical_keycode != KEY_ESCAPE:
		msg = options.changer_touche(action, ev.physical_keycode)
	if capteur.is_inside_tree():
		capteur.accept_event()
	ouvrir("options")
	l_message.text = msg

func touches_origine() -> void:
	options.touches_defaut_remettre()
	options.ecrire()
	ouvrir("options")
	l_message.text = "Touches d'origine remises."

# ---------------- manette ----------------
# Tableau des commandes de la manette, une ligne par bouton.
func schema_manette() -> String:
	var par_bouton := {}
	var ordre := []
	for l in options.MANETTE:
		var quoi: String = "Pause" if l[0] == "quit" else options.libelle(l[0])
		if l[4] == "Manche gauche":
			quoi = "Se diriger"
		if not par_bouton.has(l[4]):
			par_bouton[l[4]] = []
			ordre.append(l[4])
		if not par_bouton[l[4]].has(quoi):
			par_bouton[l[4]].append(quoi)
	var lignes := []
	for b in ordre:
		lignes.append("%s : %s" % [b, " / ".join(par_bouton[b])])
	lignes.append("Dans les menus — croix ou manche : choisir · A : valider · B : retour")
	return "\n".join(lignes)
