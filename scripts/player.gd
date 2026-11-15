extends CharacterBody3D
# Le héros à pied.

var heading := PI
var phase := 0.0
var parts := {}
var shape: CollisionShape3D

func setup(main) -> void:
	motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	shape = CollisionShape3D.new()
	var c := CapsuleShape3D.new()
	c.radius = 0.4
	c.height = 1.9
	shape.shape = c
	shape.position.y = 0.95
	add_child(shape)
	parts = main.make_human(self, Color("008751"), Color("2b2b40"), Color("5a3622"))

func walk(main, delta: float) -> void:
	var sp := 10.0 if Input.is_action_pressed("run") else 5.5
	heading += Input.get_axis("right", "left") * 2.8 * delta
	var mv := Input.get_action_strength("up") - 0.6 * Input.get_action_strength("down")
	rotation.y = heading
	velocity = Vector3(sin(heading), 0, cos(heading)) * mv * sp
	move_and_slide()
	global_position.y = 0
	phase += delta * sp * 1.5 * abs(mv)
	main.anim_human(parts, phase, 0.7 if mv != 0.0 else 0.0)
