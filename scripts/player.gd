extends CharacterBody3D
# Le héros à pied : marche, course, saut, position accroupie.
# Le fonctionnement attendu est décrit dans docs/systemes/joueur_a_pied.md.

const V_MARCHE := 5.5
const V_COURSE := 10.0
const V_ACCROUPI := 2.5
const V_SAUT := 6.5      # vitesse verticale au départ du saut (environ 1,2 m de haut)
const GRAVITE := 18.0
const H_DEBOUT := 1.9
const H_ACCROUPI := 1.2

var heading := PI
var phase := 0.0
var parts := {}
var shape: CollisionShape3D
var capsule: CapsuleShape3D
var body: Node3D          # partie visible, écrasée quand le héros s'accroupit
var vy := 0.0
var on_ground := true
var crouching := false

func setup(main) -> void:
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

# Vitesse de déplacement selon l'état (accroupi, course, marche).
func move_speed() -> float:
	if crouching:
		return V_ACCROUPI
	return V_COURSE if Input.is_action_pressed("run") else V_MARCHE

func jump() -> bool:
	if not on_ground or crouching:
		return false
	vy = V_SAUT
	on_ground = false
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
	body.scale.y = 1.0

func walk(main, delta: float) -> void:
	# on ne s'accroupit qu'au sol ; relâcher la touche relève le héros
	set_crouch(Input.is_action_pressed("crouch") and on_ground)
	if Input.is_action_just_pressed("jump"):
		jump()
	var sp := move_speed()
	heading += Input.get_axis("right", "left") * 2.8 * delta
	var mv := Input.get_action_strength("up") - 0.6 * Input.get_action_strength("down")
	rotation.y = heading
	vy -= GRAVITE * delta
	velocity = Vector3(sin(heading), 0, cos(heading)) * mv * sp + Vector3(0, vy, 0)
	move_and_slide()
	if global_position.y <= 0.0:
		# sol
		global_position.y = 0.0
		vy = 0.0
		on_ground = true
	elif vy < 0.0 and get_real_velocity().y > vy * 0.5:
		# posé sur un objet (étal, muret) : la chute est arrêtée par la collision
		vy = 0.0
		on_ground = true
	elif vy > 0.0 and get_real_velocity().y < vy * 0.5:
		# la tête touche quelque chose : la montée s'arrête
		vy = 0.0
	else:
		on_ground = false
	body.scale.y = lerp(body.scale.y, 0.63 if crouching else 1.0, 1.0 - exp(-delta * 14.0))
	if on_ground:
		phase += delta * sp * 1.5 * abs(mv)
		main.anim_human(parts, phase, 0.7 if mv != 0.0 else 0.0)
	else:
		# en l'air : jambes et bras écartés, sans balancement
		parts.legL.rotation.x = 0.5
		parts.legR.rotation.x = -0.35
		parts.armL.rotation.x = -0.9
		parts.armR.rotation.x = -0.9
