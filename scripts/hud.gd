extends RefCounted
# Affichage à l'écran : argent, santé, mission, aide, vitesse, mini-carte, écran d'accueil et de pause.

func build(m) -> void:
	var layer := CanvasLayer.new()
	m.add_child(layer)
	m.l_money = m.label(30, Color("8df59a"))
	m.l_money.position = Vector2(18, 12)
	layer.add_child(m.l_money)
	m.l_fps = m.label(16, Color.WHITE)
	m.l_fps.position = Vector2(18, 78)
	layer.add_child(m.l_fps)
	# jauge de santé
	var hp_bg := ColorRect.new()
	hp_bg.color = Color(0, 0, 0, 0.6)
	hp_bg.position = Vector2(18, 56)
	hp_bg.size = Vector2(204, 18)
	layer.add_child(hp_bg)
	m.hp_fill = ColorRect.new()
	m.hp_fill.position = Vector2(20, 58)
	m.hp_fill.size = Vector2(200, 14)
	layer.add_child(m.hp_fill)
	m.l_mission = m.label(22, Color.WHITE)
	m.l_mission.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
	m.l_mission.offset_left = 260
	m.l_mission.offset_right = -260
	m.l_mission.offset_top = 12
	m.l_mission.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	m.l_mission.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	layer.add_child(m.l_mission)
	m.l_hint = m.label(22, Color("ffe27a"))
	m.l_hint.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
	m.l_hint.offset_top = -120
	m.l_hint.offset_bottom = -20
	m.l_hint.offset_left = 80
	m.l_hint.offset_right = -80
	m.l_hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	m.l_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	m.l_hint.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	layer.add_child(m.l_hint)
	m.l_speed = m.label(44, Color.WHITE)
	m.l_speed.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	m.l_speed.offset_left = -260
	m.l_speed.offset_top = -80
	m.l_speed.offset_right = -20
	m.l_speed.offset_bottom = -12
	m.l_speed.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	layer.add_child(m.l_speed)
	m.l_banner = m.label(52, Color("f5c400"))
	m.l_banner.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	m.l_banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	m.l_banner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	m.l_banner.visible = false
	layer.add_child(m.l_banner)

	m.minimap = m.MinimapScript.new()
	m.minimap.main = m
	m.minimap.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
	m.minimap.offset_left = -206
	m.minimap.offset_top = 16
	m.minimap.offset_right = -16
	m.minimap.offset_bottom = 206
	layer.add_child(m.minimap)
	# écran d'accueil et de pause
	m.menu = Control.new()
	m.menu.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(m.menu)
	var bg := ColorRect.new()
	bg.color = Color(0.08, 0.04, 0.02, 0.72)
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	m.menu.add_child(bg)
	var cc := CenterContainer.new()
	cc.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	m.menu.add_child(cc)
	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 14)
	cc.add_child(vb)
	m.menu_title = m.label(84, Color("f5c400"))
	m.menu_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vb.add_child(m.menu_title)
	var sous_titre: Label = m.label(28, Color.WHITE)
	sous_titre.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sous_titre.text = "Cotonou, 2017-2026"
	vb.add_child(sous_titre)
	var flag := HBoxContainer.new()
	flag.add_theme_constant_override("separation", 0)
	flag.custom_minimum_size = Vector2(0, 8)
	for fc in ["008751", "fcd116", "e8112d"]:
		var r := ColorRect.new()
		r.color = Color(fc)
		r.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		flag.add_child(r)
	vb.add_child(flag)
	var help: Label = m.label(22, Color.WHITE)
	help.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	help.text = "Flèches ou ZQSD : avancer, reculer, tourner\nE : monter sur une moto ou dans une voiture, en descendre\nÀ pied — Espace : sauter, monter sur un muret · Maj : courir · C : s'accroupir\nE : acheter, s'asseoir, lire un panneau · On nage en entrant dans la mer\nEn voiture — Espace : frein à main · H : klaxon · L : phares · J et K : clignotants · V : caméra\nÀ moto — Bas : freiner · Espace : frein arrière (virage serré) · H : klaxon · V : caméra\nZémidjan — arrête ta moto près d'un client qui lève le bras, E pour accepter sa course, puis conduis-le à la colonne bleue\nF4 : niveau graphique · F3 : images par seconde\nÉchap : pause"
	vb.add_child(help)
	m.menu_play = Button.new()
	m.menu_play.add_theme_font_size_override("font_size", 30)
	m.menu_play.custom_minimum_size = Vector2(360, 64)
	m.menu_play.pressed.connect(m._play)
	vb.add_child(m.menu_play)
	var bq := Button.new()
	bq.text = "Quitter le jeu"
	bq.add_theme_font_size_override("font_size", 22)
	bq.custom_minimum_size = Vector2(360, 48)
	bq.pressed.connect(func() -> void: m.get_tree().quit())
	vb.add_child(bq)
	m.open_menu("MARINA CITY", "Jouer (Entrée)")

func update(m, delta: float) -> void:
	m.l_money.text = "%d FCFA" % m.money
	m.l_fps.text = "%d images/s · Graphismes : %s (F4)" % [Engine.get_frames_per_second(), m.QNAMES[m.quality]]
	var hp: float = m.player.health / m.player.SANTE_MAX
	m.hp_fill.size.x = 200.0 * hp
	m.hp_fill.color = Color("e8112d") if hp < 0.3 else (Color("fcd116") if hp < 0.6 else Color("3fbf5a"))
	var t := ""
	if m.help_t > 0.0:
		m.help_t -= delta
		t = "Flèches ou ZQSD : bouger · E : monter/descendre · Espace : sauter (frein en véhicule) · Maj : courir · C : s'accroupir · Échap : pause"
	if m.cur_car:
		m.l_speed.text = "%d km/h" % int(abs(m.cur_car.speed) * 3.6)
		if abs(m.cur_car.speed) < 1.5 and m.help_t <= 0.0:
			t = "E pour descendre"
		if m.zem.hint != "":
			t = m.zem.hint
		elif not m.zem.fare.is_empty() and abs(m.cur_car.speed) < 1.5:
			t = "E : déposer le client ici (course non payée)"
	else:
		m.l_speed.text = ""
		if m.need_car:
			t = "Il te faut un véhicule pour cette mission"
		else:
			var it: Dictionary = m.inter.nearest(m)
			var c = m._nearest_car()
			if m.player.sitting:
				t = "Une touche de direction pour te lever"
			elif m.player.swimming:
				t = "Tu nages — Maj : nager plus vite"
			elif not it.is_empty() and (c == null or it.d <= c.global_position.distance_to(m.player.global_position)):
				t = "E : " + it.label
			elif c != null and c.moto:
				t = "E : relever la moto" if c.fallen else "Appuie sur E pour monter sur la moto"
			elif c != null:
				t = "Appuie sur E pour monter dans la voiture"
	if m.info_t > 0.0:
		m.info_t -= delta
		t = m.info_text
	m.l_hint.text = t
	if m.banner_t > 0.0:
		m.banner_t -= delta
		if m.banner_t <= 0.0:
			m.l_banner.visible = false
