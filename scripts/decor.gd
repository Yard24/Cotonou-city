extends RefCounted
# Décor de la ville : statue de l'Amazone, marché Dantokpa, panneaux, drapeau, palmiers.

func amazone(m) -> void:
	m.cyl(30, 30, 0.06, Color("3a3a3d"), Vector3(0, 0.03, 0), null, 40)
	m.cyl(12.6, 12.6, 0.5, Color("f2f2f2"), Vector3(0, 0.25, 0), null, 32)
	m.cyl(12, 12, 0.7, Color("5f9a3a"), Vector3(0, 0.35, 0), null, 32)
	m.post(0, 0, 12.8)
	var br: Color = Color("7a4a22")
	m.cyl(5, 6, 1.6, Color("e9e2d0"), Vector3(0, 1.5, 0), null, 20)
	m.box(Vector3(4, 5, 4), Color("d8cfbb"), Vector3(0, 4.8, 0))
	m.cyl(0.42, 0.5, 4, br, Vector3(-0.65, 9.3, 0))
	m.cyl(0.42, 0.5, 4, br, Vector3(0.65, 9.3, 0))
	m.cyl(1.6, 1.1, 1.6, br, Vector3(0, 10.8, 0))
	m.cyl(0.95, 0.8, 3.6, br, Vector3(0, 13.2, 0))
	m.box(Vector3(1.3, 1.4, 1.3), br, Vector3(0, 15.6, 0))
	m.cyl(0.3, 0.3, 3.4, br, Vector3(1.5, 15.2, 0)).rotation.z = -0.65
	m.cyl(0.3, 0.3, 3.2, br, Vector3(-1.25, 12.6, 0.2)).rotation.z = 0.25
	m.cyl(0.13, 0.13, 8, Color("4a2c12"), Vector3(2.6, 16.2, 0))
	m.cyl(0.0, 0.35, 1.2, Color("4a2c12"), Vector3(2.6, 20.8, 0))

func market(m) -> void:
	var umb: Array = ["e8112d", "fcd116", "008751", "2a6fdb", "ff7a00", "ffffff", "8e2bd1"]
	var x := 13.0
	while x < 109.0:
		var z := 13.0
		while z < 109.0:
			var skip: bool = (abs(x - 60.0) < 10.0 and z < 48.0) or Vector2(x, z).length() < 44 or m.rng.randf() < 0.15 or (x > 78 and z > 86)
			if not skip:
				var px: float = x + m.rr(-1, 1)
				var pz: float = z + m.rr(-1, 1)
				m.box(Vector3(2.6, 0.9, 1.6), Color("8b5a2b"), Vector3(px, 0.6, pz), null, true)
				m.box(Vector3(1.9, 0.3, 0.6), Color(m.pick(["ff7a00", "e8112d", "2f7d32", "fcd116"])), Vector3(px, 1.2, pz))
				m.cyl(0.07, 0.07, 3, Color("555555"), Vector3(px, 1.6, pz), null, 5)
				m.cyl(0.0, 2.6, 1.1, Color(m.pick(umb)), Vector3(px, 3.35, pz), null, 8)
			z += 9.0
		x += 9.0
	m.box(Vector3(30, 8, 12), Color("d9c9a3"), Vector3(95, 4, 95), null, true)

func _sign(m, text: String, pos: Vector3, w: float, bg: Color, fg: Color, px := 96) -> void:
	m.box(Vector3(w, 2.4, 0.12), bg, pos)
	m.cyl(0.12, 0.12, pos.y, Color("777777"), Vector3(pos.x - w / 2 + 0.4, pos.y / 2, pos.z), null, 5)
	m.cyl(0.12, 0.12, pos.y, Color("777777"), Vector3(pos.x + w / 2 - 0.4, pos.y / 2, pos.z), null, 5)
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
		m.add_child(l)
	m.post(pos.x, pos.z, 0.5)

func _palm(m, x: float, z: float) -> void:
	m.cyl(0.22, 0.35, 7, Color("8b6a43"), Vector3(x, 3.5, z), null, 6)
	for i in 3:
		var l = m.box(Vector3(0.6, 0.08, 7.0), Color("2f7d32") if i % 2 else Color("3f9a3c"), Vector3(x, 7.0, z))
		l.rotation = Vector3(0.0, i * PI / 3 + m.rr(0, 0.4), 0.0)
	m.post(x, z, 0.45)

func decor(m) -> void:
	_sign(m, "Place de l'Amazone", Vector3(12, 4.2, -36), 9.5, Color("1d6b3a"), Color.WHITE, 72)
	_sign(m, "Boulevard de la Marina", Vector3(-40, 4, -151.5), 11, Color("1d6b3a"), Color.WHITE, 72)
	_sign(m, "BIENVENUE À COTONOU", Vector3(50, 6, -151.8), 14, Color("fcd116"), Color("1a1a1a"), 84)
	_sign(m, "Marché Dantokpa", Vector3(60, 4.6, 8.8), 9, Color("e8112d"), Color.WHITE, 80)
	m.cyl(0.15, 0.18, 12, Color("cccccc"), Vector3(25, 6, -25), null, 6)
	m.box(Vector3(1.8, 3.0, 0.06), Color("008751"), Vector3(26.05, 10.4, -25))
	m.box(Vector3(2.7, 1.5, 0.06), Color("fcd116"), Vector3(28.3, 11.15, -25))
	m.box(Vector3(2.7, 1.5, 0.06), Color("e8112d"), Vector3(28.3, 9.65, -25))
	m.post(25, -25, 0.5)
	for b in m.blocks:
		var x: float = b.x0 + 6.0
		while x < b.x1 - 4.0:
			for z in [b.z0 + 1.6, b.z1 - 1.6]:
				if m.rng.randf() < 0.45 and Vector2(x, z).length() > 34 and not m._near_park(x, z, 6):
					_palm(m, x, z)
			x += m.rr(22, 34)
