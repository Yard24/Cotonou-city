extends RefCounted
# Objets avec lesquels le héros interagit (touche E) : étal d'eau fraîche,
# bancs, panneaux d'information.

const PRIX_EAU := 100     # FCFA
const SOIN_EAU := 25.0    # points de santé rendus
const PORTEE := 2.6       # distance maximale pour interagir, en mètres

var items: Array = []     # {kind, pos, label, ...}

func build(m) -> void:
	_stall(m, Vector3(21, 0, -46))
	_stall(m, Vector3(-84, 0, -172))
	_bench(m, Vector3(22, 0, -54), PI)
	_bench(m, Vector3(-70, 0, -174), PI)
	_bench(m, Vector3(64, 0, 10.5), 0.0)
	_panel(m, Vector3(17, 0, -40), "Place de l'Amazone",
		"Kwabo ! Bienvenue à Cotonou. La statue de l'Amazone rend hommage aux Agodjié, les guerrières du royaume du Danhomè.")
	_panel(m, Vector3(-96, 0, -176), "Ponton de la Marina",
		"Baignade autorisée jusqu'aux bouées orange. Monte sur le ponton (Espace) et plonge au bout !")
	_panel(m, Vector3(84, 0, 106), "Halle de Dantokpa",
		"Les caisses montent jusqu'au toit : Espace devant chaque caisse. Attention, une chute de plus de 3 mètres fait mal.")

# Étal d'eau fraîche tenu par une vendeuse.
func _stall(m, p: Vector3) -> void:
	m.box(Vector3(1.8, 0.9, 0.9), Color("2a7de1"), p + Vector3(0, 0.45, 0), null, true)
	m.box(Vector3(1.2, 0.5, 0.6), Color("f4f4f4"), p + Vector3(0, 1.15, 0))
	m.cyl(0.06, 0.06, 3.0, Color("555555"), p + Vector3(0, 1.5, -0.8), null, 5)
	m.cyl(0.0, 2.0, 0.8, Color("2a6fdb"), p + Vector3(0, 3.2, -0.8), null, 8)
	var n := Node3D.new()
	n.position = p + Vector3(0, 0, -1.1)
	m.add_child(n)
	m.make_human(n, Color("fcd116"), Color("8e2bd1"), Color("4a2b1a"))
	items.append({"kind": "eau", "pos": p + Vector3(0, 0, 0.9), "label": "acheter de l'eau fraîche (%d FCFA)" % PRIX_EAU})

# Banc : le héros s'assoit du côté « h » et récupère plus vite.
func _bench(m, p: Vector3, h: float) -> void:
	var b = m.box(Vector3(2.2, 0.12, 0.6), Color("7a4a22"), p + Vector3(0, 0.5, 0))
	b.rotation.y = h
	for sx in [-0.9, 0.9]:
		var leg = m.box(Vector3(0.14, 0.5, 0.5), Color("555555"), p + Vector3(sx * cos(h), 0.25, -sx * sin(h)))
		leg.rotation.y = h
	m.wall(Vector3(2.2, 0.56, 0.6) if abs(sin(h)) < 0.5 else Vector3(0.6, 0.56, 2.2), p + Vector3(0, 0.28, 0))
	var fwd := Vector3(sin(h), 0, cos(h))
	items.append({"kind": "banc", "pos": p + fwd * 0.75, "h": h, "label": "s'asseoir"})

# Panneau d'information à lire.
func _panel(m, p: Vector3, title: String, text: String) -> void:
	m.cyl(0.08, 0.08, 1.6, Color("555555"), p + Vector3(0, 0.8, 0), null, 6)
	m.box(Vector3(1.3, 0.9, 0.1), Color("1d6b3a"), p + Vector3(0, 1.7, 0))
	m.box(Vector3(1.1, 0.7, 0.12), Color("f4f1ea"), p + Vector3(0, 1.7, 0))
	m.post(p.x, p.z, 0.15)
	items.append({"kind": "panneau", "pos": p, "label": "lire le panneau", "text": title + " — " + text})

# Objet le plus proche du héros, à portée ; {} s'il n'y en a pas. « d » = distance.
func nearest(m) -> Dictionary:
	var best := {}
	var bd := PORTEE
	var pp: Vector3 = m.player.global_position
	for it in items:
		var d: float = Vector2(it.pos.x - pp.x, it.pos.z - pp.z).length()
		if d < bd and abs(it.pos.y - pp.y) < 1.5:
			bd = d
			best = it
	if not best.is_empty():
		best = best.duplicate()
		best["d"] = bd
	return best

func use(m, it: Dictionary) -> void:
	var pl = m.player
	match it.kind:
		"eau":
			if pl.health >= pl.SANTE_MAX:
				m.say("« Kwabo ! Tu as l'air en pleine forme, garde tes sous. »", 4.0)
			elif m.money < PRIX_EAU:
				m.say("« Il te manque %d FCFA, mon ami. Reviens après une course. »" % (PRIX_EAU - m.money), 4.0)
			else:
				m.money -= PRIX_EAU
				pl.heal(SOIN_EAU)
				m.say("Eau fraîche : −%d FCFA, santé +%d" % [PRIX_EAU, int(SOIN_EAU)], 4.0)
		"banc":
			if pl.sitting:
				pl.stand()
			else:
				pl.sit(it.pos, it.h)
				m.say("Tu te reposes : la santé remonte. Une touche de direction pour te lever.", 4.0)
		"panneau":
			m.say(it.text, 8.0)
