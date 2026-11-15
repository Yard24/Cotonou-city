extends RefCounted
# Relief et bord de mer : fond marin en pente, limites de baignade, ponton,
# murets de la Marina, caisses empilées contre la halle du marché.

const WATER_Y := -0.3     # niveau de la mer
const SHORE_Z := -193.0   # la mer commence ici (au sud de la plage)
const SEA_END := -262.0   # ligne de bouées : on ne nage pas plus loin
const MURET_Z := -167.7
const MURETS := [-170.0, -60.0, 50.0, 160.0]   # centre de chaque muret (44 m de long)
const PIER_X := -100.0
const CRATE_X := 86.4     # première caisse, contre le mur nord de la halle
const CRATE_Z := 102.2
const CRATE_W := 2.4
const CRATE_N := 6
const ROOF_Y := 8.0

# Hauteur du sol : 0 partout, puis le fond descend en pente douce sous la mer.
static func ground_h(_x: float, z: float) -> float:
	if z >= SHORE_Z:
		return 0.0
	return max(-4.0, (z - SHORE_Z) * 0.3)

func build(m) -> void:
	# la plage reste fermée aux voitures (couche 2), le héros passe
	m.wall(Vector3(430, 10, 2), Vector3(0, 5, -190), 2)
	# limites de la zone de baignade
	m.wall(Vector3(434, 24, 2), Vector3(0, 0, SEA_END - 1.0))
	m.wall(Vector3(2, 24, 76), Vector3(207, 0, -226))
	m.wall(Vector3(2, 24, 76), Vector3(-207, 0, -226))
	var x := -195.0
	while x <= 195.0:
		m.cyl(0.45, 0.45, 0.7, Color("ff7a00"), Vector3(x, WATER_Y + 0.15, SEA_END + 3.0), null, 8)
		x += 15.0
	# ponton : on y monte depuis la plage (Espace), on plonge au bout
	var wood := Color("8b5a2b")
	m.box(Vector3(4, 0.3, 46), wood, Vector3(PIER_X, 0.85, -209), null, true)
	# bloc plein côté plage : c'est par là qu'on monte
	m.box(Vector3(4, 1.0, 1.0), Color("5a3d1e"), Vector3(PIER_X, 0.5, -186.5), null, true)
	var z := -188.0
	while z >= -230.0:
		for sx in [-1.7, 1.7]:
			m.cyl(0.18, 0.18, 5.0, Color("5a3d1e"), Vector3(PIER_X + sx, -1.5, z), null, 6)
		z -= 7.0
	# murets entre le boulevard de la Marina et la plage
	for cx in MURETS:
		m.box(Vector3(44, 1.0, 0.4), Color("c9683f"), Vector3(cx, 0.5, MURET_Z), null, true)
		m.box(Vector3(44.1, 0.08, 0.5), Color("f4f1ea"), Vector3(cx, 1.0, MURET_Z))
	# caisses empilées : un escalier de fortune jusqu'au toit de la halle
	var cols := ["a9743a", "8b5a2b", "b98a4e"]
	for i in CRATE_N:
		var h: float = ROOF_Y * (i + 1) / CRATE_N
		m.box(Vector3(CRATE_W, h, CRATE_W), Color(cols[i % 3]), Vector3(CRATE_X + CRATE_W * i, h / 2.0, CRATE_Z), null, true)
		m.box(Vector3(CRATE_W + 0.04, 0.1, 0.2), Color("5a3d1e"), Vector3(CRATE_X + CRATE_W * i, h - 0.3, CRATE_Z + CRATE_W / 2.0))
