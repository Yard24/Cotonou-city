# Mode photo — maquette

- Tâche : T5236 (« Mode photo : dessiner la maquette »).
- Image : `mode_photo.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Figer le jeu, déplacer librement la caméra autour de Koffi et enregistrer une image.

## Quand il s'affiche
Depuis « Mode photo » du menu pause, l'application « Photo » du téléphone, ou la touche P en jeu. Le jeu est figé ; l'affichage en jeu (argent, mini-carte) est masqué.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Grille de cadrage | 40, 40 | 864 × 584 | — | Cadre pointillé et règle des tiers, crème à 35 % ; masquable. La photo enregistrée est l'image entière, sans grille ni panneau. |
| 3 | Panneau des réglages | 928, 24 | 328 × 616 | — | À droite ; masqué avec H. |
| 4 | Titre de l'écran | 952, 45 | 157 × 42 | « Mode photo » | Barlow Condensed Bold 38. |
| 5 | Filet tricolore | 952, 88 | 96 × 6 | — | Trois segments de 32 × 6. |
| 6 | Réglage « Zoom » | 940, 116 | 304 × 48 | « Zoom : 70° » | Curseur. Champ de vision de 20° à 100°. État montré : sélectionné. |
| 7 | Réglage « Inclinaison » | 940, 168 | 304 × 48 | « Inclinaison : 0° » | Curseur. De −45° à +45°. |
| 8 | Réglage « Flou d'arrière-plan » | 940, 220 | 304 × 48 | « Flou d'arrière-plan : 0 % » | Curseur. De 0 à 100 %. |
| 9 | Réglage « Heure » | 940, 272 | 304 × 48 | « Heure : 17 h 42 » | Curseur. De 0 h à 23 h 59, pour la photo seulement. |
| 10 | Réglage « Filtre » | 940, 324 | 304 × 48 | « Filtre : Aucun » | Liste à flèches. Aucun, Harmattan, Coucher de soleil, Noir et blanc, Vieille pellicule. |
| 11 | Réglage « Cadre » | 940, 376 | 304 × 48 | « Cadre : Aucun » | Liste à flèches. Aucun, Bandes noires, Carte postale. |
| 12 | Réglage « Montrer Koffi » | 940, 428 | 304 × 48 | « Montrer Koffi : Oui » | Interrupteur. |
| 13 | Réglage « Titre du jeu » | 940, 480 | 304 × 48 | « Titre du jeu : Non » | Interrupteur. Ajoute « Marina City » en bas à droite de la photo. |
| 14 | Réglage « Grille » | 940, 532 | 304 × 48 | « Grille : Oui » | Interrupteur. |
| 15 | Bouton « Prendre la photo » | 952, 588 | 280 × 40 | « Prendre la photo » | Enregistre la photo. |
| 16 | Barre d'aide | 0, 664 | 1280 × 56 | « [Z] [Q] [S] [D] Caméra · [Haut] [Bas] Réglage · [Gauche] [Droite] Modifier · [Entrée] Photo · [H] Masquer · [Échap] Quitter » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Déplacer la caméra | Z Q S D ; Espace monter, C descendre | — | Stick gauche ; RT monter, LT descendre |
| Tourner la caméra | — | Déplacer la souris, bouton droit tenu | Stick droit |
| Changer de réglage | Flèches haut et bas | Survol | Croix haut et bas |
| Modifier le réglage | Flèches gauche et droite | Clic ou glisser | Croix gauche et droite |
| Prendre la photo | Entrée | Clic sur « Prendre la photo » | A |
| Masquer ou montrer le panneau et l'aide | H | — | Y |
| Remettre la caméra et les réglages d'origine | R | — | X |
| Quitter | Échap ou P | — | B |

## Enchaînements
- Prendre la photo : éclair blanc de 0,1 s, son `bruit_photo.ogg`, message « Photo enregistrée dans le dossier Photos » pendant 2 s en bas à gauche (48, 600). L'écran reste ouvert.
- Quitter : retour à l'origine (`menu_pause.md`, téléphone rangé, ou jeu).

## Règles et états
- La caméra reste à 30 m au plus de Koffi et ne traverse ni le sol ni les murs.
- Les photos sont des PNG à la résolution de la fenêtre, dans `user://photos/`, nommées `marina_city_AAAA-MM-JJ_HHMMSS.png`.
- Le réglage « Heure » ne change que l'éclairage de la photo : l'heure du jeu est rétablie en quittant.
- Indisponible pendant une scène d'histoire, un écran de fin de mission, d'arrestation ou d'hôpital.
- Les ZQSD pilotent la caméra, les flèches pilotent le panneau : c'est le seul écran où les deux jeux de touches sont séparés.
- Chaque photo compte pour la statistique « Photos prises » et le succès « Photographe ».

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Caméra libre : une `Camera3D` distincte, `process_mode` « toujours », pendant que l'arbre est en pause.
- Capture : masquer l'interface, attendre `RenderingServer.frame_post_draw`, puis `get_viewport().get_texture().get_image().save_png(...)`.
- Filtres : un `ColorRect` plein écran avec un petit shader, ou les réglages `adjustment_*` de l'`Environment`.
- Action à ajouter dans `InputMap` : `photo` (P).
