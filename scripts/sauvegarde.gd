extends RefCounted
# Sauvegarde : un emplacement automatique et trois emplacements manuels (décision 115),
# chargement, et lecture des sauvegardes faites avec une version plus ancienne du jeu.
# Un fichier JSON par emplacement dans le dossier de l'utilisateur.
# Fonctionnement attendu : docs/systemes/sauvegarde.md. Vérifications : selftest_sauvegarde.gd.

const VERSION := 2            # numéro du format de fichier, augmenté à chaque changement de format
const DOSSIER := "user://sauvegardes"
const NB_MANUELS := 3
const AUTO := 0               # emplacement 0 : automatique ; 1 à 3 : manuels
const VITESSE_ARRET := 1.5    # m/s : au-dessus, le véhicule « roule » et on ne sauvegarde pas à la main

var dossier := DOSSIER
var erreur := ""              # raison du dernier refus ou échec, en clair pour le joueur
var temps_jeu := 0.0          # secondes jouées dans cette partie
var vu_mission := 0           # dernières valeurs vues, pour déclencher la sauvegarde automatique
var vu_courses := 0
var nb_auto := 0              # sauvegardes automatiques faites depuis le lancement
var affichage = null          # pour annoncer « Partie sauvegardée »

func chemin(slot: int) -> String:
	return dossier + ("/auto.json" if slot == AUTO else "/manuel_%d.json" % slot)

func nom(slot: int) -> String:
	return "Sauvegarde automatique" if slot == AUTO else "Emplacement %d" % slot

# ---------------- écrire ----------------
# Photographie de la partie. À bord d'un véhicule, le héros est noté debout à côté.
func capture(m) -> Dictionary:
	var p: Vector3 = m.player.global_position
	var cap: float = m.player.heading
	if m.cur_car:
		cap = m.cur_car.heading
		p = m.cur_car.global_position + Vector3(cos(cap), 0, -sin(cap)) * (1.2 if m.cur_car.moto else 2.4)
	var mo = m.moto_romaric
	return {
		"version": VERSION,
		"jeu": "Marina City",
		"date": Time.get_datetime_string_from_system(false, true),
		"temps": snappedf(temps_jeu, 0.1),
		"argent": int(m.money),
		"mission": int(m.mission_i),
		"courses": int(m.zem.done),
		"heros": {"x": p.x, "y": p.y, "z": p.z, "cap": cap, "sante": m.player.health},
		"moto": {"x": mo.global_position.x, "z": mo.global_position.z, "cap": mo.heading, "degats": mo.damage},
	}

# Raison pour laquelle on ne peut pas sauvegarder à la main maintenant ; "" si on peut.
func refus(m) -> String:
	var pl = m.player
	if pl.ko_t > 0.0:
		return "Impossible de sauvegarder : Koffi est évanoui."
	if not m.zem.fare.is_empty():
		return "Dépose d'abord ton client."
	if m.cur_car:
		if abs(m.cur_car.speed) > VITESSE_ARRET:
			return "Arrête-toi d'abord."
		return ""
	if pl.down_t > 0.0:
		return "Impossible de sauvegarder : Koffi est par terre."
	if pl.swimming:
		return "Sors de l'eau d'abord."
	if not pl.on_ground or pl.mantle_t > 0.0:
		return "Impossible de sauvegarder en l'air."
	return ""

# Sauvegarde manuelle dans l'emplacement 1, 2 ou 3.
func sauver(m, slot: int) -> bool:
	if slot < 1 or slot > NB_MANUELS:
		erreur = "Cet emplacement n'existe pas."
		return false
	erreur = refus(m)
	if erreur != "":
		return false
	if not ecrire(slot, capture(m)):
		return false
	if affichage:
		affichage.notifier("Partie sauvegardée (emplacement %d)" % slot, "sauvegarde")
	return true

# Sauvegarde automatique : jamais refusée, sauf évanoui (on attend alors le réveil).
func sauver_auto(m) -> bool:
	if m.player.ko_t > 0.0:
		return false
	if not ecrire(AUTO, capture(m)):
		return false
	nb_auto += 1
	if affichage:
		affichage.notifier("Sauvegarde automatique", "sauvegarde", 2.5)
	return true

# Écrit d'abord un fichier provisoire, puis le renomme : une coupure de courant pendant
# l'écriture ne détruit pas la sauvegarde précédente.
func ecrire(slot: int, d: Dictionary) -> bool:
	DirAccess.make_dir_recursive_absolute(dossier)
	var tmp := chemin(slot) + ".tmp"
	var f := FileAccess.open(tmp, FileAccess.WRITE)
	if f == null:
		erreur = "Écriture impossible (disque plein ou dossier protégé)."
		return false
	f.store_string(JSON.stringify(d, "\t"))
	f.close()
	if DirAccess.rename_absolute(tmp, chemin(slot)) != OK:
		erreur = "Écriture impossible (disque plein ou dossier protégé)."
		return false
	erreur = ""
	return true

func supprimer(slot: int) -> bool:
	if not FileAccess.file_exists(chemin(slot)):
		return false
	return DirAccess.remove_absolute(chemin(slot)) == OK

# ---------------- lire ----------------
# Contenu d'un emplacement, mis au format actuel. Vide si l'emplacement est libre ou illisible
# (dans ce cas « erreur » dit pourquoi).
func lire(slot: int) -> Dictionary:
	erreur = ""
	if not FileAccess.file_exists(chemin(slot)):
		erreur = "Emplacement vide."
		return {}
	var json := JSON.new()   # (JSON.parse_string écrirait une erreur dans le journal du jeu)
	var brut = json.data if json.parse(FileAccess.get_file_as_string(chemin(slot))) == OK else null
	if typeof(brut) != TYPE_DICTIONARY:
		erreur = "Sauvegarde illisible (fichier abîmé)."
		return {}
	return migrer(brut)

# Met une sauvegarde au format actuel, version par version. Une sauvegarde faite avec un jeu
# plus récent est refusée : on ne devine pas un format qu'on ne connaît pas.
func migrer(src: Dictionary) -> Dictionary:
	var d: Dictionary = src.duplicate(true)
	var v := int(_nombre(d.get("version"), 1.0))
	if v > VERSION:
		erreur = "Cette sauvegarde vient d'une version plus récente du jeu. Mets le jeu à jour pour la charger."
		return {}
	if v < 1:
		erreur = "Sauvegarde illisible (fichier abîmé)."
		return {}
	if v == 1:
		d = _v1_vers_v2(d)
	# à la prochaine version : « if v <= 2: d = _v2_vers_v3(d) », et ainsi de suite
	return _completer(d)

# Format 1 (premières versions d'essai) : tout à plat, noms anglais, pas de moto ni de date.
func _v1_vers_v2(a: Dictionary) -> Dictionary:
	return {
		"version": 2,
		"jeu": "Marina City",
		"date": "",
		"temps": 0.0,
		"argent": a.get("money", 0),
		"mission": a.get("mission_i", 0),
		"courses": 0,
		"heros": {"x": a.get("x"), "y": 0.0, "z": a.get("z"), "cap": a.get("heading"), "sante": a.get("health")},
	}

# Toute valeur absente ou absurde est remplacée par une valeur sûre : une sauvegarde
# incomplète se charge quand même, au point de départ s'il le faut.
func _completer(d: Dictionary) -> Dictionary:
	var h: Dictionary = d.get("heros") if typeof(d.get("heros")) == TYPE_DICTIONARY else {}
	var out := {
		"version": VERSION,
		"jeu": "Marina City",
		"date": str(d.get("date", "")),
		"temps": max(0.0, _nombre(d.get("temps"), 0.0)),
		"argent": int(max(0.0, _nombre(d.get("argent"), 0.0))),
		"mission": int(max(0.0, _nombre(d.get("mission"), 0.0))),
		"courses": int(max(0.0, _nombre(d.get("courses"), 0.0))),
		"heros": {
			"x": clampf(_nombre(h.get("x"), 14.0), -205.0, 205.0),
			"y": clampf(_nombre(h.get("y"), 0.0), -3.0, 60.0),
			"z": clampf(_nombre(h.get("z"), -50.0), -260.0, 205.0),
			"cap": _nombre(h.get("cap"), PI),
			"sante": clampf(_nombre(h.get("sante"), 100.0), 1.0, 100.0),
		},
	}
	if typeof(d.get("moto")) == TYPE_DICTIONARY:
		var mo: Dictionary = d.moto
		out["moto"] = {
			"x": clampf(_nombre(mo.get("x"), 12.0), -205.0, 205.0),
			"z": clampf(_nombre(mo.get("z"), -52.0), -190.0, 205.0),
			"cap": _nombre(mo.get("cap"), 0.0),
			"degats": clampf(_nombre(mo.get("degats"), 0.0), 0.0, 100.0),
		}
	return out

func _nombre(v, defaut: float) -> float:
	if typeof(v) != TYPE_FLOAT and typeof(v) != TYPE_INT:
		return defaut
	var x := float(v)
	return defaut if is_nan(x) or is_inf(x) else x

# Charge un emplacement. Si le fichier est vide, abîmé ou trop récent, la partie en cours
# n'est pas touchée.
func charger(m, slot: int) -> bool:
	var d := lire(slot)
	if d.is_empty():
		return false
	appliquer(m, d)
	return true

# Remet le jeu dans l'état de la sauvegarde : le héros est à pied, sans client.
func appliquer(m, d: Dictionary) -> void:
	for a in ["up", "down", "left", "right", "brake", "run", "jump", "crouch"]:
		Input.action_release(a)
	if not m.zem.fare.is_empty():
		m.zem._end(m, false, 1.2)
	m.zem.offer = {}
	if m.cur_car:
		m.cur_car.speed = 0.0
		m._get_off()
	m.money = d.argent
	m.mission_i = min(d.mission, m.missions.size())
	m._set_mission()
	m.zem.done = d.courses
	temps_jeu = d.temps
	var pl = m.player
	pl.teleport(Vector3(d.heros.x, d.heros.y, d.heros.z), d.heros.cap)
	pl.health = d.heros.sante
	pl.ko_t = 0.0
	pl.sitting = false
	pl.visible = true
	pl.shape.disabled = false
	if d.has("moto"):
		var mo = m.moto_romaric
		if mo.fallen:
			mo.stand_up()
		mo.repair()
		mo.damage = d.moto.degats
		mo._show_damage()
		mo.global_position = Vector3(d.moto.x, 0, d.moto.z)
		mo.heading = d.moto.cap
		mo.rotation.y = d.moto.cap
		mo.speed = 0.0
		mo.prev_speed = 0.0
		mo.prev_heading = d.moto.cap
	m.banner_t = 0.0
	m.l_banner.visible = false
	m.info_t = 0.0
	m._camera(0.016, true)
	synchro(m)
	if affichage:
		affichage.synchro(m)

# ---------------- emplacements ----------------
# Ce que le menu affiche pour un emplacement.
func resume(slot: int, nb_missions := 3) -> Dictionary:
	var d := lire(slot)
	if d.is_empty():
		var abime := FileAccess.file_exists(chemin(slot))
		return {"slot": slot, "vide": not abime, "illisible": abime, "date": "",
			"texte": "%s — %s" % [nom(slot), erreur if abime else "vide"]}
	var etape := "Balade libre" if d.mission >= nb_missions else "Mission %d/%d" % [d.mission + 1, nb_missions]
	var t := int(d.temps)
	var texte := "%s — %s · %s FCFA · %d h %02d" % [nom(slot), etape, milliers(d.argent), t / 3600, (t % 3600) / 60]
	if d.date != "":
		texte += " · " + date_fr(d.date)
	return {"slot": slot, "vide": false, "illisible": false, "date": d.date, "texte": texte}

func liste(nb_missions := 3) -> Array:
	var out := []
	for s in NB_MANUELS + 1:
		out.append(resume(s, nb_missions))
	return out

# Emplacement de la sauvegarde la plus récente (bouton « Continuer ») ; -1 s'il n'y en a aucune.
func plus_recent() -> int:
	var best := -1
	var bd := ""
	for r in liste():
		if not r.vide and not r.illisible and (best < 0 or r.date > bd):
			best = r.slot
			bd = r.date
	return best

# « 2026-11-16 14:32:05 » devient « 16/11/2026 14:32 ».
static func date_fr(iso: String) -> String:
	if iso.length() < 16:
		return iso
	return "%s/%s/%s %s" % [iso.substr(8, 2), iso.substr(5, 2), iso.substr(0, 4), iso.substr(11, 5)]

# 12500 devient « 12 500 ».
static func milliers(n: int) -> String:
	var s := str(abs(n))
	var out := ""
	while s.length() > 3:
		out = " " + s.substr(s.length() - 3) + out
		s = s.substr(0, s.length() - 3)
	return ("-" if n < 0 else "") + s + out

# ---------------- sauvegarde automatique ----------------
func synchro(m) -> void:
	vu_mission = m.mission_i
	vu_courses = m.zem.done

# Appelé à chaque image de jeu : sauvegarde après chaque mission réussie et chaque course payée.
func step(m, delta: float) -> void:
	temps_jeu += delta
	if m.mission_i != vu_mission or m.zem.done != vu_courses:
		if m.mission_i > vu_mission or m.zem.done > vu_courses:
			if not sauver_auto(m):
				return   # évanoui : on réessaie à l'image suivante
		synchro(m)
