# Caméra et cinématiques : fonctionnement attendu

Déjà dans le jeu (`scripts/vue.gd`) : caméra à pied (6,5 m derrière, 3 m de haut), quatre vues en voiture et à moto (touche V), suivi en douceur. Ce document décrit ce qui manque. Code prévu : `scripts/vue.gd` (caméra libre), `scripts/cine.gd` (lecteur de cinématiques), `scripts/photo.gd` (mode photo). Vérifications prévues : `scripts/selftest_camera.gd`.

Rappel des décisions : caméra extérieure à trois distances plus une vue intérieure (62) ; manette prévue (114) ; dialogues sous-titrés (105) ; Koffi commente quand il conduit (107) ; pas de sang détaillé (3) ; lieux de culte respectés (18) ; pas de connexion obligatoire (71) ; missions de 5 à 12 minutes (101).

## Caméra libre
- C'est la rotation de la caméra autour de Koffi ou de son véhicule, que le joueur dirige à la souris ou au stick droit. Aujourd'hui la caméra reste derrière le héros : cela devient le comportement **par défaut quand on ne touche pas la souris**.
- **Commandes** : bouger la souris (ou le stick droit) fait tourner la caméra autour du héros. Horizontal : sans limite. Vertical : de −20° (caméra basse, regard vers le haut) à +65° (plongée). Molette (ou croix haut/bas à la manette) : distance, à pied de 3 à 10 m (6,5 m au départ). Clic du milieu ou appui sur le stick droit : recentrer derrière le héros en 0,3 seconde.
- **Sensibilité** : 0,25° par point de souris au départ, réglable de 0,05 à 1,0 dans les options ; stick droit 140° par seconde, réglable de 60 à 300. Options « inverser l'axe vertical » et « inverser l'axe horizontal ».
- **Retour automatique** : après 2,5 secondes sans mouvement de souris, si le héros avance, la caméra revient doucement derrière lui (60° par seconde). En véhicule : après 1,5 seconde. Option « caméra toujours manuelle » pour le désactiver.
- **Direction du déplacement** : au clavier seul, rien ne change (gauche/droite font pivoter le héros). Dès que la souris ou le stick droit a été utilisé pendant la session, le déplacement à pied devient **relatif à la caméra** : Haut avance dans la direction que regarde la caméra, le héros se tourne vers là où il va (10 rad/s). Une option force l'un ou l'autre mode.
- **Murs** : un rayon épais (sphère de 0,25 m) part de la tête du héros vers la caméra ; si un obstacle fixe le coupe, la caméra avance juste devant l'obstacle (en 0,1 seconde), jusqu'à 0,8 m du héros au plus près ; à moins de 1,2 m, le modèle du héros devient transparent (30 %). Elle recule de nouveau en douceur (0,5 seconde) quand la voie est libre. Les passants, véhicules en mouvement, poteaux et grillages sont ignorés (pas de sauts de caméra en pleine foule). Cela corrige le défaut noté dans « conduite voiture » (caméra qui traverse les murs en marche arrière).
- **Sol et eau** : la caméra ne descend jamais sous le sol ni sous la surface de l'eau (20 cm au-dessus au minimum).
- **Regarder derrière** : maintenir la touche B (ou gâchette, à définir avec la manette) montre l'arrière tant qu'on appuie ; en véhicule, c'est la vue arrière.
- **En véhicule** : la souris fait tourner la caméra autour du véhicule sur les trois vues extérieures ; en vue intérieure, elle tourne la tête (±100° en horizontal, −30° à +25° en vertical). Les distances de la touche V restent celles déjà fixées.
- **Champ de vision** : 70° à pied, réglable de 60 à 90° dans les options ; +6° en courant, jusqu'à +10° à pleine vitesse en véhicule (transition de 0,4 s).
- **Intérieurs** : dans une pièce, la distance est plafonnée à 3,5 m et la hauteur à 2,2 m ; dans un couloir de moins de 2 m de large, la caméra passe au-dessus de l'épaule droite (0,5 m à droite, 1,2 m derrière).
- **Tremblement** : chocs en véhicule (jusqu'à 8 cm pendant 0,4 seconde), coup reçu (3 cm) ; option « réduire les tremblements » (divise par 4) ; rien qui donne le mal des transports : pas de balancement permanent.
- **Souris** : capturée en jeu, libérée dans les menus et la pause ; si la fenêtre perd le focus, le jeu se met en pause.
- Cas limites : héros collé dos à un mur → la caméra monte au-dessus de sa tête (plongée à 60°) au lieu d'entrer dans le mur ; sous un toit bas (auvent à 2,2 m) → hauteur plafonnée sous le toit ; passage d'une vue à l'autre (à pied → moto) → transition de 0,4 seconde, l'angle choisi par le joueur est remis derrière.
- Test : 400 points de souris vers la droite font tourner la caméra de 100° à sensibilité 0,25 ; l'angle vertical reste entre −20° et +65° ; la molette borne la distance entre 3 et 10 m ; héros dos à un mur à 1 m → caméra à moins de 1 m du héros, du bon côté du mur, jamais à l'intérieur (essai sur 50 positions le long des bâtiments) ; après 2,5 secondes sans souris en marchant, la caméra est revenue à moins de 10° de l'axe arrière ; sans aucun mouvement de souris, le comportement actuel est inchangé (les tests existants de `vue.gd` passent toujours).

## Plans de cinématique
- **Principe** : toutes les cinématiques sont jouées **par le moteur du jeu**, avec les modèles et la tenue actuelle de Koffi (pas de vidéo). Elles sont décrites dans des fichiers de données, un par scène : `data/cine/<chapitre>_<mission>_<nom>.json`.
- **Format d'un fichier** : une liste de **plans**. Chaque plan a : `duree` (secondes), `camera` (type et paramètres), `acteurs` (qui est où, quelle animation), `repliques` (texte, personnage, fichier de voix, moment), `sons`, `transition` vers le plan suivant.
- **Types de plan de caméra** (9, suffisants pour tout le jeu) :

| Type | Description | Paramètres par défaut |
|---|---|---|
| `fixe` | caméra posée | focale 50° |
| `large` | plan d'ensemble d'un lieu, en hauteur | 12 à 30 m du sujet, 6 à 15 m de haut, 60° |
| `epaule` | par-dessus l'épaule de celui qui écoute, vers celui qui parle | 0,4 m sur le côté, 0,3 m derrière, 40° |
| `champ` / `contrechamp` | les deux moitiés d'un dialogue ; on ne franchit jamais la ligne entre les deux personnages | 2 m, 35° |
| `gros_plan` | visage ou objet | 1,2 m, 30° |
| `travelling` | la caméra glisse d'un point A à un point B | 0,5 à 3 m/s, départ et arrivée adoucis |
| `orbite` | tourne autour du sujet | 20° par seconde, 6 m |
| `suivi` | suit un véhicule ou un personnage, de côté ou de face | 8 m, hauteur 1,5 m |
| `grue` | monte ou descend en regardant le sujet | 2 m/s, de 1,5 à 12 m |

- **Rythme** : un plan dure 2 à 6 secondes ; une cinématique 15 à 60 secondes, 90 secondes au plus pour les débuts et fins de chapitre. Pas plus de 2 cinématiques de plus de 30 secondes par mission.
- **Transitions** : coupe franche par défaut ; fondu au noir (0,5 s) pour un changement de lieu ou d'heure ; fondu enchaîné (0,8 s) pour un passage de temps. Entrée et sortie de cinématique : deux **bandes noires** glissent en 0,4 seconde (format large), l'interface de jeu disparaît ; à la sortie, la caméra de jeu reprend exactement derrière Koffi, par une coupe ou un glissé de 0,6 seconde quand le dernier plan le permet.
- **Passer** : maintenir E (ou A à la manette) 1 seconde ; un cercle se remplit en bas à droite. Passer une cinématique place le monde dans l'état exact de sa fin (positions, objets, heure). Les cinématiques jamais vues peuvent être passées aussi (pas de visionnage forcé), sauf le premier vol en avion. Échap met en pause, avec « Reprendre », « Passer », « Quitter la mission ».
- **Sous-titres** : toujours activés au départ (décision 105), 2 lignes de 42 caractères au plus, nom du personnage en couleur devant la réplique, fond sombre à 60 %, 3 tailles ; une réplique reste au moins 1,5 seconde, et 0,06 seconde par caractère.
- **Dialogues en jeu** : la plupart des échanges se font sans cinématique, en marchant ou en conduisant (décision 107), avec sous-titres. Une cinématique est réservée aux moments forts : début et fin de mission, rencontres, coups de théâtre.
- **Acteurs** : chaque personnage va à sa marque en marchant si elle est à moins de 5 m (1,5 seconde au plus), sinon il y est placé pendant un fondu. Les passants et la circulation à moins de 15 m des marques sont écartés avant le premier plan ; la circulation est gelée hors champ et reprend à la fin. Le véhicule du joueur, s'il gêne, est rangé à l'emplacement prévu par la scène.
- **Tenue et état** : Koffi garde sa tenue, sa coiffure, sa poussière ; son véhicule garde ses dégâts. Les scènes qui exigent une tenue (cérémonie) le vérifient avant de démarrer. L'heure et la météo sont celles du jeu, sauf si la scène en impose (`heure: 18.5`, `meteo: "pluie"`), auquel cas le changement se fait pendant le fondu d'entrée.
- **Visages** : pas de synchronisation fine des lèvres ; la bouche s'ouvre et se ferme selon le volume de la voix (3 positions) ; clignement des yeux toutes les 3 à 6 secondes ; 6 expressions (neutre, sourire, rire, colère, surprise, inquiétude).
- **Contenu** : aucune arme à feu à l'image hors scènes de police écrites (décision 75) ; les coups sont cadrés large ou coupés ; pas de sang ; aucun plan dans un lieu de culte.
- **Cinématiques de trajet** : vol (voir « Avion et voyages »), car, réveil au centre de santé, arrestation (plan fixe devant le commissariat, 4 secondes).
- **Outil d'aperçu** : `--cine <nom>` lance directement une cinématique depuis la ligne de commande ; la console de débogage a la commande `cine <nom>` (voir « Outils de développement »).
- Cas limites : marque d'acteur occupée par un obstacle renversé → l'obstacle est remis à sa place pendant le fondu ; fichier de voix absent → la réplique reste affichée selon sa longueur, sans son, et une ligne est écrite dans le journal ; cinématique lancée pendant que Koffi est en l'air ou dans l'eau → elle attend qu'il soit au sol ou le place sur sa marque pendant le fondu.
- Test : chaque fichier de `data/cine/` est valide (types de plan connus, durées entre 0,5 et 20 secondes, acteurs existants, répliques de 84 caractères au plus) ; la durée totale jouée est égale à la somme des plans à ±0,1 seconde ; passer à n'importe quel instant donne le même état du monde que la lecture entière (positions des acteurs, heure, objets de mission) ; pendant la lecture, les commandes de déplacement ne bougent pas Koffi ; à la fin, l'interface est revenue et la caméra de jeu est à moins de 9 m du héros ; aucun fichier de voix manquant parmi ceux cités.

## Mode photo
- **Ouvrir** : touche P en jeu (ou depuis la pause, « Mode photo »). Le jeu se fige (monde, sons d'ambiance atténués), l'interface de jeu disparaît, un bandeau de réglages apparaît en bas. Indisponible pendant une cinématique, un écran de chargement, un évanouissement et dans les 3 secondes qui suivent un choc ; disponible en mission (le chrono est figé).
- **Déplacer la caméra** : flèches ou ZQSD pour avancer et glisser, A et E (ou gâchettes) pour monter et descendre, souris ou stick droit pour tourner, Maj pour aller plus vite (8 m/s au lieu de 2). La caméra reste dans une **sphère de 15 m autour de Koffi** (30 m en plein air si rien ne s'interpose), ne traverse ni les murs ni le sol, et ne peut pas entrer dans un bâtiment fermé ni dans une zone interdite.
- **Réglages** (bandeau, gauche/droite pour changer) :
  - champ de vision : 20 à 100° ;
  - inclinaison : −45 à +45° ;
  - mise au point : distance de 0,5 à 100 m et flou d'arrière-plan de 0 à 10 (désactivé au niveau « Bas ») ;
  - heure : décalage de −3 à +3 heures, pour la photo seulement ;
  - exposition −2 à +2, contraste, saturation ;
  - filtres : aucun, « fin d'après-midi », « harmattan », « noir et blanc », « vieille pellicule », « carte postale » (débloqué par les 12 cartes postales) ;
  - cadre : aucun, bandes de cinéma, carré, cadre « Marina City » avec le titre et « Cotonou, 2017-2026 » ;
  - Koffi : visible ou caché ; 8 poses (debout, bras croisés, salut, pouce levé, assis, accroupi, adossé, rire) et 6 expressions ; regard vers la caméra oui ou non ;
  - masquer les passants reconnaissables en gros plan : non (ils sont fictifs), mais voir le respect ci-dessous.
- **Prendre la photo** : Entrée ou clic gauche. Image en PNG, à la résolution de l'écran (option ×2 aux niveaux « Élevé » et « Ultra »), enregistrée dans `user://photos/marina_city_AAAA-MM-JJ_HHhMMmSS.png` (sous Windows : `%APPDATA%\MarinaCity\photos\`). Un message donne le nom du fichier ; « Ouvrir le dossier » dans le bandeau. Aucun envoi en ligne, aucun compte (décision 71).
- **Limite de place** : 500 photos au plus ; au-delà, le jeu prévient et propose d'ouvrir le dossier (il ne supprime rien tout seul).
- **Album** : dans le téléphone de Koffi, application « Photos » : les 30 dernières en vignettes.
- **Respect** : l'intérieur des lieux de culte n'existe pas dans le jeu ; à l'extérieur, les photos sont libres. Au village lacustre, voir « Navigation sur l'eau » (les habitants se détournent en gros plan). Aucun enfant ne peut être cadré en gros plan : à moins de 4 m d'un enfant, la caméra du mode photo est repoussée.
- **Triche impossible** : la caméra ne révèle pas les objets cachés à travers les murs (elle reste dans les volumes accessibles), le décalage d'heure ne change pas l'heure du jeu, et les adversaires ne sont pas marqués.
- **Cartes postales** (voir « Activités annexes ») : aux 12 points de vue, le mode photo s'ouvre déjà cadré ; prendre la photo valide la carte postale.
- **Fermer** : Échap ou P ; le jeu reprend exactement où il était, après un décompte visuel de 0,5 seconde en véhicule à plus de 30 km/h (pour ne pas reprendre la main par surprise).
- Cas limites : mode photo ouvert en l'air ou en pleine chute → autorisé, tout est figé ; changement de niveau graphique pendant le mode photo → refusé ; disque plein ou dossier interdit en écriture → message clair, la photo n'est pas perdue en mémoire tant que le mode est ouvert (on peut réessayer).
- Test : P fige le monde (la position d'un véhicule de circulation est identique 2 secondes plus tard) et cache l'interface ; la caméra ne s'éloigne pas de plus de 15 m du héros en ville et ne passe à travers aucun mur (essai de 200 déplacements au hasard) ; Entrée crée un fichier PNG non vide, aux dimensions de la fenêtre ; décaler l'heure de +3 ne change pas l'horloge du jeu après fermeture ; à la fermeture, la vitesse et la position du véhicule sont celles d'avant ; le mode ne s'ouvre pas pendant une cinématique ; à moins de 4 m d'un enfant, la caméra est repoussée.
