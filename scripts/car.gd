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
# suspension : la carrosserie (« body ») bouge sur ses ressorts, les roues restent au sol
const RAIDEUR := 90.0
const AMORTI := 11.0
var body: Node3D
var pitch := 0.0      # > 0 : le nez plonge (freinage)
var pitch_v := 0.0
var roll := 0.0       # > 0 : la caisse penche vers la droite (virage à gauche)
var roll_v := 0.0
var bounce := 0.0     # tassement vertical après un choc
var bounce_v := 0.0
var prev_speed := 0.0
var prev_heading := 0.0
# dégâts visibles : 0 = neuf, 100 = épave roulante (jamais d'explosion, décision 57)
const DEGATS_SEUILS := [25.0, 50.0, 80.0]
const CHOC_SANS_MAL := 10.0   # m/s perdus d'un coup sans blessure pour le conducteur
var damage := 0.0
var dmg_stage := 0
var hit_front := false
var hit_rear := false
var dmg_nodes: Array = []
var dmg_done := {}
var lights_f: Array = []
var lights_r: Array = []
var smoke: CPUParticles3D
var smoke_mat: StandardMaterial3D
var main_ref
var fx = preload("res://scripts/car_fx.gd").new()   # feux, clignotants, klaxon
var acc_long := 0.0   # accélération mesurée (m/s²), < 0 quand on freine
var yaw_rate := 0.0   # vitesse de rotation (rad/s), > 0 vers la gauche
var col := Color.WHITE

func setup(main, color: Color, taxi: bool, is_moto: bool) -> void:
	moto = is_moto
	main_ref = main
	col = color
	body = Node3D.new()
	add_child(body)
	motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	collision_mask = 3   # couche 2 : murs réservés aux véhicules (bord de plage)
	var cs := CollisionShape3D.new()
	var b := BoxShape3D.new()
	b.size = Vector3(0.8, 1.4, 1.8) if moto else Vector3(2.0, 1.4, 4.4)
	cs.shape = b
	cs.position.y = 0.9
	add_child(cs)
	_look(main, color, taxi)
	fx.setup(self, main)

# Formes visibles du véhicule (la moto a les siennes dans moto.gd).
func _look(main, color: Color, taxi: bool) -> void:
	main.box(Vector3(2.0, 0.72, 4.4), color, Vector3(0, 0.74, 0), body)
	main.box(Vector3(1.8, 0.7, 2.3), color, Vector3(0, 1.45, -0.25), body)
	main.box(Vector3(1.84, 0.44, 2.34), Color("1e2a33"), Vector3(0, 1.47, -0.25), body)
	if taxi:
		main.box(Vector3(2.03, 0.18, 4.42), Color("1f8a3a"), Vector3(0, 0.86, 0), body)
	for sx in [-0.65, 0.65]:
		lights_f.append(main.box(Vector3(0.42, 0.2, 0.06), Color("fff6c0"), Vector3(sx, 0.82, 2.21), body))
		lights_r.append(main.box(Vector3(0.42, 0.18, 0.06), Color("aa0000"), Vector3(sx, 0.84, -2.21), body))
	for p in [Vector3(-1, 0.38, 1.4), Vector3(1, 0.38, 1.4), Vector3(-1, 0.38, -1.4), Vector3(1, 0.38, -1.4)]:
		wheels.append(_wheel(main, p, 0.38, 0.3))

func _wheel(main, pos: Vector3, r: float, w: float, parent: Node = null) -> Node3D:
	var pivot := Node3D.new()
	pivot.position = pos
	(parent if parent else self).add_child(pivot)
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

func ai_step(delta: float, blocked: bool, by_player := false) -> void:
	var tgt := 0.0 if blocked else vmax
	speed += (tgt - speed) * min(1.0, delta * (7.0 if blocked else 1.4))
	dist += speed * delta
	var q := pos_on(dist)
	global_position = Vector3(q.x, 0, q.y)
	heading = lerp_angle(heading, q.z, 1.0 - exp(-delta * 7.0))
	rotation.y = heading
	_spin(delta)
	_susp(delta)
	fx.ai(delta, blocked, by_player)

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
	speed = clamp(speed, MAXR, max_speed())
	var steer := Input.get_axis("right", "left")
	var f: float = clamp(abs(speed) / 7.0, 0.0, 1.0)
	heading += steer * (2.6 if brake else 1.9) * delta * f * sign(speed) * (1.0 - abs(speed) / MAXF * 0.45)
	rotation.y = heading
	_advance(delta)
	_spin(delta)
	_susp(delta)
	fx.braking = brake or (speed > 0.5 and Input.is_action_pressed("down")) or (speed < -0.5 and Input.is_action_pressed("up"))
	if Input.is_action_pressed("horn"):
		fx.honk(0.12)
	fx.step(delta)

# Déplacement et chocs, communs à la voiture et à la moto.
func _advance(delta: float) -> void:
	var fwd := Vector3(sin(heading), 0, cos(heading))
	velocity = fwd * speed
	var before := global_position
	move_and_slide()
	var real := get_real_velocity().dot(fwd)
	# choc : sa violence est la vitesse perdue d'un coup. On compare la vitesse d'avant
	# à celle d'après le contact (glissade le long de l'obstacle) : de face on perd tout,
	# en biais presque rien.
	if get_slide_collision_count() > 0 and delta > 0.0:
		var k := get_slide_collision(0)
		var t: Vector3 = k.get_travel()
		var r: Vector3 = k.get_remainder()
		var frac: float = r.length() / max(0.0001, (t + r).length())
		if frac > 0.05:
			var after: float = (global_position - before - t).dot(fwd) / (delta * frac)
			after = clamp(after, min(speed, 0.0), max(speed, 0.0))
			var impact: float = abs(speed) - abs(after)
			if impact >= 5.0:
				hit(impact, speed > 0.0)
				var o = k.get_collider()
				if o != null and o != self and o.has_method("hit"):
					o.hit(impact * 0.7, o.to_local(global_position).z > 0.0)
				speed = after
	if abs(real) < abs(speed) - 3.0:
		speed = real * 0.5
	global_position.y = 0

func idle(delta: float) -> void:
	speed = move_toward(speed, 0.0, 12.0 * delta)
	_susp(delta)
	fx.braking = false
	fx.step(delta)

func _spin(delta: float) -> void:
	for w in wheels:
		w.rotation.x += speed * delta / 0.38

# ---------------- suspension ----------------
# La carrosserie se cabre à l'accélération, plonge au freinage et penche vers
# l'extérieur des virages ; un ressort amorti la ramène à plat.
func _susp(delta: float) -> void:
	if delta <= 0.0:
		return
	var dt: float = min(delta, 0.05)
	var acc: float = clamp((speed - prev_speed) / dt, -30.0, 30.0)
	var yaw: float = angle_difference(prev_heading, heading) / dt
	prev_speed = speed
	prev_heading = heading
	acc_long = acc
	yaw_rate = yaw
	if moto:
		_lean(dt)   # la moto penche dans le virage : voir moto.gd
		return
	var lat: float = clamp(speed * yaw, -25.0, 25.0)
	var want_p: float = clamp(-acc * 0.004, -0.07, 0.09)
	var want_r: float = clamp(lat * 0.005, -0.09, 0.09)
	if acc == 0.0 and lat == 0.0 and abs(pitch) + abs(roll) + abs(bounce) + abs(pitch_v) + abs(roll_v) + abs(bounce_v) < 0.0005:
		pitch = 0.0
		roll = 0.0
		bounce = 0.0
	else:
		pitch_v += ((want_p - pitch) * RAIDEUR - pitch_v * AMORTI) * dt
		pitch = clamp(pitch + pitch_v * dt, -0.14, 0.14)
		roll_v += ((want_r - roll) * RAIDEUR - roll_v * AMORTI) * dt
		roll = clamp(roll + roll_v * dt, -0.14, 0.14)
		bounce_v += (-bounce * RAIDEUR - bounce_v * AMORTI) * dt
		bounce = clamp(bounce + bounce_v * dt, -0.12, 0.08)
	body.rotation.x = pitch
	body.rotation.z = roll
	body.position.y = bounce

func _lean(_dt: float) -> void:
	pass

# ---------------- dégâts visibles ----------------
# Vitesse maximale : un moteur très abîmé (dégâts >= 80) plafonne à 60 %.
func max_speed() -> float:
	return MAXF * (0.6 if damage >= DEGATS_SEUILS[2] else 1.0)

# Choc reçu. impact : vitesse perdue d'un coup (m/s) ; front : par l'avant ou par l'arrière.
func hit(impact: float, front: bool) -> void:
	if impact < 5.0:
		return   # frottement ou petit contact : rien
	damage = min(100.0, damage + (impact - 4.0) * 2.5)
	if front:
		hit_front = true
	else:
		hit_rear = true
	bounce_v -= min(impact, 20.0) * 0.03
	# le conducteur encaisse les gros chocs : rien sous 36 km/h perdus, puis 2 points par m/s
	if main_ref.cur_car == self and not moto and impact > CHOC_SANS_MAL:
		main_ref.crash_hurt((impact - CHOC_SANS_MAL) * 2.0)
	_show_damage()

func repair() -> void:
	damage = 0.0
	hit_front = false
	hit_rear = false
	for n in dmg_nodes:
		n.queue_free()
	dmg_nodes = []
	dmg_done = {}
	for l in lights_f + lights_r:
		l.visible = true
	_show_damage()

func _dmg_box(key: String, size: Vector3, c: Color, pos: Vector3, rot: Vector3) -> void:
	if dmg_done.has(key):
		return
	dmg_done[key] = true
	var b = main_ref.box(size, c, pos, body)
	b.rotation = rot
	dmg_nodes.append(b)

func _show_damage() -> void:
	var st := 0
	for s in DEGATS_SEUILS:
		if damage >= s:
			st += 1
	if not moto and st >= 1:
		var tole := col.darkened(0.25)
		if hit_front:
			# capot plié, un phare cassé ; puis pare-chocs pendant et second phare
			_dmg_box("capot", Vector3(1.9, 0.08, 1.15), tole, Vector3(0.03, 1.2, 1.55), Vector3(-0.22, 0.0, 0.05))
			lights_f[0].visible = false
			if st >= 2:
				_dmg_box("parechoc_av", Vector3(2.05, 0.16, 0.12), Color("2b2b2b"), Vector3(0.08, 0.46, 2.26), Vector3(0.0, 0.09, 0.13))
				lights_f[1].visible = false
		if hit_rear:
			_dmg_box("coffre", Vector3(1.9, 0.08, 0.8), tole, Vector3(-0.03, 1.2, -1.8), Vector3(0.24, 0.0, -0.05))
			lights_r[1].visible = false
			if st >= 2:
				_dmg_box("parechoc_ar", Vector3(2.05, 0.16, 0.12), Color("2b2b2b"), Vector3(-0.08, 0.46, -2.26), Vector3(0.0, -0.09, -0.13))
				lights_r[0].visible = false
	if st >= 2 and smoke == null:
		_make_smoke()
	if smoke != null:
		smoke.emitting = st >= 2
		# fumée claire d'abord, noire et plus épaisse quand le moteur est très abîmé
		smoke_mat.albedo_color = Color(0.12, 0.12, 0.12, 0.75) if st >= 3 else Color(0.85, 0.85, 0.85, 0.5)
		smoke.scale_amount_max = 1.7 if st >= 3 else 1.1
	if st != dmg_stage:
		var worse := st > dmg_stage
		dmg_stage = st
		if worse and main_ref.cur_car == self:
			main_ref.say(["", "Aïe ! La tôle est froissée.", "Le moteur fume… doucement, ou trouve un garage.", "Moteur très abîmé : la voiture n'avance plus qu'au ralenti."][st], 4.0)

# Fumée du moteur : quelques cubes gris qui montent (peu coûteux, même au niveau Bas).
func _make_smoke() -> void:
	smoke = CPUParticles3D.new()
	smoke.position = Vector3(0, 0.95, 0.3) if moto else Vector3(0, 1.2, 1.7)
	smoke.amount = 16
	smoke.lifetime = 1.6
	smoke.local_coords = false
	smoke.direction = Vector3.UP
	smoke.spread = 20.0
	smoke.gravity = Vector3(0, 1.2, 0)
	smoke.initial_velocity_min = 1.0
	smoke.initial_velocity_max = 2.0
	smoke.scale_amount_min = 0.5
	var g := Gradient.new()
	g.set_color(0, Color(1, 1, 1, 1))
	g.set_color(1, Color(1, 1, 1, 0))
	smoke.color_ramp = g
	var bm := BoxMesh.new()
	bm.size = Vector3(0.35, 0.35, 0.35)
	smoke.mesh = bm
	smoke_mat = StandardMaterial3D.new()
	smoke_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	smoke_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	smoke_mat.vertex_color_use_as_albedo = true
	smoke.material_override = smoke_mat
	body.add_child(smoke)
