extends RefCounted
# Caméra : derrière le héros à pied ; en voiture et à moto, trois distances puis une vue
# « à la place du conducteur » (touche V). À moto, la caméra penche avec la moto dans les virages.

# distance derrière la moto, hauteur ; la dernière est la vue du guidon
const CAMS_MOTO := [[5.5, 2.6], [7.5, 3.4], [10.5, 4.6], [0.0, 0.0]]
const ROULIS_EXT := 0.2      # vues extérieures : la caméra prend 20 % de l'angle de la moto
const ROULIS_GUIDON := 0.5   # vue du guidon : 50 %

func update(m, delta: float, instant: bool) -> void:
	var car = m.cur_car
	var o: Vector3 = car.global_position if car else m.player.global_position
	var h: float = car.heading if car else m.player.heading
	var is_moto: bool = car != null and car.moto
	var lean: float = car.lean if is_moto else 0.0
	if car and m.cam_mode == 3:
		# vue intérieure (voiture) ou du guidon (moto) : regard vers l'avant, sans retard
		var fw := Vector3(sin(h), 0, cos(h))
		m.cam.position = o + Vector3(0, 1.75 if is_moto else 1.35, 0) + fw * 0.2
		m.cam_target = o + Vector3(0, 1.5 if is_moto else 1.2, 0) + fw * 20.0
		m.cam.look_at(m.cam_target, Vector3.UP)
		m.cam.rotate_object_local(Vector3(0, 0, 1), lean * ROULIS_GUIDON)
		return
	var dist := 6.5
	var hh := 3.0
	if is_moto:
		dist = CAMS_MOTO[m.cam_mode][0]
		hh = CAMS_MOTO[m.cam_mode][1]
	elif car:
		dist = m.CAMS[m.cam_mode][0]
		hh = m.CAMS[m.cam_mode][1]
	# la caméra suit aussi la hauteur du héros (saut, objets sur lesquels il monte)
	var want := Vector3(o.x - sin(h) * dist, o.y + hh, o.z - cos(h) * dist)
	var tgt := o + Vector3(0, 1.6, 0)
	if instant:
		m.cam.position = want
		m.cam_target = tgt
	else:
		m.cam.position = m.cam.position.lerp(want, 1.0 - exp(-delta * 4.5))
		m.cam_target = m.cam_target.lerp(tgt, 1.0 - exp(-delta * 10.0))
	m.cam.look_at(m.cam_target, Vector3.UP)
	if lean != 0.0:
		m.cam.rotate_object_local(Vector3(0, 0, 1), lean * ROULIS_EXT)
