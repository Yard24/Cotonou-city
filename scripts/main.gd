extends Node3D
# Marina City (dépôt cotonou-city) — monde, missions, monter et descendre des véhicules.
# Circulation et passants : trafic.gd ; caméra : vue.gd ; affichage : hud.gd.
# Quatre niveaux graphiques (touche F4) : Bas pour les petits PC, jusqu'à Ultra.

const CarScript := preload("res://scripts/car.gd")
const PlayerScript := preload("res://scripts/player.gd")
const MinimapScript := preload("res://scripts/minimap.gd")
const SelftestScript := preload("res://scripts/selftest.gd")
const DecorScript := preload("res://scripts/decor.gd")
const HudScript := preload("res://scripts/hud.gd")
const ReliefScript := preload("res://scripts/relief.gd")
const InteractionScript := preload("res://scripts/interaction.gd")
const TraficScript := preload("res://scripts/trafic.gd")
const VueScript := preload("res://scripts/vue.gd")
const ZemScript := preload("res://scripts/zem.gd")
const EmbScript := preload("res://scripts/embarquement.gd")
const WATER_Y := ReliefScript.WATER_Y
const SPAWN := Vector3(14, 0, -50)
const PAL := ["f2e6d0", "e8c99a", "d98c5f", "f4f1ea", "c4d4c8", "e2b3a0", "9fc3d9", "f0dc8a", "d6d0c4"]
const SHIRTS := ["d94f8a", "2a7de1", "ffffff", "3f9a3c", "ff7a00", "8e2bd1", "e8112d", "14a3a3"]
const CARC := ["f4f4f4", "d8d8d8", "2b2b2b", "9aa3a8", "7a1f1f", "23407a"]
const XS := [[-200, -127], [-113, -7], [7, 113], [127, 200]]
const ZS := [[-153, -127], [-113, -7], [7, 113], [127, 200]]
# voitures garées : [x, z, cap, couleur] ; garées dans le sens de la circulation (on roule à droite)
const PARK := [[10.5, -52.0, PI, "c0272d"], [-10.5, 60.0, 0.0, "f4f4f4"], [129.5, -60.0, PI, "2255aa"], [-60.0, -129.5, -PI / 2, "9aa3a8"], [-129.5, 70.0, 0.0, "1d5e3a"]]

var rng := RandomNumberGenerator.new()
var mats := {}
var blocks: Array = []
var player
var cars: Array = []
var traffic: Array = []
var npcs: Array = []
var cur_car = null
var cam: Camera3D
var cam_target := Vector3.ZERO
var marker: Node3D
var money := 0
var mission_i := 0
var need_car := false
var banner_t := 0.0
var help_t := 14.0
var l_money: Label
var l_mission: Label
var l_hint: Label
var l_speed: Label
var l_banner: Label
var l_fps: Label
var sun: DirectionalLight3D
var env: Environment
var quality := 2
var quality_t := 0.0
const QNAMES := ["Bas", "Moyen", "Élevé", "Ultra"]
var road_segs: Array = []
var menu: Control
var menu_title: Label
var menu_play: Button
var minimap: Control
var selftest := false
var frames := 0
var tester
var hud = HudScript.new()
var decor = DecorScript.new()
var relief = ReliefScript.new()
var inter = InteractionScript.new()
var trafic = TraficScript.new()
var vue = VueScript.new()
var zem = ZemScript.new()   # courses de zémidjan : clients et passager
var sys = preload("res://scripts/systemes.gd").new()   # sauvegarde, options, menus, affichage en jeu
var emb = EmbScript.new()   # monter et descendre : portières, place libre, saut en marche
var moto_romaric   # la moto prêtée par Romaric, garée au point de départ (décision 51)
var hp_fill: ColorRect
var info_text := ""
var info_t := 0.0
# caméra de conduite : trois distances puis vue intérieure (touche V)
const CAMS := [[8.0, 3.4, "proche"], [11.0, 4.6, "normale"], [15.0, 6.2, "lointaine"], [0.0, 0.0, "intérieure"]]
const SOINS_PART := 0.1     # un évanouissement coûte 10 % de l'argent en soins…
const SOINS_MAX := 2000     # … sans dépasser 2 000 FCFA
var cam_mode := 1

var missions := [
	{"t": "Mission 1/3 — Romaric te prête sa moto : monte dessus (touche E), puis roule jusqu'au Marché Dantokpa (colonne jaune).", "x": 60.0, "z": 22.0, "car": true, "r": 5000, "ok": "Arrivé au marché"},
	{"t": "Mission 2/3 — Une commerçante te confie un colis : livre-le sur le Boulevard de la Marina, au bord de la mer.", "x": -80.0, "z": -160.0, "car": true, "r": 7500, "ok": "Colis livré"},
	{"t": "Mission 3/3 — Retourne à la Place de l'Amazone et arrête-toi devant la statue.", "x": 0.0, "z": -40.0, "car": false, "r": 3000, "ok": "Bienvenue à l'Amazone"},
]

# ---------------- outils ----------------
func mat(c: Color) -> StandardMaterial3D:
	var k := c.to_html()
	if not mats.has(k):
		var m := StandardMaterial3D.new()
		m.albedo_color = c
		mats[k] = m
	return mats[k]

func box(size: Vector3, c: Color, pos: Vector3, parent: Node = null, solid := false) -> MeshInstance3D:
	var m := MeshInstance3D.new()
	var b := BoxMesh.new()
	b.size = size
	m.mesh = b
	m.material_override = mat(c)
	m.position = pos
	(parent if parent else self).add_child(m)
	if solid:
		wall(size, pos)
	return m

func cyl(rt: float, rb: float, h: float, c: Color, pos: Vector3, parent: Node = null, seg := 10) -> MeshInstance3D:
	var m := MeshInstance3D.new()
	var b := CylinderMesh.new()
	b.top_radius = rt
	b.bottom_radius = rb
	b.height = h
	b.radial_segments = seg
	b.rings = 1
	m.mesh = b
	m.material_override = mat(c)
	m.position = pos
	(parent if parent else self).add_child(m)
	return m

# Mur invisible. Couche 1 : tout le monde ; couche 2 : arrête seulement les véhicules.
func wall(size: Vector3, pos: Vector3, layer := 1) -> void:
	var s := StaticBody3D.new()
	s.collision_layer = layer
	var cs := CollisionShape3D.new()
	var sh := BoxShape3D.new()
	sh.size = size
	cs.shape = sh
	s.position = pos
	s.add_child(cs)
	add_child(s)

func post(x: float, z: float, r: float) -> void:
	var s := StaticBody3D.new()
	var cs := CollisionShape3D.new()
	var sh := CylinderShape3D.new()
	sh.radius = r
	sh.height = 6.0
	cs.shape = sh
	s.position = Vector3(x, 3, z)
	s.add_child(cs)
	add_child(s)

func rr(a: float, b: float) -> float:
	return rng.randf_range(a, b)

func pick(a: Array):
	return a[rng.randi() % a.size()]

func make_human(parent: Node, shirt: Color, pants: Color, skin: Color) -> Dictionary:
	var d := {}
	for side in [["legL", -0.17], ["legR", 0.17]]:
		var p := Node3D.new()
		p.position = Vector3(side[1], 0.9, 0)
		parent.add_child(p)
		box(Vector3(0.22, 0.9, 0.24), pants, Vector3(0, -0.45, 0), p)
		d[side[0]] = p
	box(Vector3(0.6, 0.75, 0.32), shirt, Vector3(0, 1.28, 0), parent)
	for side in [["armL", -0.4], ["armR", 0.4]]:
		var p := Node3D.new()
		p.position = Vector3(side[1], 1.6, 0)
		parent.add_child(p)
		box(Vector3(0.15, 0.68, 0.17), skin, Vector3(0, -0.34, 0), p)
		d[side[0]] = p
	box(Vector3(0.36, 0.38, 0.36), skin, Vector3(0, 1.88, 0), parent)
	return d

func anim_human(d: Dictionary, ph: float, amt: float) -> void:
	var s := sin(ph) * amt
	d.legL.rotation.x = s
	d.legR.rotation.x = -s
	d.armL.rotation.x = -s * 0.8
	d.armR.rotation.x = s * 0.8

func label(size: int, color: Color) -> Label:
	var l := Label.new()
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	l.add_theme_color_override("font_outline_color", Color.BLACK)
	l.add_theme_constant_override("outline_size", 8)
	return l

# ---------------- démarrage ----------------
func _ready() -> void:
	rng.seed = 20171
	selftest = "--selftest" in OS.get_cmdline_user_args()
	_inputs()
	_env()
	_world()
	decor.amazone(self)
	decor.market(self)
	decor.decor(self)
	trafic.vehicles(self)
	trafic.people(self)
	zem.build(self)
	relief.build(self)
	inter.build(self)
	_hud()
	_set_mission()
	_apply_quality()
	if not selftest:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	sys.build(self)

func _inputs() -> void:
	var m := {"up": [KEY_W, KEY_UP], "down": [KEY_S, KEY_DOWN], "left": [KEY_A, KEY_LEFT], "right": [KEY_D, KEY_RIGHT],
		"brake": [KEY_SPACE], "jump": [KEY_SPACE], "crouch": [KEY_C, KEY_CTRL], "run": [KEY_SHIFT], "enter": [KEY_E], "quit": [KEY_ESCAPE], "fps": [KEY_F3], "quality": [KEY_F4],
		"horn": [KEY_H], "lights": [KEY_L], "blink_l": [KEY_J], "blink_r": [KEY_K], "cam": [KEY_V]}
	for a in m:
		if not InputMap.has_action(a):
			InputMap.add_action(a)
		for k in m[a]:
			var e := InputEventKey.new()
			e.physical_keycode = k
			InputMap.action_add_event(a, e)

func _env() -> void:
	var we := WorldEnvironment.new()
	var e := Environment.new()
	env = e
	e.background_mode = Environment.BG_COLOR
	e.background_color = Color("f6cf96")
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	e.ambient_light_color = Color("fff1d6")
	e.ambient_light_energy = 0.45
	e.fog_enabled = true
	e.fog_light_color = Color("f6cf96")
	e.fog_density = 0.004
	we.environment = e
	add_child(we)
	sun = DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55, -50, 0)
	sun.light_color = Color("ffdcaa")
	sun.light_energy = 0.7
	sun.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_4_SPLITS
	sun.directional_shadow_max_distance = 160.0
	add_child(sun)
	cam = Camera3D.new()
	cam.fov = 62
	cam.far = 320
	cam.near = 0.5
	add_child(cam)

func _world() -> void:
	box(Vector3(520, 0.2, 440), Color("b5653a"), Vector3(0, -0.1, 53))
	box(Vector3(520, 0.2, 26), Color("e8d3a0"), Vector3(0, -0.09, -180))
	box(Vector3(1400, 0.2, 600), Color("2a86b5"), Vector3(0, -0.4, -493))
	var road := Color("3a3a3d")
	var dashes: Array = []
	for x in [-120, 0, 120]:
		box(Vector3(14, 0.04, 367), road, Vector3(x, 0.0, 16.5))
		road_segs.append([Vector2(x, -167), Vector2(x, 200), 14.0])
		var z := -160.0
		while z < 195.0:
			dashes.append(Transform3D(Basis(), Vector3(x, 0.03, z)))
			z += 14.0
	for z in [-160, -120, 0, 120]:
		box(Vector3(420 if z == -160 else 400, 0.04, 14), road, Vector3(0, 0.005, z))
		road_segs.append([Vector2(-210, z), Vector2(210, z), 14.0])
		var x := -195.0
		while x < 195.0:
			dashes.append(Transform3D(Basis(Vector3.UP, PI / 2), Vector3(x, 0.035, z)))
			x += 14.0
	var mm := MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	var dm := BoxMesh.new()
	dm.size = Vector3(0.3, 0.02, 5.0)
	mm.mesh = dm
	mm.instance_count = dashes.size()
	for i in dashes.size():
		mm.set_instance_transform(i, dashes[i])
	var mi := MultiMeshInstance3D.new()
	mi.multimesh = mm
	mi.material_override = mat(Color("e8e8e8"))
	add_child(mi)
	for i in XS.size():
		for j in ZS.size():
			var b := {"x0": float(XS[i][0]), "x1": float(XS[i][1]), "z0": float(ZS[j][0]), "z1": float(ZS[j][1]), "market": i == 2 and j == 2}
			blocks.append(b)
			box(Vector3(b.x1 - b.x0, 0.1, b.z1 - b.z0), Color("a3957f"), Vector3((b.x0 + b.x1) / 2, 0.03, (b.z0 + b.z1) / 2))
	# limites du monde
	wall(Vector3(430, 10, 2), Vector3(0, 5, 207))
	wall(Vector3(2, 10, 400), Vector3(207, 5, 8))
	wall(Vector3(2, 10, 400), Vector3(-207, 5, 8))
	for b in blocks:
		if b.market:
			continue
		for cx in _lots(b.x0, b.x1):
			for cz in _lots(b.z0, b.z1):
				if Vector2(cx, cz).length() < 46 or _near_park(cx, cz, 17) or rng.randf() < 0.12:
					continue
				var w := rr(9, 15)
				var d := rr(9, 15)
				var h := rr(16, 28) if rng.randf() < 0.12 else rr(4, 12)
				box(Vector3(w, h, d), Color(pick(PAL)), Vector3(cx, h / 2, cz), null, true)
				for f in min(2, int(h / 3.3)):
					box(Vector3(w + 0.06, 1.0, d + 0.06), Color("3c4b57"), Vector3(cx, f * 3.3 + 2.0, cz))

func _lots(a0: float, a1: float) -> Array:
	var l := a1 - a0 - 6.0
	var n: int = max(1, int(l / 20.0))
	var out := []
	for i in n:
		out.append(a0 + 3.0 + l / n * (i + 0.5))
	return out

func _near_park(x: float, z: float, d: float) -> bool:
	for p in PARK:
		if Vector2(p[0] - x, p[1] - z).length() < d:
			return true
	return false

func _hud() -> void:
	hud.build(self)

	if selftest:
		_play()

func open_menu(title: String, play_text: String) -> void:
	menu_title.text = title
	menu_play.text = play_text
	menu.visible = true
	for a in ["up", "down", "left", "right", "brake", "run", "jump", "crouch"]:
		Input.action_release(a)

func _play() -> void:
	menu.visible = false

# Hauteur du sol à cet endroit (0 partout, fond en pente sous la mer).
func ground_h(x: float, z: float) -> float:
	return ReliefScript.ground_h(x, z)

# Message d'information en bas de l'écran pendant quelques secondes.
func say(text: String, secs: float) -> void:
	info_text = text
	info_t = secs

# Réveil du héros après un évanouissement.
func respawn() -> void:
	player.teleport(SPAWN, PI)
	player.health = player.SANTE_MAX
	var frais: int = min(SOINS_MAX, int(money * SOINS_PART))
	money -= frais
	_banner("Tu reprends tes esprits\nplace de l'Amazone" + ("\nSoins : -%d FCFA" % frais if frais > 0 else ""))

# Choc en voiture : le conducteur perd de la santé ; évanoui, il est sorti du véhicule.
func crash_hurt(amount: float) -> void:
	player.hurt(amount)
	if player.ko_t > 0.0 and cur_car:
		cur_car.speed = 0.0
		toggle_car()

# Coup de klaxon : les passants proches sursautent et pressent le pas quelques secondes.
func startle(pos: Vector3, radius: float) -> int:
	var n := 0
	for p in npcs:
		if p.n.position.distance_to(pos) < radius:
			p.scare = 2.5
			n += 1
	return n

# Touche E : descendre du véhicule, sinon l'objet ou le véhicule le plus proche.
# (Les courses de zémidjan s'acceptent avec M : zem.gd.)
func press_e() -> void:
	if cur_car:
		toggle_car()
		return
	if player.ko_t > 0.0 or player.down_t > 0.0 or player.mantle_t > 0.0:
		return
	var it: Dictionary = inter.nearest(self)
	var c = _nearest_car()
	if not it.is_empty() and (c == null or it.d <= c.global_position.distance_to(player.global_position)):
		inter.use(self, it)
	else:
		toggle_car()

func focus_pos() -> Vector3:
	return cur_car.global_position if cur_car else player.global_position

func focus_heading() -> float:
	return cur_car.heading if cur_car else player.heading

func _set_mission() -> void:
	if mission_i < missions.size():
		var m: Dictionary = missions[mission_i]
		l_mission.text = m.t
		marker.position = Vector3(m.x, 0, m.z)
		marker.visible = true
	else:
		l_mission.text = "Balade libre — les missions de cette version sont terminées. Explore Cotonou !"
		marker.visible = false

func _banner(t: String) -> void:
	l_banner.text = t
	l_banner.visible = true
	banner_t = 3.0

func _apply_quality() -> void:
	var vp := get_viewport()
	sun.shadow_enabled = quality >= 1
	sun.directional_shadow_max_distance = [0.0, 110.0, 180.0, 260.0][quality]
	vp.scaling_3d_scale = [0.7, 1.0, 1.0, 1.0][quality]
	vp.msaa_3d = [Viewport.MSAA_DISABLED, Viewport.MSAA_DISABLED, Viewport.MSAA_2X, Viewport.MSAA_4X][quality]
	cam.far = [260.0, 420.0, 600.0, 900.0][quality]
	env.fog_density = [0.006, 0.0035, 0.0025, 0.0018][quality]
	env.ssao_enabled = quality >= 3
	env.glow_enabled = false

# ---------------- monter / descendre ----------------
# Véhicule le plus proche sur lequel on peut monter : voitures, et motos garées.
func _nearest_car():
	var best = null
	var bd := 4.8
	for c in cars + traffic:
		if c.moto and c.ai:
			continue
		var d: float = c.global_position.distance_to(player.global_position)
		if d < bd:
			bd = d
			best = c
	return best

# Monter ou descendre : portières, place libre, saut en marche… tout est dans embarquement.gd.
func toggle_car() -> void:
	emb.toggle(self)

func mount(c) -> void:
	if c.ai:
		c.ai = false
		c.speed = 0.0
		traffic.erase(c)
		cars.append(c)
		_banner("Voiture empruntée !")
	cur_car = c
	c.fx.blink = 0
	c.fx._show_blink()
	c.fx._spot()
	if c.moto:
		c.lean = 0.0
		c.set_rider_color(Color("008751"))
	player.reset_pose()
	player.visible = false
	player.shape.disabled = true

# Le héros quitte le véhicule de toute façon (chute) : debout à gauche s'il y a la place.
func _get_off() -> void:
	emb.descendre(self, true)

# Chute à moto : le pilote se retrouve par terre à côté de sa moto couchée. Il perd de la
# santé et du temps, jamais connaissance (décision 53) : il lui reste toujours 5 points.
const CHUTE_SANTE_MIN := 5.0
const CHUTE_T := 2.0
func moto_fall(_c, impact: float) -> void:
	_get_off()
	player.hurt(min((impact - 4.0) * 2.5, player.health - CHUTE_SANTE_MIN))
	player.fall_down(CHUTE_T)
	say("Chute ! Relève la moto avec E, puis remonte dessus.", 5.0)
	zem.on_fall(self, _c)

# ---------------- boucle ----------------
func _physics_process(delta: float) -> void:
	frames += 1
	if selftest:
		if tester == null:
			tester = SelftestScript.new()
		tester.step(self)
	if "--shot" in OS.get_cmdline_user_args() and frames == 90:
		get_viewport().get_texture().get_image().save_png("user://shot.png")
		get_tree().quit()
	if sys.step(self, delta):
		return   # un panneau de menu (sauvegarde, options) est ouvert
	if Input.is_action_just_pressed("quit") and not selftest:
		if menu.visible:
			_play()
		else:
			open_menu("PAUSE", "Reprendre")
	if menu.visible:
		if Input.is_action_just_pressed("ui_accept"):
			_play()
		return
	if Input.is_action_just_pressed("enter"):
		press_e()
	if Input.is_action_just_pressed("quality"):
		quality = (quality + 1) % 4
		_apply_quality()
		quality_t = 3.0
	if Input.is_action_just_pressed("fps"):
		l_fps.visible = not l_fps.visible
	if cur_car:
		if Input.is_action_just_pressed("lights"):
			cur_car.fx.toggle_lights()
		if Input.is_action_just_pressed("blink_l"):
			cur_car.fx.set_blink(1)
		if Input.is_action_just_pressed("blink_r"):
			cur_car.fx.set_blink(-1)
		if Input.is_action_just_pressed("horn"):
			startle(cur_car.global_position, cur_car.fx.HORN_RANGE)
		if Input.is_action_just_pressed("cam"):
			cam_mode = (cam_mode + 1) % CAMS.size()
			say("Caméra %s (V pour changer)" % CAMS[cam_mode][2], 2.0)
		if emb.bloque(self):
			cur_car.idle(delta)   # le héros s'installe : la voiture ne démarre pas encore
		else:
			cur_car.drive(delta)
	else:
		player.walk(self, delta)
	for c in cars:
		if c != cur_car:
			c.idle(delta)
	emb.step(self, delta)
	var pp: Vector3 = focus_pos()
	trafic.step(self, delta, pp)
	zem.step(self, delta)
	_mission(pp)
	_camera(delta, false)
	_hud_update(delta)

func _mission(pp: Vector3) -> void:
	need_car = false
	if mission_i >= missions.size():
		return
	var m: Dictionary = missions[mission_i]
	if Vector2(pp.x - m.x, pp.z - m.z).length() < 5.5:
		if m.car and not cur_car:
			need_car = true
			return
		money += m.r
		_banner("MISSION ACCOMPLIE\n%s · +%d FCFA" % [m.ok, m.r])
		mission_i += 1
		_set_mission()

func _camera(delta: float, instant: bool) -> void:
	vue.update(self, delta, instant)

func _hud_update(delta: float) -> void:
	hud.update(self, delta)
