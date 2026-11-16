extends "res://scripts/car.gd"
# Moto de zémidjan : accélération, freinage, équilibre et inclinaison, chute du pilote.
# Le fonctionnement attendu est décrit dans docs/systemes/conduite_moto.md.
# « lean » > 0 : la moto penche à gauche (côté +X), c'est-à-dire vers l'intérieur d'un virage à gauche.

const V_MAX := 26.0          # 94 km/h
const V_RECUL := -1.5        # on recule en poussant avec les pieds
const ACCEL := 18.0          # m/s² au démarrage…
const ACCEL_CHUTE := 0.8     # … et 80 % de moins à pleine vitesse
const FREIN := 20.0          # touche Bas : les deux freins
const FREIN_AR := 10.0       # Espace seul : frein arrière
const FREIN_TOUT := 26.0     # Bas + Espace
const FREIN_MOTEUR := 3.0    # aucune touche
const PENCHE_MAX := 0.66     # 38°
const PENCHE_VITE := 7.0     # rapidité de la mise sur l'angle
const G_VIRAGE := 26.0       # plus c'est grand, plus la moto tourne pour un même angle
const YAW_MAX := 2.4         # rad/s : virage le plus serré
const BEQUILLE := 0.14       # moto garée : penchée de 8° sur sa béquille
const CHUTE_CHOC := 7.0      # m/s perdus d'un coup (25 km/h) : le pilote tombe
const COUCHEE := 1.35        # angle de la moto couchée
# avec un passager à l'arrière, la moto est plus lourde
const CHARGE_ACCEL := 0.85   # 15 % d'accélération en moins
const CHARGE_FREIN := 0.9    # 10 % de freinage en moins
const CHARGE_PENCHE := 0.75  # mise sur l'angle plus lente
# circulation : une moto remonte une file arrêtée par le couloir, au pas (décision 61)
const FAUFILE_ECART := 1.9   # m à côté de la file
const FAUFILE_V := 5.0       # 18 km/h
const FAUFILE_COTE := -1.0   # vers l'axe de la route : à droite, la circulation roulant à gauche de la chaussée

var lean := 0.0
var fallen := false
var fall_side := 1.0
var rider: Node3D
var foot: MeshInstance3D
var shirt: MeshInstance3D
var passenger: Node3D
var pass_shirt: MeshInstance3D
var loaded := false   # un client est assis derrière le pilote

func _look(main, color: Color, _taxi: bool) -> void:
	main.box(Vector3(0.34, 0.42, 1.5), Color("222222"), Vector3(0, 0.62, 0), body)
	main.box(Vector3(0.32, 0.28, 0.55), color, Vector3(0, 0.9, 0.35), body)
	main.box(Vector3(0.7, 0.06, 0.06), Color("999999"), Vector3(0, 1.15, 0.7), body)
	# les roues penchent avec la moto
	wheels = [_wheel(main, Vector3(0, 0.33, 0.62), 0.33, 0.14, body), _wheel(main, Vector3(0, 0.33, -0.62), 0.33, 0.14, body)]
	# le pilote : chemise jaune des zémidjans (décision 43), casque (décision 52)
	rider = Node3D.new()
	body.add_child(rider)
	shirt = main.box(Vector3(0.48, 0.62, 0.3), Color("f2c200"), Vector3(0, 1.38, -0.12), rider)
	main.box(Vector3(0.2, 0.55, 0.55), Color("2b2b40"), Vector3(-0.2, 0.95, 0.1), rider)
	main.box(Vector3(0.2, 0.55, 0.55), Color("2b2b40"), Vector3(0.2, 0.95, 0.1), rider)
	main.box(Vector3(0.36, 0.36, 0.36), Color("222222"), Vector3(0, 1.9, -0.1), rider)
	# à l'arrêt, le pilote pose le pied gauche par terre
	foot = main.box(Vector3(0.16, 0.75, 0.2), Color("2b2b40"), Vector3(0.36, 0.38, 0.1), rider)
	foot.rotation.z = -0.25
	foot.visible = false
	# le passager, assis derrière le pilote, casqué lui aussi ; caché tant qu'il n'y a pas de client
	passenger = Node3D.new()
	body.add_child(passenger)
	pass_shirt = main.box(Vector3(0.46, 0.6, 0.28), Color.WHITE, Vector3(0, 1.36, -0.52), passenger)
	main.box(Vector3(0.2, 0.5, 0.5), Color("2b2b40"), Vector3(-0.22, 0.95, -0.34), passenger)
	main.box(Vector3(0.2, 0.5, 0.5), Color("2b2b40"), Vector3(0.22, 0.95, -0.34), passenger)
	main.box(Vector3(0.34, 0.34, 0.34), Color("444444"), Vector3(0, 1.86, -0.5), passenger)
	passenger.visible = false

# Le héros garde son maillot vert (décision 27) ; les zémidjans de la circulation sont en jaune.
func set_rider_color(c: Color) -> void:
	shirt.material_override = main_ref.mat(c)

# Un client monte derrière (couleur de sa chemise) ou descend.
func set_passenger(on: bool, c := Color.WHITE) -> void:
	loaded = on
	passenger.visible = on and not fallen
	if on:
		pass_shirt.material_override = main_ref.mat(c)

func _ai_target() -> float:
	return min(vmax, FAUFILE_V) if side_want != 0.0 or abs(side) > 0.2 else vmax

func max_speed() -> float:
	return V_MAX * (0.6 if damage >= DEGATS_SEUILS[2] else 1.0)

func drive(delta: float) -> void:
	if fallen:
		idle(delta)
		return
	var up := Input.is_action_pressed("up")
	var down := Input.is_action_pressed("down")
	var rear := Input.is_action_pressed("brake")
	# freinage : Bas = les deux freins, Espace = frein arrière seul, les deux ensemble = freinage d'urgence
	var dec := 0.0
	if speed > 0.0:
		if down and speed > 0.3:
			dec = FREIN
		if rear:
			dec = FREIN_AR if dec == 0.0 else FREIN_TOUT
	if dec > 0.0:
		speed = max(0.0, speed - dec * (CHARGE_FREIN if loaded else 1.0) * delta)
	elif up:
		# vive au démarrage, de moins en moins à mesure que la vitesse monte
		speed += ACCEL * (CHARGE_ACCEL if loaded else 1.0) * (1.0 - ACCEL_CHUTE * max(speed, 0.0) / V_MAX) * delta
	elif down:
		speed -= 4.0 * delta   # presque arrêté : on recule avec les pieds
	else:
		speed = move_toward(speed, 0.0, FREIN_MOTEUR * delta)
	speed = clamp(speed, V_RECUL, max_speed())
	# équilibre : la direction commande l'angle, et c'est l'angle qui fait tourner la moto
	var steer := Input.get_axis("right", "left")
	var v: float = abs(speed)
	var plein: float = clamp(v / 6.0, 0.0, 1.0)
	lean += (steer * PENCHE_MAX * plein - lean) * (1.0 - exp(-delta * PENCHE_VITE * (CHARGE_PENCHE if loaded else 1.0)))
	var yaw := 0.0
	if v > 0.05:
		yaw = clamp(G_VIRAGE * tan(lean) / max(v, 7.0), -YAW_MAX, YAW_MAX)
		# au pas, on tourne surtout avec le guidon
		yaw += steer * 1.6 * (1.0 - plein) * clamp(v, 0.0, 1.0)
		if rear and v > 5.0:
			yaw *= 1.35   # frein arrière : la roue arrière glisse, le virage se resserre
	heading += yaw * delta * sign(speed)
	rotation.y = heading
	_advance(delta)
	if fallen:
		speed = 0.0
		return
	_spin(delta)
	_susp(delta)
	fx.braking = dec > 0.0
	if Input.is_action_pressed("horn"):
		fx.honk(0.12)
	fx.step(delta)

# Appelé à chaque image par la suspension : angle affiché, pilote, pied à terre.
func _lean(dt: float) -> void:
	var ridden: bool = main_ref.cur_car == self
	if fallen:
		lean = 0.0
		body.rotation.z = lerp(body.rotation.z, COUCHEE * fall_side, 1.0 - exp(-dt * 12.0))
		body.rotation.x = 0.0
	else:
		if ai:
			# circulation : l'angle suit le virage réellement pris
			var want: float = clamp(atan(speed * yaw_rate / 9.8), -0.5, 0.5)
			lean += (want - lean) * (1.0 - exp(-dt * PENCHE_VITE))
		elif not ridden:
			lean += (BEQUILLE - lean) * (1.0 - exp(-dt * PENCHE_VITE))
		# la fourche plonge un peu au freinage
		var want_p: float = clamp(-acc_long * 0.003, -0.03, 0.07)
		pitch += (want_p - pitch) * (1.0 - exp(-dt * 10.0))
		body.rotation.z = -lean
		body.rotation.x = pitch
	rider.visible = (ai or ridden) and not fallen
	passenger.visible = loaded and not fallen
	foot.visible = ridden and abs(speed) < 1.0

# ---------------- chute ----------------
func hit(impact: float, front: bool) -> void:
	super.hit(impact, front)
	if impact < CHUTE_CHOC or fallen or ai:
		return
	fall()   # une moto garée percutée se couche aussi
	if main_ref.cur_car == self:
		main_ref.moto_fall(self, impact)

func fall() -> void:
	fallen = true
	fall_side = -1.0 if lean > 0.0 else 1.0   # elle se couche du côté où elle penchait
	speed = 0.0
	lean = 0.0

func stand_up() -> void:
	fallen = false
	lean = BEQUILLE
	body.rotation.z = -lean

func repair() -> void:
	super.repair()
	if fallen:
		stand_up()
