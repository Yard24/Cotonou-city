extends RefCounted
# Feux, clignotants et klaxon d'un véhicule (un objet par véhicule).
# Côté gauche du véhicule = +X local (l'avant est +Z).

const BLINK_HZ := 1.5       # battements par seconde
const BLINK_STOP := 1.2     # le clignotant s'éteint seul après 70° de virage environ
const HORN_RANGE := 14.0    # les passants sursautent dans ce rayon
static var lum := {}
static var horn_stream: AudioStreamWAV

var car
var m
var lights_on := false
var blink := 0              # 1 gauche, -1 droite, 0 éteint
var blink_t := 0.0
var blink_h0 := 0.0
var blink_lit := false
var braking := false
var brake_shown := false
var ind := {1: [], -1: []}
var spot: SpotLight3D
var horn_on := false
var horn_t := 0.0
var horn_cool := 0.0
var honks := 0
var blocked_t := 0.0
var ai_blink_t := 0.0
var horn_player: AudioStreamPlayer3D

# Matière lumineuse (non éclairée) partagée entre tous les véhicules.
static func lum_mat(c: Color) -> StandardMaterial3D:
	var k := c.to_html()
	if not lum.has(k):
		var mt := StandardMaterial3D.new()
		mt.albedo_color = c
		mt.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		lum[k] = mt
	return lum[k]

func setup(c, main) -> void:
	car = c
	m = main
	if car.moto:
		return
	for side in [1, -1]:
		for z in [2.21, -2.21]:
			var b = m.box(Vector3(0.16, 0.2, 0.07), Color("ff9a00"), Vector3(side * 0.92, 0.83, z), car.body)
			b.material_override = lum_mat(Color("ffa200"))
			b.visible = false
			ind[side].append(b)

# ---------------- phares ----------------
func toggle_lights() -> void:
	set_lights(not lights_on)

func set_lights(on: bool) -> void:
	lights_on = on
	if car.moto:
		return
	for l in car.lights_f:
		l.material_override = lum_mat(Color("fffbe0")) if on else m.mat(Color("fff6c0"))
	_spot()

# Un vrai faisceau seulement pour la voiture du joueur (une lumière coûte cher au niveau Bas).
func _spot() -> void:
	var want: bool = lights_on and m.cur_car == car and not car.moto and (car.lights_f[0].visible or car.lights_f[1].visible)
	if want and spot == null:
		spot = SpotLight3D.new()
		spot.position = Vector3(0, 0.95, 2.3)
		spot.rotation = Vector3(-0.12, PI, 0)
		spot.spot_range = 32.0
		spot.spot_angle = 38.0
		spot.light_energy = 2.2
		spot.light_color = Color("fff3c8")
		spot.shadow_enabled = false
		car.body.add_child(spot)
	if spot != null:
		spot.visible = want

# ---------------- clignotants ----------------
# Même touche une seconde fois : on éteint. L'autre touche : on change de côté.
func set_blink(side: int) -> void:
	blink = 0 if side == blink else side
	blink_t = 0.0
	blink_h0 = car.heading
	_show_blink()

func _show_blink() -> void:
	blink_lit = blink != 0 and fmod(blink_t * BLINK_HZ, 1.0) < 0.5
	for side in ind:
		for b in ind[side]:
			b.visible = blink_lit and side == blink

# ---------------- klaxon ----------------
func honk(secs: float) -> void:
	if not horn_on:
		honks += 1
		if horn_player == null:
			horn_player = AudioStreamPlayer3D.new()
			horn_player.stream = _horn()
			horn_player.unit_size = 14.0
			horn_player.max_distance = 90.0
			horn_player.pitch_scale = 1.25 if car.moto else 1.0
			car.add_child(horn_player)
		horn_player.play()
	horn_on = true
	horn_t = max(horn_t, secs)

# Son fabriqué par le code : deux notes mêlées, comme un klaxon de voiture.
static func _horn() -> AudioStreamWAV:
	if horn_stream == null:
		var rate := 22050
		var n := 2205   # 0,1 s : 42 et 53 périodes entières, la boucle ne claque pas
		var data := PackedByteArray()
		data.resize(n * 2)
		for i in n:
			var t := float(i) / rate
			var v := 0.0
			for f in [420.0, 530.0]:
				v += sin(TAU * f * t) + 0.5 * sin(TAU * 2.0 * f * t) + 0.3 * sin(TAU * 3.0 * f * t)
			data.encode_s16(i * 2, int(clamp(v * 0.2, -1.0, 1.0) * 32000.0))
		horn_stream = AudioStreamWAV.new()
		horn_stream.format = AudioStreamWAV.FORMAT_16_BITS
		horn_stream.mix_rate = rate
		horn_stream.stereo = false
		horn_stream.data = data
		horn_stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
		horn_stream.loop_begin = 0
		horn_stream.loop_end = n
	return horn_stream

# ---------------- à chaque image ----------------
func step(delta: float) -> void:
	if horn_on:
		horn_t -= delta
		if horn_t <= 0.0:
			horn_on = false
			horn_player.stop()
	horn_cool = max(0.0, horn_cool - delta)
	if car.moto:
		return
	if blink != 0:
		blink_t += delta
		if angle_difference(blink_h0, car.heading) * blink > BLINK_STOP:
			blink = 0
		_show_blink()
	if braking != brake_shown:
		brake_shown = braking
		for l in car.lights_r:
			l.material_override = lum_mat(Color("ff2a1a")) if braking else m.mat(Color("aa0000"))
	if spot != null and spot.visible and m.cur_car != car:
		spot.visible = false

# Circulation : feux stop quand elle freine, clignotant quand elle tourne,
# et un coup de klaxon de temps en temps si le joueur la bloque (rare, décision 59).
func ai(delta: float, blocked: bool, by_player: bool) -> void:
	braking = blocked or car.acc_long < -1.5
	if not car.moto:
		var side := 0
		if abs(car.yaw_rate) > 0.3 and car.speed > 1.0:
			side = 1 if car.yaw_rate > 0.0 else -1
			ai_blink_t = 0.7
		elif ai_blink_t > 0.0:
			ai_blink_t -= delta
			side = blink
		if side != blink:
			blink = side
			blink_t = 0.0
			blink_h0 = car.heading - side * 10.0   # pas d'arrêt automatique
		elif blink != 0:
			blink_h0 = car.heading
	blocked_t = blocked_t + delta if by_player else 0.0
	if blocked_t > 3.0 and horn_cool <= 0.0:
		honk(0.45)
		horn_cool = 14.0
	step(delta)
