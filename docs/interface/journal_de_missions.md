# Journal de missions — maquette

- Tâche : T5184 (« Journal de missions : dessiner la maquette »).
- Image : `journal_de_missions.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Rappeler ce que Koffi a à faire : mission en cours et ses objectifs, missions disponibles, missions terminées, et l'état de ses affaires (dette, courses).

## Quand il s'affiche
En jeu sur Tab (clavier) ou croix bas (manette), ou depuis « Journal de missions » du menu pause. Le jeu est en pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 349 × 53 | « Journal de missions » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Onglet « En cours » | 88, 124 | 176 × 44 | « En cours » | Onglet actif (fond or, texte brun). |
| 5 | Onglet « Disponibles » | 272, 124 | 176 × 44 | « Disponibles » | Onglet inactif. |
| 6 | Onglet « Terminées » | 456, 124 | 176 × 44 | « Terminées » | Onglet inactif. |
| 7 | Touches de changement d'onglet | 48, 132 | 620 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 8 | Avancement du chapitre | 931, 139 | 301 × 20 | « Chapitre 1 · 2 missions principales sur 8 » | Barlow Regular 18, aligné à droite sur la ligne des onglets. |
| 9 | Intertitre « Histoire » | 48, 199 | 76 × 18 | « HISTOIRE » | Barlow SemiBold 16, capitales. |
| 10 | Intertitre « Travail et affaires » | 48, 307 | 184 × 18 | « TRAVAIL ET AFFAIRES » | Barlow SemiBold 16, capitales. |
| 11 | Ligne « La moto de Romaric » | 48, 224 | 440 × 64 | « La moto de Romaric / Romaric · Ganhi » | Icône de carte 40 × 40, titre Barlow Condensed SemiBold 24, détail Barlow Regular 16. État montré : sélectionnée. |
| 12 | Ligne « Courses de zémidjan » | 48, 332 | 440 × 64 | « Courses de zémidjan / Le Doyen · partout en ville » | Icône de carte 40 × 40, titre Barlow Condensed SemiBold 24, détail Barlow Regular 16. |
| 13 | Ligne « Beignets du matin » | 48, 404 | 440 × 64 | « Beignets du matin / Maman Koffi · Dantokpa » | Icône de carte 40 × 40, titre Barlow Condensed SemiBold 24, détail Barlow Regular 16. |
| 14 | Ligne « La dette de Tonton Gratien » | 48, 476 | 440 × 64 | « La dette de Tonton Gratien / Reste 18 000 FCFA à rembourser » | Icône de carte 40 × 40, titre Barlow Condensed SemiBold 24, détail Barlow Regular 16. |
| 15 | Panneau de détail | 512, 188 | 720 × 452 | — | Détail de la ligne sélectionnée. |
| 16 | Titre de la mission | 544, 209 | 274 × 42 | « La moto de Romaric » | Barlow Condensed Bold 38. |
| 17 | Type, donneur, lieu | 544, 255 | 418 × 20 | « Mission principale 2 sur 8 · Donnée par Romaric · Ganhi » | Barlow Regular 18. |
| 18 | Résumé | 544, 294 | 656 × 78 | « Romaric te prête sa moto, mais il veut d'abord voir si tu sais encore conduire à Cotonou après trois ans à Lagos. Fais trois courses sans lui rayer la peinture. » | Barlow Regular 20, interligne 28, 3 lignes au plus. |
| 19 | Liste des objectifs | 544, 392 | 656 × 180 | « OBJECTIFS / Rejoins Romaric à son atelier / Monte sur la moto / Conduis le client à Ganhi / Fais deux autres courses / Rapporte la moto à Romaric » | Une ligne de 30 par objectif, Barlow 20. Fait : pastille verte à coche, texte gris clair. En cours : triangle et texte jaune pâle ffe27a, SemiBold. À venir : cercle vide et texte brun clair. |
| 20 | Récompense | 544, 526 | 260 × 32 | « Récompense / 500 FCFA » | Étiquette Barlow SemiBold 16, icône `objet_argent.svg` 32, montant Barlow Condensed Bold 26 vert clair. |
| 21 | Bouton « Voir sur la carte » | 544, 572 | 260 × 44 | « Voir sur la carte » | Ouvre la grande carte centrée sur l'objectif en cours. |
| 22 | Bouton « Abandonner la mission » | 940, 572 | 260 × 44 | « Abandonner la mission » | Demande confirmation, puis arrête la mission. Présent seulement pour une mission en cours. |
| 23 | Barre d'aide | 0, 664 | 1280 × 56 | « [A] [E] Onglet · [Haut] [Bas] Choisir · [Droite] Détail · [Entrée] Valider · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer d'onglet | A et E | Clic sur l'onglet | LB et RB |
| Changer de ligne | Flèches haut et bas, ou Z et S | Survol ; molette pour faire défiler | Croix ou stick gauche, haut et bas |
| Passer de la liste aux boutons du détail, et revenir | Flèches droite et gauche, ou D et Q | Survol | Croix ou stick gauche, droite et gauche |
| Activer le bouton sélectionné | Entrée ou Espace | Clic gauche | A |
| Voir sur la carte (raccourci depuis la liste) | Entrée sur une ligne | Double clic sur une ligne | A sur une ligne |
| Fermer | Échap ou Tab | Clic droit | B |

## Enchaînements
- « Voir sur la carte » : `grande_carte.md`, centrée sur l'objectif, qui devient l'objectif suivi.
- « Abandonner la mission » : boîte « Abandonner cette mission ? » (texte « Tu pourras la reprendre plus tard auprès de Romaric. », boutons « Abandonner » et « Continuer », sélection sur « Continuer ») ; après abandon, retour au jeu, hors mission.
- « Rejouer la mission » (onglet « Terminées ») : boîte de confirmation, puis `ecran_de_chargement.md` et la mission.
- Fermer : retour au jeu ou à `menu_pause.md`, selon l'origine.

## Règles et états
- À l'ouverture : onglet « En cours », première ligne sélectionnée ; le détail suit la sélection sans délai.
- La liste défile au-delà de 6 lignes (barre de défilement à x = 492, comme dans `options_de_touches.md`).
- Aucune mission n'oblige à faire du mal à un innocent (décision 102) : les résumés ne le proposent jamais.
- La ligne « La dette de Tonton Gratien » disparaît une fois la dette remboursée (fin du chapitre 2, décision 72).
- Pendant une mission, les onglets « Disponibles » et « Terminées » restent consultables, mais « Rejouer la mission » est grisé.

## Contenu des onglets
- « En cours » : la mission principale lancée ou à reprendre, puis les activités ouvertes (courses de zémidjan, livraisons, dette).
- « Disponibles » : missions qui attendent le joueur, avec le texte de détail « Va voir <personnage> à <lieu> » et la distance ; bouton « Voir sur la carte » seulement.
- « Terminées » : missions finies, de la plus récente à la plus ancienne, avec « Temps », « Gain » et le bouton « Rejouer la mission » à la place de « Abandonner la mission ».
- Onglet vide : texte centré dans la colonne de gauche, « Rien ici pour le moment. » (Barlow Regular 20, gris clair).

## Noms des missions
Les titres de la maquette (« La moto de Romaric », « Beignets du matin », « La dette de Tonton Gratien ») sont des exemples cohérents avec les décisions 28 à 31 et 93 ; les titres définitifs viendront de `docs/histoire/`. Un titre tient en 30 caractères, un résumé en 220 caractères, un objectif en 48 caractères : au-delà, l'écran coupe avec « … ».

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Données attendues par mission : identifiant, titre, type (principale, secondaire, activité), donneur, lieu, résumé, liste d'objectifs avec état, récompense en FCFA, position de l'objectif.
- Action à ajouter dans `InputMap` : `journal` (Tab, croix bas).
