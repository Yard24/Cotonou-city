extends RefCounted
# Test automatique de la sauvegarde : manuelle, automatique, chargement, emplacements,
# compatibilité entre versions. Appelé par systemes.gd à la fin du test complet, tout dans
# la même image, dans un dossier de sauvegardes réservé au test.

const DT := 1.0 / 60.0

# Renvoie "" si tout va bien, sinon le message d'échec.
func run(m) -> String:
	var s = m.sys.sauvegarde
	for t in [_manuelle, _automatique, _chargement, _emplacements, _versions]:
		_propre(m, s)
		var e: String = t.call(m, s)
		if e != "":
			return e
	_propre(m, s)
	m.mission_i = m.missions.size()
	m._set_mission()
	s.synchro(m)
	return ""

func _propre(m, s) -> void:
	for i in s.NB_MANUELS + 1:
		s.supprimer(i)
	if m.cur_car != null:
		m.cur_car.speed = 0.0
		m._get_off()
	m.zem.fare = {}
	m.player.ko_t = 0.0
	m.player.down_t = 0.0
	s.synchro(m)

# Met la partie dans un état connu, héros debout au sol.
func _etat(m, argent: int, mission: int, pos: Vector3, cap: float, sante: float) -> void:
	m.money = argent
	m.mission_i = mission
	m._set_mission()
	m.player.teleport(pos, cap)
	m.player.on_ground = true
	m.player.swimming = false
	m.player.health = sante

func _texte(chemin: String, texte: String) -> void:
	DirAccess.make_dir_recursive_absolute(chemin.get_base_dir())
	var f := FileAccess.open(chemin, FileAccess.WRITE)
	f.store_string(texte)
	f.close()

func _manuelle(m, s) -> String:
	var pl = m.player
	var mo = m.moto_romaric
	_etat(m, 1234, 1, Vector3(30, 0, 40), 1.0, 62.0)
	m.zem.done = 2
	mo.global_position = Vector3(40, 0, -30)
	mo.heading = 0.7
	mo.damage = 30.0
	s.temps_jeu = 725.0
	# refus : en l'air, évanoui, client à bord, véhicule qui roule, emplacement inexistant
	pl.on_ground = false
	if s.sauver(m, 1) or s.erreur == "" or FileAccess.file_exists(s.chemin(1)):
		return "sauvegarde manuelle : acceptée en l'air"
	pl.on_ground = true
	pl.ko_t = 1.0
	if s.sauver(m, 1):
		return "sauvegarde manuelle : acceptée évanoui"
	pl.ko_t = 0.0
	m.zem.fare = {"essai": true}
	if s.sauver(m, 1):
		return "sauvegarde manuelle : acceptée avec un client à bord"
	m.zem.fare = {}
	if s.sauver(m, 0) or s.sauver(m, 4):
		return "sauvegarde manuelle : acceptée hors des emplacements 1 à 3"
	if not s.sauver(m, 1):
		return "sauvegarde manuelle : refusée sans raison (%s)" % s.erreur
	if not FileAccess.file_exists(s.chemin(1)) or FileAccess.file_exists(s.chemin(1) + ".tmp"):
		return "sauvegarde manuelle : fichier absent ou fichier provisoire resté"
	var brut = JSON.parse_string(FileAccess.get_file_as_string(s.chemin(1)))
	if typeof(brut) != TYPE_DICTIONARY or int(brut.version) != s.VERSION or int(brut.argent) != 1234:
		return "sauvegarde manuelle : contenu du fichier inattendu"
	# on change tout, puis on recharge
	_etat(m, 5, 0, Vector3(-60, 0, -178), 2.0, 11.0)
	m.zem.done = 9
	mo.global_position = Vector3(0, 0, 100)
	mo.damage = 90.0
	s.temps_jeu = 3.0
	if not s.charger(m, 1):
		return "sauvegarde manuelle : rechargement impossible (%s)" % s.erreur
	if m.money != 1234 or m.mission_i != 1 or m.zem.done != 2 or abs(pl.health - 62.0) > 0.01 or abs(s.temps_jeu - 725.0) > 0.11:
		return "sauvegarde manuelle : argent %d, mission %d, courses %d, santé %.0f après rechargement" % [m.money, m.mission_i, m.zem.done, pl.health]
	if pl.global_position.distance_to(Vector3(30, 0, 40)) > 0.01 or abs(pl.heading - 1.0) > 0.001:
		return "sauvegarde manuelle : héros replacé en %s" % pl.global_position
	if mo.global_position.distance_to(Vector3(40, 0, -30)) > 0.01 or abs(mo.damage - 30.0) > 0.01 or abs(mo.heading - 0.7) > 0.001:
		return "sauvegarde manuelle : moto replacée en %s, dégâts %.0f" % [mo.global_position, mo.damage]
	if m.l_mission.text != m.missions[1].t or abs(m.marker.position.x - m.missions[1].x) > 0.01:
		return "sauvegarde manuelle : la mission affichée n'est pas celle de la sauvegarde"
	# en voiture : refusée en roulant, acceptée à l'arrêt, le héros est noté debout à côté
	var c = m.cars[0]
	c.global_position = Vector3(60, 0, 0)
	c.heading = 0.0
	c.rotation.y = 0.0
	m.mount(c)
	c.speed = 10.0
	if s.sauver(m, 2):
		return "sauvegarde manuelle : acceptée en roulant"
	c.speed = 0.0
	if not s.sauver(m, 2):
		return "sauvegarde manuelle : refusée à l'arrêt en voiture (%s)" % s.erreur
	if not s.charger(m, 2) or m.cur_car != null or not pl.visible or pl.shape.disabled:
		return "sauvegarde manuelle : après chargement, le héros devrait être à pied"
	var d: float = pl.global_position.distance_to(c.global_position)
	if d < 2.0 or d > 3.0:
		return "sauvegarde manuelle : héros à %.1f m de la voiture (attendu 2,4 m)" % d
	print("sauvegarde manuelle : refusée en l'air, évanoui, avec un client, en roulant ; argent, mission, courses, santé, position, moto et temps de jeu retrouvés ; en voiture, le héros est rechargé à pied à %.1f m" % d)
	return ""

func _automatique(m, s) -> String:
	_etat(m, 100, 2, Vector3(20, 0, -40), 0.0, 80.0)
	if not s.sauver(m, 1):
		return "sauvegarde automatique : préparation impossible"
	var avant: String = FileAccess.get_file_as_string(s.chemin(1))
	s.synchro(m)
	var n0: int = s.nb_auto
	s.step(m, DT)
	if s.nb_auto != n0 or FileAccess.file_exists(s.chemin(0)):
		return "sauvegarde automatique : faite sans mission réussie"
	# la vraie fin de mission : le héros arrive au point de la mission 3
	var mi: Dictionary = m.missions[2]
	m._mission(Vector3(mi.x, 0, mi.z))
	if m.mission_i != 3:
		return "sauvegarde automatique : la mission 3 ne se termine pas"
	s.step(m, DT)
	var a: Dictionary = s.lire(0)
	if s.nb_auto != n0 + 1 or a.is_empty() or a.mission != 3 or a.argent != 100 + mi.r:
		return "sauvegarde automatique : pas de sauvegarde après la mission"
	s.step(m, DT)
	if s.nb_auto != n0 + 1:
		return "sauvegarde automatique : refaite à l'image suivante"
	# une course de zémidjan payée
	m.zem.done += 1
	m.money += 300
	s.step(m, DT)
	if s.nb_auto != n0 + 2 or s.lire(0).argent != 400 + mi.r:
		return "sauvegarde automatique : pas de sauvegarde après une course payée"
	# évanoui : elle attend le réveil
	m.zem.done += 1
	m.player.ko_t = 1.0
	s.step(m, DT)
	if s.nb_auto != n0 + 2:
		return "sauvegarde automatique : faite pendant un évanouissement"
	m.player.ko_t = 0.0
	s.step(m, DT)
	if s.nb_auto != n0 + 3:
		return "sauvegarde automatique : pas rattrapée après le réveil"
	# charger une partie plus ancienne ne déclenche pas de sauvegarde automatique
	if not s.charger(m, 1):
		return "sauvegarde automatique : chargement impossible"
	s.step(m, DT)
	if s.nb_auto != n0 + 3 or m.mission_i != 2:
		return "sauvegarde automatique : déclenchée par un chargement"
	if FileAccess.get_file_as_string(s.chemin(1)) != avant:
		return "sauvegarde automatique : elle a touché à un emplacement manuel"
	print("sauvegarde automatique : après la mission 3 et après une course payée, une seule fois ; attend le réveil si évanoui ; pas après un chargement ; emplacements manuels intacts")
	return ""

func _chargement(m, s) -> String:
	var pl = m.player
	_etat(m, 777, 1, Vector3(-30, 0, 50), 0.3, 55.0)
	var p0: Vector3 = pl.global_position
	if s.charger(m, 3) or s.erreur != "Emplacement vide." or m.money != 777 or pl.global_position != p0:
		return "chargement : emplacement vide accepté ou partie modifiée"
	_texte(s.chemin(3), "{ ceci n'est pas une sauvegarde")
	if s.charger(m, 3) or not s.erreur.begins_with("Sauvegarde illisible") or m.money != 777 or m.mission_i != 1 or pl.global_position != p0:
		return "chargement : fichier abîmé accepté ou partie modifiée"
	_texte(s.chemin(3), "[1, 2, 3]")
	if s.charger(m, 3) or m.money != 777:
		return "chargement : fichier qui n'est pas une sauvegarde accepté"
	# chargement en pleine action : à moto avec un client, évanoui, bandeau affiché
	if not s.sauver(m, 1):
		return "chargement : préparation impossible"
	var mo = m.moto_romaric
	m.mount(mo)
	mo.speed = 15.0
	mo.set_passenger(true, Color.WHITE)
	m.zem.fare = {"cl": m.zem.clients[0], "moto": mo, "dest": 1, "prix": 300}
	m.zem.clients[0].state = "a_bord"
	pl.health = 3.0
	m._banner("essai")
	m.money = 0
	if not s.charger(m, 1):
		return "chargement : refusé en pleine course (%s)" % s.erreur
	if m.cur_car != null or not m.zem.fare.is_empty() or mo.speed != 0.0 or m.l_banner.visible:
		return "chargement : véhicule, client ou bandeau de l'ancienne partie encore là"
	if m.money != 777 or abs(pl.health - 55.0) > 0.01 or pl.global_position.distance_to(p0) > 0.01 or pl.ko_t > 0.0:
		return "chargement : état du héros incorrect après chargement"
	if m.cam.global_position.distance_to(pl.global_position) > 12.0:
		return "chargement : la caméra n'a pas rejoint le héros"
	print("chargement : emplacement vide et fichier abîmé refusés sans toucher à la partie ; en pleine course, le héros se retrouve à pied, sans client, caméra sur lui")
	return ""

func _emplacements(m, s) -> String:
	if s.liste().size() != 4 or s.plus_recent() != -1:
		return "emplacements : il en faut 4 (1 automatique, 3 manuels), vides au départ"
	for r in s.liste():
		if not r.vide or not r.texte.ends_with("vide"):
			return "emplacements : « %s » devrait être vide" % r.texte
	# trois parties différentes dans les trois emplacements
	for i in [1, 2, 3]:
		_etat(m, 1000 * i, i - 1, Vector3(10 * i, 0, 20), 0.0, 90.0)
		var d: Dictionary = s.capture(m)
		d.date = "2026-11-1%d 14:32:05" % i
		d.temps = 3900.0 * i
		if not s.ecrire(i, d):
			return "emplacements : écriture impossible"
	for i in [1, 2, 3]:
		if not s.charger(m, i) or m.money != 1000 * i or m.mission_i != i - 1 or abs(m.player.global_position.x - 10.0 * i) > 0.01:
			return "emplacements : l'emplacement %d ne rend pas sa partie" % i
	var t: String = s.resume(2, 3).texte
	if t != "Emplacement 2 — Mission 2/3 · 2 000 FCFA · 2 h 10 · 12/11/2026 14:32":
		return "emplacements : résumé « %s »" % t
	if s.plus_recent() != 3:
		return "emplacements : la plus récente devrait être la 3"
	var a: Dictionary = s.capture(m)
	a.date = "2026-11-15 09:00:00"
	a.mission = 3
	s.ecrire(0, a)
	if s.plus_recent() != 0 or not s.resume(0, 3).texte.begins_with("Sauvegarde automatique — Balade libre"):
		return "emplacements : la sauvegarde automatique n'est pas comptée"
	if not s.supprimer(3) or not s.resume(3).vide or s.supprimer(3) or s.resume(2).vide:
		return "emplacements : suppression incorrecte"
	_texte(s.chemin(3), "abîmé")
	var r3: Dictionary = s.resume(3)
	if r3.vide or not r3.illisible or s.plus_recent() != 0:
		return "emplacements : un fichier abîmé devrait être signalé illisible"
	if s.milliers(0) != "0" or s.milliers(999) != "999" or s.milliers(12500) != "12 500" or s.milliers(1234567) != "1 234 567":
		return "emplacements : séparateur de milliers"
	print("emplacements : 1 automatique + 3 manuels indépendants ; résumé « %s » ; « Continuer » prend la plus récente ; suppression et fichier abîmé signalés" % t)
	return ""

func _versions(m, s) -> String:
	var pl = m.player
	# format 1 : tout à plat, noms anglais
	_etat(m, 1, 0, Vector3(0, 0, 0), 0.0, 100.0)
	_texte(s.chemin(1), JSON.stringify({"version": 1, "money": 900, "mission_i": 2, "x": 50.0, "z": 60.0, "heading": 0.5, "health": 40.0}))
	var mo_pos: Vector3 = m.moto_romaric.global_position
	if not s.charger(m, 1):
		return "versions : sauvegarde au format 1 refusée (%s)" % s.erreur
	if m.money != 900 or m.mission_i != 2 or pl.global_position.distance_to(Vector3(50, 0, 60)) > 0.01 or abs(pl.health - 40.0) > 0.01 or abs(pl.heading - 0.5) > 0.001:
		return "versions : format 1 mal converti (argent %d, mission %d)" % [m.money, m.mission_i]
	if m.moto_romaric.global_position != mo_pos:
		return "versions : format 1 sans moto, la moto ne devait pas bouger"
	# sans numéro de version : lu comme le format 1
	_texte(s.chemin(2), JSON.stringify({"money": 350, "mission_i": 1, "x": -20.0, "z": 30.0, "heading": 0.0, "health": 90.0}))
	if not s.charger(m, 2) or m.money != 350:
		return "versions : sauvegarde sans numéro de version refusée"
	if s.lire(2).version != s.VERSION:
		return "versions : la sauvegarde convertie n'est pas au format actuel"
	# version plus récente que le jeu : refusée, partie intacte
	_texte(s.chemin(3), JSON.stringify({"version": s.VERSION + 1, "argent": 5, "mission": 0}))
	if s.charger(m, 3) or not s.erreur.contains("plus récente") or m.money != 350:
		return "versions : sauvegarde d'une version future acceptée"
	if not s.resume(3).illisible:
		return "versions : une sauvegarde future devrait être signalée dans la liste"
	# format actuel incomplet ou absurde : valeurs sûres
	_texte(s.chemin(3), JSON.stringify({"version": 2, "argent": -50, "mission": 99, "inconnu": "plus tard", "heros": {"x": 99999.0, "sante": 500.0, "cap": "nord"}}))
	if not s.charger(m, 3):
		return "versions : sauvegarde incomplète refusée (%s)" % s.erreur
	if m.money != 0 or m.mission_i != m.missions.size() or pl.global_position.x > 205.01 or abs(pl.global_position.z + 50.0) > 0.01 or pl.health != 100.0 or abs(pl.heading - PI) > 0.001:
		return "versions : valeurs absurdes non corrigées (argent %d, mission %d, x %.0f, santé %.0f)" % [m.money, m.mission_i, pl.global_position.x, pl.health]
	_texte(s.chemin(3), JSON.stringify({"version": 2}))
	if not s.charger(m, 3) or pl.global_position.distance_to(Vector3(14, 0, -50)) > 0.01 or m.mission_i != 0:
		return "versions : une sauvegarde vide de contenu devrait ramener au point de départ"
	_texte(s.chemin(3), JSON.stringify({"version": 0}))
	if s.charger(m, 3):
		return "versions : numéro de version 0 accepté"
	print("compatibilité : format 1 et fichier sans numéro convertis au format %d ; version future refusée sans toucher à la partie ; valeurs absentes ou absurdes remplacées par des valeurs sûres" % s.VERSION)
	return ""
