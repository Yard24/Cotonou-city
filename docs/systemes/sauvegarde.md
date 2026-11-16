# Sauvegarde : fonctionnement attendu

Code : `scripts/sauvegarde.gd` (écriture, lecture, emplacements, versions), `scripts/menus.gd` (panneaux « Sauvegarder » et « Charger », bouton « Continuer »), branchés par `scripts/systemes.gd`. Vérifications : `scripts/selftest_sauvegarde.gd` et `scripts/selftest_menus.gd`, lancés à la fin du test automatique.

Décision 115 : sauvegarde automatique après chaque mission, plus 3 emplacements manuels.

## Ce qui est gardé
- Argent, numéro de la mission en cours, nombre de courses de zémidjan payées, temps de jeu, date et heure.
- Héros : position, direction, santé.
- Moto de Romaric : position, direction, dégâts.
- Pas encore gardés (ils reviennent à leur place de départ au chargement) : voitures empruntées et leurs dégâts, clients de zémidjan, circulation, objet tenu en main, niveau de recherche.
- Les options (graphismes, audio, touches, manette) ne sont pas dans la sauvegarde : elles valent pour toutes les parties (voir `menus.md`).

Un fichier par emplacement, au format JSON, dans le dossier de l'utilisateur (`user://sauvegardes/` ; sous Windows : `%APPDATA%\Godot\app_userdata\Marina City\sauvegardes\`) : `auto.json`, `manuel_1.json`, `manuel_2.json`, `manuel_3.json`.

## Sauvegarde manuelle
- Échap (pause), « Sauvegarder », puis un des trois emplacements. Le bouton « Sauvegarder » n'existe que dans la pause, pas sur l'écran d'accueil.
- Emplacement vide : sauvegarde immédiate. Emplacement occupé : question « Remplacer la partie de l'emplacement N ? », réponse « Non » par défaut.
- Refusée, avec la raison affichée dans le panneau : Koffi évanoui ou par terre après une chute ; en l'air ou en train de franchir un muret ; dans l'eau (« Sors de l'eau d'abord. ») ; un client à bord (« Dépose d'abord ton client. ») ; véhicule qui roule à plus de 1,5 m/s (« Arrête-toi d'abord. »).
- À bord d'un véhicule à l'arrêt : acceptée ; le héros est enregistré debout à côté du véhicule (1,2 m à gauche d'une moto, 2,4 m d'une voiture).
- Le fichier est d'abord écrit sous un nom provisoire puis renommé : une coupure pendant l'écriture ne détruit pas la sauvegarde précédente.
- Une notification « Partie sauvegardée (emplacement N) » s'affiche en jeu.
- Plus tard : points de sauvegarde dans les logements du héros (lot « Propriétés »), image de la partie dans l'emplacement.
- Test : les cinq refus ; fichier présent sans fichier provisoire ; après avoir tout changé puis rechargé, on retrouve argent, mission, courses, santé, position, direction, moto (place et dégâts) et temps de jeu ; en voiture, refus en roulant, accord à l'arrêt, héros rechargé à pied à 2,4 m.

## Sauvegarde automatique
- Un seul emplacement, à part des trois manuels ; elle ne touche jamais à un emplacement manuel.
- Faite après chaque mission réussie et après chaque course de zémidjan payée, une seule fois par événement, sans rien demander. Notification « Sauvegarde automatique » pendant 2,5 s.
- Jamais refusée (même en roulant), sauf si Koffi est évanoui : elle attend alors son réveil.
- Charger une partie ne déclenche pas de sauvegarde automatique.
- Plus tard : aussi au dernier point de contrôle d'une mission (décision 101), à l'achat d'une propriété, à la sortie d'un bâtiment.
- Test : rien sans événement ; une sauvegarde après la vraie fin de la mission 3 (argent et mission exacts dans le fichier) ; pas de seconde à l'image suivante ; une après une course payée ; attente pendant l'évanouissement puis rattrapage ; rien après un chargement ; emplacement manuel inchangé à l'octet près.

## Chargement
- Écran d'accueil : « Continuer » (seulement s'il existe une sauvegarde) charge la plus récente des quatre ; « Charger une partie » ouvre la liste des quatre emplacements, les vides sont grisés.
- En pause : « Charger une partie », puis question « Charger cette partie ? Ce qui n'est pas sauvegardé sera perdu. », « Non » par défaut. Depuis l'écran d'accueil, pas de question.
- Après chargement : le jeu reprend tout de suite, héros à pied à l'endroit enregistré, sans client, véhicule quitté, bandeaux et messages de l'ancienne partie effacés, caméra placée derrière lui. Ni gain ni perte d'argent annoncés.
- Emplacement vide, fichier abîmé ou fichier qui n'est pas une sauvegarde : refus avec un message clair (« Emplacement vide. », « Sauvegarde illisible (fichier abîmé). ») et la partie en cours n'est pas touchée. Le fichier abîmé n'est pas effacé.
- Test : les trois refus sans aucun changement de la partie ; chargement à moto, à 54 km/h, avec un client et presque plus de santé : héros à pied, client descendu, moto arrêtée, bandeau effacé, santé et argent de la sauvegarde, caméra à moins de 12 m.

## Emplacements multiples
- Quatre emplacements : « Sauvegarde automatique » et « Emplacement 1 » à « 3 », indépendants.
- Chaque ligne du menu résume la partie : `Emplacement 2 — Mission 2/3 · 2 000 FCFA · 2 h 10 · 12/11/2026 14:32` (étape, argent avec séparateur de milliers, temps de jeu, date). Toutes les missions finies : « Balade libre ». Libre : « vide ». Illisible : la raison.
- « La plus récente » se décide à la date écrite dans le fichier.
- Un emplacement peut être supprimé par le code (`supprimer`) ; il n'y a pas encore de bouton pour cela, on remplace.
- Plus tard : bouton « Supprimer », copie d'un emplacement vers un autre, plusieurs profils de joueur.
- Test : quatre emplacements vides au départ ; trois parties différentes rendues chacune par son emplacement ; texte exact du résumé ; la plus récente est choisie, sauvegarde automatique comprise ; suppression ; fichier abîmé signalé illisible et jamais choisi par « Continuer » ; séparateur de milliers.

## Compatibilité entre versions
- Chaque fichier porte un numéro de format (`"version"`, aujourd'hui 2). Il n'augmente que si le format change, pas à chaque version du jeu.
- Format plus ancien : converti à la lecture, version par version (1 vers 2, plus tard 2 vers 3…), sans modifier le fichier ; il sera réécrit au format actuel à la prochaine sauvegarde dans cet emplacement. Le format 1 est celui des premiers essais (tout à plat, noms anglais : `money`, `mission_i`, `x`, `z`, `heading`, `health`) ; un fichier sans numéro est lu comme du format 1.
- Format plus récent que le jeu : refusé avec « Cette sauvegarde vient d'une version plus récente du jeu. Mets le jeu à jour pour la charger. » ; le fichier reste intact.
- Valeur absente : valeur de départ (place de l'Amazone, santé 100, argent 0, mission 1). Valeur absurde : ramenée dans ses limites (argent jamais négatif, santé de 1 à 100, position dans la carte, mission au plus « toutes finies »). Champs inconnus : ignorés.
- Règle pour la suite : on n'enlève et on ne renomme un champ qu'en augmentant le numéro et en écrivant la conversion, avec son test.
- Test : fichier au format 1 et fichier sans numéro chargés avec les bonnes valeurs ; version 3 refusée, partie intacte, signalée dans la liste ; valeurs absurdes corrigées ; fichier presque vide = point de départ ; version 0 refusée.
