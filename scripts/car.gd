extends CharacterBody3D
# Véhicule : conduit par le joueur, ou en circulation automatique le long d'un trajet.

const MAXF := 34.0
const MAXR := -10.0
var speed := 0.0
var heading := 0.0
var ai := false
var moto := false
var path: Array = []
var seg_start: Array = []
var path_len := 0.0
var dist := 0.0
var vmax := 12.0
var wheels: Array = []

func setup(main, color: Color, taxi: bool, is_moto: bool) -> void:
	moto = is_moto
	motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	var cs := CollisionShape3D.new()
	var b := BoxShape3D.new()
	b.size = Vector3(0.8, 1.4, 1.8) if moto else Vector3(2.0, 1.4, 4.4)
	cs.shape = b
	cs.position.y = 0.9
	add_child(cs)
	if moto:
		main.box(Vector3(0.34, 0.42, 1.5), Color("222222"), Vector3(0, 0.62, 0), self)
		main.box(Vector3(0.32, 0.28, 0.55), color, Vector3(0, 0.9, 0.35), self)
		main.box(Vector3(0.7, 0.06, 0.06), Color("999999"), Vector3(0, 1.15, 0.7), self)
		main.box(Vector3(0.48, 0.62, 0.3), Color("f2c200"), Vector3(0, 1.38, -0.12), self)
		main.box(Vector3(0.2, 0.55, 0.55), Color("2b2b40"), Vector3(-0.2, 0.95, 0.1), self)
		main.box(Vector3(0.2, 0.55, 0.55), Color("2b2b40"), Vector3(0.2, 0.95, 0.1), self)
		main.box(Vector3(0.36, 0.36, 0.36), Color("222222"), Vector3(0, 1.9, -0.1), self)
		wheels = [_wheel(main, Vector3(0, 0.33, 0.62), 0.33, 0.14), _wheel(main, Vector3(0, 0.33, -0.62), 0.33, 0.14)]
	else:
		main.box(Vector3(2.0, 0.72, 4.4), color, Vector3(0, 0.74, 0), self)
		main.box(Vector3(1.8, 0.7, 2.3), color, Vector3(0, 1.45, -0.25), self)
		main.box(Vector3(1.84, 0.44, 2.34), Color("1e2a33"), Vector3(0, 1.47, -0.25), self)
		if taxi:
			main.box(Vector3(2.03, 0.18, 4.42), Color("1f8a3a"), Vector3(0, 0.86, 0), self)
		main.box(Vector3(0.42, 0.2, 0.06), Color("fff6c0"), Vector3(-0.65, 0.82, 2.21), self)
		main.box(Vector3(0.42, 0.2, 0.06), Color("fff6c0"), Vector3(0.65, 0.82, 2.21), self)
		main.box(Vector3(0.42, 0.18, 0.06), Color("aa0000"), Vector3(-0.65, 0.84, -2.21), self)
		main.box(Vector3(0.42, 0.18, 0.06), Color("aa0000"), Vector3(0.65, 0.84, -2.21), self)
		for p in [Vector3(-1, 0.38, 1.4), Vector3(1, 0.38, 1.4), Vector3(-1, 0.38, -1.4), Vector3(1, 0.38, -1.4)]:
			wheels.append(_wheel(main, p, 0.38, 0.3))

func _wheel(main, pos: Vector3, r: float, w: float) -> Node3D:
	var pivot := Node3D.new()
	pivot.position = pos
	add_child(pivot)
	var m := MeshInstance3D.new()
	var c := CylinderMesh.new()
	c.top_radius = r
	c.bottom_radius = r
	c.height = w
	c.radial_segments = 10
	c.rings = 1
	m.mesh = c
	m.material_override = main.mat(Color("151515"))
	m.rotation.z = PI / 2
	pivot.add_child(m)
	return pivot

func set_path(pts: Array) -> void:
	path = pts
	seg_start = []
	path_len = 0.0
	for i in pts.size():
		seg_start.append(path_len)
		path_len += (pts[(i + 1) % pts.size()] - pts[i]).length()

func pos_on(d: float) -> Vector3:
	d = fposmod(d, path_len)
	for i in path.size():
		var a: Vector2 = path[i]
		var b: Vector2 = path[(i + 1) % path.size()]
		var l := (b - a).length()
		if d <= seg_start[i] + l:
			var p := a.lerp(b, (d - seg_start[i]) / l)
			return Vector3(p.x, p.y, atan2(b.x - a.x, b.y - a.y))
	return Vector3(path[0].x, path[0].y, 0)

func place_on_path() -> void:
	var q := pos_on(dist)
	global_position = Vector3(q.x, 0, q.y)
	heading = q.z
	rotation.y = heading

func ai_step(delta: float, blocked: bool) -> void:
	var tgt := 0.0 if blocked else vmax
	speed += (tgt - speed) * min(1.0, delta * (7.0 if blocked else 1.4))
	dist += speed * delta
	var q := pos_on(dist)
	global_position = Vector3(q.x, 0, q.y)
	heading = lerp_angle(heading, q.z, 1.0 - exp(-delta * 7.0))
	rotation.y = heading
	_spin(delta)

func drive(delta: float) -> void:
	var brake := Input.is_action_pressed("brake")
	if Input.is_action_pressed("up"):
		speed += (32.0 if speed < 0 else 16.0) * delta
	elif Input.is_action_pressed("down"):
		speed -= (30.0 if speed > 0 else 11.0) * delta
	else:
		speed = move_toward(speed, 0.0, 4.0 * delta)
	if brake:
		speed *= max(0.0, 1.0 - 3.5 * delta)
	speed = clamp(speed, MAXR, MAXF)
	var steer := Input.get_axis("right", "left")
	var f: float = clamp(abs(speed) / 7.0, 0.0, 1.0)
	heading += steer * (2.6 if brake else 1.9) * delta * f * sign(speed) * (1.0 - abs(speed) / MAXF * 0.45)
	rotation.y = heading
	var fwd := Vector3(sin(heading), 0, cos(heading))
	velocity = fwd * speed
	move_and_slide()
	var real := get_real_velocity().dot(fwd)
	if abs(real) < abs(speed) - 3.0:
		speed = real * 0.5
	global_position.y = 0
	_spin(delta)

func idle(delta: float) -> void:
	speed = move_toward(speed, 0.0, 12.0 * delta)

func _spin(delta: float) -> void:
	for w in wheels:
		w.rotation.x += speed * delta / 0.38
