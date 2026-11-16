extends RefCounted
# Circulation et passants : véhicules garés, trajets de la circulation, piétons des trottoirs.
# L'ordre des tirages au hasard ne doit pas changer : la ville reste la même d'un lancement à l'autre.

const CarScript := preload("res://scripts/car.gd")
const MotoScript := preload("res://scripts/moto.gd")
const PlayerScript := preload("res://scripts/player.gd")
# motos garées : [x, z, cap, couleur] ; la première est celle de Romaric, à côté du point de départ
const MOTOS := [[16.0, -52.0, PI, "aa1111"], [70.0, 12.0, PI / 2, "1144aa"], [-70.0, -149.8, PI / 2, "111111"]]

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
	# dernier élément : trajet à parcourir à l'envers pour rouler à droite de la chaussée
	var paths := [
		[_quad(1, 1), 12.0, 3, 1, true], [_quad(-1, 1), 12.0, 3, 1, false], [_quad(1, -1), 12.0, 3, 1, false], [_quad(-1, -1), 12.0, 3, 1, true],
		[[Vector2(-123.5, -123.5), Vector2(123.5, -123.5), Vector2(123.5, 123.5), Vector2(-123.5, 123.5)], 14.0, 8, 4, true],
		[[Vector2(-200, -163.5), Vector2(200, -163.5), Vector2(200, -156.5), Vector2(-200, -156.5)], 16.0, 7, 3, true]]
	for P in paths:
		# on roule à droite, comme au Bénin : les trajets sont parcourus dans ce sens-là
		var pts: Array = P[0].duplicate()
		if P[4]:
			pts.reverse()
		for i in P[2]:
			var is_moto: bool = i < P[3]
			var taxi: bool = (not is_moto) and m.rng.randf() < 0.45
			var col := Color(m.pick(["aa1111", "1144aa", "111111"])) if is_moto else (Color("f2c200") if taxi else Color(m.pick(m.CARC)))
			var c = make(m, col, taxi, is_moto)
			c.ai = true
			c.set_path(pts)
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

# Demi-largeur d'un véhicule, et marge pour passer à côté sans le gêner.
const COULOIR := 0.25
func _half(v) -> float:
	return 0.4 if v.moto else 1.0

# Ce véhicule de la circulation doit-il s'arrêter ? Renvoie [bloqué, bloqué par le joueur].
# Une moto qui passe à côté, dans le couloir, ne gêne pas (décision 61) ; un obstacle
# droit devant arrête tout le monde.
func blocked_by(m, a, pp: Vector3) -> Array:
	var f := Vector3(sin(a.heading), 0, cos(a.heading))
	var l := Vector3(f.z, 0, -f.x)
	for o in m.traffic + m.cars:
		if o == a:
			continue
		var dv: Vector3 = o.global_position - a.global_position
		var d := dv.length()
		if d < 8.5 and d > 0.1 and dv.dot(f) / d > 0.72:
			if (a.moto or o.moto) and abs(dv.dot(l)) > _half(a) + _half(o) + COULOIR:
				continue
			if a.moto and a.side_want != 0.0 and not o.moto and d > 4.5:
				continue   # elle déboîte déjà : elle ne s'arrête que si elle n'a pas la place
			return [true, o == m.cur_car]
	if not m.cur_car:
		var dv2: Vector3 = pp - a.global_position
		var d2: float = dv2.length()
		if d2 < 8.5 and d2 > 0.1 and dv2.dot(f) / d2 > 0.72:
			return [true, true]
	return [false, false]

# Moto de la circulation : écart à prendre pour remonter une file. Elle déboîte derrière une
# voiture arrêtée ou très lente sur sa voie, reste dans le couloir tant qu'elle longe une
# voiture, puis se rabat. Les voitures, elles, restent dans la file.
func _faufile(m, a) -> float:
	var q: Vector3 = a.pos_on(a.dist)
	var f := Vector3(sin(q.z), 0, cos(q.z))
	var l := Vector3(f.z, 0, -f.x)
	for o in m.traffic + m.cars:
		if o == a or o.moto:
			continue
		var dv: Vector3 = o.global_position - Vector3(q.x, 0, q.y)
		var lon: float = dv.dot(f)
		if abs(dv.dot(l)) < 1.5 and lon > -5.5 and ((lon < 5.5 and abs(a.side) > 0.3) or (lon < 10.0 and abs(o.speed) < 3.0)):
			return a.FAUFILE_ECART * a.FAUFILE_COTE
	return 0.0

# À chaque image : la circulation s'arrête derrière un obstacle, les passants vont et viennent.
func step(m, delta: float, pp: Vector3) -> void:
	for a in m.traffic:
		if a.moto:
			a.side_want = _faufile(m, a)
		var b: Array = blocked_by(m, a, pp)
		a.ai_step(delta, b[0], b[1])
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
