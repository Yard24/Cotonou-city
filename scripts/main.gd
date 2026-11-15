extends Node3D
# Cotonou City — monde, circulation, missions, affichage.
# Quatre niveaux graphiques (touche F4) : Bas pour les petits PC, jusqu'à Ultra.

const CarScript := preload("res://scripts/car.gd")
const PlayerScript := preload("res://scripts/player.gd")
const MinimapScript := preload("res://scripts/minimap.gd")
const SelftestScript := preload("res://scripts/selftest.gd")
const PAL := ["f2e6d0", "e8c99a", "d98c5f", "f4f1ea", "c4d4c8", "e2b3a0", "9fc3d9", "f0dc8a", "d6d0c4"]
const SHIRTS := ["d94f8a", "2a7de1", "ffffff", "3f9a3c", "ff7a00", "8e2bd1", "e8112d", "14a3a3"]
const CARC := ["f4f4f4", "d8d8d8", "2b2b2b", "9aa3a8", "7a1f1f", "23407a"]
const XS := [[-200, -127], [-113, -7], [7, 113], [127, 200]]
const ZS := [[-153, -127], [-113, -7], [7, 113], [127, 200]]
const PARK := [[10.5, -52.0, 0.0, "c0272d"], [-10.5, 60.0, PI, "f4f4f4"], [129.5, -60.0, 0.0, "2255aa"], [-60.0, -129.5, PI / 2, "9aa3a8"], [-129.5, 70.0, PI, "1d5e3a"]]

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

var missions := [
	{"t": "Mission 1/3 — Monte dans la voiture rouge à côté de toi (touche E), puis roule jusqu'au Marché Dantokpa (colonne jaune).", "x": 60.0, "z": 22.0, "car": true, "r": 5000, "ok": "Arrivé au marché"},
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

func wall(size: Vector3, pos: Vector3) -> void:
	var s := StaticBody3D.new()
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
	_amazone()
	_market()
	_decor()
	_vehicles()
	_people()
	_hud()
	_set_mission()
	_apply_quality()
	if not selftest:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _inputs() -> void:
	var m := {"up": [KEY_W, KEY_UP], "down": [KEY_S, KEY_DOWN], "left": [KEY_A, KEY_LEFT], "right": [KEY_D, KEY_RIGHT],
		"brake": [KEY_SPACE], "jump": [KEY_SPACE], "crouch": [KEY_C, KEY_CTRL], "run": [KEY_SHIFT], "enter": [KEY_E], "quit": [KEY_ESCAPE], "fps": [KEY_F3], "quality": [KEY_F4]}
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
	wall(Vector3(430, 10, 2), Vector3(0, 5, -190))
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

func _amazone() -> void:
	cyl(30, 30, 0.06, Color("3a3a3d"), Vector3(0, 0.03, 0), null, 40)
	cyl(12.6, 12.6, 0.5, Color("f2f2f2"), Vector3(0, 0.25, 0), null, 32)
	cyl(12, 12, 0.7, Color("5f9a3a"), Vector3(0, 0.35, 0), null, 32)
	post(0, 0, 12.8)
	var br := Color("7a4a22")
	cyl(5, 6, 1.6, Color("e9e2d0"), Vector3(0, 1.5, 0), null, 20)
	box(Vector3(4, 5, 4), Color("d8cfbb"), Vector3(0, 4.8, 0))
	cyl(0.42, 0.5, 4, br, Vector3(-0.65, 9.3, 0))
	cyl(0.42, 0.5, 4, br, Vector3(0.65, 9.3, 0))
	cyl(1.6, 1.1, 1.6, br, Vector3(0, 10.8, 0))
	cyl(0.95, 0.8, 3.6, br, Vector3(0, 13.2, 0))
	box(Vector3(1.3, 1.4, 1.3), br, Vector3(0, 15.6, 0))
	cyl(0.3, 0.3, 3.4, br, Vector3(1.5, 15.2, 0)).rotation.z = -0.65
	cyl(0.3, 0.3, 3.2, br, Vector3(-1.25, 12.6, 0.2)).rotation.z = 0.25
	cyl(0.13, 0.13, 8, Color("4a2c12"), Vector3(2.6, 16.2, 0))
	cyl(0.0, 0.35, 1.2, Color("4a2c12"), Vector3(2.6, 20.8, 0))

func _market() -> void:
	var umb := ["e8112d", "fcd116", "008751", "2a6fdb", "ff7a00", "ffffff", "8e2bd1"]
	var x := 13.0
	while x < 109.0:
		var z := 13.0
		while z < 109.0:
			var skip: bool = (abs(x - 60.0) < 10.0 and z < 48.0) or Vector2(x, z).length() < 44 or rng.randf() < 0.15 or (x > 78 and z > 86)
			if not skip:
				var px := x + rr(-1, 1)
				var pz := z + rr(-1, 1)
				box(Vector3(2.6, 0.9, 1.6), Color("8b5a2b"), Vector3(px, 0.6, pz), null, true)
				box(Vector3(1.9, 0.3, 0.6), Color(pick(["ff7a00", "e8112d", "2f7d32", "fcd116"])), Vector3(px, 1.2, pz))
				cyl(0.07, 0.07, 3, Color("555555"), Vector3(px, 1.6, pz), null, 5)
				cyl(0.0, 2.6, 1.1, Color(pick(umb)), Vector3(px, 3.35, pz), null, 8)
			z += 9.0
		x += 9.0
	box(Vector3(30, 8, 12), Color("d9c9a3"), Vector3(95, 4, 95), null, true)

func _sign(text: String, pos: Vector3, w: float, bg: Color, fg: Color, px := 96) -> void:
	box(Vector3(w, 2.4, 0.12), bg, pos)
	cyl(0.12, 0.12, pos.y, Color("777777"), Vector3(pos.x - w / 2 + 0.4, pos.y / 2, pos.z), null, 5)
	cyl(0.12, 0.12, pos.y, Color("777777"), Vector3(pos.x + w / 2 - 0.4, pos.y / 2, pos.z), null, 5)
	for s in [1.0, -1.0]:
		var l := Label3D.new()
		l.text = text
		l.font_size = px
		l.pixel_size = 0.012
		l.modulate = fg
		l.outline_size = 0
		l.position = pos + Vector3(0, 0, 0.08 * s)
		if s < 0:
			l.rotation.y = PI
		add_child(l)
	post(pos.x, pos.z, 0.5)

func _palm(x: float, z: float) -> void:
	cyl(0.22, 0.35, 7, Color("8b6a43"), Vector3(x, 3.5, z), null, 6)
	for i in 3:
		var l := box(Vector3(0.6, 0.08, 7.0), Color("2f7d32") if i % 2 else Color("3f9a3c"), Vector3(x, 7.0, z))
		l.rotation = Vector3(0.0, i * PI / 3 + rr(0, 0.4), 0.0)
	post(x, z, 0.45)

func _decor() -> void:
	_sign("Place de l'Amazone", Vector3(12, 4.2, -36), 9.5, Color("1d6b3a"), Color.WHITE, 72)
	_sign("Boulevard de la Marina", Vector3(-40, 4, -151.5), 11, Color("1d6b3a"), Color.WHITE, 72)
	_sign("BIENVENUE À COTONOU", Vector3(50, 6, -151.8), 14, Color("fcd116"), Color("1a1a1a"), 84)
	_sign("Marché Dantokpa", Vector3(60, 4.6, 8.8), 9, Color("e8112d"), Color.WHITE, 80)
	cyl(0.15, 0.18, 12, Color("cccccc"), Vector3(25, 6, -25), null, 6)
	box(Vector3(1.8, 3.0, 0.06), Color("008751"), Vector3(26.05, 10.4, -25))
	box(Vector3(2.7, 1.5, 0.06), Color("fcd116"), Vector3(28.3, 11.15, -25))
	box(Vector3(2.7, 1.5, 0.06), Color("e8112d"), Vector3(28.3, 9.65, -25))
	post(25, -25, 0.5)
	for b in blocks:
		var x: float = b.x0 + 6.0
		while x < b.x1 - 4.0:
			for z in [b.z0 + 1.6, b.z1 - 1.6]:
				if rng.randf() < 0.45 and Vector2(x, z).length() > 34 and not _near_park(x, z, 6):
					_palm(x, z)
			x += rr(22, 34)

func _car(color: Color, taxi: bool, is_moto: bool):
	var c = CarScript.new()
	add_child(c)
	c.setup(self, color, taxi, is_moto)
	return c

func _quad(sx: float, sz: float) -> Array:
	var p := [Vector2(sx * 3.5, sz * 26), Vector2(sx * 3.5, sz * 116.5), Vector2(sx * 116.5, sz * 116.5), Vector2(sx * 116.5, sz * 3.5), Vector2(sx * 26, sz * 3.5)]
	var a1 := atan2(sz * 3.5, sx * 20.5)
	var da := angle_difference(a1, atan2(sz * 20.5, sx * 3.5))
	for i in 9:
		var a := a1 + da * i / 8.0
		p.append(Vector2(cos(a), sin(a)) * 21.0)
	return p

func _vehicles() -> void:
	for p in PARK:
		var c = _car(Color(p[3]), false, false)
		c.global_position = Vector3(p[0], 0, p[1])
		c.heading = p[2]
		c.rotation.y = p[2]
		cars.append(c)
	var paths := [
		[_quad(1, 1), 12.0, 3, 1], [_quad(-1, 1), 12.0, 3, 1], [_quad(1, -1), 12.0, 3, 1], [_quad(-1, -1), 12.0, 3, 1],
		[[Vector2(-123.5, -123.5), Vector2(123.5, -123.5), Vector2(123.5, 123.5), Vector2(-123.5, 123.5)], 14.0, 8, 4],
		[[Vector2(-200, -163.5), Vector2(200, -163.5), Vector2(200, -156.5), Vector2(-200, -156.5)], 16.0, 7, 3]]
	for P in paths:
		for i in P[2]:
			var is_moto: bool = i < P[3]
			var taxi: bool = (not is_moto) and rng.randf() < 0.45
			var col := Color(pick(["aa1111", "1144aa", "111111"])) if is_moto else (Color("f2c200") if taxi else Color(pick(CARC)))
			var c = _car(col, taxi, is_moto)
			c.ai = true
			c.set_path(P[0])
			c.vmax = P[1]
			c.speed = P[1]
			c.dist = c.path_len * i / P[2]
			c.place_on_path()
			traffic.append(c)

func _people() -> void:
	player = PlayerScript.new()
	add_child(player)
	player.setup(self)
	player.global_position = Vector3(14, 0, -50)
	player.rotation.y = player.heading
	for i in 30:
		var b = pick(blocks)
		var e := rng.randi() % 4
		var a: Vector2
		var c: Vector2
		if e < 2:
			var z: float = b.z1 - 1.6 if e == 1 else b.z0 + 1.6
			a = Vector2(b.x0 + 3, z)
			c = Vector2(b.x1 - 3, z)
		else:
			var x: float = b.x0 + 1.6 if e == 2 else b.x1 - 1.6
			a = Vector2(x, b.z0 + 3)
			c = Vector2(x, b.z1 - 3)
		var n := Node3D.new()
		add_child(n)
		var parts := make_human(n, Color(pick(SHIRTS)), Color(pick(["2b2b40", "5a4632", "1d5e3a", "222222"])), Color(pick(["5a3622", "4a2b1a", "6b4228"])))
		npcs.append({"n": n, "p": parts, "a": a, "c": c, "len": (c - a).length(), "t": rng.randf() * (c - a).length(), "dir": 1.0 if rng.randf() < 0.5 else -1.0, "v": rr(1.2, 2.0), "ph": rng.randf() * 6.0})
	marker = Node3D.new()
	add_child(marker)
	var bm := cyl(3, 3, 40, Color.WHITE, Vector3(0, 20, 0), marker, 16)
	var m := StandardMaterial3D.new()
	m.albedo_color = Color(1, 0.82, 0, 0.3)
	m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	m.cull_mode = BaseMaterial3D.CULL_DISABLED
	bm.material_override = m
	_camera(0.0, true)

func _hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	l_money = label(30, Color("8df59a"))
	l_money.position = Vector2(18, 12)
	layer.add_child(l_money)
	l_fps = label(16, Color.WHITE)
	l_fps.position = Vector2(18, 54)
	layer.add_child(l_fps)
	l_mission = label(22, Color.WHITE)
	l_mission.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
	l_mission.offset_left = 260
	l_mission.offset_right = -260
	l_mission.offset_top = 12
	l_mission.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	l_mission.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	layer.add_child(l_mission)
	l_hint = label(22, Color("ffe27a"))
	l_hint.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
	l_hint.offset_top = -120
	l_hint.offset_bottom = -20
	l_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l_hint.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	layer.add_child(l_hint)
	l_speed = label(44, Color.WHITE)
	l_speed.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	l_speed.offset_left = -260
	l_speed.offset_top = -80
	l_speed.offset_right = -20
	l_speed.offset_bottom = -12
	l_speed.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	layer.add_child(l_speed)
	l_banner = label(52, Color("f5c400"))
	l_banner.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	l_banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l_banner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	l_banner.visible = false
	layer.add_child(l_banner)

	minimap = MinimapScript.new()
	minimap.main = self
	minimap.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
	minimap.offset_left = -206
	minimap.offset_top = 16
	minimap.offset_right = -16
	minimap.offset_bottom = 206
	layer.add_child(minimap)
	# écran d'accueil et de pause
	menu = Control.new()
	menu.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(menu)
	var bg := ColorRect.new()
	bg.color = Color(0.08, 0.04, 0.02, 0.72)
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	menu.add_child(bg)
	var cc := CenterContainer.new()
	cc.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	menu.add_child(cc)
	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 14)
	cc.add_child(vb)
	menu_title = label(84, Color("f5c400"))
	menu_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vb.add_child(menu_title)
	var flag := HBoxContainer.new()
	flag.add_theme_constant_override("separation", 0)
	flag.custom_minimum_size = Vector2(0, 8)
	for fc in ["008751", "fcd116", "e8112d"]:
		var r := ColorRect.new()
		r.color = Color(fc)
		r.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		flag.add_child(r)
	vb.add_child(flag)
	var help := label(22, Color.WHITE)
	help.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	help.text = "Flèches ou ZQSD : avancer, reculer, tourner\nE : monter ou descendre d'une voiture\nÀ pied — Espace : sauter · Maj : courir · C : s'accroupir\nEn voiture — Espace : frein à main\nF4 : niveau graphique · F3 : images par seconde\nÉchap : pause"
	vb.add_child(help)
	menu_play = Button.new()
	menu_play.add_theme_font_size_override("font_size", 30)
	menu_play.custom_minimum_size = Vector2(360, 64)
	menu_play.pressed.connect(_play)
	vb.add_child(menu_play)
	var bq := Button.new()
	bq.text = "Quitter le jeu"
	bq.add_theme_font_size_override("font_size", 22)
	bq.custom_minimum_size = Vector2(360, 48)
	bq.pressed.connect(func() -> void: get_tree().quit())
	vb.add_child(bq)
	open_menu("COTONOU CITY", "Jouer (Entrée)")
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
func _nearest_car():
	var best = null
	var bd := 4.8
	for c in cars + traffic:
		if c.moto:
			continue
		var d: float = c.global_position.distance_to(player.global_position)
		if d < bd:
			bd = d
			best = c
	return best

func toggle_car() -> void:
	if cur_car:
		if abs(cur_car.speed) > 6.0:
			return
		var h: float = cur_car.heading
		player.global_position = cur_car.global_position + Vector3(cos(h), 0, -sin(h)) * 2.4
		player.heading = h
		player.rotation.y = h
		player.visible = true
		player.shape.disabled = false
		player.reset_pose()
		cur_car.speed = 0.0
		cur_car = null
		return
	var c = _nearest_car()
	if c == null:
		return
	if c.ai:
		c.ai = false
		c.speed = 0.0
		traffic.erase(c)
		cars.append(c)
		_banner("Voiture empruntée !")
	cur_car = c
	player.reset_pose()
	player.visible = false
	player.shape.disabled = true

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
		toggle_car()
	if Input.is_action_just_pressed("quality"):
		quality = (quality + 1) % 4
		_apply_quality()
		quality_t = 3.0
	if Input.is_action_just_pressed("fps"):
		l_fps.visible = not l_fps.visible
	if cur_car:
		cur_car.drive(delta)
	else:
		player.walk(self, delta)
	for c in cars:
		if c != cur_car:
			c.idle(delta)
	var pp: Vector3 = cur_car.global_position if cur_car else player.global_position
	for a in traffic:
		var f := Vector3(sin(a.heading), 0, cos(a.heading))
		var blocked := false
		for o in traffic + cars:
			if o == a:
				continue
			var dv: Vector3 = o.global_position - a.global_position
			var d := dv.length()
			if d < 8.5 and d > 0.1 and dv.dot(f) / d > 0.72:
				blocked = true
				break
		if not blocked and not cur_car:
			var dv2: Vector3 = pp - a.global_position
			var d2: float = dv2.length()
			blocked = d2 < 8.5 and d2 > 0.1 and dv2.dot(f) / d2 > 0.72
		a.ai_step(delta, blocked)
	for n in npcs:
		n.t += n.dir * n.v * delta
		if n.t > n.len:
			n.t = n.len
			n.dir = -1.0
		elif n.t < 0.0:
			n.t = 0.0
			n.dir = 1.0
		var p: Vector2 = n.a.lerp(n.c, n.t / n.len)
		n.n.position = Vector3(p.x, 0.08, p.y)
		n.n.rotation.y = atan2((n.c.x - n.a.x) * n.dir, (n.c.y - n.a.y) * n.dir)
		n.ph += delta * n.v * 3.0
		anim_human(n.p, n.ph, 0.6)
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
	var o: Vector3 = cur_car.global_position if cur_car else player.global_position
	var h: float = cur_car.heading if cur_car else player.heading
	var dist := 11.0 if cur_car else 6.5
	var hh := 4.6 if cur_car else 3.0
	# la caméra suit aussi la hauteur du héros (saut, objets sur lesquels il monte)
	var want := Vector3(o.x - sin(h) * dist, o.y + hh, o.z - cos(h) * dist)
	var tgt := o + Vector3(0, 1.6, 0)
	if instant:
		cam.position = want
		cam_target = tgt
	else:
		cam.position = cam.position.lerp(want, 1.0 - exp(-delta * 4.5))
		cam_target = cam_target.lerp(tgt, 1.0 - exp(-delta * 10.0))
	cam.look_at(cam_target, Vector3.UP)

func _hud_update(delta: float) -> void:
	l_money.text = "%d FCFA" % money
	l_fps.text = "%d images/s · Graphismes : %s (F4)" % [Engine.get_frames_per_second(), QNAMES[quality]]
	var t := ""
	if help_t > 0.0:
		help_t -= delta
		t = "Flèches ou ZQSD : bouger · E : monter/descendre · Espace : sauter (frein à main en voiture) · Maj : courir · C : s'accroupir · Échap : pause"
	if cur_car:
		l_speed.text = "%d km/h" % int(abs(cur_car.speed) * 3.6)
		if abs(cur_car.speed) < 1.5 and help_t <= 0.0:
			t = "E pour descendre"
	else:
		l_speed.text = ""
		if need_car:
			t = "Il te faut une voiture pour cette mission"
		elif _nearest_car() != null:
			t = "Appuie sur E pour monter dans la voiture"
	l_hint.text = t
	if banner_t > 0.0:
		banner_t -= delta
		if banner_t <= 0.0:
			l_banner.visible = false
