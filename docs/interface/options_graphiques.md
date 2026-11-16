# Options graphiques — maquette

- Tâche : T5168 (« Options graphiques : dessiner la maquette »).
- Image : `options_graphiques.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Régler l'image : niveau graphique global, fenêtre, résolution, cadence, puis les réglages fins (ombres, distance, anticrénelage, échelle de rendu, luminosité).

## Quand il s'affiche
Depuis « Options » du menu principal ou du menu pause (premier onglet). Ouvert depuis la pause, le fond est l'image du jeu sous le voile 140a05 à 72 % au lieu du fond de menu.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 131 × 53 | « Options » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Onglet « Graphismes » | 88, 124 | 176 × 44 | « Graphismes » | Onglet actif (fond or, texte brun). |
| 5 | Onglet « Audio » | 272, 124 | 176 × 44 | « Audio » | Onglet inactif. |
| 6 | Onglet « Touches » | 456, 124 | 176 × 44 | « Touches » | Onglet inactif. |
| 7 | Onglet « Langue » | 640, 124 | 176 × 44 | « Langue » | Onglet inactif. |
| 8 | Touches de changement d'onglet | 48, 132 | 804 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 9 | Réglage « Niveau graphique » | 48, 188 | 744 × 36 | « Niveau graphique : Moyen » | Liste à flèches. Valeurs : Bas, Moyen, Élevé, Ultra, Personnalisé. État montré : sélectionné. |
| 10 | Réglage « Mode d'affichage » | 48, 228 | 744 × 36 | « Mode d'affichage : Plein écran » | Liste à flèches. Valeurs : Plein écran, Fenêtre sans bord, Fenêtre. |
| 11 | Réglage « Résolution » | 48, 268 | 744 × 36 | « Résolution : 1920 × 1080 » | Liste à flèches. Valeurs : Liste des résolutions de l'écran, de 1280 × 720 à la résolution native. |
| 12 | Réglage « Synchronisation verticale » | 48, 308 | 744 × 36 | « Synchronisation verticale : Oui » | Interrupteur Oui / Non. Valeurs : Oui par défaut. |
| 13 | Réglage « Limite d'images par seconde » | 48, 348 | 744 × 36 | « Limite d'images par seconde : 60 » | Liste à flèches. Valeurs : 30, 60, 90, 120, 144, Sans limite. |
| 14 | Réglage « Ombres » | 48, 388 | 744 × 36 | « Ombres : Moyennes » | Liste à flèches. Valeurs : Aucune, Moyennes (110 m), Longues (180 m), Très longues (260 m). |
| 15 | Réglage « Distance d'affichage » | 48, 428 | 744 × 36 | « Distance d'affichage : 420 m » | Liste à flèches. Valeurs : 260 m, 420 m, 600 m, 900 m. |
| 16 | Réglage « Anticrénelage » | 48, 468 | 744 × 36 | « Anticrénelage : Aucun » | Liste à flèches. Valeurs : Aucun, 2×, 4×. |
| 17 | Réglage « Échelle de rendu » | 48, 508 | 744 × 36 | « Échelle de rendu : 100 % » | Curseur. Valeurs : De 50 % à 100 %, par pas de 5. |
| 18 | Réglage « Luminosité » | 48, 548 | 744 × 36 | « Luminosité : 50 % » | Curseur. Valeurs : De 0 % à 100 %, par pas de 5 ; 50 % = image d'origine. |
| 19 | Réglage « Afficher les images par seconde » | 48, 588 | 744 × 36 | « Afficher les images par seconde : Non » | Interrupteur Oui / Non. Valeurs : Affiche le compteur sous la jauge de santé (raccourci F3). |
| 20 | Panneau d'explication | 816, 188 | 416 × 440 | — | Explique le réglage sélectionné ; son contenu change avec la sélection. |
| 21 | Titre de l'explication | 840, 209 | 173 × 31 | « Niveau graphique » | Barlow Condensed SemiBold 28. Reprend le nom du réglage sélectionné. |
| 22 | Texte de l'explication | 840, 253 | 368 × 95 | « Règle d'un coup les ombres, la distance d'affichage, l'anticrénelage et l'échelle de rendu. Si tu changes l'un d'eux à la main, le niveau devient « Personnalisé ». » | Barlow Regular 18, interligne 25, largeur 368. |
| 23 | Tableau des niveaux | 840, 362 | 368 × 144 | « Bas, Moyen, Élevé, Ultra / Ombres : Non, 110 m, 180 m, 260 m / Distance : 260 m, 420 m, 600 m, 900 m / Anticrén. : Aucun, Aucun, 2×, 4× / Échelle : 70 %, 100 %, 100 %, 100 % » | Barlow 16 ; la colonne du niveau choisi est surlignée (or à 16 %). Visible seulement quand « Niveau graphique » est sélectionné. |
| 24 | Rappel du raccourci | 840, 591 | 144 × 18 | « Raccourci en jeu : F4 » | Barlow Regular 16, en bas du panneau. |
| 25 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Gauche] [Droite] Modifier · [R] Valeurs par défaut · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de réglage | Flèches haut et bas, ou Z et S | Survol de la ligne ; molette pour faire défiler | Croix ou stick gauche, haut et bas |
| Modifier la valeur | Flèches gauche et droite, ou Q et D ; maintenir pour aller plus vite sur un curseur | Clic sur une flèche ‹ › ; clic ou glisser sur un curseur ; clic sur un interrupteur | Croix ou stick gauche, gauche et droite ; A bascule un interrupteur |
| Changer d'onglet | A (précédent) et E (suivant) | Clic sur l'onglet | LB et RB |
| Remettre les valeurs par défaut de l'onglet | R | — | Y |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Onglets : `options_graphiques.md`, `options_audio.md`, `options_de_touches.md`, `choix_de_la_langue.md`. Le passage est immédiat, sans fondu ; l'ordre boucle (E sur « Langue » revient à « Graphismes »).
- Retour : l'écran d'où l'on vient (`menu_principal.md` ou `menu_pause.md`). Les réglages sont enregistrés à ce moment dans `user://reglages.cfg`.
- R ou Y : boîte de confirmation « Remettre les valeurs par défaut ? » (texte « Seuls les réglages de cet onglet sont concernés. », boutons « Remettre » et « Annuler », sélection sur « Annuler »).
- Changer « Mode d'affichage » ou « Résolution » applique tout de suite puis ouvre la boîte « Garder cet affichage ? » (texte « Retour à l'affichage précédent dans 10 secondes. », boutons « Garder » et « Revenir », sélection sur « Revenir ») ; sans réponse au bout de 10 s, l'ancien réglage revient.

## Règles et états
- Tous les autres réglages s'appliquent dès qu'on les change, sans bouton « Appliquer » : on voit le résultat derrière le voile quand on vient de la pause.
- Changer « Ombres », « Distance d'affichage », « Anticrénelage » ou « Échelle de rendu » fait passer « Niveau graphique » à « Personnalisé ». Choisir un niveau remet ces quatre réglages aux valeurs du tableau.
- Les listes ne bouclent pas : au bout de la liste, la flèche correspondante passe à 35 % d'opacité.
- « Résolution » est grisée en mode « Fenêtre sans bord » (résolution de l'écran imposée).
- F4 (niveau suivant) et F3 (compteur) restent actifs en jeu comme aujourd'hui.

## Valeurs appliquées par niveau
Reprises de `_apply_quality()` dans `scripts/main.gd` (variable `quality` de 0 à 3) : l'écran ne fait que les exposer.

| Réglage | Bas | Moyen | Élevé | Ultra |
|---|---|---|---|---|
| Ombres du soleil (distance) | aucune | 110 m | 180 m | 260 m |
| Distance d'affichage (`cam.far`) | 260 m | 420 m | 600 m | 900 m |
| Anticrénelage (`msaa_3d`) | aucun | aucun | 2× | 4× |
| Échelle de rendu (`scaling_3d_scale`) | 70 % | 100 % | 100 % | 100 % |
| Densité de la brume | 0,006 | 0,0035 | 0,0025 | 0,0018 |
| Occlusion ambiante | non | non | non | oui |

Valeurs par défaut de l'onglet : niveau « Moyen », plein écran, résolution native, synchronisation verticale « Oui », limite 60, luminosité 50 %, compteur d'images « Non ».

## Textes du panneau d'explication
- Niveau graphique : « Règle d'un coup les ombres, la distance d'affichage, l'anticrénelage et l'échelle de rendu. Si tu changes l'un d'eux à la main, le niveau devient « Personnalisé ». »
- Mode d'affichage : « Plein écran pour jouer, fenêtre pour garder un œil sur autre chose. »
- Résolution : « Nombre de points affichés. Plus bas, le jeu est plus fluide mais moins net. »
- Synchronisation verticale : « Évite les images coupées en deux. À couper seulement si le jeu répond avec du retard. »
- Limite d'images par seconde : « Plafonne la cadence pour moins chauffer et moins consommer. »
- Ombres : « Distance jusqu'où le soleil projette des ombres. C'est le réglage qui coûte le plus. »
- Distance d'affichage : « Jusqu'où l'on voit la ville avant la brume. »
- Anticrénelage : « Adoucit les bords en escalier. »
- Échelle de rendu : « Calcule l'image plus petite puis l'agrandit. À baisser sur un PC modeste. »
- Luminosité : « À monter si la nuit est trop sombre sur ton écran. »
- Afficher les images par seconde : « Montre la cadence sous la jauge de santé. Raccourci : F3. »

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Liste : `VBoxContainer` de 11 lignes (hauteur 36, séparation 4). Une ligne = un `Control` focalisable qui reçoit `ui_left` et `ui_right`.
- Appliquer : `DisplayServer.window_set_mode`, `window_set_size`, `window_set_vsync_mode`, `Engine.max_fps`, et les champs déjà réglés par `_apply_quality()`. Luminosité : `Environment.adjustment_brightness` de 0,7 à 1,3.
- Enregistrer dans `user://reglages.cfg` (`ConfigFile`, section `graphismes`).
