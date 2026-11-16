extends RefCounted
# Test automatique de la conduite voiture : direction, frein à main, marche arrière,
# suspension, collisions, dégâts visibles, santé du conducteur, feux, klaxon, caméra. Appelé par selftest.gd, tout dans la même image.
# Terrain d'essai : la plage (plate, fermée à la circulation), voiture tournée vers l'est.

const DT := 1.0 / 60.0
const EST := PI / 2
var err := ""
var last_d := 0.0   # distance parcourue pendant le dernier virage d'essai

# Pose la voiture-obstacle sur la plage. À appeler quelques images avant run() :
# le moteur physique ne prend en compte un véhicule déplacé qu'à l'image suivante.
func prepare(m) -> void:
	_put(m.cars[2], 140, -178, EST, 0.0)

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	var c = m.cars[1]
	var b = m.cars[2]
	for t in [_direction, _frein_a_main, _marche_arriere, _suspension, _collisions, _degats, _sante, _feux, _klaxon, _camera]:
		_release()
		c.repair()
		b.repair()
		t.call(m, c, b)
		_release()
		if err != "":
			return err
	c.repair()
	b.repair()
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
	c.pitch = 0.0
	c.pitch_v = 0.0
	c.roll = 0.0
	c.roll_v = 0.0
	c.bounce = 0.0
	c.bounce_v = 0.0

func _run(c, secs: float, keys: Array = []) -> void:
	for k in keys:
		Input.action_press(k)
	for i in int(round(secs * 60.0)):
		c.drive(DT)
	for k in keys:
		Input.action_release(k)

# Angle parcouru en tournant 0,5 s sans accélérer, depuis la vitesse v.
func _turn(c, v: float, key: String, brake := false) -> float:
	_put(c, 0, -178, EST, v)
	_run(c, 0.5, [key, "brake"] if brake else [key])
	last_d = c.global_position.distance_to(Vector3(0, 0, -178))
	return angle_difference(EST, c.heading)

func _direction(_m, c, _b) -> void:
	# à l'arrêt, le volant ne fait pas pivoter la voiture
	if abs(_turn(c, 0.0, "left")) > 0.001:
		err = "direction : la voiture pivote à l'arrêt"
		return
	var l10 := _turn(c, 10.0, "left")
	var zl: float = c.global_position.z
	var r10 := _turn(c, 10.0, "right")
	var l30 := _turn(c, 30.0, "left")
	# gauche et droite symétriques ; à gauche de l'est, c'est le sud (z diminue)
	if l10 < 0.5 or l10 > 1.1 or abs(l10 + r10) > 0.02 or zl > -178.5 or c.global_position.z > -178.5:
		err = "direction : %.2f rad à gauche, %.2f à droite en 0,5 s à 36 km/h" % [l10, r10]
		return
	# plus on roule vite, moins la voiture tourne
	if l30 >= l10 * 0.85 or l30 < 0.2:
		err = "direction : à 108 km/h la voiture tourne autant qu'à 36 (%.2f contre %.2f rad)" % [l30, l10]
		return
	print("direction : %.0f° en 0,5 s à 36 km/h, %.0f° à 108 km/h, rien à l'arrêt, gauche et droite symétriques" % [rad_to_deg(l10), rad_to_deg(l30)])

func _frein_a_main(_m, c, _b) -> void:
	# roue libre : la voiture ralentit à peine
	_put(c, 0, -178, EST, 20.0)
	_run(c, 1.0)
	var v_libre: float = c.speed
	var d_libre: float = c.global_position.x
	# frein à main : presque arrêtée en 1 seconde, en quelques mètres
	_put(c, 0, -178, EST, 20.0)
	_run(c, 1.0, ["brake"])
	var v_frein: float = c.speed
	var d_frein: float = c.global_position.x
	if v_libre < 15.0 or v_frein > 1.5 or d_frein > 8.0 or d_frein < 2.0 or d_libre < 15.0:
		err = "frein à main : %.1f m/s après 1 s (%.1f m), contre %.1f m/s en roue libre" % [v_frein, d_frein, v_libre]
		return
	# il resserre le virage : presque le même angle, sur une distance bien plus courte
	var sans := _turn(c, 12.0, "left")
	var d_sans := last_d
	var avec := _turn(c, 12.0, "left", true)
	var d_avec := last_d
	if avec < sans * 0.8 or d_avec > d_sans * 0.6:
		err = "frein à main : le virage n'est pas plus serré (%.2f rad sur %.1f m contre %.2f rad sur %.1f m)" % [avec, d_avec, sans, d_sans]
		return
	print("frein à main : de 72 km/h à %.0f km/h en 1 s sur %.1f m ; virage de %.0f° sur %.1f m au lieu de %.0f° sur %.1f m" % [v_frein * 3.6, d_frein, rad_to_deg(avec), d_avec, rad_to_deg(sans), d_sans])

func _marche_arriere(_m, c, _b) -> void:
	_put(c, 100, -178, EST, 0.0)
	_run(c, 3.0, ["down"])
	var recul: float = 100.0 - c.global_position.x
	if abs(c.speed - c.MAXR) > 0.01 or recul < 12.0 or recul > 30.0 or abs(c.global_position.z + 178.0) > 0.01:
		err = "marche arrière : %.1f m/s, %.1f m de recul en 3 s" % [c.speed, recul]
		return
	# en reculant, le volant agit à l'envers (comme une vraie voiture) : l'arrière part à gauche
	_run(c, 0.5, ["down", "left"])
	var a := angle_difference(EST, c.heading)
	if a > -0.3:
		err = "marche arrière : la direction n'est pas inversée (%.2f rad)" % a
		return
	# « avancer » pendant qu'on recule freine fort puis repart en avant
	_put(c, 100, -178, EST, c.MAXR)
	_run(c, 0.5, ["up"])
	if c.speed < 0.0:
		err = "marche arrière : la voiture ne repart pas en avant (%.1f m/s)" % c.speed
		return
	print("marche arrière : plafonnée à %.0f km/h, %.1f m en 3 s, direction inversée, reprise en avant en moins de 0,5 s" % [-c.MAXR * 3.6, recul])

func _suspension(_m, c, _b) -> void:
	if c.body == null or c.wheels[0].get_parent() != c or c.lights_f[0].get_parent() != c.body:
		err = "suspension : carrosserie et roues mal séparées"
		return
	var lim := 0.0
	# accélération : le nez se lève
	_put(c, 0, -178, EST, 0.0)
	_run(c, 0.3, ["up"])
	var p_acc: float = c.pitch
	# freinage : le nez plonge
	_put(c, 0, -178, EST, 20.0)
	_run(c, 0.3, ["down"])
	var p_frein: float = c.pitch
	# virages : la caisse penche vers l'extérieur
	_put(c, 0, -178, EST, 15.0)
	_run(c, 0.4, ["left"])
	var r_g: float = c.roll
	_put(c, 0, -178, EST, 15.0)
	_run(c, 0.4, ["right"])
	var r_d: float = c.roll
	if p_acc > -0.02 or p_frein < 0.03 or r_g < 0.02 or abs(r_g + r_d) > 0.005:
		err = "suspension : tangage %.3f / %.3f, roulis %.3f / %.3f" % [p_acc, p_frein, r_g, r_d]
		return
	if abs(c.body.rotation.z - c.roll) > 0.0001 or c.rotation.x != 0.0:
		err = "suspension : la carrosserie ne suit pas"
		return
	# jamais plus de 8° environ, même en maltraitant la voiture
	_put(c, -150, -178, EST, 30.0)
	for i in 240:
		var k: String = ["left", "right", "down", "up"][(i / 20) % 4]
		Input.action_press(k)
		Input.action_press("brake" if i % 50 < 10 else k)
		c.drive(DT)
		_release()
		lim = max(lim, max(abs(c.pitch), abs(c.roll)))
	if lim > 0.141:
		err = "suspension : angle excessif (%.2f rad)" % lim
		return
	# à l'arrêt, tout revient à plat
	c.speed = 0.0
	for i in 150:
		c.idle(DT)
	if abs(c.pitch) + abs(c.roll) + abs(c.bounce) > 0.003:
		err = "suspension : la voiture ne revient pas à plat (%.4f)" % (abs(c.pitch) + abs(c.roll) + abs(c.bounce))
		return
	print("suspension : nez levé de %.1f° à l'accélération, plongé de %.1f° au freinage, roulis de %.1f° en virage, %.1f° au plus, retour à plat à l'arrêt" % [rad_to_deg(-p_acc), rad_to_deg(p_frein), rad_to_deg(r_g), rad_to_deg(lim)])

func _collisions(_m, c, b) -> void:
	# de face contre le mur du bout du monde (x = 206) : arrêt net, on ne traverse pas
	_put(c, 180, -178, EST, 20.0)
	_run(c, 2.5)
	if c.global_position.x > 204.0 or c.global_position.x < 202.0 or abs(c.speed) > 1.0:
		err = "collisions : mur de face, x = %.1f, vitesse %.1f" % [c.global_position.x, c.speed]
		return
	# on peut repartir en marche arrière après le choc
	_run(c, 1.0, ["down"])
	if c.global_position.x > 202.0:
		err = "collisions : voiture coincée contre le mur"
		return
	# contre une voiture arrêtée : on s'arrête derrière elle, elle ne bouge pas
	c.repair()
	_put(c, 134, -178, EST, 12.0)
	_run(c, 3.0)
	var gap: float = b.global_position.x - c.global_position.x
	if gap < 4.3 or gap > 5.0 or b.global_position.distance_to(Vector3(140, 0, -178)) > 0.01:
		err = "collisions : contre une voiture, écart %.2f m" % gap
		return
	if c.damage <= 0.0 or b.damage <= 0.0 or not c.hit_front or not b.hit_rear or b.damage >= c.damage:
		err = "collisions : dégâts %.0f (avant) et %.0f (voiture percutée)" % [c.damage, b.damage]
		return
	var dg := "choc à 40 km/h environ contre une voiture arrêtée : dégâts %.0f pour moi, %.0f pour elle" % [c.damage, b.damage]
	# en biais contre le mur de la plage : la voiture glisse le long du mur, sans dégât
	c.repair()
	_put(c, 0, -186, EST + 0.2, 15.0)
	_run(c, 1.5, ["up"])
	if c.global_position.z < -188.2 or c.global_position.x < 15.0 or c.speed < 8.0 or c.damage > 0.0:
		err = "collisions : en biais, x = %.1f, z = %.1f, vitesse %.1f, dégâts %.0f" % [c.global_position.x, c.global_position.z, c.speed, c.damage]
		return
	print("collisions : arrêt net contre un mur puis dégagement en marche arrière ; %s ; glissade le long d'un mur en biais sans dégât" % dg)

func _degats(m, c, b) -> void:
	if c.damage != 0.0 or c.dmg_stage != 0 or c.smoke != null and c.smoke.emitting or not c.lights_f[0].visible:
		err = "dégâts : la voiture réparée n'est pas neuve"
		return
	# petit contact : rien
	c.hit(4.0, true)
	if c.damage != 0.0:
		err = "dégâts : un simple contact abîme la voiture"
		return
	# choc de face à 70 km/h environ contre le mur : tôle froissée, un phare cassé, pas encore de fumée
	_put(c, 198, -178, EST, 20.0)
	_run(c, 2.0)
	var d1: float = c.damage
	if c.dmg_stage != 1 or not c.dmg_done.has("capot") or c.lights_f[0].visible or not c.lights_f[1].visible or c.smoke != null:
		err = "dégâts : premier choc, dégâts %.0f, stade %d" % [d1, c.dmg_stage]
		return
	if c.dmg_done.has("coffre") or not c.lights_r[0].visible or c.max_speed() != c.MAXF:
		err = "dégâts : l'arrière est abîmé par un choc avant"
		return
	# choc par l'arrière, en reculant contre l'autre voiture : coffre plié, fumée claire
	_put(c, 150, -178, EST, -10.0)
	_run(c, 1.5, ["down"])
	if not c.hit_rear or not c.dmg_done.has("coffre") or c.lights_r[1].visible:
		err = "dégâts : pas de dégât à l'arrière en reculant (%.0f)" % c.damage
		return
	c.hit(8.0, true)
	if c.dmg_stage != 2 or c.smoke == null or not c.smoke.emitting or c.smoke_mat.albedo_color.r < 0.5 or c.lights_f[1].visible:
		err = "dégâts : pas de fumée claire au stade 2 (dégâts %.0f)" % c.damage
		return
	var d2: float = c.damage
	# moteur très abîmé : fumée noire, vitesse plafonnée à 60 %, mais la voiture roule toujours
	m.cur_car = c
	m.info_t = 0.0
	for i in 6:
		c.hit(30.0, true)
	# (ces chocs assomment aussi le conducteur : on le remet sur pied, sa santé est testée plus loin)
	m.cur_car = null
	m.player.ko_t = 0.0
	m.player.health = 100.0
	if c.damage != 100.0 or c.dmg_stage != 3 or c.smoke_mat.albedo_color.r > 0.3 or m.info_t <= 0.0:
		err = "dégâts : stade 3 non atteint (dégâts %.0f)" % c.damage
		return
	_put(c, -30, -178, EST, 0.0)
	_run(c, 6.0, ["up"])
	if abs(c.speed - c.MAXF * 0.6) > 0.01 or c.global_position.x < 20.0:
		err = "dégâts : vitesse %.1f m/s avec un moteur très abîmé" % c.speed
		return
	var vmax: float = c.speed
	# réparation : tout redevient neuf
	var n: int = c.dmg_nodes.size()
	c.repair()
	if c.damage != 0.0 or c.smoke.emitting or not c.lights_f[0].visible or not c.lights_r[1].visible or c.dmg_nodes.size() != 0 or c.max_speed() != c.MAXF:
		err = "dégâts : la réparation ne remet pas à neuf"
		return
	print("dégâts : mur à 70 km/h environ = %.0f (capot plié, un phare) ; puis %.0f (coffre, fumée claire) ; à 100 fumée noire et %.0f km/h au plus ; %d pièces de tôle retirées à la réparation" % [d1, d2, vmax * 3.6, n])

func _sante(m, c, _b) -> void:
	var pl = m.player
	pl.health = 100.0
	m.cur_car = c
	pl.visible = false
	# choc moyen (moins de 36 km/h perdus) : la voiture est abîmée, pas le conducteur
	c.hit(9.0, true)
	if pl.health != 100.0 or c.damage <= 0.0:
		err = "santé au volant : un choc moyen blesse le conducteur (%.0f)" % pl.health
		return
	# gros choc : 72 km/h perdus d'un coup = 20 points ; pleine vitesse = 48 points
	c.hit(20.0, true)
	var h1: float = pl.health
	c.hit(34.0, true)
	if abs(h1 - 80.0) > 0.01 or abs(pl.health - 32.0) > 0.01 or m.cur_car != c:
		err = "santé au volant : %.0f puis %.0f (attendu 80 puis 32)" % [h1, pl.health]
		return
	# le choc de trop : évanoui, sorti de la voiture, qui s'arrête
	c.speed = 20.0
	c.hit(34.0, true)
	if pl.ko_t <= 0.0 or m.cur_car != null or not pl.visible or c.speed != 0.0:
		err = "santé au volant : pas d'évanouissement à zéro"
		return
	# réveil : les soins coûtent 10 % de l'argent, 2 000 FCFA au plus, rien si on n'a rien
	var paye := []
	for somme in [0, 5000, 80000]:
		m.money = somme
		m.respawn()
		paye.append(somme - m.money)
	pl.ko_t = 0.0
	m.money = 400
	if paye != [0, 500, 2000] or pl.health != 100.0:
		err = "soins : %s FCFA payés (attendu 0, 500, 2000)" % str(paye)
		return
	print("santé au volant : choc moyen sans mal, 72 km/h = -20, pleine vitesse = -48, évanoui à zéro et sorti de la voiture ; soins 0, 500 et 2 000 FCFA")

func _feux(m, c, _b) -> void:
	var fx = c.fx
	if fx.ind[1].size() != 2 or fx.ind[-1].size() != 2 or fx.ind[1][0].position.x < 0.0 or fx.lights_on:
		err = "feux : clignotants absents ou phares allumés au départ"
		return
	# phares : les optiques s'allument, le faisceau n'existe que pour la voiture du joueur
	fx.toggle_lights()
	if not fx.lights_on or fx.spot != null or c.lights_f[0].material_override.shading_mode != BaseMaterial3D.SHADING_MODE_UNSHADED:
		err = "feux : phares d'une voiture vide mal allumés"
		return
	m.cur_car = c
	fx.set_lights(true)
	if fx.spot == null or not fx.spot.visible:
		err = "feux : pas de faisceau pour la voiture du joueur"
		return
	fx.toggle_lights()
	if fx.lights_on or fx.spot.visible or c.lights_f[0].material_override != m.mat(Color("fff6c0")):
		err = "feux : les phares ne s'éteignent pas"
		return
	# feux stop : frein, frein à main, pas en roue libre ni en accélérant
	var stop := []
	for keys in [["down"], ["brake"], [], ["up"]]:
		_put(c, 0, -178, EST, 15.0)
		_run(c, 0.1, keys)
		stop.append(fx.brake_shown)
	if stop != [true, true, false, false]:
		err = "feux stop : %s" % str(stop)
		return
	# clignotant gauche : il bat, à gauche seulement, et s'arrête seul après le virage
	_put(c, 0, -178, EST, 0.0)
	fx.set_blink(1)
	var vu := [0, 0]
	for i in 80:
		c.drive(DT)
		vu[0 if fx.ind[1][0].visible else 1] += 1
		if fx.ind[-1][0].visible or fx.ind[1][0].visible != fx.ind[1][1].visible:
			err = "clignotants : mauvais côté allumé"
			return
	if vu[0] < 30 or vu[1] < 30:
		err = "clignotants : pas de battement (%s)" % str(vu)
		return
	_put(c, 0, -178, EST, 10.0)
	fx.blink_h0 = EST
	_run(c, 1.2, ["left"])
	if fx.blink != 0 or fx.ind[1][0].visible:
		err = "clignotants : pas d'arrêt automatique après le virage"
		return
	# même touche deux fois : éteint ; autre touche : change de côté
	fx.set_blink(-1)
	fx.set_blink(1)
	var b1: int = fx.blink
	fx.set_blink(1)
	if b1 != 1 or fx.blink != 0:
		err = "clignotants : bascule incorrecte"
		return
	m.cur_car = null
	# circulation : feux stop quand elle est bloquée, clignotant quand elle tourne
	var a = null
	for t in m.traffic:
		if not t.moto:
			a = t
			break
	var d0: float = a.dist
	var v0: float = a.speed
	var tourne := false
	var stop_ai := false
	for i in 1500:
		a.ai_step(DT, false)
		tourne = tourne or a.fx.blink != 0
		stop_ai = stop_ai or a.fx.brake_shown
	for i in 30:
		a.ai_step(DT, true)
	if not tourne or stop_ai or not a.fx.brake_shown:
		err = "circulation : clignotant %s, feux stop à tort %s, feux stop bloquée %s" % [tourne, stop_ai, a.fx.brake_shown]
		return
	a.dist = d0
	a.speed = v0
	a.place_on_path()
	print("feux : phares et faisceau, feux stop au frein et au frein à main, clignotant qui bat %d images sur 80 et s'arrête après le virage ; circulation : clignotant en virage, feux stop à l'arrêt" % vu[0])

func _klaxon(m, c, _b) -> void:
	var fx = c.fx
	# un appui bref : le son démarre, puis s'arrête seul
	_put(c, 0, -178, EST, 0.0)
	_run(c, 0.2, ["horn"])
	if not fx.horn_on or fx.honks != 1 or fx.horn_player == null or fx.horn_player.stream.data.size() != 4410:
		err = "klaxon : il ne sonne pas"
		return
	_run(c, 0.3)
	if fx.horn_on:
		err = "klaxon : il ne s'arrête pas quand on relâche"
		return
	# les passants proches sursautent, pas les autres
	var p = m.npcs[0]
	var pres: int = m.startle(p.n.position, fx.HORN_RANGE)
	var loin: int = m.startle(Vector3(0, 0, -240), fx.HORN_RANGE)
	if pres < 1 or loin != 0 or p.scare <= 0.0:
		err = "klaxon : passants %d près, %d loin" % [pres, loin]
		return
	# circulation : bloquée par le joueur, elle klaxonne une fois après 3 s, puis patiente (décision 59)
	var a = m.traffic[0]
	var d0: float = a.dist
	var n0: int = a.fx.honks
	for i in 170:
		a.ai_step(DT, true, true)
	var tot: int = a.fx.honks - n0
	for i in 600:
		a.ai_step(DT, true, true)
	var tard: int = a.fx.honks - n0
	# bloquée par autre chose que le joueur : silence
	var b = m.traffic[1]
	var n1: int = b.fx.honks
	var d1: float = b.dist
	for i in 600:
		b.ai_step(DT, true, false)
	if tot != 0 or tard != 1 or b.fx.honks != n1:
		err = "klaxon de la circulation : %d avant 3 s, %d en 13 s, %d sans le joueur" % [tot, tard, b.fx.honks - n1]
		return
	a.dist = d0
	b.dist = d1
	print("klaxon : sonne tant qu'on appuie, %d passant(s) sursaute(nt) ; circulation : un seul coup en 13 s quand le joueur bloque, aucun sinon" % pres)

func _camera(m, c, _b) -> void:
	_put(c, 0, -178, EST, 0.0)
	m.cur_car = c
	var fwd := Vector3(1, 0, 0)
	var ds := []
	for mode in 3:
		m.cam_mode = mode
		m._camera(0.0, true)
		var rel: Vector3 = m.cam.global_position - c.global_position
		var back: float = -rel.dot(fwd)
		var vise: float = (-m.cam.global_transform.basis.z).angle_to(c.global_position + Vector3(0, 1.6, 0) - m.cam.global_position)
		if abs(back - m.CAMS[mode][0]) > 0.01 or abs(rel.y - m.CAMS[mode][1]) > 0.01 or abs(rel.z) > 0.01 or vise > 0.01:
			err = "caméra de conduite : mode %d, %.1f m derrière, %.1f m de haut" % [mode, back, rel.y]
			return
		ds.append(back)
	if not (ds[0] < ds[1] and ds[1] < ds[2]):
		err = "caméra de conduite : les trois distances ne sont pas croissantes"
		return
	# vue intérieure : dans la voiture, à hauteur d'yeux, regard droit devant
	m.cam_mode = 3
	m._camera(0.0, true)
	var r: Vector3 = m.cam.global_position - c.global_position
	if Vector2(r.x, r.z).length() > 0.5 or r.y < 1.1 or r.y > 1.6 or (-m.cam.global_transform.basis.z).dot(fwd) < 0.99:
		err = "caméra de conduite : vue intérieure mal placée"
		return
	# elle suit la voiture qui tourne, sans retard
	_put(c, 0, -178, EST + 1.0, 0.0)
	m._camera(DT, false)
	if (-m.cam.global_transform.basis.z).dot(Vector3(sin(EST + 1.0), 0, cos(EST + 1.0))) < 0.99:
		err = "caméra de conduite : la vue intérieure ne suit pas la voiture"
		return
	# à pied, la caméra ne dépend pas du mode choisi en voiture
	m.cur_car = null
	m._camera(0.0, true)
	var dp: float = Vector2(m.cam.global_position.x - m.player.global_position.x, m.cam.global_position.z - m.player.global_position.z).length()
	m.cam_mode = 1
	if abs(dp - 6.5) > 0.01:
		err = "caméra : à pied elle n'est plus à 6,5 m (%.1f)" % dp
		return
	print("caméra de conduite : %.0f, %.0f et %.0f m derrière la voiture, vue intérieure à %.2f m de haut, 6,5 m à pied" % [ds[0], ds[1], ds[2], r.y])

