extends RefCounted
# Circulation et passants : véhicules garés, trajets de la circulation, piétons des trottoirs.
# L'ordre des tirages au hasard ne doit pas changer : la ville reste la même d'un lancement à l'autre.

const CarScript := preload("res://scripts/car.gd")
const MotoScript := preload("res://scripts/moto.gd")
const PlayerScript := preload("res://scripts/player.gd")
# motos garées : [x, z, cap, couleur] ; la première est celle de Romaric, à côté du point de départ
const MOTOS := [[16.0, -52.0, 0.0, "aa1111"], [70.0, 12.0, PI / 2, "1144aa"], [-70.0, -149.8, PI / 2, "111111"]]

func make(m, color: Color, taxi: bool, is_moto: bool):
	var c = MotoScript.new() if is_moto else CarScript.new()
	m.add_child(c)
	c.setup(m, color, taxi, is_moto)
	return c

func _quad(sx: float, sz: float) -> Array:
	var p := [Vector2(sx * 3.5, sz * 26), Vector2(sx * 3.5, sz * 116.5), Vector2(sx * 116.5, sz * 116.5), Vector2(sx * 116.5, sz * 3.5), Vector2(sx * 26, sz * 3.5)]
	var a1 := atan2(sz * 3.5, sx * 20.5)
	var da := angle_difference(a1, atan2(sz * 20.5, sx * 3.5))
	for i in 9:
		var a := a1 + da * i / 8.0
		p.append(Vector2(cos(a), sin(a)) * 21.0)
	return p

func _park(m, p: Array, is_moto: bool):
	var c = make(m, Color(p[3]), false, is_moto)
	c.global_position = Vector3(p[0], 0, p[1])
	c.heading = p[2]
	c.rotation.y = p[2]
	m.cars.append(c)
	return c

func vehicles(m) -> void:
	for p in m.PARK:
		_park(m, p, false)
	for p in MOTOS:
		var c = _park(m, p, true)
		if m.moto_romaric == null:
			m.moto_romaric = c
	var paths := [
		[_quad(1, 1), 12.0, 3, 1], [_quad(-1, 1), 12.0, 3, 1], [_quad(1, -1), 12.0, 3, 1], [_quad(-1, -1), 12.0, 3, 1],
		[[Vector2(-123.5, -123.5), Vector2(123.5, -123.5), Vector2(123.5, 123.5), Vector2(-123.5, 123.5)], 14.0, 8, 4],
		[[Vector2(-200, -163.5), Vector2(200, -163.5), Vector2(200, -156.5), Vector2(-200, -156.5)], 16.0, 7, 3]]
	for P in paths:
		for i in P[2]:
			var is_moto: bool = i < P[3]
			var taxi: bool = (not is_moto) and m.rng.randf() < 0.45
			var col := Color(m.pick(["aa1111", "1144aa", "111111"])) if is_moto else (Color("f2c200") if taxi else Color(m.pick(m.CARC)))
			var c = make(m, col, taxi, is_moto)
			c.ai = true
			c.set_path(P[0])
			c.vmax = P[1]
			c.speed = P[1]
			c.dist = c.path_len * i / P[2]
			c.place_on_path()
			m.traffic.append(c)

func people(m) -> void:
	m.player = PlayerScript.new()
	m.add_child(m.player)
	m.player.setup(m)
	m.player.global_position = m.SPAWN
	m.player.rotation.y = m.player.heading
	for i in 30:
		var b = m.pick(m.blocks)
		var e: int = m.rng.randi() % 4
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
		m.add_child(n)
		var parts: Dictionary = m.make_human(n, Color(m.pick(m.SHIRTS)), Color(m.pick(["2b2b40", "5a4632", "1d5e3a", "222222"])), Color(m.pick(["5a3622", "4a2b1a", "6b4228"])))
		m.npcs.append({"n": n, "p": parts, "a": a, "c": c, "len": (c - a).length(), "t": m.rng.randf() * (c - a).length(), "dir": 1.0 if m.rng.randf() < 0.5 else -1.0, "v": m.rr(1.2, 2.0), "ph": m.rng.randf() * 6.0, "scare": 0.0})
	m.marker = Node3D.new()
	m.add_child(m.marker)
	var bm: MeshInstance3D = m.cyl(3, 3, 40, Color.WHITE, Vector3(0, 20, 0), m.marker, 16)
	var mt := StandardMaterial3D.new()
	mt.albedo_color = Color(1, 0.82, 0, 0.3)
	mt.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mt.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mt.cull_mode = BaseMaterial3D.CULL_DISABLED
	bm.material_override = mt
	m._camera(0.0, true)

# À chaque image : la circulation s'arrête derrière un obstacle, les passants vont et viennent.
func step(m, delta: float, pp: Vector3) -> void:
	for a in m.traffic:
		var f := Vector3(sin(a.heading), 0, cos(a.heading))
		var blocked := false
		var by_player := false
		for o in m.traffic + m.cars:
			if o == a:
				continue
			var dv: Vector3 = o.global_position - a.global_position
			var d := dv.length()
			if d < 8.5 and d > 0.1 and dv.dot(f) / d > 0.72:
				blocked = true
				by_player = o == m.cur_car
				break
		if not blocked and not m.cur_car:
			var dv2: Vector3 = pp - a.global_position
			var d2: float = dv2.length()
			blocked = d2 < 8.5 and d2 > 0.1 and dv2.dot(f) / d2 > 0.72
			by_player = blocked
		a.ai_step(delta, blocked, by_player)
	for n in m.npcs:
		var hurry := 1.0
		if n.scare > 0.0:
			n.scare -= delta
			hurry = 2.2
		n.t += n.dir * n.v * hurry * delta
		if n.t > n.len:
			n.t = n.len
			n.dir = -1.0
		elif n.t < 0.0:
			n.t = 0.0
			n.dir = 1.0
		var p: Vector2 = n.a.lerp(n.c, n.t / n.len)
		n.n.position = Vector3(p.x, 0.08, p.y)
		n.n.rotation.y = atan2((n.c.x - n.a.x) * n.dir, (n.c.y - n.a.y) * n.dir)
		n.ph += delta * n.v * hurry * 3.0
		m.anim_human(n.p, n.ph, 0.6)
