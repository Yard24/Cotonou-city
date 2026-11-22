extends RefCounted
# Point d'entrée unique des systèmes « autour du jeu » : sauvegarde, options, menus,
# affichage en jeu, commandes tactiles. main.gd ne connaît que ce fichier (build au lancement, step à chaque image).

const SauvegardeScript := preload("res://scripts/sauvegarde.gd")
const OptionsScript := preload("res://scripts/options.gd")
const MenusScript := preload("res://scripts/menus.gd")
const AffichageScript := preload("res://scripts/affichage.gd")
const TactileScript := preload("res://scripts/tactile.gd")

var sauvegarde = SauvegardeScript.new()
var options = OptionsScript.new()
var menus = MenusScript.new()
var affichage = AffichageScript.new()
var tactile = TactileScript.new()   # manette virtuelle et boutons (téléphone)

# Après la création du monde et de l'affichage.
func build(m) -> void:
	if m.selftest:
		# le test automatique ne touche ni aux sauvegardes ni aux options du joueur
		sauvegarde.dossier = "user://test_sauvegardes"
		options.fichier = "user://test_options.json"
		options.sans_ecran = true
		for s in sauvegarde.NB_MANUELS + 1:
			sauvegarde.supprimer(s)
		if FileAccess.file_exists(options.fichier):
			DirAccess.remove_absolute(options.fichier)
	options.build(m)
	affichage.options = options
	affichage.build(m)
	sauvegarde.affichage = affichage
	sauvegarde.synchro(m)
	menus.build(m, sauvegarde, options)
	menus.tactile = tactile
	tactile.build(m, options)

# À chaque image, avant le reste de main.gd. Renvoie true quand un panneau de menu est
# ouvert : main.gd s'arrête là pour cette image.
func step(m, delta: float) -> bool:
	tactile.step(m, delta)   # avant le reste : les boutons touchés appuient sur les actions d'entrée
	if menus.step(m, delta):
		return true
	options.step(m)
	if not m.menu.visible:
		sauvegarde.step(m, delta)
		affichage.step(m, delta)
		if m.frames % 30 == 0:
			bus_klaxons(m)
	return false

# Les klaxons (créés au premier coup de klaxon de chaque véhicule) passent par la piste
# « Effets », réglée par le curseur « Bruitages ».
func bus_klaxons(m) -> void:
	for c in m.cars + m.traffic:
		if c.fx.horn_player != null and c.fx.horn_player.bus != &"Effets":
			c.fx.horn_player.bus = &"Effets"

# Texte à afficher : au doigt, les touches du clavier citées deviennent les boutons tactiles.
func adapter(t: String) -> String:
	return tactile.adapter(t)

# Tests automatiques de ces systèmes, lancés par selftest.gd. "" si tout va bien.
func selftest(m) -> String:
	for t in [preload("res://scripts/selftest_sauvegarde.gd"), preload("res://scripts/selftest_menus.gd"), preload("res://scripts/selftest_affichage.gd"), preload("res://scripts/selftest_tactile.gd")]:
		var e = t.new().run(m)
		if typeof(e) != TYPE_STRING:
			return "test interrompu par une erreur de script"
		if e != "":
			return e
	return ""
