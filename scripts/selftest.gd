extends RefCounted
# Test automatique sans écran : lancé avec « -- --selftest ».
# main.gd appelle step() à chaque image ; le test doit finir par « SELFTEST OK ».

const VoitureTest := preload("res://scripts/selftest_voiture.gd")
const MotoTest := preload("res://scripts/selftest_moto.gd")
const MotoVilleTest := preload("res://scripts/selftest_moto_ville.gd")
const CirculationTest := preload("res://scripts/selftest_circulation.gd")
const TactileTest := preload("res://scripts/selftest_tactile.gd")
var tactile   # dernière partie : quelques secondes de vrai jeu au doigt
var voiture
var moto_ville
var start := Vector3.ZERO
var max_y := 0.0
var d_walk := 0.0

func step(m) -> void:
	if tactile != null:
		var r: String = tactile.live(m)
		if r == "OK":
			print("SELFTEST OK")
			m.get_tree().quit(0)
		elif r != "":
			_fail(m, r)
		return
	var f: int = m.frames
	var pl = m.player
	max_y = max(max_y, pl.global_position.y)
	if f == 4:
		if m.road_segs.size() != 7 or m.minimap == null or not m.minimap.is_inside_tree():
			_fail(m, "mini-carte absente ou routes manquantes")
			return
		if m.menu_title.text != "MARINA CITY" or ProjectSettings.get_setting("application/config/name") != "Marina City":
			_fail(m, "le titre du jeu n'est pas « Marina City »")
			return
		m.open_menu("PAUSE", "Reprendre")
		start = m.traffic[0].global_position
	elif f == 8:
		if m.traffic[0].global_position.distance_to(start) > 0.01:
			_fail(m, "la pause ne fige pas le jeu")
			return
		m._play()
		print("menu : pause et reprise OK · mini-carte présente")
	elif f == 10:
		# la voiture rouge garée près du départ (le véhicule le plus proche est la moto de Romaric)
		m.mount(m.cars[0])
		if m.cur_car == null:
			_fail(m, "impossible de monter dans la voiture")
			return
		start = m.cur_car.global_position
		Input.action_press("up")
	elif f == 250:
		Input.action_release("up")
		var d: float = m.cur_car.global_position.distance_to(start)
		if d < 20.0:
			_fail(m, "la voiture n'a pas avancé (%.1f m)" % d)
			return
		print("conduite : %.1f m parcourus, %.0f km/h" % [d, m.cur_car.speed * 3.6])
		m.cur_car.speed = 0.0
		m.toggle_car()
		if m.cur_car != null or not pl.visible:
			_fail(m, "impossible de descendre")
			return
		start = pl.global_position
		Input.action_press("up")
	elif f == 370:
		d_walk = pl.global_position.distance_to(start)
		if d_walk < 3.0:
			_fail(m, "le héros ne marche pas (%.1f m)" % d_walk)
			return
		var moved := 0
		for a in m.traffic:
			if a.speed > 1.0:
				moved += 1
		print("marche : %.1f m · circulation : %d/%d véhicules en mouvement" % [d_walk, moved, m.traffic.size()])
		# la suite se passe sur la plage : terrain plat, sans obstacle ni circulation
		_to_beach(pl)
		Input.action_press("run")
	elif f == 430:
		# course : 1 seconde en ligne droite, nettement plus vite que la marche
		Input.action_release("run")
		Input.action_release("up")
		var d_run: float = pl.global_position.distance_to(start)
		if d_run < 8.0 or d_run > 11.0:
			_fail(m, "course : %.1f m en 1 s (attendu environ 10 m)" % d_run)
			return
		print("course : %.1f m en 1 s" % d_run)
		max_y = 0.0
		Input.action_press("jump")
	elif f == 432:
		Input.action_release("jump")
		if pl.on_ground:
			_fail(m, "saut : le héros ne décolle pas")
			return
		# pas de second saut en l'air
		if pl.jump():
			_fail(m, "saut : double saut possible en l'air")
			return
	elif f == 490:
		if max_y < 0.9 or max_y > 1.6:
			_fail(m, "saut : hauteur %.2f m (attendu environ 1,2 m)" % max_y)
			return
		if not pl.on_ground or pl.global_position.y > 0.001:
			_fail(m, "saut : le héros ne retombe pas au sol")
			return
		print("saut : %.2f m de haut, retour au sol OK" % max_y)
		_to_beach(pl)
		Input.action_press("crouch")
	elif f == 550:
		# accroupi : lent, capsule plus basse, saut interdit
		var d_c: float = pl.global_position.distance_to(start)
		if not pl.crouching or pl.capsule.height > 1.3:
			_fail(m, "accroupi : le héros ne se baisse pas")
			return
		if d_c < 1.8 or d_c > 3.2:
			_fail(m, "accroupi : %.1f m en 1 s (attendu environ 2,5 m)" % d_c)
			return
		if pl.jump():
			_fail(m, "accroupi : saut possible en position accroupie")
			return
		Input.action_release("crouch")
		print("accroupi : %.1f m en 1 s, capsule %.1f m" % [d_c, pl.capsule.height])
	elif f == 600:
		Input.action_release("up")
		if pl.crouching or pl.capsule.height < 1.85 or pl.body.scale.y < 0.95:
			_fail(m, "accroupi : le héros ne se relève pas")
			return
		# caméra à la troisième personne : derrière le héros, à bonne distance, et elle le regarde
		var head: Vector3 = pl.global_position + Vector3(0, 1.6, 0)
		var to_head: Vector3 = head - m.cam.global_position
		var dist: float = to_head.length()
		var fwd := Vector3(sin(pl.heading), 0, cos(pl.heading))
		var ang: float = rad_to_deg((-m.cam.global_transform.basis.z).angle_to(to_head))
		if dist < 4.0 or dist > 9.0:
			_fail(m, "caméra : distance au héros %.1f m" % dist)
			return
		if to_head.normalized().dot(fwd) < 0.7:
			_fail(m, "caméra : elle n'est pas derrière le héros")
			return
		if ang > 10.0 or m.cam.global_position.y < 2.0:
			_fail(m, "caméra : elle ne regarde pas le héros (écart %.0f°)" % ang)
			return
		print("caméra : %.1f m derrière le héros, écart de visée %.1f°" % [dist, ang])
		# nage : le héros entre dans la mer en marchant vers le sud
		_place(pl, Vector3(-60, 0, -190), PI)
	elif f > 600:
		_step2(m, f, pl)

# Suite du test : nage, chute et santé, franchissement, interactions.
func _step2(m, f: int, pl) -> void:
	var swim_y: float = m.WATER_Y - pl.NAGE_FOND
	if f == 720:
		if not pl.swimming or abs(pl.global_position.y - swim_y) > 0.05:
			_fail(m, "nage : le héros ne flotte pas (y = %.2f)" % pl.global_position.y)
			return
		if pl.jump():
			_fail(m, "nage : saut possible dans l'eau")
			return
		start = pl.global_position
	elif f == 780:
		var d: float = pl.global_position.distance_to(start)
		if d < 2.0 or d > 3.0:
			_fail(m, "nage : %.1f m en 1 s (attendu environ 2,5 m)" % d)
			return
		if pl.body.rotation.x < 0.8:
			_fail(m, "nage : le corps ne s'allonge pas")
			return
		d_walk = d
		pl.heading = 0.0   # demi-tour vers la plage
	elif f == 960:
		if pl.swimming or pl.wading or abs(pl.global_position.y) > 0.001 or pl.global_position.z < -193.0:
			_fail(m, "nage : le héros ne ressort pas de l'eau (z = %.1f)" % pl.global_position.z)
			return
		Input.action_release("up")
		# plongeon de 6 m dans l'eau profonde : pas de blessure
		pl.teleport(Vector3(-60, 6, -215), PI)
	elif f == 1020:
		if not pl.swimming or pl.health < 100.0 or pl.last_fall < 6.0:
			_fail(m, "plongeon : nage %s, santé %.0f, chute %.1f m" % [pl.swimming, pl.health, pl.last_fall])
			return
		print("nage : %.1f m en 1 s, sortie de l'eau OK, plongeon de %.1f m sans blessure" % [d_walk, pl.last_fall])
		# petite chute : sans mal
		pl.teleport(Vector3(-60, 2.5, -178), PI)
	elif f == 1060:
		if not pl.on_ground or pl.health < 100.0 or abs(pl.last_fall - 2.5) > 0.2:
			_fail(m, "chute de 2,5 m : santé %.0f, chute mesurée %.1f m" % [pl.health, pl.last_fall])
			return
		pl.teleport(Vector3(-60, 8, -178), PI)
	elif f == 1130:
		# 8 m : (8 - 3) x 11 = 55 points perdus
		if abs(pl.health - 45.0) > 3.0:
			_fail(m, "chute de 8 m : santé %.0f (attendu environ 45)" % pl.health)
			return
		if m.hp_fill.size.x > 100.0:
			_fail(m, "santé : la jauge ne suit pas")
			return
		d_walk = pl.health
		pl.teleport(Vector3(-60, 14, -178), PI)
	elif f == 1220:
		if pl.health > 0.0 or pl.ko_t <= 0.0:
			_fail(m, "chute de 14 m : le héros devrait s'évanouir (santé %.0f)" % pl.health)
			return
	elif f == 1400:
		if pl.ko_t > 0.0 or pl.health < 100.0 or pl.global_position.distance_to(m.SPAWN) > 1.0:
			_fail(m, "évanouissement : pas de réveil place de l'Amazone")
			return
		print("chute : 2,5 m sans mal, 8 m laisse %.0f de santé, 14 m évanouissement puis réveil" % d_walk)
		# la santé remonte seule après 10 s sans blessure
		pl.health = 50.0
		pl.hurt_t = 0.0
		# muret de la Marina : Espace devant le muret, puis on continue vers la plage
		_place(pl, Vector3(-60, 0, -166), PI)
	elif f == 1430:
		Input.action_press("jump")
	elif f == 1432:
		Input.action_release("jump")
		if pl.mantle_t <= 0.0:
			_fail(m, "muret : le héros ne monte pas dessus")
			return
	elif f == 1460:
		if pl.global_position.y < 0.9:
			_fail(m, "muret : le héros n'est pas passé par le dessus (y = %.2f)" % pl.global_position.y)
			return
	elif f == 1530:
		if pl.global_position.z > -168.3 or abs(pl.global_position.y) > 0.001 or pl.health < 50.0:
			_fail(m, "muret : pas franchi (z = %.1f, y = %.2f)" % [pl.global_position.z, pl.global_position.y])
			return
		print("muret : franchi, héros de l'autre côté à z = %.1f" % pl.global_position.z)
		# mur trop haut (halle du marché) : Espace reste un saut normal
		_place(pl, Vector3(105, 0, 103), PI)
	elif f == 1560:
		Input.action_press("jump")
	elif f == 1562:
		Input.action_release("jump")
		if pl.mantle_t > 0.0 or pl.on_ground:
			_fail(m, "mur haut : le héros ne devrait pas l'escalader")
			return
	elif f == 1600:
		# caisses empilées : 6 marches de 1,33 m jusqu'au toit de la halle
		_place(pl, Vector3(86.4, 0, 105), PI)
	elif f >= 1630 and f < 1990:
		var k: int = (f - 1630) % 60
		if k == 0:
			Input.action_press("jump")
		elif k == 2:
			Input.action_release("jump")
			if pl.mantle_t <= 0.0:
				_fail(m, "caisses : marche %d non franchie (y = %.2f)" % [(f - 1630) / 60 + 1, pl.global_position.y])
				return
		elif k == 35:
			# une fois sur la caisse : vers l'est, puis vers le toit après la dernière
			pl.heading = PI if f > 1930 else PI / 2
	elif f == 2030:
		if abs(pl.global_position.y - 8.0) > 0.05 or pl.global_position.z > 100.5 or not pl.on_ground:
			_fail(m, "caisses : le héros n'est pas sur le toit (y = %.2f, z = %.1f)" % [pl.global_position.y, pl.global_position.z])
			return
		if pl.health < 50.3 or pl.health > 53.0:
			_fail(m, "santé : elle ne remonte pas après 10 s sans blessure (%.0f)" % pl.health)
			return
		pl.health = 100.0
		# on quitte le toit par le nord, loin des caisses
		_place(pl, Vector3(105, 8, 97), 0.0)
	elif f == 2150:
		Input.action_release("up")
		if abs(pl.global_position.y) > 0.001 or abs(pl.last_fall - 8.0) > 0.2 or abs(pl.health - 45.0) > 3.0:
			_fail(m, "toit : chute %.1f m, santé %.0f" % [pl.last_fall, pl.health])
			return
		print("caisses : toit de la halle atteint à 8 m, chute du toit, santé %.0f" % pl.health)
		# ponton : on monte par le bout côté plage, on court jusqu'au bout, on tombe à l'eau
		_place(pl, Vector3(-100, 0, -184.5), PI)
	elif f == 2180:
		Input.action_press("jump")
	elif f == 2182:
		Input.action_release("jump")
		if pl.mantle_t <= 0.0:
			_fail(m, "ponton : impossible d'y monter depuis la plage")
			return
	elif f == 2240:
		if abs(pl.global_position.y - 1.0) > 0.05 or not pl.on_ground or pl.global_position.z > -186.5:
			_fail(m, "ponton : le héros n'est pas dessus (y = %.2f)" % pl.global_position.y)
			return
		Input.action_press("run")
	elif f == 2570:
		Input.action_release("run")
		Input.action_release("up")
		if not pl.swimming or pl.global_position.z > -232.0 or abs(pl.health - 45.0) > 3.0:
			_fail(m, "ponton : pas de plongeon au bout (z = %.1f, nage %s)" % [pl.global_position.z, pl.swimming])
			return
		var z_dive: float = pl.global_position.z
		# ligne de bouées : 4 secondes de nage vers le large ne la font pas dépasser
		pl.teleport(Vector3(-60, m.WATER_Y - pl.NAGE_FOND, -256), PI)
		Input.action_press("up")
		for i in 240:
			pl.walk(m, 1.0 / 60.0)
		Input.action_release("up")
		if not pl.swimming or pl.global_position.z < -262.0 or pl.global_position.z > -259.0:
			_fail(m, "bouées : le héros n'est pas arrêté à la limite (z = %.1f)" % pl.global_position.z)
			return
		print("ponton : montée depuis la plage, plongeon au bout (z = %.1f) · bouées : nage arrêtée à z = %.1f" % [z_dive, pl.global_position.z])
		_interactions(m, pl)
	elif f == 2574 and voiture != null:
		var e: String = voiture.run(m)
		if e == "":
			e = MotoTest.new().run(m)
		if e == "":
			e = CirculationTest.new().run(m)   # remet la circulation comme au lancement
		if e == "":
			e = moto_ville.run(m)
		if e == "":
			e = m.sys.selftest(m)   # sauvegarde, menus, affichage en jeu
		if e != "":
			_fail(m, e)
			return
		tactile = TactileTest.new()   # SELFTEST OK sera écrit à la fin de cette partie

# Interactions : étal d'eau, banc, panneau. Tout se fait dans la même image.
func _interactions(m, pl) -> void:
	var eau: Dictionary = m.inter.items[0]
	var banc: Dictionary = m.inter.items[2]
	var panneau: Dictionary = m.inter.items[5]
	if eau.kind != "eau" or banc.kind != "banc" or panneau.kind != "panneau":
		_fail(m, "interactions : objets manquants")
		return
	var h0: float = pl.health
	pl.teleport(Vector3(60, 0, 60), 0.0)
	m.money = 500
	m.press_e()
	if m.money != 500 or not m.inter.nearest(m).is_empty():
		_fail(m, "interactions : E agit sans objet à portée")
		return
	pl.teleport(eau.pos, PI)
	m.money = 50
	m.press_e()
	if m.money != 50 or pl.health != h0:
		_fail(m, "eau : vendue sans assez d'argent")
		return
	m.money = 500
	m.press_e()
	if m.money != 400 or abs(pl.health - h0 - 25.0) > 0.01:
		_fail(m, "eau : argent %d, santé %.0f" % [m.money, pl.health])
		return
	pl.teleport(panneau.pos + Vector3(0, 0, 1.2), PI)
	m.info_t = 0.0
	m.press_e()
	if m.info_t <= 0.0 or not m.info_text.begins_with("Place de l'Amazone"):
		_fail(m, "panneau : texte non affiché")
		return
	pl.teleport(banc.pos + Vector3(1.0, 0, 0), PI)
	m.press_e()
	if not pl.sitting or m.cur_car != null:
		_fail(m, "banc : le héros ne s'assoit pas")
		return
	h0 = pl.health
	for i in 60:
		pl.walk(m, 1.0 / 60.0)
	if not pl.sitting or pl.health < h0 + 5.0:
		_fail(m, "banc : la santé ne remonte pas assis (%.0f)" % pl.health)
		return
	Input.action_press("up")
	pl.walk(m, 1.0 / 60.0)
	Input.action_release("up")
	if pl.sitting:
		_fail(m, "banc : le héros ne se relève pas")
		return
	print("interactions : eau achetée (400 FCFA restants), panneau lu, banc et repos OK")
	# la plage reste fermée aux voitures : une voiture lancée vers la mer s'arrête avant l'eau
	var c = m.cars[1]
	c.global_position = Vector3(-60, 0, -180)
	c.heading = PI
	c.speed = 15.0
	Input.action_press("up")
	for i in 120:
		c.drive(1.0 / 60.0)
	Input.action_release("up")
	if c.global_position.z < -189.5:
		_fail(m, "plage : une voiture peut rouler dans la mer (z = %.1f)" % c.global_position.z)
		return
	c.speed = 0.0
	print("plage : voiture arrêtée avant la mer à z = %.1f" % c.global_position.z)
	# conduite voiture : la voiture-obstacle est posée maintenant, le test tourne 4 images plus tard
	voiture = VoitureTest.new()
	voiture.prepare(m)
	moto_ville = MotoVilleTest.new()
	moto_ville.prepare(m)

# Place le héros quelque part et le fait avancer.
func _place(pl, pos: Vector3, h: float) -> void:
	pl.teleport(pos, h)
	start = pos
	Input.action_press("up")

# Place le héros sur la plage, tourné vers l'est, et le fait avancer.
func _to_beach(pl) -> void:
	pl.global_position = Vector3(-60, 0, -178)
	pl.heading = PI / 2
	start = pl.global_position
	Input.action_press("up")

func _fail(m, msg: String) -> void:
	print("SELFTEST ECHEC : " + msg)
	m.get_tree().quit(1)
