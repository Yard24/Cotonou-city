extends RefCounted
# Test automatique de la moto en ville : passager à l'arrière (course de zémidjan) et passage
# entre les voitures. Appelé par selftest.gd après selftest_moto.gd, tout dans la même image.

const DT := 1.0 / 60.0
const EST := PI / 2
var err := ""
var file: Array = []   # trois voitures côte à côte au bout ouest de la plage

# Posées quelques images avant le test, comme la voiture-obstacle du test de la voiture :
# 1,4 m de passage entre les deux premières, 0,4 m entre les deux dernières.
func prepare(m) -> void:
	for z in [-179.7, -176.3, -173.9]:
		var v = m.trafic.make(m, Color("777777"), false, false)
		v.global_position = Vector3(-185, 0, z)
		v.heading = EST
		v.rotation.y = EST
		file.append(v)

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	var c = m.moto_romaric
	for t in [_passager, _passage, _droite, _faufile]:
		_reset(m, c)
		t.call(m, c)
		if err != "":
			return err
	_reset(m, c)
	return ""

func _reset(m, c) -> void:
	for a in ["up", "down", "left", "right", "brake"]:
		Input.action_release(a)
	if m.cur_car != null:
		m.cur_car.speed = 0.0
		m.toggle_car()
	c.repair()
	m.player.reset_pose()
	m.player.health = 100.0

func _put(c, x: float, z: float, h: float, v: float) -> void:
	c.global_position = Vector3(x, 0, z)
	c.heading = h
	c.rotation.y = h
	c.speed = v
	c.prev_speed = v
	c.prev_heading = h
	if c.moto:
		c.lean = 0.0
	c.pitch = 0.0

func _run(c, secs: float, keys: Array = []) -> void:
	for k in keys:
		Input.action_press(k)
	for i in int(round(secs * 60.0)):
		c.drive(DT)
	for k in keys:
		Input.action_release(k)

func _d(a: Vector3, b: Vector3) -> float:
	return Vector2(a.x - b.x, a.z - b.z).length()

# ---------------- passager à l'arrière ----------------
func _passager(m, c) -> void:
	var z = m.zem
	var pl = m.player
	if z.clients.size() != z.SPOTS.size() or z.clients.size() < 4:
		err = "passager : il n'y a pas de clients au bord des routes"
		return
	for cl in z.clients:
		if cl.state != "attend" or not cl.n.visible or _d(cl.n.position, z.spot_pos(cl.home)) > 0.01:
			err = "passager : un client n'attend pas à sa place"
			return
	# décision 64 : de 100 à 1 000 FCFA selon la distance
	if z.tarif(0.0) != 100 or z.tarif(100.0) != 300 or z.tarif(5000.0) != 1000 or z.tarif(137.0) % 50 != 0 or z.tarif(300.0) <= z.tarif(150.0):
		err = "passager : tarif faux (%d, %d, %d)" % [z.tarif(0.0), z.tarif(100.0), z.tarif(5000.0)]
		return
	# les trois missions paient 5 000, 7 500 et 3 000 FCFA (décision de Bravo du 16 novembre)
	var paies := []
	for mi in m.missions:
		paies.append(mi.r)
	var mission0: int = m.mission_i
	var argent0: int = m.money
	m.mission_i = 2
	m.money = 0
	m._mission(Vector3(m.missions[2].x, 0, m.missions[2].z))
	var paye: int = m.money
	m.mission_i = mission0
	m.money = argent0
	m._set_mission()
	if paies != [5000, 7500, 3000] or paye != 3000:
		err = "missions : elles paient %s FCFA (attendu 5 000, 7 500 et 3 000) ; la troisième verse %d" % [str(paies), paye]
		return
	var cl = z.clients[2]
	var spot: Vector3 = z.spot_pos(2)
	var money0: int = m.money
	# à pied ou en voiture, les clients ne montent pas
	pl.teleport(spot + Vector3(0, 0, -2.0), 0.0)
	z.step(m, DT)
	var car = m.cars[0]
	var car_p: Vector3 = car.global_position
	var car_h: float = car.heading
	_put(car, spot.x, spot.z - 4.3, EST, 0.0)
	m.cur_car = car
	z.step(m, DT)
	m.cur_car = null
	_put(car, car_p.x, car_p.z, car_h, 0.0)
	if cl.state != "attend" or not z.fare.is_empty() or cl.p.armR.rotation.x != 0.0:
		err = "passager : un client monte ou fait signe alors que le joueur n'est pas à moto"
		return
	# à moto, en roulant : le client lève le bras, il ne monte pas tant qu'on roule
	pl.teleport(c.global_position + Vector3(1.5, 0, 0), 0.0)
	m.mount(c)
	_put(c, spot.x, spot.z - 4.3, EST, 12.0)
	z.step(m, DT)
	if cl.state != "attend" or not z.fare.is_empty() or cl.p.armR.rotation.x > -2.0 or z.hint == "" or z.clients[0].p.armR.rotation.x != 0.0:
		err = "passager : le client ne fait pas signe à la moto qui approche, ou monte en marche"
		return
	# arrêt près de lui : il annonce sa destination et son prix, mais ne monte pas tout seul
	c.speed = 0.0
	for i in 30:
		z.step(m, DT)
	if not z.fare.is_empty() or z.offer.is_empty() or z.offer.cl != cl or c.loaded or not cl.n.visible or not ("M : accepter" in z.hint) or not (str(z.offer.prix) in z.hint):
		err = "passager : le client monte sans accord, ou ne propose pas sa course (« %s »)" % z.hint
		return
	# le joueur peut refuser en repartant : rien ne se passe
	c.speed = 8.0
	z.step(m, DT)
	if not z.offer.is_empty() or not z.fare.is_empty():
		err = "passager : la proposition reste valable alors que la moto est repartie"
		return
	# la touche M : celle qui porte la lettre M sur un clavier AZERTY (place du point-virgule
	# QWERTY) ou QWERTY ; pas la place du M QWERTY (virgule en AZERTY), et pas la touche E
	var t_azerty := InputEventKey.new()
	t_azerty.physical_keycode = KEY_SEMICOLON
	t_azerty.keycode = KEY_M
	var t_qwerty := InputEventKey.new()
	t_qwerty.physical_keycode = KEY_M
	t_qwerty.keycode = KEY_M
	var t_virgule := InputEventKey.new()
	t_virgule.physical_keycode = KEY_M
	t_virgule.keycode = KEY_COMMA
	var t_e := InputEventKey.new()
	t_e.physical_keycode = KEY_E
	t_e.keycode = KEY_E
	if not InputMap.event_is_action(t_azerty, "course") or not InputMap.event_is_action(t_qwerty, "course") or InputMap.event_is_action(t_virgule, "course") or InputMap.event_is_action(t_e, "course") or InputMap.event_is_action(t_azerty, "enter") or not InputMap.event_is_action(t_e, "enter"):
		err = "passager : la touche M n'est pas celle de la course, ou E l'est encore"
		return
	# E devant le client : E ne sert qu'à descendre, la course n'est pas acceptée
	c.speed = 0.0
	z.step(m, DT)
	m.press_e()
	z.step(m, DT)
	if m.cur_car != null or not z.fare.is_empty() or c.loaded or cl.state != "attend":
		err = "passager : E accepte encore la course au lieu de faire descendre le pilote"
		return
	m.mount(c)
	# M : la course est acceptée, le client monte, la colonne bleue montre l'arrivée
	Input.action_press("course")
	z.step(m, DT)
	var monte: bool = not z.fare.is_empty()
	z.step(m, DT)   # touche tenue : rien de plus (le client ne redescend pas)
	Input.action_release("course")
	z.step(m, DT)
	c.drive(DT)
	if not monte:
		err = "passager : la touche M n'accepte pas la course"
		return
	if m.cur_car != c:
		err = "passager : M devant un client fait descendre le pilote"
		return
	if z.fare.is_empty() or z.fare.cl != cl or not c.loaded or not c.passenger.visible or cl.n.visible or not z.dest_marker.visible:
		err = "passager : le client ne monte pas à l'arrière de la moto arrêtée"
		return
	var dest: int = z.fare.dest
	var prix: int = z.fare.prix
	var trajet: float = _d(spot, z.spot_pos(dest))
	if dest == 2 or trajet < 60.0 or prix != z.tarif(trajet) or prix < 100 or prix > 1000 or _d(z.dest_marker.position, z.spot_pos(dest)) > 0.01 or m.info_t <= 0.0:
		err = "passager : destination ou prix faux (%d FCFA pour %.0f m)" % [prix, trajet]
		return
	# un seul client à la fois
	var s0: Vector3 = z.spot_pos(0)
	_put(c, s0.x - 4.3, s0.z, 0.0, 0.0)
	z.step(m, DT)
	if z.fare.cl != cl or not z.offer.is_empty() or z.clients[0].state != "attend" or z.clients[0].p.armR.rotation.x != 0.0:
		err = "passager : un second client monte ou fait signe alors que la moto est prise"
		return
	# la moto chargée est plus lourde : elle accélère, freine et se couche moins vite
	var mes := []
	for charge in [false, true]:
		c.loaded = charge
		_put(c, -150, -178, EST, 0.0)
		_run(c, 1.0, ["up"])
		var v1: float = c.speed
		_put(c, -150, -178, EST, 25.0)
		_run(c, 2.0, ["down"])
		var df: float = c.global_position.x + 150.0
		_put(c, -150, -178, EST, 15.0)
		_run(c, 0.15, ["left"])
		mes.append([v1, df, c.lean])
	if mes[1][0] > mes[0][0] * 0.9 or mes[1][0] < mes[0][0] * 0.75 or mes[1][1] < mes[0][1] * 1.05 or mes[1][1] > mes[0][1] * 1.25 or mes[1][2] >= mes[0][2] * 0.95 or mes[1][2] <= 0.0:
		err = "passager : la moto chargée ne se conduit pas comme prévu (%.1f contre %.1f m/s, %.1f contre %.1f m)" % [mes[1][0], mes[0][0], mes[1][1], mes[0][1]]
		return
	# arrivée : rien tant qu'on roule ; à l'arrêt le client descend et paie
	var sd: Vector3 = z.spot_pos(dest)
	_put(c, sd.x + 4.3, sd.z, 0.0, 10.0)
	z.step(m, DT)
	if z.fare.is_empty() or m.money != money0 or z.hint == "":
		err = "passager : la course est payée sans s'arrêter"
		return
	c.speed = 0.0
	z.step(m, DT)
	c.drive(DT)
	if not z.fare.is_empty() or m.money != money0 + prix or c.loaded or c.passenger.visible or z.dest_marker.visible or z.done != 1:
		err = "passager : la course n'est pas payée à l'arrivée (%d FCFA)" % (m.money - money0)
		return
	if cl.state != "part" or not cl.n.visible or _d(cl.n.position, sd) > 2.0 or _d(cl.n.position, z.clients[dest].n.position) < 1.0:
		err = "passager : le client n'est pas descendu sur le trottoir de l'arrivée"
		return
	# il s'en va, puis un client attend de nouveau à son point de départ
	_put(c, -150, -178, EST, 0.0)
	for i in int((z.T_PART + 0.5) * 60.0):
		z.step(m, DT)
	if cl.state != "absent" or cl.n.visible:
		err = "passager : le client déposé ne s'en va pas"
		return
	for i in int(z.T_RETOUR * 60.0):
		z.step(m, DT)
	if cl.state != "attend" or not cl.n.visible or _d(cl.n.position, spot) > 0.01:
		err = "passager : aucun client ne revient attendre"
		return
	# M avec un client à bord : il descend ici, sans payer ; E : le pilote descend
	_put(c, sd.x + 4.3, sd.z, 0.0, 0.0)
	z.step(m, DT)
	z.press(m)
	var cl2 = z.clients[dest]
	if z.fare.is_empty() or z.fare.cl != cl2 or z.fare.dest == dest:
		err = "passager : le client suivant ne monte pas"
		return
	var money1: int = m.money
	z.press(m)
	if m.cur_car != c or not z.fare.is_empty() or m.money != money1 or c.loaded or cl2.state != "part" or not cl2.n.visible or _d(cl2.n.position, c.global_position) > 2.0:
		err = "passager : M ne dépose pas le client (ou la course interrompue est payée)"
		return
	z.step(m, DT)
	m.press_e()
	if m.cur_car != null or not z.fare.is_empty():
		err = "passager : après avoir déposé le client, E ne fait pas descendre le pilote"
		return
	# E avec un client à bord : le pilote descend, le client aussi, la course n'est pas payée
	m.mount(c)
	_put(c, s0.x - 4.3, s0.z, 0.0, 0.0)
	z.step(m, DT)
	z.press(m)
	var cl3 = z.clients[0]
	if z.fare.is_empty() or z.fare.cl != cl3:
		err = "passager : pas de client pour l'essai de descente"
		return
	m.press_e()
	z.step(m, DT)
	if m.cur_car != null or not z.fare.is_empty() or c.loaded or m.money != money1 or cl3.state != "part":
		err = "passager : E avec un client à bord ne fait pas descendre le pilote et son client"
		return
	# chute avec un client : il tombe, se relève et repart à pied ; course perdue (décisions 4 et 53)
	for i in int((z.T_PART + z.T_RETOUR + 0.5) * 60.0):
		z.step(m, DT)
	m.mount(c)
	_put(c, s0.x - 4.3, s0.z, 0.0, 0.0)
	z.step(m, DT)
	z.press(m)
	if z.fare.is_empty() or z.fare.cl != cl3:
		err = "passager : pas de client pour l'essai de chute"
		return
	c.hit(12.0, true)
	if not c.fallen or m.cur_car != null or not z.fare.is_empty() or c.loaded or m.money != money1 or cl3.state != "tombe" or cl3.n.rotation.x > -1.0 or _d(cl3.n.position, c.global_position) > 2.0 or _d(cl3.n.position, pl.global_position) < 1.0 or abs(pl.health - 80.0) > 0.01:
		err = "passager : chute avec un client mal gérée (santé %.0f)" % pl.health
		return
	for i in int((z.T_TOMBE + 0.2) * 60.0):
		z.step(m, DT)
	if cl3.state != "part" or abs(cl3.n.rotation.x) > 0.001 or not cl3.n.visible:
		err = "passager : le client tombé ne se relève pas"
		return
	print("missions : 5 000, 7 500 et 3 000 FCFA · passager à l'arrière : %d clients au bord des routes ; le client propose, M accepte (E ne fait que descendre) ; course de %.0f m = %d FCFA, payée à l'arrêt devant l'arrivée ; moto chargée : %.0f km/h après 1 s au lieu de %.0f, freinage sur %.1f m au lieu de %.1f ; M dépose le client sans paiement ; chute : le client tombe, se relève et s'en va" % [z.clients.size(), trajet, prix, mes[1][0] * 3.6, mes[0][0] * 3.6, mes[1][1], mes[0][1]])

# ---------------- passage entre les voitures : le joueur ----------------
func _passage(m, c) -> void:
	m.mount(c)
	# 1,4 m entre deux voitures arrêtées : la moto passe sans rien toucher
	_put(c, -200, -178, EST, 10.0)
	_run(c, 1.5, ["up"])
	if c.global_position.x < -180.0 or c.fallen or c.damage > 0.0 or abs(c.global_position.z + 178.0) > 0.05 or file[0].damage > 0.0 or file[1].damage > 0.0:
		err = "passage : la moto ne passe pas entre deux voitures séparées de 1,4 m (x = %.1f, dégâts %.0f)" % [c.global_position.x, c.damage]
		return
	var v_passe: float = c.speed
	# 0,4 m : elle ne passe pas, et à faible vitesse le pilote ne tombe pas
	_put(c, -193, -175.1, EST, 6.0)
	_run(c, 1.2)
	_run(c, 2.0, ["up"])
	if c.global_position.x > -187.5 or c.fallen:
		err = "passage : la moto traverse deux voitures séparées de 0,4 m (x = %.1f)" % c.global_position.x
		return
	# une voiture ne passe pas là où la moto passe
	m.toggle_car()
	var car = m.cars[0]
	var car_p: Vector3 = car.global_position
	var car_h: float = car.heading
	m.cur_car = car
	_put(car, -200, -178, EST, 4.0)
	_run(car, 2.5, ["up"])
	var x_car: float = car.global_position.x
	m.cur_car = null
	car.repair()
	_put(car, car_p.x, car_p.z, car_h, 0.0)
	if x_car > -188.0:
		err = "passage : une voiture passe entre les deux voitures (x = %.1f)" % x_car
		return
	print("passage entre les voitures : 1,4 m de large, la moto passe à %.0f km/h sans rien toucher ; 0,4 m, elle reste derrière ; une voiture ne passe pas" % (v_passe * 3.6))

# ---------------- on roule à droite ----------------
# Chaque véhicule de la circulation qui roule en ligne droite doit être à droite de l'axe de sa route.
func _droite(m, _c) -> void:
	var n := 0
	for a in m.traffic:
		var f := Vector3(sin(a.heading), 0, cos(a.heading))
		var p: Vector3 = a.global_position
		var ecart := 0.0
		if abs(f.x) > 0.999:
			var best := 999.0
			for zr in [-160.0, -120.0, 0.0, 120.0]:
				if abs(p.z - zr) < abs(best):
					best = p.z - zr
			ecart = best * f.x      # à droite d'un cap à l'est : vers +z
		elif abs(f.z) > 0.999:
			var best := 999.0
			for xr in [-120.0, 0.0, 120.0]:
				if abs(p.x - xr) < abs(best):
					best = p.x - xr
			ecart = -best * f.z     # à droite d'un cap vers +z : vers -x
		else:
			continue   # en plein virage
		n += 1
		if ecart < 2.0 or ecart > 5.0:
			err = "sens de circulation : un véhicule ne roule pas à droite (%.1f m de l'axe, en %.0f ; %.0f)" % [ecart, p.x, p.z]
			return
	if n < 15:
		err = "sens de circulation : trop peu de véhicules vérifiés (%d)" % n
		return
	print("sens de circulation : %d véhicules en ligne droite, tous à droite de l'axe de leur route" % n)

# ---------------- passage entre les voitures : la circulation ----------------
func _faufile(m, c) -> void:
	# une file sur le grand tour : une voiture arrêtée, une moto puis une voiture qui arrivent derrière
	var motos := []
	var autos := []
	for a in m.traffic:
		if a.vmax == 14.0:
			(motos if a.moto else autos).append(a)
	if motos.is_empty() or autos.size() < 2:
		err = "faufilage : pas assez de véhicules sur le grand tour"
		return
	var x = autos[0]
	var y = autos[1]
	var mo = motos[0]
	var k := 0
	for a in motos + autos:
		if a != x and a != y and a != mo:
			a.dist = 400.0 + 70.0 * k
			k += 1
	x.dist = 160.0
	x.vmax = 0.0
	x.speed = 0.0
	mo.dist = 130.0
	y.dist = 112.0
	for a in motos + autos:
		a.side = 0.0
		a.side_want = 0.0
		a.place_on_path()
	var f := Vector3(1, 0, 0)
	var l := Vector3(0, 0, -1)
	var xp: Vector3 = x.global_position
	# on roule à droite : la voie doit être à droite de l'axe de sa route (z = 120), cap à l'est
	if xp.z < 120.5 or abs(x.heading - EST) > 0.01 or m.trafic.blocked_by(m, x, Vector3(0, 0, -178))[0]:
		err = "faufilage : la voiture d'essai n'est pas seule sur sa voie"
		return
	# le joueur à moto droit devant une voiture : elle s'arrête ; à côté, dans le couloir : elle roule
	m.mount(c)
	_put(c, xp.x + 5.0, xp.z, EST, 0.0)
	var devant: Array = m.trafic.blocked_by(m, x, c.global_position)
	_put(c, xp.x + 5.0, xp.z - 1.9, EST, 0.0)
	var a_cote: Array = m.trafic.blocked_by(m, x, c.global_position)
	_put(c, 0, -178, EST, 0.0)
	# une voiture à la même place gêne toujours
	var car = m.cars[0]
	var car_p: Vector3 = car.global_position
	var car_h: float = car.heading
	_put(car, xp.x + 5.0, xp.z - 1.9, EST, 0.0)
	var auto_cote: Array = m.trafic.blocked_by(m, x, c.global_position)
	_put(car, car_p.x, car_p.z, car_h, 0.0)
	if not devant[0] or not devant[1] or a_cote[0] or not auto_cote[0]:
		err = "faufilage : une voiture réagit mal à ce qui est devant elle (moto devant %s, moto à côté %s, voiture à côté %s)" % [devant[0], a_cote[0], auto_cote[0]]
		return
	# la moto de la circulation remonte la file par le couloir, au pas ; la voiture reste derrière
	var pp: Vector3 = c.global_position
	var ecart_min := 99.0
	var v_max := 0.0
	var t_passe := -1.0
	var cote_axe := true
	for i in 900:
		m.trafic.step(m, DT, pp)
		var dv: Vector3 = mo.global_position - xp
		var lon: float = dv.dot(f)
		if abs(lon) < 3.2:
			ecart_min = min(ecart_min, abs(dv.dot(l)))
			cote_axe = cote_axe and dv.dot(l) > 0.0   # côté axe de la route, pas côté trottoir
			v_max = max(v_max, mo.speed)
		if abs((mo.global_position - y.global_position).dot(f)) < 3.2 and abs((mo.global_position - y.global_position).dot(l)) < 1.4:
			err = "faufilage : la moto traverse la voiture qui la suit"
			return
		if t_passe < 0.0 and lon > 8.0:
			t_passe = (i + 1) * DT
	if t_passe < 0.0 or t_passe > 10.0:
		err = "faufilage : la moto reste bloquée derrière la voiture arrêtée"
		return
	if ecart_min < 1.6 or ecart_min > 2.5 or v_max > mo.FAUFILE_V + 0.5 or not cote_axe:
		err = "faufilage : la moto passe trop près ou trop vite (%.2f m, %.1f m/s)" % [ecart_min, v_max]
		return
	if abs(mo.side) > 0.01 or mo.speed < 10.0:
		err = "faufilage : la moto ne reprend pas sa voie et sa vitesse après la file (écart %.2f m, %.1f m/s)" % [mo.side, mo.speed]
		return
	var reste: float = (xp - y.global_position).dot(f)
	if reste < 5.0 or reste > 9.0 or y.speed > 0.5 or y.side != 0.0 or x.dist != 160.0:
		err = "faufilage : la voiture ne reste pas dans la file (%.1f m derrière, %.1f m/s)" % [reste, y.speed]
		return
	print("passage entre les voitures, circulation : une voiture s'arrête pour une moto droit devant, pas pour une moto dans le couloir ; la moto remonte la file à %.2f m de la voiture, à %.0f km/h au plus, en %.1f s, puis reprend sa voie ; la voiture attend %.1f m derrière" % [ecart_min, v_max * 3.6, t_passe, reste])
