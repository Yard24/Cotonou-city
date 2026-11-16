# Options audio — maquette

- Tâche : T5172 (« Options audio : dessiner la maquette »).
- Image : `options_audio.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Régler les volumes par famille de sons, les sous-titres et le comportement de la radio.

## Quand il s'affiche
Depuis les options, deuxième onglet. Même fond que `options_graphiques.md`.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 131 × 53 | « Options » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Onglet « Graphismes » | 88, 124 | 176 × 44 | « Graphismes » | Onglet inactif. |
| 5 | Onglet « Audio » | 272, 124 | 176 × 44 | « Audio » | Onglet actif (fond or, texte brun). |
| 6 | Onglet « Touches » | 456, 124 | 176 × 44 | « Touches » | Onglet inactif. |
| 7 | Onglet « Langue » | 640, 124 | 176 × 44 | « Langue » | Onglet inactif. |
| 8 | Touches de changement d'onglet | 48, 132 | 804 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 9 | Réglage « Volume général » | 48, 188 | 744 × 40 | « Volume général : 80 % » | Curseur. Valeurs : De 0 % à 100 %, par pas de 5. Bus « Master ». État montré : sélectionné. |
| 10 | Réglage « Musique et radio » | 48, 232 | 744 × 40 | « Musique et radio : 70 % » | Curseur. Valeurs : Bus « Musique ». |
| 11 | Réglage « Bruitages » | 48, 276 | 744 × 40 | « Bruitages : 90 % » | Curseur. Valeurs : Moteurs, chocs, klaxons, menus. Bus « Bruitages ». |
| 12 | Réglage « Voix » | 48, 320 | 744 × 40 | « Voix : 100 % » | Curseur. Valeurs : Dialogues et commentaires de Koffi. Bus « Voix ». |
| 13 | Réglage « Ambiance de la ville » | 48, 364 | 744 × 40 | « Ambiance de la ville : 80 % » | Curseur. Valeurs : Foule, marché, mer, pluie. Bus « Ambiance ». |
| 14 | Réglage « Sous-titres » | 48, 408 | 744 × 40 | « Sous-titres : Oui » | Interrupteur Oui / Non. Valeurs : Oui par défaut (décision 105). |
| 15 | Réglage « Taille des sous-titres » | 48, 452 | 744 × 40 | « Taille des sous-titres : Normale » | Liste à flèches. Valeurs : Petite (20), Normale (24), Grande (30). |
| 16 | Réglage « Fond sombre sous les sous-titres » | 48, 496 | 744 × 40 | « Fond sombre sous les sous-titres : Oui » | Interrupteur Oui / Non. Valeurs : Plaque 140a05 à 72 %. |
| 17 | Réglage « Radio au démarrage d'un véhicule » | 48, 540 | 744 × 40 | « Radio au démarrage d'un véhicule : Allumée » | Liste à flèches. Valeurs : Allumée, Éteinte. |
| 18 | Réglage « Son quand le jeu est en arrière-plan » | 48, 584 | 744 × 40 | « Son quand le jeu est en arrière-plan : Non » | Interrupteur Oui / Non. Valeurs : Non par défaut. |
| 19 | Panneau d'explication | 816, 188 | 416 × 440 | — | Explique le réglage sélectionné ; son contenu change avec la sélection. |
| 20 | Titre de l'explication | 840, 209 | 153 × 31 | « Volume général » | Barlow Condensed SemiBold 28. Reprend le nom du réglage sélectionné. |
| 21 | Texte de l'explication | 840, 253 | 368 × 70 | « Monte ou baisse tous les sons du jeu d'un coup. Les quatre curseurs suivants règlent chaque famille de sons par rapport à ce volume. » | Barlow Regular 18, interligne 25, largeur 368. |
| 22 | Étiquette de l'aperçu | 840, 407 | 222 × 18 | « APERÇU DES SOUS-TITRES » | Barlow SemiBold 16, capitales. |
| 23 | Aperçu des sous-titres | 840, 436 | 368 × 150 | « Romaric : Koffi ! Tu vas rayer ma moto, oh ! » | Petite image de rue avec un sous-titre d'exemple, qui suit en direct la taille et le fond choisis. Le nom du personnage précède la réplique. |
| 24 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Gauche] [Droite] Modifier · [R] Valeurs par défaut · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

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

## Règles et états
- Chaque changement s'entend tout de suite. En relâchant un curseur, un son témoin de la famille est joué : `bruit_menu_valider.ogg` pour « Bruitages » et « Volume général », 2 s de la musique du menu pour « Musique et radio », la réplique d'exemple de Romaric pour « Voix », 2 s d'ambiance de marché pour « Ambiance de la ville ».
- À 0 %, le bus est coupé (`mute`) et la valeur affichée devient « Coupé ».
- « Taille des sous-titres » et « Fond sombre » sont grisés quand « Sous-titres » est sur « Non ».
- Valeurs par défaut : 80 %, 70 %, 90 %, 100 %, 80 %, sous-titres « Oui », taille « Normale », fond « Oui », radio « Allumée », arrière-plan « Non ».
- Il n'y a pas de réglage de langue des voix : français seulement à la sortie (décision 117).

## Textes du panneau d'explication
- Volume général : « Monte ou baisse tous les sons du jeu d'un coup. Les quatre curseurs suivants règlent chaque famille de sons par rapport à ce volume. »
- Musique et radio : « Les quatre stations de radio et la musique des menus. »
- Bruitages : « Moteurs, freins, chocs, klaxons et sons des menus. »
- Voix : « Les dialogues, et Koffi qui commente quand il conduit. »
- Ambiance de la ville : « Le marché, la circulation au loin, la mer, la pluie. »
- Sous-titres : « Affiche le texte des dialogues en bas de l'écran. »
- Taille des sous-titres : « Trois tailles. « Grande » est conseillée sur une télévision. »
- Fond sombre sous les sous-titres : « Une plaque sombre derrière le texte, pour le lire même en plein soleil. »
- Radio au démarrage d'un véhicule : « Allume la radio dès que tu montes, sur la dernière station écoutée. »
- Son quand le jeu est en arrière-plan : « Garde le son quand tu passes sur une autre fenêtre. »

## Sous-titres en jeu (rappel pour l'aperçu)
Centrés en bas, ligne de base de la dernière ligne à y = 632, largeur 880 au plus, 2 lignes au plus, Barlow Medium, crème ; nom du personnage suivi de deux-points. Tailles : 20, 24 ou 30.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Cinq bus audio à créer : `Master`, `Musique`, `Bruitages`, `Voix`, `Ambiance`. Volume : `AudioServer.set_bus_volume_db(bus, linear_to_db(valeur / 100.0))`.
- Enregistrer dans `user://reglages.cfg`, section `audio`.
