# Menu principal — maquette

- Tâche : T5148 (« Menu principal : dessiner la maquette »).
- Image : `menu_principal.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Point de départ : reprendre, commencer ou charger une partie, régler le jeu, voir les succès et les crédits, quitter.

## Quand il s'affiche
Après l'écran titre ; au retour d'une partie par « Quitter » du menu pause ; à la fin des crédits.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre du jeu | 96, 62 | 367 × 84 | « MARINA CITY » | Barlow Condensed Bold 76, or, interlettrage 2. |
| 3 | Bande tricolore | 96, 140 | 216 × 6 | — | Trois segments de 72 × 6. |
| 4 | Sous-titre | 96, 158 | 190 × 24 | « Cotonou, 2017-2026 » | Barlow Medium 22, crème. |
| 5 | Bouton « Continuer » | 96, 216 | 360 × 52 | « Continuer » | Reprend la dernière sauvegarde (automatique ou manuelle, la plus récente). Absent s'il n'existe aucune sauvegarde : la sélection part alors sur « Nouvelle partie ». État montré : sélectionné. |
| 6 | Bouton « Nouvelle partie » | 96, 276 | 360 × 52 | « Nouvelle partie » | Ouvre l'écran Nouvelle partie. |
| 7 | Bouton « Charger une partie » | 96, 336 | 360 × 52 | « Charger une partie » | Ouvre l'écran Chargement de partie. Grisé s'il n'existe aucune sauvegarde. |
| 8 | Bouton « Options » | 96, 396 | 360 × 52 | « Options » | Ouvre les options, onglet Graphismes. |
| 9 | Bouton « Succès » | 96, 456 | 360 × 52 | « Succès » | Ouvre l'écran Succès. |
| 10 | Bouton « Crédits » | 96, 516 | 360 × 52 | « Crédits » | Ouvre l'écran Crédits. |
| 11 | Bouton « Quitter le jeu » | 96, 576 | 360 × 52 | « Quitter le jeu » | Ouvre la boîte de confirmation « Quitter le jeu ? ». |
| 12 | Carte « Dernière partie » | 640, 216 | 592 × 292 | — | Résumé de la sauvegarde que « Continuer » va charger. Masquée s'il n'y a pas de sauvegarde. |
| 13 | Étiquette de la carte | 664, 239 | 149 × 18 | « DERNIÈRE PARTIE » | Barlow SemiBold 16, capitales, interlettrage 1,5, brun clair a3957f. |
| 14 | Vignette de la sauvegarde | 664, 268 | 224 × 126 | — | Capture d'écran réduite prise au moment de la sauvegarde (16:9). |
| 15 | Chapitre | 912, 271 | 231 × 33 | « Chapitre 1 — Le retour » | Barlow Condensed SemiBold 30. |
| 16 | Année et difficulté | 912, 311 | 187 × 20 | « 2017 · Difficulté : Normal » | Barlow Regular 18, gris clair. |
| 17 | Argent | 912, 337 | 127 × 33 | « 12 450 FCFA » | Barlow Condensed Bold 30, vert clair 8df59a. |
| 18 | Temps de jeu | 912, 375 | 161 × 20 | « Temps de jeu : 3 h 42 » | Barlow Regular 18. |
| 19 | Mission suivante | 664, 414 | 390 × 22 | « Mission suivante : La dette de Tonton Gratien » | Barlow Medium 20. Nom de la prochaine mission principale. |
| 20 | Barre d'avancement de l'histoire | 664, 448 | 544 × 8 | — | Rail 6b4a30, remplissage or ; ici 9 %. |
| 21 | Avancement | 664, 469 | 103 × 20 | « Histoire : 9 % » | Barlow Regular 18. |
| 22 | Date de la sauvegarde | 848, 471 | 360 × 18 | « Sauvegarde automatique · 14 novembre 2026, 18 h 07 » | Barlow Regular 16, aligné à droite. Date et heure réelles du PC. |
| 23 | Conseil | 640, 533 | 592 × 20 | « Conseil : à moto, le frein arrière (Espace) aide à tourner serré. » | Barlow Regular 18, jaune pâle ffe27a. Tiré au hasard dans la liste de `ecran_de_chargement.md`. |
| 24 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Valider » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |
| 25 | Version | 48, 685 | 74 × 18 | « Version 0.1 » | Barlow Regular 16, dans la barre d'aide, à gauche. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Valider | Entrée ou Espace | Clic gauche | A |
| Aller sur « Quitter le jeu » | Échap | — | B |
| Premier ou dernier choix | Début, Fin | — | — |

## Enchaînements
- « Continuer » : `ecran_de_chargement.md`, puis le jeu, à l'endroit de la dernière sauvegarde.
- « Nouvelle partie » : `nouvelle_partie.md`.
- « Charger une partie » : `chargement_de_partie.md`.
- « Options » : `options_graphiques.md` (les onglets mènent à `options_audio.md`, `options_de_touches.md`, `choix_de_la_langue.md`).
- « Succès » : `succes.md`. « Crédits » : `credits.md`.
- « Quitter le jeu » : boîte de confirmation (titre « Quitter le jeu ? », texte « Ta partie est sauvegardée après chaque mission. », boutons « Quitter » et « Rester », sélection sur « Rester »).
- 3 minutes sans action : retour à `ecran_titre.md`.

## Règles et états
- La sélection boucle : Bas sur « Quitter le jeu » revient à « Continuer ».
- À l'ouverture, la sélection est sur « Continuer » s'il existe une sauvegarde, sinon sur « Nouvelle partie » et la carte « Dernière partie » est remplacée par le texte « Aucune partie enregistrée. Lance une nouvelle partie pour commencer. » (Barlow Regular 20, crème, à x = 640, y = 260).
- Chaque déplacement joue `bruit_menu_deplacer.ogg`, chaque validation `bruit_menu_valider.ogg`.
- Les statistiques ne sont pas ici : elles appartiennent à une partie et s'ouvrent depuis le menu pause.
- Les noms de chapitre et de mission de la maquette sont des exemples ; les noms définitifs viendront de `docs/histoire/`.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- `VBoxContainer` de 7 `Button` (séparation 8, taille minimale 360 × 52) ; `focus_neighbor_top` du premier vers le dernier et inversement pour la boucle.
- Le survol de la souris appelle `grab_focus()` : une seule notion de sélection pour les trois périphériques.
- Lire les sauvegardes dans `user://sauvegardes/` (`auto.sav`, `emplacement_1.sav` à `emplacement_3.sav`) ; la plus récente alimente la carte.
