# Outils de développement : fonctionnement attendu

Déjà dans le jeu : le test automatique lancé par `-- --selftest` (`scripts/main.gd`, `scripts/selftest.gd`, `selftest_voiture.gd`, `selftest_moto.gd`, `selftest_moto_ville.gd`), qui doit afficher `SELFTEST OK` et aucune ligne `SCRIPT ERROR` ; F3 (images par seconde) et F4 (niveau graphique). Code prévu : `scripts/console.gd`, `scripts/dev.gd` (téléportation et aides), `scripts/journal.gd` et `scripts/plantage.gd` (journal et rapport). Vérifications prévues : `scripts/selftest_outils.gd`.

Rappel : pas de connexion obligatoire ni d'envoi de données (décision 71) ; fichier du jeu `MarinaCity.exe` ; Windows d'abord, Linux ensuite (118) ; toute fonction de jeu ajoutée a sa vérification dans le test automatique (conventions) ; un fichier de code ne dépasse pas 600 lignes.

## Règle commune : le mode développement
- Les outils de ce document n'existent que si le jeu est lancé avec `-- --dev`, ou depuis l'éditeur Godot. Dans la version publique, sans cette option, la console, la téléportation et les aides ne répondent pas (aucune touche cachée).
- Dès qu'une commande qui change la partie est utilisée (argent, téléportation, chapitre, santé…), la partie en cours est marquée **« modifiée »** : c'est écrit dans la sauvegarde, les succès ne se débloquent plus et le pourcentage porte un astérisque (voir « Statistiques et succès »). Les commandes d'observation (`voir`, `info`, `fps`) ne marquent rien.
- Un petit « DEV » orange s'affiche en haut à droite tant que le mode est actif.

## Console de débogage
- **Ouvrir** : touche F1 (choix de Claude : la touche « ² » dépend trop du clavier). Un panneau sombre couvre le tiers bas de l'écran : 12 lignes d'historique, une ligne de saisie. Le jeu continue derrière ; les touches de jeu sont coupées pendant la saisie. F1 ou Échap ferme.
- **Saisie** : Entrée valide ; Haut/Bas rappellent les 50 dernières commandes (gardées d'une session à l'autre dans `user://console_historique.txt`) ; Tab complète le nom de la commande ou propose les arguments (noms de lieux, de véhicules, de missions).
- **Réponses** : une ligne par résultat, en français ; vert pour un succès, orange pour un avertissement, rouge pour une erreur (« Commande inconnue : "argnet". Voulais-tu dire "argent" ? »). Une erreur de commande ne plante jamais le jeu.
- **Commandes** :

| Commande | Effet |
|---|---|
| `aide [commande]` | liste des commandes, ou détail d'une seule |
| `argent <montant>` / `argent +<montant>` | fixe ou ajoute de l'argent (FCFA, entier) |
| `sante <0-100>` | fixe la santé |
| `heure <hh[:mm]>` / `jour +<n>` | règle l'heure de jeu, avance de n jours |
| `vitesse_temps <0-20>` | ralentit ou accélère le jeu (1 = normal, 0 = figé) |
| `meteo <soleil\|harmattan\|pluie\|orage>` | change la météo |
| `chapitre <1-6>` | place l'histoire au début d'un chapitre (ville, prix, âge de Koffi) |
| `mission <liste\|lancer\|reussir\|echouer\|etape> [nom]` | pilote le moteur de missions |
| `etoiles <0-5>` | fixe le niveau de recherche |
| `reputation <quartier\|groupe> <valeur>` | fixe une réputation |
| `vehicule <modele> [degats] [carburant]` | fait apparaître un véhicule 5 m devant le joueur |
| `reparer` / `plein` | répare et fait le plein du véhicule courant |
| `tenue <identifiant>` / `objet <identifiant> [n]` | donne une tenue ou un objet |
| `tp …` | téléportation (voir plus bas) |
| `invincible <oui\|non>` | la santé ne descend plus |
| `passants <n>` / `circulation <n>` | fixe le nombre de passants ou de véhicules ; 0 pour vider |
| `voir <collisions\|chemins\|zones\|occulteurs\|masques\|perception\|abris\|sons>` | affiche ou cache un calque de débogage |
| `info [objet]` | décrit ce que vise la caméra : nom, état, zone, niveau de détail |
| `cine <nom>` | joue une cinématique |
| `langue <fr\|en\|xx>` | change la langue |
| `qualite <bas\|moyen\|eleve\|ultra>` | change le niveau graphique |
| `bench` | lance le parcours de mesure |
| `sauver <1-3>` / `charger <1-3\|auto>` | sauvegarde ou charge un emplacement |
| `test [nom]` | lance le test automatique, ou une seule famille |
| `journal [n]` | affiche les n dernières lignes du journal |
| `capture` | enregistre une image de l'écran dans `user://captures/` |
| `rapport` | fabrique un rapport comme après un plantage, sans planter |
| `quitter` | ferme le jeu |

- **Fichiers de commandes** : `executer <fichier>` lit `user://scripts_console/<fichier>.txt`, une commande par ligne, `#` pour les commentaires. `-- --dev --console "argent 50000; tp dantokpa; heure 18"` exécute des commandes au lancement (séparées par des points-virgules) — pratique pour Bravo : un raccourci Windows par situation à essayer.
- **Calques `voir`** : collisions en fil de fer vert ; chemins des passants et de la circulation en bleu ; frontières et noms des zones de 250 m ; cônes de vue des adversaires (jaune, rouge en alerte) et rayons d'ouïe ; marqueurs d'abri ; sons en cours (cercle et nom).
- **Écran d'état** (F2, mode développement) : position du joueur (x, y, z, zone), vitesse, état (à pied, moto…), mission et étape en cours, heure et jour de jeu, météo, étoiles, nombre d'objets actifs.
- Cas limites : argument hors bornes → refus avec les bornes rappelées, rien n'est changé ; commande lancée pendant une cinématique → refusée sauf `voir`, `info`, `journal`, `capture` ; `chapitre` pendant une mission → la mission est d'abord abandonnée, avec demande de confirmation (`chapitre 4 oui`).
- Test : sans `--dev`, F1 n'ouvre rien et `Console.executer("argent 1000")` renvoie un refus ; avec `--dev`, `argent 5000` fixe l'argent à 5 000 et marque la partie « modifiée », `voir zones` ne la marque pas ; `argent abc` et `sante 150` renvoient une erreur sans rien changer ; une commande inconnue propose la plus proche ; chaque commande du tableau est déclarée avec un texte d'aide ; `--console "argent 50000; heure 18"` donne 50 000 FCFA et 18 h au démarrage ; l'historique est relu au lancement suivant.

## Téléportation
- Sert à essayer vite un lieu ou une situation sans traverser la ville. Mode développement seulement.
- **Par la console** :
  - `tp <lieu>` : vers un lieu nommé. Les lieux sont dans `data/lieux_tp.json` (nom, position, orientation) : `amazone`, `marina`, `ganhi`, `dantokpa`, `missebo`, `etoile_rouge`, `akpakpa`, `port`, `fidjrosse`, `aeroport`, `pont_ancien`, `pont_milieu`, `pont_nord`, `embarcadere`, `village_lacustre`, `maison`, `atelier_romaric`, `commissariat`, `centre_sante`, plus un point par propriété et par ville (`parakou`, `ouidah`…). Au moins un lieu par quartier et un par intérieur.
  - `tp <x> <z>` ou `tp <x> <y> <z>` : vers des coordonnées en mètres ; sans y, le joueur est posé sur le sol.
  - `tp mission [nom]` : au point de départ de la mission nommée, ou à l'objectif en cours.
  - `tp repere` : au repère posé sur la grande carte.
  - `tp retour` : à la position d'avant la dernière téléportation (10 positions gardées).
  - `tp zone <CC> <RR>` : au centre d'une zone de 250 m.
- **Par la carte** : grande carte ouverte, clic droit sur un point = téléportation à cet endroit.
- **Vol libre** : touche F6 — le héros ne subit plus la gravité ni les collisions, se déplace à 20 m/s (Maj : 80 m/s), monte et descend avec A et E. F6 de nouveau le repose au sol sous lui. Sert à inspecter les toits et les limites de la carte.
- **Déroulement d'une téléportation** : fondu au noir de 0,2 seconde ; chargement de la zone d'arrivée et de ses 8 voisines (voir « Performance ») ; le joueur est tenu immobile jusqu'à ce que le sol existe ; il est posé **sur le sol libre le plus proche** de la position demandée (recherche en spirale jusqu'à 20 m si le point est dans un mur, un véhicule ou l'eau profonde) ; fondu d'ouverture. Vitesse remise à zéro, caméra replacée derrière lui.
- **Avec un véhicule** : téléporté au volant, le joueur arrive avec son véhicule, posé sur la chaussée la plus proche, à l'arrêt, sans passager (un client de zémidjan en cours est déposé et la course annulée sans paiement).
- **Autre ville** : `tp parakou` fait le changement de ville complet (voir « Avion et voyages », chargement des villes), sans billet ni cinématique.
- **Effets annexes** : étoiles de recherche et poursuivants effacés (sinon ils resteraient à l'ancien endroit) ; l'heure ne change pas ; la mission en cours continue, sauf si elle impose une zone — alors un avertissement orange le dit.
- **Marque** : toute téléportation marque la partie « modifiée ».
- Cas limites : lieu inconnu → liste des noms proches ; coordonnées hors de la carte → ramenées au bord, avec un avertissement ; zone d'arrivée dont le fichier manque → téléportation annulée, retour à la position de départ ; téléportation pendant une chute, une nage ou un évanouissement → l'état est remis à « debout » ; en vol libre, les objets à collecter ne se ramassent pas.
- Test : `tp dantokpa` place le héros à moins de 2 m de la position du fichier, sur le sol (écart vertical inférieur à 0,1 m), vitesse nulle ; chaque lieu de `data/lieux_tp.json` est à l'intérieur de la carte, hors de l'eau profonde, hors d'un obstacle, et la téléportation vers chacun réussit ; `tp` vers un point situé dans un bâtiment pose le héros dehors à moins de 20 m ; `tp retour` ramène à la position précédente à 1 m près ; `tp` au volant garde le véhicule avec ses dégâts ; les étoiles tombent à 0 ; sans `--dev`, rien ne se passe.

## Tests automatiques
- **Principe actuel, conservé** : `MarinaCity -- --selftest` (en pratique `godot --headless --fixed-fps 60 -- --selftest`) joue une suite de vérifications dans le vrai jeu, à pas de temps fixe, sans écran, et termine par `SELFTEST OK` ou `SELFTEST ECHEC`. Code de sortie 0 ou 1. Aucune ligne `SCRIPT ERROR` n'est tolérée.
- **Organisation** : un fichier `scripts/selftest_<famille>.gd` par système (joueur, voiture, moto, eau, tenue, repas, réputation, adversaire, décor, caméra, perf, texte, tuto, stats, outils…), chacun de moins de 600 lignes. Chaque fichier déclare une liste de cas : un nom en français (« une chute de 8 m laisse environ 45 points »), une préparation, des actions, des attentes.
- **Chaque cas est isolé** : il démarre d'un monde d'essai remis à neuf (petite scène plate « banc d'essai » de 300 × 300 m avec mer, pente, mur, muret, route, ou un morceau nommé de la vraie carte quand le cas le demande), avec un générateur de hasard à graine fixe (`graine = 2017` par défaut). L'ordre des cas ne change pas le résultat.
- **Outils offerts aux cas** : appuyer et relâcher une touche simulée ; avancer de n secondes ; placer le héros, un véhicule, un passant, un adversaire ; régler l'heure, la météo, le chapitre, l'argent ; comparer avec une tolérance (`attendre_entre(valeur, min, max, "ce que c'est")`) ; attendre un événement avec un délai maximal.
- **Options de lancement** :
  - `--selftest` : tout ;
  - `--selftest voiture,moto` : seulement ces familles ;
  - `--selftest-cas "chute de 8 m"` : les cas dont le nom contient ce texte ;
  - `--selftest-rapide` : les cas marqués « rapides » (objectif : moins de 60 secondes au total) ;
  - `--selftest-graine 42` : autre graine, pour débusquer les cas qui dépendent du hasard ;
  - `--selftest-rapport user://tests/rapport.json` : résultat détaillé (par cas : réussi ou non, durée, message).
- **Sortie** : une ligne par famille (`voiture : 34 réussis, 0 raté — 12,4 s`), puis pour chaque raté le nom du cas, la valeur attendue et la valeur mesurée (`ATTENDU entre 8 et 11, MESURÉ 12,3 — distance en 1 s de course`). Dernière ligne : `SELFTEST OK (412 cas, 3 min 05 s)`.
- **Durée** : suite complète en moins de 10 minutes en mode sans écran (le temps simulé va plus vite que le temps réel) ; un cas ne dépasse pas 60 secondes simulées, sauf les parcours (mission 1 jouée de bout en bout, traversée de la carte), marqués « longs ».
- **Trois niveaux de vérification** :
  1. **règles** (la majorité) : une fonction, une règle, un chiffre de ces documents ;
  2. **données** : chaque fichier de `data/` est lisible, complet et cohérent (identifiants uniques, positions atteignables, prix positifs, clés de texte existantes, voix présentes) ;
  3. **parcours** : un robot joue une mission entière ou traverse la ville pendant plusieurs minutes simulées, et l'on vérifie qu'il n'y a ni erreur, ni chute sous le sol, ni blocage de plus de 20 secondes, ni mémoire qui enfle.
- **Garde-fous du projet** vérifiés à chaque passage : aucun fichier `.gd` de plus de 600 lignes ; aucun mot de la liste d'interdits dans les textes et les données (armes à feu pour le joueur, jeux d'argent, partis, marques réelles listées) ; le titre de la fenêtre est « Marina City » ; les décisions chiffrées déjà validées (barème des dégâts, prix d'une course, soins à 10 % plafonnés à 2 000 FCFA) ont chacune un cas nommé d'après la décision.
- **Quand** : avant chaque commit d'un lot (règle de `TRAVAIL_AUTOMATIQUE.md`). Un lot dont le test échoue n'est pas poussé. Une vérification qui échoue de temps en temps est traitée comme un échec : on la corrige ou on corrige le jeu, on ne la retire pas.
- **Images** : pas de comparaison d'images en mode sans écran. Un mode à part, `--captures-test`, à lancer sur un PC avec écran, prend 12 images à des points fixes (même heure, même météo, même graine) dans `user://captures_test/` pour que Bravo ou Claude les compare d'un lot à l'autre.
- Cas limites : un cas qui plante n'arrête pas la suite (il est compté raté, le monde d'essai est recréé) ; un cas qui dépasse son délai est interrompu et compté raté ; famille inconnue en option → erreur claire et code de sortie 2.
- Test (du système de test lui-même) : un cas volontairement faux est bien compté raté et donne le code de sortie 1 ; un cas qui provoque une erreur de script est compté raté sans arrêter les suivants ; deux passages avec la même graine donnent les mêmes mesures au millième ; `--selftest voiture` ne lance que cette famille ; le rapport JSON contient une entrée par cas ; la suite rapide dure moins de 60 secondes.

## Rapport de plantage
- **But** : quand le jeu plante ou se fige chez Bravo ou chez un joueur, obtenir de quoi comprendre, sans rien envoyer tout seul (décision 71).
- **Journal de session** : `user://journal/session_AAAA-MM-JJ_HHhMMmSS.log`, écrit au fil de l'eau (vidé sur le disque à chaque ligne importante). Contenu : version du jeu et date de fabrication, système, processeur, carte graphique et pilote, mémoire, résolution, niveau graphique, langue ; puis les événements : chargement et déchargement de zones, début, étape et fin de mission, sauvegardes, changement de ville, avertissements, erreurs de script avec le fichier et la ligne, images de plus de 100 ms. Une ligne = heure réelle, heure de jeu, catégorie, message. Les 10 dernières sessions sont gardées, 5 Mo au plus chacune (au-delà, le début est coupé).
- **Balise de session** : un fichier `user://session_en_cours` est créé au lancement et supprimé à la fermeture normale. S'il existe au lancement, c'est que la session précédente s'est mal terminée.
- **Trois cas détectés** :
  1. **erreur de script** en jeu : le jeu ne se ferme pas ; l'erreur est notée ; à la 20e erreur identique en une minute, un bandeau propose de sauvegarder et de créer un rapport ;
  2. **plantage** (le jeu se ferme tout seul) : au lancement suivant, la balise le révèle ;
  3. **jeu figé** : un fil de surveillance vérifie que la boucle principale avance ; sans image depuis 15 secondes (hors chargement), il écrit l'état dans le journal ; si le joueur ferme alors la fenêtre, c'est traité comme un plantage.
- **Au lancement après un plantage** : une fenêtre simple — « Marina City s'est mal fermé la dernière fois. Ta partie est intacte : la dernière sauvegarde automatique date de 14 h 32. » Trois boutons : « Créer un rapport », « Continuer », « Ouvrir le dossier des rapports ».
- **Le rapport** : un fichier `user://rapports/rapport_AAAA-MM-JJ_HHhMM.zip` contenant : le journal de la session fautive ; un résumé lisible `resume.txt` (version, machine, ce que faisait le joueur : ville, zone, position, à pied ou véhicule, mission et étape, heure de jeu, temps écoulé depuis le lancement, dernière erreur) ; les réglages (`reglages.cfg`) ; la dernière image de l'écran si elle a pu être gardée (une capture réduite à 640 px est prise toutes les 30 secondes en mémoire, écrite seulement en cas d'erreur) ; la sauvegarde automatique, **seulement si le joueur coche la case**.
- **Vie privée** : le rapport ne contient ni nom d'utilisateur (les chemins sont raccourcis : `user://…`), ni nom de la machine, ni adresse réseau, ni fichier hors du dossier du jeu. Le résumé est affiché au joueur avant création. **Aucun envoi automatique** : le jeu ouvre le dossier et dit « Envoie ce fichier à l'adresse indiquée sur la page du jeu » ; un bouton « Copier le résumé » met le texte dans le presse-papiers.
- **Protection de la partie** : les sauvegardes sont écrites dans un fichier temporaire puis renommées (jamais de sauvegarde à moitié écrite) ; l'avant-dernière sauvegarde automatique est gardée (`auto_precedente`) ; si la sauvegarde automatique est illisible, le jeu propose la précédente.
- **Plantages répétés** : 2 mauvaises fermetures de suite dans les 60 premières secondes → au 3e lancement, le jeu propose de démarrer en **mode sans risque** (niveau graphique Bas, rendu Compatibilité, fenêtre 1280 × 720) ; le choix est annulable dans les options.
- **Mode développement** : la commande `rapport` de la console fabrique un rapport à la demande ; `plantage_test` provoque volontairement une erreur de script pour vérifier la chaîne.
- **Ménage** : 20 rapports gardés au plus, les plus anciens supprimés ; le dossier des journaux ne dépasse pas 50 Mo.
- Cas limites : disque plein → le rapport n'est pas créé, message clair, le jeu continue ; plantage pendant l'écriture d'une sauvegarde → le fichier temporaire est ignoré, la sauvegarde d'avant est intacte ; plantage avant l'ouverture du journal (tout début) → la balise suffit à proposer le mode sans risque.
- Test : une session normale crée puis supprime la balise ; une session interrompue de force laisse la balise, et le lancement suivant affiche la fenêtre de rapport ; « Créer un rapport » produit un zip contenant `resume.txt` et le journal, sans la sauvegarde si la case n'est pas cochée ; le résumé ne contient ni nom d'utilisateur ni chemin absolu (recherche du nom du compte et de « C:\Users », « /home/ ») ; `plantage_test` écrit une ligne d'erreur avec fichier et ligne dans le journal ; une sauvegarde interrompue à mi-écriture laisse la précédente lisible ; 2 mauvaises fermetures rapides proposent le mode sans risque ; aucun appel réseau n'est fait par ces fonctions.
