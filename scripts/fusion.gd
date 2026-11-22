extends RefCounted
# Sur téléphone : le décor fixe (bâtiments, routes, palmiers, bancs…), fait de plus d'un
# millier de petits blocs, est regroupé en quelques dizaines de morceaux, un par carré de
# 64 m. Chaque bloc garde sa couleur (couleur des sommets). Le téléphone dessine ainsi
# quelques dizaines d'objets au lieu d'un millier : c'est ce qui coûte le plus cher à un
# petit processeur graphique. Sur PC, rien n'est regroupé (main.gd ne l'appelle que sur téléphone).
# Ne sont regroupés que les blocs posés directement dans le monde, sans enfant ni script,
# avec une couleur simple. Un bloc qu'on veut modifier après sa création doit être rangé
# sous un autre nœud, ou porter la méta « ne_pas_fusionner ».
# Vérifications : selftest_tactile.gd (_fusion).

const CARRE := 64.0

var avant := 0       # blocs regroupés
var apres := 0       # morceaux créés
var sommets := 0     # sommets recopiés

static func fusionnable(n: Node) -> bool:
	if not (n is MeshInstance3D) or not n.visible or n.get_child_count() > 0 or n.get_script() != null or n.has_meta("ne_pas_fusionner"):
		return false
	if not (n.mesh is BoxMesh or n.mesh is CylinderMesh) or not (n.material_override is StandardMaterial3D):
		return false
	var mt: StandardMaterial3D = n.material_override
	return mt.albedo_texture == null and mt.transparency == BaseMaterial3D.TRANSPARENCY_DISABLED \
		and mt.shading_mode == BaseMaterial3D.SHADING_MODE_PER_PIXEL and not mt.emission_enabled \
		and mt.albedo_color.a >= 1.0

func fusionner(m: Node3D) -> void:
	var groupes := {}
	for n in m.get_children():
		if fusionnable(n):
			var p: Vector3 = n.position
			var cle := Vector2i(floori(p.x / CARRE), floori(p.z / CARRE))
			if not groupes.has(cle):
				groupes[cle] = []
			groupes[cle].append(n)
	var mt := StandardMaterial3D.new()
	mt.vertex_color_use_as_albedo = true
	mt.vertex_color_is_srgb = true
	for cle in groupes:
		var pos := PackedVector3Array()
		var nor := PackedVector3Array()
		var col := PackedColorArray()
		var idx := PackedInt32Array()
		for n in groupes[cle]:
			var a: Array = n.mesh.surface_get_arrays(0)
			var xf: Transform3D = n.transform
			var bn: Basis = xf.basis.inverse().transposed()
			var c: Color = n.material_override.albedo_color
			var base := pos.size()
			var v: PackedVector3Array = a[Mesh.ARRAY_VERTEX]
			var nn: PackedVector3Array = a[Mesh.ARRAY_NORMAL]
			for i in v.size():
				pos.append(xf * v[i])
				nor.append((bn * nn[i]).normalized())
				col.append(c)
			var ii: PackedInt32Array = a[Mesh.ARRAY_INDEX]
			for i in ii:
				idx.append(base + i)
			n.visible = false   # gardé (invisible) : un script qui le tiendrait encore ne plante pas
			avant += 1
		var arr := []
		arr.resize(Mesh.ARRAY_MAX)
		arr[Mesh.ARRAY_VERTEX] = pos
		arr[Mesh.ARRAY_NORMAL] = nor
		arr[Mesh.ARRAY_COLOR] = col
		arr[Mesh.ARRAY_INDEX] = idx
		var am := ArrayMesh.new()
		am.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)
		var mi := MeshInstance3D.new()
		mi.name = "Decor_%d_%d" % [cle.x, cle.y]
		mi.mesh = am
		mi.material_override = mt
		mi.set_meta("ne_pas_fusionner", true)
		m.add_child(mi)
		apres += 1
		sommets += pos.size()
