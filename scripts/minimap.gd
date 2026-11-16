extends Control
# Mini-carte : tourne avec le joueur, montre routes, îlots, circulation et objectif.

var main
const S := 0.55

func _ready() -> void:
	clip_contents = true
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(_d: float) -> void:
	queue_redraw()

func _draw() -> void:
	if main == null:
		return
	var c := size / 2.0
	var o: Vector3 = main.focus_pos()
	var h: float = main.focus_heading()
	var sn := sin(h)
	var cs := cos(h)
	var tr := func(x: float, z: float) -> Vector2:
		var dx := x - o.x
		var dz := z - o.z
		return c + Vector2(-(dx * cs - dz * sn), -(dx * sn + dz * cs)) * S
	var quad := func(x0: float, z0: float, x1: float, z1: float, col: Color) -> void:
		draw_colored_polygon(PackedVector2Array([tr.call(x0, z0), tr.call(x1, z0), tr.call(x1, z1), tr.call(x0, z1)]), col)
	draw_rect(Rect2(Vector2.ZERO, size), Color("b5653a"))
	quad.call(-600.0, -900.0, 600.0, -192.0, Color("2a86b5"))
	quad.call(-600.0, -192.0, 600.0, -167.0, Color("e8d3a0"))
	for b in main.blocks:
		quad.call(b.x0, b.z0, b.x1, b.z1, Color("e0a85a") if b.market else Color("cbbb9c"))
	for r in main.road_segs:
		draw_line(tr.call(r[0].x, r[0].y), tr.call(r[1].x, r[1].y), Color("3a3a3d"), r[2] * S)
	var oc: Vector2 = tr.call(0.0, 0.0)
	draw_circle(oc, 30.0 * S, Color("3a3a3d"))
	draw_circle(oc, 12.0 * S, Color("5f9a3a"))
	for a in main.traffic:
		var p: Vector2 = tr.call(a.global_position.x, a.global_position.z)
		draw_rect(Rect2(p - Vector2(1.5, 1.5), Vector2(3, 3)), Color.WHITE)
	# clients de zémidjan qui attendent (petits points bleus), objectif de mission (jaune), arrivée de la course (bleu)
	for cl in main.zem.clients:
		if cl.state == "attend":
			draw_circle(tr.call(cl.n.position.x, cl.n.position.z), 2.5, Color("19c0ff"))
	for mk in [[main.marker, Color("ffd200")], [main.zem.dest_marker, Color("19c0ff")]]:
		if mk[0].visible:
			var m: Vector2 = tr.call(mk[0].position.x, mk[0].position.z)
			var d := m - c
			var lim := c.x - 10.0
			if d.length() > lim:
				m = c + d.normalized() * lim
			draw_circle(m, 7.0, Color.BLACK)
			draw_circle(m, 5.0, mk[1])
	var col := Color("ff4444") if main.cur_car else Color("00d084")
	draw_colored_polygon(PackedVector2Array([c + Vector2(0, -9), c + Vector2(6, 7), c + Vector2(0, 3), c + Vector2(-6, 7)]), col)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0, 0, 0, 0.8), false, 3.0)
