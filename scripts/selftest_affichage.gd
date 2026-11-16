extends RefCounted
# Test automatique de l'affichage en jeu : santé, argent, objet en main, notifications,
# indicateur de recherche. Appelé par systemes.gd, tout dans la même image.

const DT := 1.0 / 60.0

func run(m) -> String:
	var a = m.sys.affichage
	for t in [_sante, _argent, _objet, _notifications, _recherche]:
		_propre(m, a)
		var e: String = t.call(m, a)
		if e != "":
			return e
	_propre(m, a)
	return ""

func _propre(m, a) -> void:
	if m.cur_car != null:
		m.cur_car.speed = 0.0
		m._get_off()
	m.player.ko_t = 0.0
	m.player.health = 100.0
	a.visibles = []
	a.attente = []
	a.lacher()
	a.recherche = 0
	a.perdu_de_vue = false
	a.synchro(m)
	a.step(m, DT)

func _pas(m, a, secs: float) -> void:
	for i in int(round(secs * 60.0)):
		a.step(m, DT)

func _sante(m, a) -> String:
	var pl = m.player
	if a.l_sante.text != "100" or a.eclair.color.a != 0.0 or a.voile.color.a != 0.0:
		return "santé : à 100, ni éclair ni voile attendus (texte « %s »)" % a.l_sante.text
	if not a.l_sante.is_inside_tree() or a.l_sante.get_index() > m.menu.get_index():
		return "santé : la valeur doit être sous l'écran de pause"
	pl.hurt(30.0)
	a.step(m, DT)
	m.hud.update(m, DT)
	if a.l_sante.text != "70" or a.eclair.color.a < 0.6 or abs(a.voile.color.a - 0.45 * 30.0 / 40.0) > 0.03:
		return "santé : blessure de 30, texte « %s », éclair %.2f, voile %.2f" % [a.l_sante.text, a.eclair.color.a, a.voile.color.a]
	if abs(m.hp_fill.size.x - 140.0) > 0.5:
		return "santé : la jauge ne suit pas (%.0f pixels sur 200)" % m.hp_fill.size.x
	_pas(m, a, 1.0)
	if a.eclair.color.a != 0.0 or a.voile.color.a != 0.0:
		return "santé : l'éclair et le voile ne s'effacent pas en 1 s"
	# gros choc : voile plafonné
	pl.hurt(45.0)
	a.step(m, DT)
	if a.voile.color.a > 0.451 or a.voile.color.a < 0.4:
		return "santé : voile d'un gros choc %.2f (0,45 au plus)" % a.voile.color.a
	# santé basse : la jauge bat et le chiffre passe au rouge
	var mini := 1.0
	var maxi := 0.0
	for i in 120:
		a.step(m, DT)
		if i >= 60:
			mini = min(mini, a.eclair.color.a)
			maxi = max(maxi, a.eclair.color.a)
	if a.l_sante.text != "25" or maxi < 0.3 or mini > 0.05 or a.l_sante.get_theme_color("font_color") == Color.WHITE:
		return "santé : sous 30 %%, la jauge devrait battre (de %.2f à %.2f)" % [mini, maxi]
	# soigné : plus d'alerte, et pas d'éclair quand la santé remonte
	pl.heal(50.0)
	a.step(m, DT)
	if a.l_sante.text != "75" or a.eclair.color.a != 0.0 or a.l_sante.get_theme_color("font_color") != Color.WHITE:
		return "santé : l'alerte reste après les soins"
	if a.texte_sante(0.4) != "1" or a.texte_sante(0.0) != "0" or a.texte_sante(99.6) != "100":
		return "santé : arrondi de la valeur affichée"
	print("affichage santé : valeur à côté de la jauge ; blessure de 30 = éclair sur la jauge et voile rouge (0,34), effacés en moins de 1 s ; voile plafonné à 0,45 ; sous 30 % la jauge bat et le chiffre rougit")
	return ""

func _argent(m, a) -> String:
	m.money = 1250
	m.hud.update(m, DT)
	if m.l_money.text != "1250 FCFA":
		return "argent : affichage « %s »" % m.l_money.text
	a.synchro(m)
	m.money += 500
	a.step(m, DT)
	if a.visibles.size() != 1 or a.notif_labels[0].text != "+500 FCFA" or a.visibles[0].type != "gain":
		return "argent : gain non annoncé"
	m.money -= 100
	a.step(m, DT)
	m.hud.update(m, DT)
	if a.visibles.size() != 2 or a.notif_labels[1].text != "-100 FCFA" or a.visibles[1].type != "perte" or m.l_money.text != "1650 FCFA":
		return "argent : dépense non annoncée"
	a.step(m, DT)
	if a.visibles.size() != 2:
		return "argent : annonce répétée sans changement"
	# après un chargement, la différence d'argent n'est pas annoncée
	a.visibles = []
	m.money = 9000
	a.synchro(m)
	a.step(m, DT)
	if not a.visibles.is_empty():
		return "argent : différence annoncée après un chargement"
	m.money = 0
	m.hud.update(m, DT)
	if m.l_money.text != "0 FCFA":
		return "argent : affichage à zéro"
	print("affichage argent : « 1250 FCFA » en haut à gauche, toujours à jour ; gain (+500 FCFA) et dépense (-100 FCFA) annoncés une fois, rien après un chargement")
	return ""

func _objet(m, a) -> String:
	if a.texte_objet() != "Mains nues" or not a.l_objet.visible or a.objet_jauge.visible:
		return "objet en main : « Mains nues » sans jauge attendu à pied"
	# aucune arme à feu, ni couteau ni machette (décisions 3 et 78)
	for interdit in ["pistolet", "fusil", "couteau", "machette", ""]:
		if a.prendre(interdit) or a.objet != "":
			return "objet en main : « %s » ne doit pas pouvoir être tenu" % interdit
	if a.OBJETS.size() != 2 or not a.prendre("bâton"):
		return "objet en main : seuls le bâton et la planche existent"
	a.step(m, DT)
	if a.l_objet.text != "Bâton" or not a.objet_jauge.visible or abs(a.objet_jauge.size.x - 100.0) > 0.01:
		return "objet en main : bâton non affiché"
	for i in 3:
		a.user()
	a.step(m, DT)
	if abs(a.objet_jauge.size.x - 62.5) > 0.01:
		return "objet en main : la jauge d'usure ne suit pas (%.1f)" % a.objet_jauge.size.x
	# en véhicule : rien d'affiché ; à pied : de retour
	m.mount(m.cars[0])
	a.step(m, DT)
	if a.l_objet.visible or a.objet_jauge.visible or a.objet_fond.visible:
		return "objet en main : affiché en véhicule"
	m._get_off()
	a.step(m, DT)
	if not a.l_objet.visible or a.objet != "bâton" or a.coups != 5:
		return "objet en main : perdu en descendant du véhicule"
	for i in 5:
		a.user()
	a.step(m, DT)
	if a.objet != "" or a.l_objet.text != "Mains nues" or a.objet_jauge.visible or a.notif_labels[0].text != "Bâton cassé":
		return "objet en main : le bâton devrait casser au 8e coup"
	a.prendre("planche")
	a.step(m, DT)
	if a.l_objet.text != "Planche" or a.coups != 5:
		return "objet en main : planche"
	a.lacher()
	a.user()
	a.step(m, DT)
	if a.l_objet.text != "Mains nues":
		return "objet en main : lâcher"
	print("affichage de l'objet en main : « Mains nues », bâton (8 coups) ou planche (5 coups) avec jauge d'usure ; caché en véhicule ; aucune arme à feu, ni couteau ni machette")
	return ""

func _notifications(m, a) -> String:
	if a.notif_labels.size() != 4 or a.notif_labels[0].visible:
		return "notifications : 4 lignes, vides au départ"
	a.notifier("Bonjour", "info")
	a.step(m, DT)
	var l: Label = a.notif_labels[0]
	if not l.visible or l.text != "Bonjour" or l.modulate.a != 1.0 or a.notif_labels[1].visible:
		return "notifications : message non affiché"
	a.notifier("Bonjour", "info")
	a.notifier("Bonjour", "info")
	a.step(m, DT)
	if l.text != "Bonjour ×3" or a.visibles.size() != 1:
		return "notifications : un message répété devrait être compté (« %s »)" % l.text
	a.notifier("Attention", "alerte")
	a.notifier("Bizarre", "type inconnu")
	a.step(m, DT)
	if a.notif_labels[1].get_theme_color("font_color") != Color(a.COULEURS.alerte) or a.notif_labels[2].get_theme_color("font_color") != Color.WHITE:
		return "notifications : couleur selon le type"
	# plus de 4 : les suivantes attendent leur tour
	for i in 4:
		a.notifier("Message %d" % i, "info", 2.0)
	a.step(m, DT)
	if a.visibles.size() != 4 or a.attente.size() != 3 or not a.notif_labels[3].visible or a.notif_labels[3].text != "Message 0":
		return "notifications : 4 à l'écran et 3 en attente attendus (%d, %d)" % [a.visibles.size(), a.attente.size()]
	_pas(m, a, 1.8)
	if a.notif_labels[3].modulate.a > 0.5 or a.notif_labels[0].modulate.a != 1.0:
		return "notifications : fondu de fin"
	_pas(m, a, 0.3)
	if a.visibles.size() != 4 or a.notif_labels[3].text != "Message 1" or a.attente.size() != 2:
		return "notifications : la suivante ne prend pas la place libérée (« %s »)" % a.notif_labels[3].text
	_pas(m, a, 2.2)
	if a.visibles.size() != 2 or a.notif_labels[0].text != "Message 2" or a.notif_labels[2].visible:
		return "notifications : durée de 4 s non respectée (%d visibles)" % a.visibles.size()
	_pas(m, a, 2.1)
	if not a.visibles.is_empty() or a.notif_labels[0].visible:
		return "notifications : elles ne s'effacent pas"
	# file limitée
	for i in 30:
		a.notifier("File %d" % i, "info")
	if a.attente.size() != a.NOTIF_FILE:
		return "notifications : file d'attente non limitée"
	# la sauvegarde s'annonce
	a.visibles = []
	a.attente = []
	m.player.on_ground = true
	m.player.swimming = false
	if not m.sys.sauvegarde.sauver(m, 1) or a.visibles.size() != 1 or a.visibles[0].type != "sauvegarde" or not a.visibles[0].texte.begins_with("Partie sauvegardée"):
		return "notifications : la sauvegarde n'est pas annoncée (%s)" % m.sys.sauvegarde.erreur
	m.sys.sauvegarde.supprimer(1)
	print("notifications : 4 lignes à gauche, 4 s chacune avec fondu ; message répété compté (×3) ; les suivantes attendent leur tour ; couleur selon le type ; sauvegarde annoncée")
	return ""

func _recherche(m, a) -> String:
	var e = a.etoiles
	if e.visible or a.recherche != 0 or e.NB != 5 or not e.is_inside_tree():
		return "recherche : cinq étoiles, cachées quand on n'est pas recherché"
	if e.points(Vector2.ZERO, 10.0).size() != 10:
		return "recherche : dessin de l'étoile"
	a.regler_recherche(3)
	a.step(m, DT)
	if not e.visible or e.niveau != 3 or e.eteint or a.visibles.size() != 1 or a.visibles[0].texte != "Recherché par la police : 3 étoiles":
		return "recherche : 3 étoiles non affichées ou non annoncées"
	a.regler_recherche(2)
	a.step(m, DT)
	if e.niveau != 2 or a.visibles.size() != 1:
		return "recherche : la baisse ne doit pas être annoncée comme une alerte"
	a.regler_recherche(9)
	a.step(m, DT)
	if a.recherche != 5 or e.niveau != 5:
		return "recherche : plus de 5 étoiles"
	# perdu de vue : les étoiles clignotent
	a.regler_recherche(5, true)
	var eteintes := 0
	var changements := 0
	var avant := false
	for i in 96:
		a.step(m, DT)
		if e.eteint:
			eteintes += 1
		if e.eteint != avant:
			changements += 1
			avant = e.eteint
	if eteintes < 40 or eteintes > 56 or changements < 3 or changements > 4 or not e.visible or e.niveau != 5:
		return "recherche : clignotement quand la police a perdu le joueur (%d images éteintes, %d changements)" % [eteintes, changements]
	a.regler_recherche(5, false)
	_pas(m, a, 1.0)
	if e.eteint:
		return "recherche : les étoiles clignotent encore une fois retrouvé"
	a.regler_recherche(-2)
	a.step(m, DT)
	if e.visible or a.recherche != 0 or a.visibles[-1].texte != "La police ne te cherche plus":
		return "recherche : fin de recherche"
	a.regler_recherche(0, true)
	a.step(m, DT)
	if a.perdu_de_vue or e.visible:
		return "recherche : rien à perdre de vue quand on n'est pas recherché"
	print("indicateur de recherche : 0 à 5 étoiles sous la mini-carte, cachées à 0 ; hausse annoncée ; clignotement (0,4 s) quand la police a perdu le joueur de vue ; fin de recherche annoncée")
	return ""
