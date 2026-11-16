extends RefCounted
# Affichage en jeu, en plus de hud.gd : santé (valeur, éclair quand on est blessé, alerte
# quand elle est basse), objet tenu en main, notifications, indicateur de recherche.
# Fonctionnement attendu : docs/systemes/affichage_en_jeu.md. Vérifications : selftest_affichage.gd.

const SANTE_BASSE := 0.3      # sous 30 %, la jauge bat
const T_ECLAIR := 0.4         # durée de l'éclair blanc sur la jauge après une blessure
const VOILE_MAX := 0.45       # opacité maximale du voile rouge
const PERTE_VOILE := 40.0     # perte de santé qui donne le voile maximal
# Objets qu'on peut tenir : nombre de coups avant qu'ils cassent (décision 78).
# Aucune arme à feu, ni couteau ni machette (décisions 3 et 78) : tout autre nom est refusé.
const OBJETS := {"bâton": 8, "planche": 5}
const NOTIF_MAX := 4          # notifications visibles en même temps
const NOTIF_T := 4.0          # durée d'une notification, en secondes
const NOTIF_FONDU := 0.5
const NOTIF_FILE := 12        # au-delà, les plus anciennes en attente sont abandonnées
const COULEURS := {"info": "ffffff", "gain": "8df59a", "perte": "ff8f80", "alerte": "ffb347", "sauvegarde": "9fd8ff"}
const RECHERCHE_MAX := 5
const T_CLIGNOTE := 0.4

var options = null
var l_sante: Label
var eclair: ColorRect
var voile: ColorRect
var l_objet: Label
var objet_fond: ColorRect
var objet_jauge: ColorRect
var notif_labels: Array = []
var etoiles: Control

var vu_sante := 100.0
var vu_argent := 0
var eclair_t := 0.0
var voile_a := 0.0
var pouls := 0.0
var objet := ""               # "" : mains nues
var coups := 0
var visibles: Array = []      # notifications à l'écran : {texte, type, t, n}
var attente: Array = []
var recherche := 0            # 0 : pas recherché ; 1 à 5 étoiles
var perdu_de_vue := false
var clignote_t := 0.0

func build(m) -> void:
	var couche: Node = m.l_money.get_parent()
	var ajout := func(c: Control) -> void:
		couche.add_child(c)
		couche.move_child(c, m.menu.get_index())   # sous l'écran de pause
	voile = ColorRect.new()
	voile.color = Color(0.75, 0.05, 0.05, 0.0)
	voile.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	voile.mouse_filter = Control.MOUSE_FILTER_IGNORE
	couche.add_child(voile)
	couche.move_child(voile, 0)   # derrière tout le reste de l'affichage
	eclair = ColorRect.new()
	eclair.color = Color(1, 1, 1, 0)
	eclair.position = Vector2(18, 56)
	eclair.size = Vector2(204, 18)
	eclair.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ajout.call(eclair)
	l_sante = m.label(18, Color.WHITE)
	l_sante.position = Vector2(230, 51)
	ajout.call(l_sante)
	# objet tenu en main, sous la santé et le compteur d'images
	l_objet = m.label(18, Color.WHITE)
	l_objet.position = Vector2(18, 104)
	ajout.call(l_objet)
	objet_fond = ColorRect.new()
	objet_fond.color = Color(0, 0, 0, 0.6)
	objet_fond.position = Vector2(18, 132)
	objet_fond.size = Vector2(104, 10)
	ajout.call(objet_fond)
	objet_jauge = ColorRect.new()
	objet_jauge.color = Color("d9a05b")
	objet_jauge.position = Vector2(20, 134)
	objet_jauge.size = Vector2(100, 6)
	ajout.call(objet_jauge)
	# notifications : à gauche, empilées vers le bas
	for i in NOTIF_MAX:
		var l: Label = m.label(20, Color.WHITE)
		l.position = Vector2(18, 156 + i * 30)
		l.visible = false
		ajout.call(l)
		notif_labels.append(l)
	# étoiles de recherche : sous la mini-carte
	etoiles = load("res://scripts/etoiles.gd").new()
	etoiles.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
	etoiles.offset_left = -201
	etoiles.offset_right = -21
	etoiles.offset_top = 214
	etoiles.offset_bottom = 248
	etoiles.visible = false
	ajout.call(etoiles)
	synchro(m)

# Après un chargement : on repart des valeurs actuelles, sans annoncer la différence.
func synchro(m) -> void:
	vu_sante = m.player.health
	vu_argent = m.money
	eclair_t = 0.0
	voile_a = 0.0

func step(m, delta: float) -> void:
	_sante(m, delta)
	_argent(m)
	_objet(m)
	_notifs(delta)
	_recherche(delta)

# ---------------- santé ----------------
func _sante(m, delta: float) -> void:
	var pl = m.player
	var perte: float = vu_sante - pl.health
	vu_sante = pl.health
	if perte >= 1.0:
		eclair_t = T_ECLAIR
		voile_a = max(voile_a, min(VOILE_MAX, VOILE_MAX * perte / PERTE_VOILE))
		if options:
			options.vibrer(perte)
	eclair_t = max(0.0, eclair_t - delta)
	voile_a = max(0.0, voile_a - delta * 0.6)
	var part: float = pl.health / pl.SANTE_MAX
	var a := eclair_t / T_ECLAIR * 0.9
	if part < SANTE_BASSE and part > 0.0:
		pouls += delta * 6.0
		a = max(a, 0.35 * (0.5 + 0.5 * sin(pouls)))
	eclair.color.a = a
	voile.color.a = voile_a
	l_sante.text = texte_sante(pl.health)
	l_sante.add_theme_color_override("font_color", Color("ff8f80") if part < SANTE_BASSE else Color.WHITE)

# La valeur affichée ne tombe à 0 que si le héros est vraiment évanoui.
static func texte_sante(sante: float) -> String:
	return "%d" % (0 if sante <= 0.0 else max(1, int(round(sante))))

# ---------------- argent ----------------
func _argent(m) -> void:
	var d: int = m.money - vu_argent
	vu_argent = m.money
	if d > 0:
		notifier("+%d FCFA" % d, "gain")
	elif d < 0:
		notifier("-%d FCFA" % -d, "perte")

# ---------------- objet en main ----------------
# Ramasser un objet. Refusé (false) pour tout ce qui n'est pas dans OBJETS.
func prendre(nom: String) -> bool:
	if not OBJETS.has(nom):
		return false
	objet = nom
	coups = OBJETS[nom]
	return true

func lacher() -> void:
	objet = ""
	coups = 0

# Un coup donné avec l'objet ; au dernier, il casse et le héros se retrouve mains nues.
func user() -> void:
	if objet == "":
		return
	coups -= 1
	if coups <= 0:
		notifier("%s cassé%s" % ["Bâton" if objet == "bâton" else "Planche", "" if objet == "bâton" else "e"], "alerte")
		lacher()

func texte_objet() -> String:
	return "Mains nues" if objet == "" else objet.substr(0, 1).to_upper() + objet.substr(1)

func _objet(m) -> void:
	var a_pied: bool = m.cur_car == null
	l_objet.visible = a_pied
	l_objet.text = texte_objet()
	l_objet.add_theme_color_override("font_color", Color(1, 1, 1, 0.6) if objet == "" else Color.WHITE)
	objet_fond.visible = a_pied and objet != ""
	objet_jauge.visible = objet_fond.visible
	if objet != "":
		objet_jauge.size.x = 100.0 * coups / OBJETS[objet]

# ---------------- notifications ----------------
# Petit message à gauche de l'écran. Le même message répété est compté (« ×2 ») au lieu
# d'être empilé.
func notifier(texte: String, type := "info", secs := NOTIF_T) -> void:
	for old in visibles + attente:
		if old.texte == texte and old.type == type:
			old.n += 1
			old.t = secs
			return
	var n := {"texte": texte, "type": type if COULEURS.has(type) else "info", "t": secs, "n": 1}
	if visibles.size() < NOTIF_MAX:
		visibles.append(n)
	else:
		attente.append(n)
		if attente.size() > NOTIF_FILE:
			attente.pop_front()

func _notifs(delta: float) -> void:
	for n in visibles:
		n.t -= delta
	visibles = visibles.filter(func(n) -> bool: return n.t > 0.0)
	while visibles.size() < NOTIF_MAX and not attente.is_empty():
		visibles.append(attente.pop_front())
	for i in NOTIF_MAX:
		var l: Label = notif_labels[i]
		l.visible = i < visibles.size()
		if l.visible:
			var n: Dictionary = visibles[i]
			l.text = n.texte + (" ×%d" % n.n if n.n > 1 else "")
			l.add_theme_color_override("font_color", Color(COULEURS[n.type]))
			l.modulate.a = clampf(n.t / NOTIF_FONDU, 0.0, 1.0)

# ---------------- indicateur de recherche ----------------
# Appelé par le futur système de police. niveau : 0 à 5 étoiles ; perdu : la police ne voit
# plus le joueur, les étoiles clignotent jusqu'à ce qu'elle abandonne ou le retrouve.
func regler_recherche(niveau: int, perdu := false) -> void:
	var n := clampi(niveau, 0, RECHERCHE_MAX)
	if n > recherche:
		notifier("Recherché par la police : %d étoile%s" % [n, "s" if n > 1 else ""], "alerte")
	elif n == 0 and recherche > 0:
		notifier("La police ne te cherche plus", "info")
	recherche = n
	perdu_de_vue = perdu and n > 0
	if not perdu_de_vue:
		clignote_t = 0.0

func _recherche(delta: float) -> void:
	if perdu_de_vue:
		clignote_t += delta
	etoiles.visible = recherche > 0
	etoiles.regler(recherche, etoiles_eteintes())

func etoiles_eteintes() -> bool:
	return perdu_de_vue and int(clignote_t / T_CLIGNOTE) % 2 == 1
