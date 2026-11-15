extends RefCounted
# Test automatique sans écran : lancé avec « -- --selftest ».
# main.gd appelle step() à chaque image ; le test doit finir par « SELFTEST OK ».

var start := Vector3.ZERO
var max_y := 0.0
var d_walk := 0.0

func step(m) -> void:
	var f: int = m.frames
	var pl = m.player
	max_y = max(max_y, pl.global_position.y)
	if f == 4:
		if m.road_segs.size() != 7 or m.minimap == null or not m.minimap.is_inside_tree():
			_fail(m, "mini-carte absente ou routes manquantes")
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
		m.toggle_car()
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
		print("SELFTEST OK")
		m.get_tree().quit(0)

# Place le héros sur la plage, tourné vers l'est, et le fait avancer.
func _to_beach(pl) -> void:
	pl.global_position = Vector3(-60, 0, -178)
	pl.heading = PI / 2
	start = pl.global_position
	Input.action_press("up")

func _fail(m, msg: String) -> void:
	print("SELFTEST ECHEC : " + msg)
	m.get_tree().quit(1)
