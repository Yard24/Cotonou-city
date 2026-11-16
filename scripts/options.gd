extends RefCounted
# Options du jeu : graphismes, audio, touches du clavier, manette. Gardées dans un fichier
# JSON à part des sauvegardes : elles valent pour toutes les parties.
# Fonctionnement attendu : docs/systemes/menus.md. Vérifications : selftest_menus.gd.

const FICHIER := "user://options.json"
const DEFAUT := {
	"qualite": 2,           # 0 Bas, 1 Moyen, 2 Élevé, 3 Ultra
	"plein_ecran": false,   # sinon fenêtre agrandie
	"synchro": true,        # synchronisation verticale
	"fps_max": 0,           # images par seconde au plus ; 0 : sans limite
	"voir_fps": true,
	"vol_general": 80,      # volumes de 0 à 100
	"vol_musique": 70,
	"vol_effets": 100,
	"vol_voix": 100,
	"manette": true,
	"zone_morte": 25,       # en pourcentage de la course du manche
	"vibrations": true,
}
const FPS_CHOIX := [30, 60, 120, 0]
const BUS := {"vol_general": "Master", "vol_musique": "Musique", "vol_effets": "Effets", "vol_voix": "Voix"}
# Actions dont on peut changer la touche, dans l'ordre du menu.
const ACTIONS := [
	["up", "Avancer, accélérer"], ["down", "Reculer, freiner"], ["left", "Tourner à gauche"], ["right", "Tourner à droite"],
	["enter", "Monter, descendre, utiliser"], ["jump", "Sauter"], ["run", "Courir"], ["crouch", "S'accroupir"],
	["brake", "Frein à main"], ["horn", "Klaxon"], ["lights", "Phares"], ["blink_l", "Clignotant gauche"],
	["blink_r", "Clignotant droit"], ["cam", "Changer de caméra"]]
# Deux actions ne se gênent que si elles servent dans la même situation.
const A_PIED := ["up", "down", "left", "right", "enter", "jump", "run", "crouch"]
const EN_VEHICULE := ["up", "down", "left", "right", "enter", "brake", "horn", "lights", "blink_l", "blink_r", "cam"]
# Manette : [action, "bouton" ou "axe", numéro, sens de l'axe, nom affiché].
const MANETTE := [
	["up", "axe", JOY_AXIS_LEFT_Y, -1.0, "Manche gauche"], ["down", "axe", JOY_AXIS_LEFT_Y, 1.0, "Manche gauche"],
	["left", "axe", JOY_AXIS_LEFT_X, -1.0, "Manche gauche"], ["right", "axe", JOY_AXIS_LEFT_X, 1.0, "Manche gauche"],
	["left", "bouton", JOY_BUTTON_DPAD_LEFT, 0.0, "Croix gauche"], ["right", "bouton", JOY_BUTTON_DPAD_RIGHT, 0.0, "Croix droite"],
	["up", "axe", JOY_AXIS_TRIGGER_RIGHT, 1.0, "Gâchette droite"], ["down", "axe", JOY_AXIS_TRIGGER_LEFT, 1.0, "Gâchette gauche"],
	["jump", "bouton", JOY_BUTTON_A, 0.0, "A (bas)"], ["brake", "bouton", JOY_BUTTON_A, 0.0, "A (bas)"],
	["crouch", "bouton", JOY_BUTTON_B, 0.0, "B (droite)"], ["run", "bouton", JOY_BUTTON_X, 0.0, "X (gauche)"],
	["enter", "bouton", JOY_BUTTON_Y, 0.0, "Y (haut)"],
	["blink_l", "bouton", JOY_BUTTON_LEFT_SHOULDER, 0.0, "Bouton d'épaule gauche"], ["blink_r", "bouton", JOY_BUTTON_RIGHT_SHOULDER, 0.0, "Bouton d'épaule droit"],
	["horn", "bouton", JOY_BUTTON_LEFT_STICK, 0.0, "Clic du manche gauche"], ["lights", "bouton", JOY_BUTTON_DPAD_UP, 0.0, "Croix haut"],
	["cam", "bouton", JOY_BUTTON_BACK, 0.0, "Sélection"], ["quit", "bouton", JOY_BUTTON_START, 0.0, "Start"]]

# Dans les menus, Godot connaît déjà la croix et le manche ; on ajoute valider et retour.
const MANETTE_MENUS := [["ui_accept", "bouton", JOY_BUTTON_A, 0.0, ""], ["ui_cancel", "bouton", JOY_BUTTON_B, 0.0, ""]]

var fichier := FICHIER
var v := {}                  # valeurs courantes, mêmes clés que DEFAUT
var touches := {}            # action -> touche principale (code physique)
var touches_defaut := {}
var reservees: Array = []    # touches qu'on ne peut pas attribuer (Échap, F3, F4, flèches, Ctrl…)
var sans_ecran := false      # test automatique : on ne touche pas à la fenêtre
var vibration := []          # dernière vibration demandée [faible, forte, durée]
var manette_posee := false

# Appelé une fois au lancement, après la création des actions par main.gd.
func build(m) -> void:
	v = DEFAUT.duplicate()
	for a in ACTIONS:
		var evs := InputMap.action_get_events(a[0])
		touches_defaut[a[0]] = (evs[0] as InputEventKey).physical_keycode
		for i in range(1, evs.size()):
			if evs[i] is InputEventKey and not reservees.has(evs[i].physical_keycode):
				reservees.append(evs[i].physical_keycode)
	for k in [KEY_ESCAPE, KEY_F3, KEY_F4, KEY_ENTER, KEY_KP_ENTER]:
		if not reservees.has(k):
			reservees.append(k)
	touches = touches_defaut.duplicate()
	for b in ["Musique", "Effets", "Voix"]:
		if AudioServer.get_bus_index(b) < 0:
			AudioServer.add_bus()
			AudioServer.set_bus_name(AudioServer.bus_count - 1, b)
	lire()
	appliquer(m)

# ---------------- fichier ----------------
func lire() -> void:
	if not FileAccess.file_exists(fichier):
		return
	var json := JSON.new()
	var d = json.data if json.parse(FileAccess.get_file_as_string(fichier)) == OK else null
	if typeof(d) != TYPE_DICTIONARY:
		return   # fichier abîmé : on garde les réglages par défaut
	for k in DEFAUT:
		if d.has(k) and typeof(d[k]) in [TYPE_BOOL, TYPE_FLOAT, TYPE_INT]:
			v[k] = _borne(k, d[k])
	if typeof(d.get("touches")) == TYPE_DICTIONARY:
		for a in touches_defaut:
			var k = d.touches.get(a)
			if typeof(k) in [TYPE_FLOAT, TYPE_INT] and not reservees.has(int(k)) and int(k) > 0:
				_pose_touche(a, int(k))
		# deux actions sur la même touche dans le fichier : on revient aux touches par défaut
		for a in touches:
			if _conflit(a, touches[a]) != "":
				touches_defaut_remettre()
				break

func ecrire() -> bool:
	var d: Dictionary = v.duplicate()
	d["touches"] = touches.duplicate()
	var f := FileAccess.open(fichier, FileAccess.WRITE)
	if f == null:
		return false
	f.store_string(JSON.stringify(d, "\t"))
	f.close()
	return true

# Ramène une valeur dans ses limites et à son type.
func _borne(k: String, x):
	if typeof(DEFAUT[k]) == TYPE_BOOL:
		return bool(x)
	var n := int(x)
	match k:
		"qualite":
			return clampi(n, 0, 3)
		"fps_max":
			return n if FPS_CHOIX.has(n) else 0
		"zone_morte":
			return clampi(n, 5, 60)
	return clampi(n, 0, 100)

# Change un réglage, l'applique tout de suite et l'enregistre.
func regler(m, k: String, x) -> void:
	if not DEFAUT.has(k):
		return
	v[k] = _borne(k, x)
	appliquer(m)
	ecrire()

# ---------------- appliquer ----------------
func appliquer(m) -> void:
	# graphismes
	if m.quality != v.qualite:
		m.quality = v.qualite
		m._apply_quality()
	m.l_fps.visible = v.voir_fps
	Engine.max_fps = v.fps_max
	if not sans_ecran:
		# on ne touche à la fenêtre que pour entrer en plein écran ou en sortir
		var plein := DisplayServer.window_get_mode() in [DisplayServer.WINDOW_MODE_FULLSCREEN, DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN]
		if plein != v.plein_ecran:
			DisplayServer.window_set_mode(mode_fenetre())
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if v.synchro else DisplayServer.VSYNC_DISABLED)
	# audio
	for k in BUS:
		var i := AudioServer.get_bus_index(BUS[k])
		AudioServer.set_bus_mute(i, v[k] <= 0)
		AudioServer.set_bus_volume_db(i, decibels(v[k]))
	# manette
	_manette(v.manette)
	for a in InputMap.get_actions():
		if not str(a).begins_with("ui_"):
			InputMap.action_set_deadzone(a, v.zone_morte / 100.0)

func mode_fenetre() -> int:
	return DisplayServer.WINDOW_MODE_FULLSCREEN if v.plein_ecran else DisplayServer.WINDOW_MODE_MAXIMIZED

# Volume de 0 à 100 en décibels : 100 = 0 dB, 50 = -6 dB, 0 = muet.
static func decibels(vol: int) -> float:
	return -80.0 if vol <= 0 else linear_to_db(vol / 100.0)

# F4 et F3 changent le niveau graphique et le compteur en jeu : le menu et le fichier suivent.
func step(m) -> void:
	if m.quality != v.qualite or m.l_fps.visible != v.voir_fps:
		v.qualite = m.quality
		v.voir_fps = m.l_fps.visible
		ecrire()

# ---------------- touches ----------------
func nom_touche(k: int) -> String:
	var kc := DisplayServer.keyboard_get_keycode_from_physical(k) if not sans_ecran else k
	if kc == 0:
		kc = k
	var noms := {KEY_SPACE: "Espace", KEY_SHIFT: "Maj", KEY_CTRL: "Ctrl", KEY_ALT: "Alt", KEY_TAB: "Tab", KEY_BACKSPACE: "Retour arrière"}
	if noms.has(kc):
		return noms[kc]
	return OS.get_keycode_string(kc)

func _contextes(a: String) -> Array:
	var out := []
	if A_PIED.has(a):
		out.append(0)
	if EN_VEHICULE.has(a):
		out.append(1)
	return out

# Action qui utilise déjà cette touche dans la même situation ; "" s'il n'y en a pas.
func _conflit(action: String, k: int) -> String:
	var ctx := _contextes(action)
	for a in touches:
		if a != action and touches[a] == k:
			for c in _contextes(a):
				if ctx.has(c):
					return a
	return ""

func _pose_touche(action: String, k: int) -> void:
	for e in InputMap.action_get_events(action):
		if e is InputEventKey and e.physical_keycode == touches[action]:
			InputMap.action_erase_event(action, e)
	var ev := InputEventKey.new()
	ev.physical_keycode = k
	InputMap.action_add_event(action, ev)
	touches[action] = k

# Attribue une touche à une action. Si une autre action de la même situation l'utilisait,
# les deux échangent leurs touches. Renvoie le message à afficher ; il commence par
# « Refusé » si rien n'a changé.
func changer_touche(action: String, k: int) -> String:
	if not touches.has(action):
		return "Refusé : action inconnue."
	if reservees.has(k):
		return "Refusé : la touche %s est réservée." % nom_touche(k)
	if touches[action] == k:
		return "%s : %s" % [libelle(action), nom_touche(k)]
	var autre := _conflit(action, k)
	var ancienne: int = touches[action]
	_pose_touche(action, k)
	var msg := "%s : %s" % [libelle(action), nom_touche(k)]
	if autre != "":
		_pose_touche(autre, ancienne)
		msg += " · %s passe sur %s" % [libelle(autre), nom_touche(ancienne)]
	ecrire()
	return msg

func touches_defaut_remettre() -> void:
	for a in touches_defaut:
		_pose_touche(a, touches_defaut[a])

func libelle(action: String) -> String:
	for a in ACTIONS:
		if a[0] == action:
			return a[1]
	return action

# ---------------- manette ----------------
func _ev_manette(l: Array) -> InputEvent:
	if l[1] == "axe":
		var e := InputEventJoypadMotion.new()
		e.device = -1
		e.axis = l[2]
		e.axis_value = l[3]
		return e
	var b := InputEventJoypadButton.new()
	b.device = -1
	b.button_index = l[2]
	b.pressed = true
	return b

func _manette(on: bool) -> void:
	if on == manette_posee:
		return
	manette_posee = on
	for l in MANETTE + MANETTE_MENUS:
		var e := _ev_manette(l)
		if on:
			InputMap.action_add_event(l[0], e)
		else:
			for old in InputMap.action_get_events(l[0]):
				if old.get_class() == e.get_class() and old.is_match(e, false):
					InputMap.action_erase_event(l[0], old)

func manette_nom() -> String:
	var pads := Input.get_connected_joypads()
	return "aucune manette branchée" if pads.is_empty() else Input.get_joy_name(pads[0])

# Secousse de la manette quand le héros est blessé : plus forte et plus longue pour un gros choc.
func vibrer(perte: float) -> bool:
	if not v.manette or not v.vibrations or perte < 5.0:
		return false
	var force := clampf(perte / 40.0, 0.25, 1.0)
	vibration = [force * 0.6, force, 0.15 + 0.35 * force]
	for pad in Input.get_connected_joypads():
		Input.start_joy_vibration(pad, vibration[0], vibration[1], vibration[2])
	return true
