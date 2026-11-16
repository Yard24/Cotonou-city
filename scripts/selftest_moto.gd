extends RefCounted
# Test automatique de la conduite moto : départ à moto, accélération, freinage, équilibre et
# inclinaison, chute du pilote, caméra. Appelé par selftest.gd après le test de la voiture,
# tout dans la même image. Terrain d'essai : la plage, moto tournée vers l'est.

const DT := 1.0 / 60.0
const EST := PI / 2
const NORD_PLAGE := Vector3(0, 0, -1)   # à gauche quand on roule vers l'est
var err := ""

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	var c = m.moto_romaric
	for t in [_depart, _acceleration, _freinage, _equilibre, _plafond, _chute, _camera]:
		_release()
		c.repair()
		m.player.health = 100.0
		t.call(m, c)
		_release()
		if err != "":
			return err
	if m.cur_car != null:
		m.toggle_car()
	c.repair()
	m.player.health = 100.0
	return ""

func _release() -> void:
	for a in ["up", "down", "left", "right", "brake"]:
		Input.action_release(a)

func _put(c, x: float, z: float, h: float, v: float) -> void:
	c.global_position = Vector3(x, 0, z)
	c.heading = h
	c.rotation.y = h
	c.speed = v
	c.prev_speed = v
	c.prev_heading = h
	c.lean = 0.0
	c.pitch = 0.0

func _run(c, secs: float, keys: Array = []) -> void:
	for k in keys:
		Input.action_press(k)
	for i in int(round(secs * 60.0)):
		c.drive(DT)
	for k in keys:
		Input.action_release(k)

# De combien le haut de la moto penche vers la gauche du pilote (en radians, > 0 à gauche).
func _tilt(c) -> float:
	var up: Vector3 = c.body.global_transform.basis.y
	var left := Vector3(cos(c.heading), 0, -sin(c.heading))
	return atan2(up.dot(left), up.y)

func _depart(m, c) -> void:
	var pl = m.player
	# décision 51 : le premier véhicule du joueur est la moto, garée à côté du point de départ
	var d_moto: float = c.global_position.distance_to(m.SPAWN)
	if not c.moto or d_moto > 4.0 or d_moto >= m.cars[0].global_position.distance_to(m.SPAWN) or not ("moto" in m.missions[0].t):
		err = "départ : la moto de Romaric n'est pas le véhicule le plus proche du point de départ"
		return
	c.idle(DT)
	if c.rider.visible or c.fallen:
		err = "départ : une moto garée ne doit pas avoir de pilote"
		return
	for i in 60:
		c.idle(DT)
	if abs(_tilt(c) - c.BEQUILLE) > 0.01:
		err = "départ : la moto garée n'est pas posée sur sa béquille (%.2f rad)" % _tilt(c)
		return
	pl.teleport(m.SPAWN, PI)
	m.press_e()
	if m.cur_car != c or pl.visible:
		err = "départ : E ne fait pas monter sur la moto"
		return
	c.drive(DT)
	if not c.rider.visible or not c.foot.visible or c.wheels[0].get_parent() != c.body:
		err = "départ : pilote, pied à terre ou roues mal affichés"
		return
	# les motos de la circulation ont leur conducteur : on ne monte pas dessus
	var z = m.traffic[0]
	pl.global_position = z.global_position + Vector3(1.5, 0, 0)
	m.cur_car = null
	var near = m._nearest_car()
	m.cur_car = c
	if not z.moto or near == z:
		err = "départ : on peut monter sur une moto de la circulation"
		return
	m.press_e()
	c.idle(DT)
	if m.cur_car != null or not pl.visible or c.rider.visible:
		err = "départ : E ne fait pas descendre de la moto"
		return
	if abs(pl.global_position.distance_to(c.global_position) - 1.2) > 0.01:
		err = "départ : le héros ne descend pas à côté de la moto"
		return
	m.mount(c)
	print("départ à moto : la moto de Romaric est à %.1f m du point de départ, E pour monter et descendre, moto garée sur sa béquille" % d_moto)

func _acceleration(m, c) -> void:
	m.cur_car = c
	_put(c, -150, -178, EST, 0.0)
	_run(c, 1.0, ["up"])
	var v1: float = c.speed
	var d1: float = c.global_position.x + 150.0
	_run(c, 3.0, ["up"])
	var v4: float = c.speed
	var d4: float = c.global_position.x + 150.0
	# vive au départ (plus de 45 km/h en 1 s), plafonnée à 94 km/h
	if v1 < 12.5 or v1 > 16.0 or abs(v4 - c.V_MAX) > 0.01 or d4 < 70.0 or abs(c.global_position.z + 178.0) > 0.01:
		err = "accélération moto : %.1f m/s après 1 s, %.1f après 4 s, %.1f m" % [v1, v4, d4]
		return
	# de moins en moins forte : la deuxième seconde ajoute moins de vitesse que la première
	_put(c, -150, -178, EST, v1)
	_run(c, 1.0, ["up"])
	if c.speed - v1 >= v1 * 0.7:
		err = "accélération moto : elle ne faiblit pas avec la vitesse"
		return
	# aucune touche : frein moteur, 3 m/s²
	_put(c, -150, -178, EST, 20.0)
	_run(c, 1.0)
	if abs(c.speed - 17.0) > 0.05:
		err = "accélération moto : frein moteur, %.1f m/s après 1 s (attendu 17)" % c.speed
		return
	# pas de marche arrière au moteur : on recule au pas, avec les pieds
	_put(c, -150, -178, EST, 0.0)
	_run(c, 3.0, ["down"])
	var vr: float = c.speed
	if abs(vr - c.V_RECUL) > 0.01 or c.global_position.x > -152.0 or c.global_position.x < -155.0:
		err = "accélération moto : recul à %.1f m/s, x = %.1f" % [vr, c.global_position.x]
		return
	_run(c, 0.5, ["up"])
	if c.speed <= 0.0:
		err = "accélération moto : elle ne repart pas en avant après avoir reculé"
		return
	# moteur très abîmé : 60 % de la vitesse maximale
	c.damage = 85.0
	_put(c, -150, -178, EST, 0.0)
	_run(c, 5.0, ["up"])
	if abs(c.speed - c.V_MAX * 0.6) > 0.01:
		err = "accélération moto : moteur abîmé, %.1f m/s" % c.speed
		return
	print("accélération moto : %.0f km/h en 1 s (%.1f m), %.0f km/h au plus, %.0f m en 4 s, frein moteur, recul au pas à %.0f km/h, %.0f km/h moteur abîmé" % [v1 * 3.6, d1, v4 * 3.6, d4, -vr * 3.6, c.speed * 3.6])

# Distance et temps d'arrêt depuis 25 m/s avec les touches données.
func _stop(c, keys: Array) -> Array:
	_put(c, -150, -178, EST, 25.0)
	for k in keys:
		Input.action_press(k)
	var n := 0
	while c.speed > 0.01 and n < 600:
		c.drive(DT)
		n += 1
	for k in keys:
		Input.action_release(k)
	return [c.global_position.x + 150.0, n * DT]

func _freinage(m, c) -> void:
	m.cur_car = c
	var a := _stop(c, ["down"])
	if not c.fx.braking:
		err = "freinage moto : le feu stop n'est pas commandé"
		return
	var b := _stop(c, ["brake"])
	var u := _stop(c, ["down", "brake"])
	# 90 km/h : 1,25 s et 16 m avec les deux freins ; le frein arrière seul freine deux fois moins
	if abs(a[1] - 1.25) > 0.05 or a[0] < 14.0 or a[0] > 17.5:
		err = "freinage moto : arrêt en %.2f s sur %.1f m (attendu 1,25 s, 16 m)" % [a[1], a[0]]
		return
	if abs(b[1] - 2.5) > 0.05 or b[0] < a[0] * 1.8 or u[0] >= a[0] or abs(u[1] - 0.96) > 0.05:
		err = "freinage moto : frein arrière %.2f s sur %.1f m, urgence %.2f s sur %.1f m" % [b[1], b[0], u[1], u[0]]
		return
	# freiner l'emporte sur l'accélérateur ; une fois arrêtée, la moto ne repart pas en arrière d'un coup
	_put(c, -150, -178, EST, 25.0)
	_run(c, 0.5, ["up", "brake"])
	if abs(c.speed - 20.0) > 0.05:
		err = "freinage moto : accélérateur + frein, %.1f m/s (attendu 20)" % c.speed
		return
	_put(c, -150, -178, EST, 10.0)
	_run(c, 0.6, ["down"])
	if c.speed > 0.0 or c.speed < -0.5:
		err = "freinage moto : après l'arrêt, vitesse %.2f" % c.speed
		return
	# en ligne droite, freiner ne fait ni tourner ni pencher
	if abs(c.global_position.z + 178.0) > 0.001 or abs(c.lean) > 0.001:
		err = "freinage moto : la moto dévie en freinant"
		return
	# frein arrière en virage : le virage se resserre
	_put(c, -150, -178, EST, 15.0)
	_run(c, 0.7, ["left"])
	var a1: float = angle_difference(EST, c.heading)
	var l1: float = c.global_position.distance_to(Vector3(-150, 0, -178))
	_put(c, -150, -178, EST, 15.0)
	_run(c, 0.7, ["left", "brake"])
	var a2: float = angle_difference(EST, c.heading)
	var l2: float = c.global_position.distance_to(Vector3(-150, 0, -178))
	if a2 <= a1 * 1.2 or l2 >= l1:
		err = "freinage moto : frein arrière en virage, %.2f rad sur %.1f m contre %.2f sur %.1f" % [a2, l2, a1, l1]
		return
	print("freinage moto : de 90 km/h à l'arrêt en %.2f s sur %.1f m ; frein arrière seul %.1f m ; les deux %.1f m ; en virage %.0f° sur %.1f m au lieu de %.0f° sur %.1f m" % [a[1], a[0], b[0], u[0], rad_to_deg(a2), l2, rad_to_deg(a1), l1])

# Angle tourné en 1 s à vitesse v maintenue (accélérateur relâché), et angle d'inclinaison atteint.
func _virage(c, v: float, key: String) -> Array:
	_put(c, -100, -178, EST, v)
	var top := 0.0
	Input.action_press(key)
	for i in 60:
		c.speed = v
		c.drive(DT)
		top = max(top, abs(c.lean))
	Input.action_release(key)
	return [angle_difference(EST, c.heading), _tilt(c), top]

func _equilibre(m, c) -> void:
	m.cur_car = c
	# en ligne droite : debout, pied relevé
	_put(c, -150, -178, EST, 15.0)
	_run(c, 1.0, ["up"])
	if abs(_tilt(c)) > 0.001 or c.foot.visible or abs(c.global_position.z + 178.0) > 0.001:
		err = "équilibre : la moto penche ou dévie en ligne droite"
		return
	# à l'arrêt : le guidon ne fait ni pivoter ni pencher, le pied est posé
	_put(c, -150, -178, EST, 0.0)
	_run(c, 0.5, ["left"])
	if abs(angle_difference(EST, c.heading)) > 0.001 or abs(_tilt(c)) > 0.001 or not c.foot.visible:
		err = "équilibre : à l'arrêt la moto pivote, penche, ou le pied n'est pas à terre"
		return
	# en virage : elle penche vers l'intérieur, jamais plus de 38°, et c'est symétrique
	var g := _virage(c, 15.0, "left")
	var zg: float = c.global_position.z
	var d := _virage(c, 15.0, "right")
	if g[0] <= 0.0 or g[1] < 0.55 or g[2] > c.PENCHE_MAX + 0.001 or zg > -179.0:
		err = "équilibre : virage à gauche, %.2f rad tournés, moto penchée de %.2f rad" % [g[0], g[1]]
		return
	if abs(g[0] + d[0]) > 0.02 or abs(g[1] + d[1]) > 0.01:
		err = "équilibre : gauche et droite ne sont pas symétriques"
		return
	# la mise sur l'angle est progressive : après 0,1 s on est loin de l'angle complet
	_put(c, -100, -178, EST, 15.0)
	_run(c, 0.1, ["left"])
	if c.lean <= 0.05 or c.lean > c.PENCHE_MAX * 0.6:
		err = "équilibre : mise sur l'angle trop brusque ou absente (%.2f rad en 0,1 s)" % c.lean
		return
	# guidon relâché : la moto se redresse en moins d'une seconde et repart tout droit
	_run(c, 0.5, ["left"])
	_run(c, 1.0)
	var h1: float = c.heading
	_run(c, 0.5)
	if abs(c.lean) > 0.01 or abs(angle_difference(h1, c.heading)) > 0.01:
		err = "équilibre : la moto ne se redresse pas (%.3f rad)" % c.lean
		return
	# plus on roule vite, plus le virage est large ; au pas, on tourne au guidon presque sans pencher
	var lent := _virage(c, 2.0, "left")
	var ville := _virage(c, 8.0, "left")
	var vite := _virage(c, 26.0, "left")
	if not (ville[0] > g[0] and g[0] > vite[0]) or vite[0] < 0.2 or ville[0] > 1.2:
		err = "équilibre : angles tournés en 1 s : %.2f à 29 km/h, %.2f à 54, %.2f à 94" % [ville[0], g[0], vite[0]]
		return
	if lent[0] < 0.6 or lent[1] > 0.3:
		err = "équilibre : au pas, %.2f rad tournés, penchée de %.2f rad" % [lent[0], lent[1]]
		return
	# en reculant avec les pieds, le guidon agit à l'envers, comme sur une vraie moto
	_put(c, -100, -178, EST, -1.5)
	for i in 30:
		c.speed = -1.5
		Input.action_press("left")
		c.drive(DT)
	Input.action_release("left")
	if angle_difference(EST, c.heading) >= 0.0:
		err = "équilibre : direction non inversée en reculant"
		return
	# circulation : une moto penche dans les virages de son trajet, et se redresse ensuite
	var z = m.traffic[0]
	var d0: float = z.dist
	var top := 0.0
	z.speed = z.vmax
	for i in 60 * 40:
		z.ai_step(DT, false)
		top = max(top, abs(z.lean))
		if top > 0.1 and abs(z.lean) < 0.01:
			break
	z.dist = d0
	z.place_on_path()
	if top < 0.1 or top > 0.5 or abs(z.lean) >= 0.01 or not z.rider.visible:
		err = "équilibre : moto de la circulation, angle maximal %.2f rad" % top
		return
	print("équilibre : %.0f° d'angle en virage (38° au plus), gauche et droite symétriques, redressée en ligne droite ; en 1 s : %.0f° à 29 km/h, %.0f° à 54, %.0f° à 94 ; au pas %.0f° au guidon ; circulation : %.0f° dans ses virages" % [rad_to_deg(g[1]), rad_to_deg(ville[0]), rad_to_deg(g[0]), rad_to_deg(vite[0]), rad_to_deg(lent[0]), rad_to_deg(top)])

# Inclinaison réaliste : l'angle dépend de la vitesse et du rayon du virage
# (tan(angle) = v² / (rayon × g)) et ne dépasse jamais le plafond, pour la moto comme pour la caméra.
func _plafond(m, c) -> void:
	m.cur_car = c
	var maxi: float = c.PENCHE_MAX
	if maxi < deg_to_rad(35.0) or maxi > deg_to_rad(40.0):
		err = "plafond : angle maximal de la moto %.0f° (attendu entre 35 et 40°)" % rad_to_deg(maxi)
		return
	# la formule : plus vite ou plus serré = plus penché ; ligne droite = droite ; jamais plus que le plafond
	if abs(c.angle_virage(15.0, 0.0)) > 0.0001 or c.angle_virage(15.0, 15.0 / 60.0) >= c.angle_virage(15.0, 15.0 / 30.0) or c.angle_virage(10.0, 10.0 / 30.0) >= c.angle_virage(15.0, 15.0 / 30.0) or c.angle_virage(30.0, 3.0) > maxi or abs(c.angle_virage(10.0, 10.0 / 20.0) - atan(100.0 / (20.0 * 9.81))) > 0.001 or abs(c.angle_virage(12.0, -0.4) + c.angle_virage(12.0, 0.4)) > 0.0001:
		err = "plafond : la formule de l'angle ne suit pas la vitesse et le rayon du virage"
		return
	# virage tenu 3 s à plusieurs vitesses : on mesure le rayon réellement suivi et l'angle affiché
	var p0 := Vector3(-100, 0, -178)
	var lignes := []
	var angles := []
	for v in [2.0, 3.0, 6.0, 10.0, 15.0, 20.0, 26.0]:
		for charge in [false, true]:
			c.loaded = charge
			_put(c, p0.x, p0.z, EST, v)
			Input.action_press("left")
			var top := 0.0
			var h_avant := EST
			for i in 180:
				c.speed = v
				h_avant = c.heading
				c.drive(DT)
				c.global_position = p0   # sur place : seuls le cap et l'angle comptent
				top = max(top, max(abs(c.lean), abs(_tilt(c))))
			Input.action_release("left")
			var lacet: float = angle_difference(h_avant, c.heading) / DT
			var rayon: float = v / lacet
			var attendu: float = min(atan(v * v / (rayon * 9.81)), maxi)
			if top > maxi + 0.0005 or lacet <= 0.0 or rayon < c.RAYON_MIN - 0.01 or abs(c.lean - attendu) > 0.01 or abs(_tilt(c) - c.lean) > 0.001:
				err = "plafond : à %.0f km/h, rayon %.1f m, moto penchée de %.1f° (attendu %.1f°, plafond %.0f°)" % [v * 3.6, rayon, rad_to_deg(c.lean), rad_to_deg(attendu), rad_to_deg(maxi)]
				c.loaded = false
				return
			if not charge:
				lignes.append("%.0f km/h : rayon %.0f m, %.0f°" % [v * 3.6, rayon, rad_to_deg(c.lean)])
				angles.append(c.lean)
	c.loaded = false
	# au pas la moto penche peu ; l'angle grandit avec la vitesse jusqu'au plafond
	if angles[0] > 0.25 or not (angles[0] < angles[1] and angles[1] < angles[2]) or angles[6] < maxi - 0.01:
		err = "plafond : l'angle ne grandit pas avec la vitesse (%.0f°, %.0f°, %.0f°)" % [rad_to_deg(angles[0]), rad_to_deg(angles[1]), rad_to_deg(angles[2])]
		return
	# conduite brutale pendant 20 s (gauche, droite, freins, accélérateur, passager) : jamais au-delà
	var top2 := 0.0
	var seq := [["up", "left"], ["left", "brake"], ["up", "right"], ["right", "down"], ["left"], ["right", "brake", "down"], ["up", "left"], ["right"]]
	_put(c, p0.x, p0.z, EST, 0.0)
	for k in 1200:
		if k % 25 == 0:
			_release()
			for a in seq[(k / 25) % seq.size()]:
				Input.action_press(a)
			c.loaded = (k / 300) % 2 == 1
		c.drive(DT)
		c.global_position = p0
		top2 = max(top2, max(abs(c.lean), abs(_tilt(c))))
	_release()
	c.loaded = false
	if top2 > maxi + 0.0005 or top2 < 0.3:
		err = "plafond : en conduite brutale la moto penche de %.1f° (plafond %.0f°)" % [rad_to_deg(top2), rad_to_deg(maxi)]
		return
	# caméra : elle penche moins que la moto, et elle a son propre plafond
	var vue = m.vue
	if vue.ROULIS_EXT_MAX >= vue.ROULIS_GUIDON_MAX or vue.ROULIS_GUIDON_MAX >= maxi or vue.ROULIS_EXT_MAX > deg_to_rad(10.0):
		err = "plafond : les plafonds de la caméra ne sont pas inférieurs à celui de la moto"
		return
	for i in 41:
		var a: float = -1.4 + i * 0.07
		var re: float = vue.roulis(a, false)
		var rg: float = vue.roulis(a, true)
		if abs(re) > vue.ROULIS_EXT_MAX + 0.0001 or abs(rg) > vue.ROULIS_GUIDON_MAX + 0.0001 or re * a < 0.0 or rg * a < 0.0 or (abs(a) > 0.01 and (abs(re) >= abs(a) or abs(rg) >= abs(a))):
			err = "plafond : caméra penchée de %.1f° pour une moto à %.1f°" % [rad_to_deg(rg), rad_to_deg(a)]
			return
	# mesuré sur la vraie caméra, moto au plafond puis au-delà (cas impossible, par sécurité)
	var pires := []
	for a in [maxi, 1.3]:
		for mode in [1, 3]:
			_put(c, 0, -178, EST, 0.0)
			c.lean = a
			m.cam_mode = mode
			m._camera(0.0, true)
			# roulis autour de l'axe de visée : la verticale vue dans le repère de la caméra
			var bc: Basis = m.cam.global_transform.basis
			var r: float = abs(atan2(bc.x.y, bc.y.y))
			var lim: float = vue.ROULIS_GUIDON_MAX if mode == 3 else vue.ROULIS_EXT_MAX
			if r > lim + 0.001 or r < 0.05:
				err = "plafond : la caméra (mode %d) penche de %.1f° (plafond %.0f°)" % [mode, rad_to_deg(r), rad_to_deg(lim)]
				return
			pires.append(r)
	c.lean = 0.0
	m.cam_mode = 1
	print("inclinaison réaliste : angle = atan(v² / (rayon × g)), plafond %.0f° ; %s ; conduite brutale %.0f° au plus ; caméra %.0f° au plus, %.0f° en vue du guidon" % [rad_to_deg(maxi), " · ".join(lignes), rad_to_deg(top2), rad_to_deg(pires[2]), rad_to_deg(pires[3])])

func _chute(m, c) -> void:
	var pl = m.player
	m.cur_car = c
	pl.visible = false
	# petit choc (moins de 25 km/h perdus d'un coup) : le pilote reste en selle
	c.hit(6.0, true)
	if c.fallen or m.cur_car != c or pl.health != 100.0 or c.damage <= 0.0:
		err = "chute : un petit choc fait tomber le pilote"
		return
	# frôler un mur en biais : pas de chute non plus
	c.repair()
	_put(c, 0, -186, EST + 0.2, 12.0)
	_run(c, 1.5, ["up"])
	if c.fallen or m.cur_car != c or c.global_position.x < 15.0:
		err = "chute : le pilote tombe en frôlant un mur (x = %.1f)" % c.global_position.x
		return
	# de face contre le mur du bout du monde à 72 km/h : chute
	c.repair()
	_put(c, 190, -178, EST, 20.0)
	for i in 120:
		c.speed = 20.0 if not c.fallen else 0.0
		c.drive(DT)
	var perdu: float = 100.0 - pl.health
	if not c.fallen or m.cur_car != null or not pl.visible or pl.down_t <= 0.0 or c.speed != 0.0:
		err = "chute : pas de chute contre un mur à 72 km/h"
		return
	if abs(perdu - 40.0) > 3.0 or c.damage < 30.0 or pl.ko_t > 0.0:
		err = "chute : %.0f points de santé perdus (attendu 40 environ), dégâts %.0f" % [perdu, c.damage]
		return
	if abs(abs(c.body.rotation.z) - c.COUCHEE) > 0.05 or c.rider.visible or c.global_position.x > 206.0:
		err = "chute : la moto n'est pas couchée (%.2f rad)" % c.body.rotation.z
		return
	if pl.global_position.distance_to(c.global_position) > 1.5 or pl.global_position.x > 206.0:
		err = "chute : le pilote n'est pas à côté de sa moto"
		return
	# par terre : aucune action possible pendant 2 secondes
	var p0: Vector3 = pl.global_position
	Input.action_press("up")
	m.press_e()
	for i in 60:
		pl.walk(m, DT)
	if c.fallen == false or m.cur_car != null or pl.global_position.distance_to(p0) > 0.01 or pl.jump() or pl.body.rotation.x > -1.2:
		err = "chute : le pilote peut agir alors qu'il est par terre"
		return
	pl.heading = -EST   # on s'éloigne du mur
	for i in 90:
		pl.walk(m, DT)
	Input.action_release("up")
	if pl.down_t > 0.0 or pl.global_position.distance_to(p0) < 1.0 or abs(pl.body.rotation.x) > 0.05:
		err = "chute : le pilote ne se relève pas"
		return
	# E une fois : on relève la moto ; E une seconde fois : on remonte
	pl.global_position = c.global_position + Vector3(0, 0, -1.2)
	m.press_e()
	if c.fallen or m.cur_car != null:
		err = "chute : E ne relève pas la moto"
		return
	c.idle(DT)
	m.press_e()
	if m.cur_car != c or abs(_tilt(c)) > 0.2:
		err = "chute : impossible de remonter sur la moto relevée"
		return
	# face au mur : on recule avec les pieds en braquant, puis on repart
	_run(c, 2.6, ["down", "left"])
	_run(c, 1.0, ["up"])
	if c.speed < 5.0 or c.fallen:
		err = "chute : la moto ne repart pas après la chute"
		return
	# une chute ne fait jamais perdre connaissance : il reste toujours 5 points (décision 53)
	pl.health = 12.0
	c.fallen = false
	c.hit(26.0, true)
	if pl.health != 5.0 or pl.ko_t > 0.0 or not c.fallen or pl.down_t <= 0.0:
		err = "chute : santé %.0f après une grosse chute avec 12 points (attendu 5)" % pl.health
		return
	# déjà à 5 points : la chute ne coûte plus que du temps
	pl.down_t = 0.0
	c.stand_up()
	m.mount(c)
	c.hit(26.0, true)
	if pl.health != 5.0 or pl.ko_t > 0.0:
		err = "chute : la santé descend sous 5 points"
		return
	pl.down_t = 0.0
	pl.reset_pose()
	# une moto garée percutée par un autre véhicule se couche, sans blesser personne
	c.stand_up()
	c.hit(8.0, false)
	if not c.fallen or pl.health != 5.0 or pl.down_t > 0.0:
		err = "chute : une moto garée percutée ne se couche pas"
		return
	c.repair()
	if c.fallen:
		err = "chute : la réparation ne relève pas la moto"
		return
	print("chute du pilote : petit choc et mur frôlé sans chute ; mur de face à 72 km/h = chute, -%.0f de santé, 2 s par terre, moto couchée à relever avec E ; jamais moins de 5 points" % perdu)

func _camera(m, c) -> void:
	_put(c, 0, -178, EST, 0.0)
	m.cur_car = c
	m.player.visible = false
	var fwd := Vector3(1, 0, 0)
	var ds := []
	for mode in 3:
		m.cam_mode = mode
		m._camera(0.0, true)
		var rel: Vector3 = m.cam.global_position - c.global_position
		var back: float = -rel.dot(fwd)
		var vise: float = (-m.cam.global_transform.basis.z).angle_to(c.global_position + Vector3(0, 1.6, 0) - m.cam.global_position)
		# plus près et plus bas qu'en voiture, et droite tant que la moto est droite
		if back >= m.CAMS[mode][0] or rel.y >= m.CAMS[mode][1] or back < 4.0 or abs(rel.z) > 0.01 or vise > 0.01 or abs(m.cam.global_transform.basis.y.z) > 0.001:
			err = "caméra moto : mode %d, %.1f m derrière, %.1f m de haut" % [mode, back, rel.y]
			return
		ds.append(back)
	if not (ds[0] < ds[1] and ds[1] < ds[2]):
		err = "caméra moto : les trois distances ne sont pas croissantes"
		return
	# la caméra penche du même côté que la moto, mais moins qu'elle
	c.lean = 0.6
	c._lean(DT)
	m.cam_mode = 1
	m._camera(0.0, true)
	var up: Vector3 = m.cam.global_transform.basis.y
	var roulis_ext: float = atan2(up.dot(NORD_PLAGE), up.y)
	m.cam_mode = 3
	m._camera(0.0, true)
	up = m.cam.global_transform.basis.y
	var roulis_g: float = atan2(up.dot(NORD_PLAGE), up.y)
	var r: Vector3 = m.cam.global_position - c.global_position
	if _tilt(c) < 0.55 or roulis_ext < 0.1 or roulis_ext > 0.3 or roulis_g <= roulis_ext or roulis_g >= 0.6:
		err = "caméra moto : moto penchée de %.2f rad, caméra de %.2f (extérieure) et %.2f (guidon)" % [_tilt(c), roulis_ext, roulis_g]
		return
	# vue du guidon : à hauteur des yeux du pilote, regard devant, et elle suit la moto sans retard
	if Vector2(r.x, r.z).length() > 0.5 or r.y < 1.5 or r.y > 2.0 or (-m.cam.global_transform.basis.z).dot(fwd) < 0.99:
		err = "caméra moto : vue du guidon mal placée"
		return
	_put(c, 0, -178, EST + 1.0, 0.0)
	m._camera(DT, false)
	if (-m.cam.global_transform.basis.z).dot(Vector3(sin(EST + 1.0), 0, cos(EST + 1.0))) < 0.99 or abs(m.cam.global_transform.basis.y.y - 1.0) > 0.01:
		err = "caméra moto : la vue du guidon ne suit pas la moto"
		return
	# en voiture et à pied, rien ne change
	m.cur_car = m.cars[1]
	m.cam_mode = 1
	m._camera(0.0, true)
	var dv: float = Vector2(m.cam.global_position.x - m.cars[1].global_position.x, m.cam.global_position.z - m.cars[1].global_position.z).length()
	m.cur_car = null
	m.player.visible = true
	m._camera(0.0, true)
	var dp: float = Vector2(m.cam.global_position.x - m.player.global_position.x, m.cam.global_position.z - m.player.global_position.z).length()
	if abs(dv - 11.0) > 0.01 or abs(dp - 6.5) > 0.01 or abs(m.cam.global_transform.basis.y.x) > 0.001 and abs(m.cam.global_transform.basis.x.y) > 0.001:
		err = "caméra moto : la caméra de la voiture (%.1f m) ou à pied (%.1f m) a changé" % [dv, dp]
		return
	print("caméra moto : %.1f, %.1f et %.1f m derrière la moto ; moto penchée de %.0f° : caméra de %.0f°, vue du guidon de %.0f°, à %.2f m de haut" % [ds[0], ds[1], ds[2], rad_to_deg(0.6), rad_to_deg(roulis_ext), rad_to_deg(roulis_g), r.y])
