extends CharacterBody3D
# Le héros à pied : marche, course, saut, position accroupie, nage,
# chute et santé, franchissement de muret, position assise.
# Le fonctionnement attendu est décrit dans docs/systemes/joueur_a_pied.md.

const V_MARCHE := 5.5
const V_COURSE := 10.0
const V_ACCROUPI := 2.5
const V_NAGE := 2.5
const V_NAGE_RAPIDE := 3.6
const V_SAUT := 6.5      # vitesse verticale au départ du saut (environ 1,2 m de haut)
const GRAVITE := 18.0
const H_DEBOUT := 1.9
const H_ACCROUPI := 1.2
const NAGE_FOND := 1.15  # en nageant, les pieds restent à 1,15 m sous la surface
const GUE := 0.4         # à partir de 40 cm d'eau, la marche ralentit
const CHUTE_SANS_MAL := 3.0   # hauteur de chute sans blessure, en mètres
const CHUTE_DEGATS := 11.0    # points de santé perdus par mètre au-delà
const MURET_MIN := 0.3
const MURET_MAX := 1.5   # hauteur maximale d'un obstacle franchissable
const T_MURET := 0.45    # durée du franchissement, en secondes
const SANTE_MAX := 100.0
const T_REPOS := 10.0    # secondes sans blessure avant que la santé remonte
const T_KO := 2.5        # durée de l'évanouissement

var main
var heading := PI
var phase := 0.0
var parts := {}
var shape: CollisionShape3D
var capsule: CapsuleShape3D
var body: Node3D          # partie visible, écrasée quand le héros s'accroupit
var vy := 0.0
var on_ground := true     # au sol ou posé sur un objet
var on_floor := true      # posé sur le sol lui-même (ou porté par l'eau)
var crouching := false
var swimming := false
var wading := false
var sitting := false
var health := SANTE_MAX
var hurt_t := 99.0        # secondes depuis la dernière blessure
var ko_t := 0.0           # temps d'évanouissement restant
var air_top := 0.0        # point le plus haut atteint depuis le dernier appui
var last_fall := 0.0      # hauteur de la dernière chute
var mantle_t := 0.0       # temps de franchissement restant
var mantle_a := Vector3.ZERO
var mantle_b := Vector3.ZERO

func setup(m) -> void:
	main = m
	motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	shape = CollisionShape3D.new()
	capsule = CapsuleShape3D.new()
	capsule.radius = 0.4
	capsule.height = H_DEBOUT
	shape.shape = capsule
	shape.position.y = H_DEBOUT / 2.0
	add_child(shape)
	body = Node3D.new()
	add_child(body)
	parts = main.make_human(body, Color("008751"), Color("2b2b40"), Color("5a3622"))

# Vitesse de déplacement selon l'état (nage, accroupi, course, marche, eau peu profonde).
func move_speed() -> float:
	var run := Input.is_action_pressed("run")
	if swimming:
		return V_NAGE_RAPIDE if run else V_NAGE
	if crouching:
		return V_ACCROUPI
	if wading:
		return V_MARCHE * 0.6
	return V_COURSE if run else V_MARCHE

func jump() -> bool:
	if not on_ground or crouching or swimming or sitting or ko_t > 0.0:
		return false
	vy = V_SAUT
	on_ground = false
	on_floor = false
	return true

func set_crouch(on: bool) -> void:
	if on == crouching:
		return
	crouching = on
	capsule.height = H_ACCROUPI if on else H_DEBOUT
	shape.position.y = capsule.height / 2.0

# Remet le héros debout et au sol (utilisé quand il monte en voiture ou en descend).
func reset_pose() -> void:
	set_crouch(false)
	vy = 0.0
	on_ground = true
	on_floor = true
	swimming = false
	wading = false
	sitting = false
	mantle_t = 0.0
	air_top = global_position.y
	body.scale.y = 1.0
	body.rotation.x = 0.0
	body.position = Vector3.ZERO

# Déplace le héros d'un coup ; s'il est placé en l'air, il tombe de cette hauteur.
func teleport(pos: Vector3, h: float) -> void:
	reset_pose()
	global_position = pos
	heading = h
	rotation.y = h
	air_top = pos.y
	on_ground = false
	on_floor = false

# ---------------- santé ----------------
func hurt(amount: float) -> void:
	if amount <= 0.0 or ko_t > 0.0:
		return
	health = max(0.0, health - amount)
	hurt_t = 0.0
	if health <= 0.0:
		# évanoui : il se réveillera place de l'Amazone
		ko_t = T_KO
		sitting = false
		mantle_t = 0.0
		set_crouch(false)
		main._banner("Tu t'es évanoui…")

func heal(amount: float) -> void:
	health = min(SANTE_MAX, health + amount)

# ---------------- position assise ----------------
func sit(pos: Vector3, h: float) -> void:
	teleport(pos, h)
	on_ground = true
	sitting = true

func stand() -> void:
	sitting = false

# ---------------- franchissement ----------------
func _ray(a: Vector3, b: Vector3, inside := false) -> Dictionary:
	var q := PhysicsRayQueryParameters3D.create(a, b, 1, [get_rid()])
	q.hit_from_inside = inside
	return get_world_3d().direct_space_state.intersect_ray(q)

# Cherche devant le héros un obstacle bas sur lequel monter.
# Renvoie le point d'arrivée (pieds posés sur l'obstacle) ou null.
func find_ledge():
	var o := global_position
	var fwd := Vector3(sin(heading), 0, cos(heading))
	var knee := o + Vector3(0, 0.25, 0)
	var hit := _ray(knee, knee + fwd * 1.0)
	if hit.is_empty():
		return null
	var p: Vector3 = hit.position + fwd * 0.45
	# on cherche le dessus de l'obstacle en visant vers le bas ; si le départ du
	# rayon est déjà dans l'obstacle, c'est qu'il est trop haut
	# (juste derrière sa face avant, pour ne pas manquer un muret mince)
	var e: Vector3 = hit.position + fwd * 0.1
	var top := _ray(Vector3(e.x, o.y + MURET_MAX + 0.1, e.z), Vector3(e.x, o.y + 0.2, e.z), true)
	if top.is_empty():
		return null
	var h: float = top.position.y - o.y
	if h < MURET_MIN or h > MURET_MAX:
		return null
	# il faut la place de se tenir debout dessus
	for dy in [0.25, 1.0, 1.8]:
		var y: float = top.position.y + dy
		if not _ray(Vector3(o.x, y, o.z), Vector3(p.x, y, p.z), true).is_empty():
			return null
	return Vector3(p.x, top.position.y, p.z)

func try_mantle() -> bool:
	var l = find_ledge()
	if l == null:
		return false
	mantle_a = global_position
	mantle_b = l
	mantle_t = T_MURET
	vy = 0.0
	return true

func _mantle_step(delta: float) -> void:
	mantle_t = max(0.0, mantle_t - delta)
	var t := 1.0 - mantle_t / T_MURET
	# on se hisse d'abord, on avance ensuite
	var q := mantle_a.lerp(mantle_b, clamp((t - 0.4) / 0.6, 0.0, 1.0))
	q.y = lerp(mantle_a.y, mantle_b.y, clamp(t / 0.6, 0.0, 1.0))
	global_position = q
	parts.armL.rotation.x = -2.6 + t * 2.0
	parts.armR.rotation.x = -2.6 + t * 2.0
	parts.legL.rotation.x = 0.9 * (1.0 - t)
	parts.legR.rotation.x = -0.2
	if mantle_t <= 0.0:
		on_ground = true
		on_floor = false
		air_top = q.y

# ---------------- boucle ----------------
func walk(_m, delta: float) -> void:
	hurt_t += delta
	if ko_t > 0.0:
		# évanoui : allongé, sans contrôle
		ko_t -= delta
		body.rotation.x = lerp(body.rotation.x, -PI / 2, 1.0 - exp(-delta * 8.0))
		body.position.y = lerp(body.position.y, 0.25, 1.0 - exp(-delta * 8.0))
		if ko_t <= 0.0:
			ko_t = 0.0
			main.respawn()
		return
	if health < SANTE_MAX and (sitting or hurt_t > T_REPOS):
		health = min(SANTE_MAX, health + (6.0 if sitting else 1.5) * delta)
	if mantle_t > 0.0:
		_mantle_step(delta)
		return
	if sitting:
		for a in ["up", "down", "left", "right", "jump"]:
			if Input.is_action_pressed(a):
				stand()
		if sitting:
			body.position = body.position.lerp(Vector3(0, -0.4, -0.35), 1.0 - exp(-delta * 10.0))
			parts.legL.rotation.x = -1.5
			parts.legR.rotation.x = -1.5
			parts.armL.rotation.x = -0.3
			parts.armR.rotation.x = -0.3
			return
	# on ne s'accroupit qu'au sol ; relâcher la touche relève le héros
	set_crouch(Input.is_action_pressed("crouch") and on_ground and not swimming)
	if Input.is_action_just_pressed("jump") and on_ground and not crouching and not swimming:
		# devant un obstacle bas, Espace sert à monter dessus
		if not try_mantle():
			jump()
		else:
			return
	var sp := move_speed()
	heading += Input.get_axis("right", "left") * 2.8 * delta
	var mv := Input.get_action_strength("up") - 0.6 * Input.get_action_strength("down")
	rotation.y = heading
	vy -= GRAVITE * delta
	velocity = Vector3(sin(heading), 0, cos(heading)) * mv * sp + Vector3(0, vy, 0)
	var was_floor := on_floor
	var was_ground := on_ground
	move_and_slide()
	# hauteur du sol sous le héros ; en eau profonde, l'eau le porte
	var gh: float = main.ground_h(global_position.x, global_position.z)
	var swim_y: float = main.WATER_Y - NAGE_FOND
	var floor_y: float = max(gh, swim_y)
	var y := global_position.y
	if y <= floor_y or (was_floor and vy <= 0.0 and y - floor_y < 0.35):
		# sol (on reste collé au sol dans une pente douce)
		global_position.y = floor_y
		vy = 0.0
		on_ground = true
		on_floor = true
	elif vy < 0.0 and get_real_velocity().y > vy * 0.5:
		# posé sur un objet (étal, muret) : la chute est arrêtée par la collision
		vy = 0.0
		on_ground = true
		on_floor = false
	elif vy > 0.0 and get_real_velocity().y < vy * 0.5:
		# la tête touche quelque chose : la montée s'arrête
		vy = 0.0
		on_floor = false
	else:
		on_ground = false
		on_floor = false
	swimming = on_floor and gh < swim_y
	wading = on_floor and not swimming and gh < main.WATER_Y - GUE
	if on_ground:
		if not was_ground:
			_land(air_top - global_position.y)
		air_top = global_position.y
	else:
		air_top = max(air_top, global_position.y)
	_pose(delta, sp, mv)

# Fin d'une chute : au-delà de 3 m on se blesse, sauf en tombant dans l'eau profonde.
func _land(h: float) -> void:
	last_fall = h
	if swimming or h <= CHUTE_SANS_MAL:
		return
	hurt((h - CHUTE_SANS_MAL) * CHUTE_DEGATS)

func _pose(delta: float, sp: float, mv: float) -> void:
	var k := 1.0 - exp(-delta * 14.0)
	body.scale.y = lerp(body.scale.y, 0.63 if crouching else 1.0, k)
	# en nageant, le corps s'allonge à la surface
	body.rotation.x = lerp(body.rotation.x, 1.25 if swimming else 0.0, k)
	body.position = body.position.lerp(Vector3(0, 1.0, 0) if swimming else Vector3.ZERO, k)
	if swimming:
		phase += delta * (2.0 + 2.0 * abs(mv))
		var s := sin(phase)
		parts.armL.rotation.x = PI + s * 0.9
		parts.armR.rotation.x = PI - s * 0.9
		parts.legL.rotation.x = s * 0.3
		parts.legR.rotation.x = -s * 0.3
	elif on_ground:
		phase += delta * sp * 1.5 * abs(mv)
		main.anim_human(parts, phase, 0.7 if mv != 0.0 else 0.0)
	else:
		# en l'air : jambes et bras écartés, sans balancement
		parts.legL.rotation.x = 0.5
		parts.legR.rotation.x = -0.35
		parts.armL.rotation.x = -0.9
		parts.armR.rotation.x = -0.9
