# Options de touches — maquette

- Tâche : T5176 (« Options de touches : dessiner la maquette »).
- Image : `options_de_touches.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Voir et changer les touches du clavier et les boutons de la manette, action par action, et régler la caméra et les vibrations.

## Quand il s'affiche
Depuis les options, troisième onglet. Même fond que `options_graphiques.md`.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 131 × 53 | « Options » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Onglet « Graphismes » | 88, 124 | 176 × 44 | « Graphismes » | Onglet inactif. |
| 5 | Onglet « Audio » | 272, 124 | 176 × 44 | « Audio » | Onglet inactif. |
| 6 | Onglet « Touches » | 456, 124 | 176 × 44 | « Touches » | Onglet actif (fond or, texte brun). |
| 7 | Onglet « Langue » | 640, 124 | 176 × 44 | « Langue » | Onglet inactif. |
| 8 | Touches de changement d'onglet | 48, 132 | 804 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 9 | En-têtes des colonnes | 48, 190 | 744 × 24 | « ACTION / CLAVIER / MANETTE » | Barlow SemiBold 16, capitales, à x = 64, 448 et 632. |
| 10 | Intertitre de section | 64, 226 | 48 × 24 | « À pied » | Barlow Condensed SemiBold 22, or. Sections : « À pied », « En véhicule », « Partout », « Manette et souris ». |
| 11 | Ligne « Avancer » | 48, 256 | 744 × 36 | « Avancer / Z ou ↑ / Stick gauche » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 12 | Ligne « Reculer » | 48, 296 | 744 × 36 | « Reculer / S ou ↓ / Stick gauche » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 13 | Ligne « Aller à gauche » | 48, 336 | 744 × 36 | « Aller à gauche / Q ou ← / Stick gauche » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 14 | Ligne « Aller à droite » | 48, 376 | 744 × 36 | « Aller à droite / D ou → / Stick gauche » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 15 | Ligne « Courir » | 48, 416 | 744 × 36 | « Courir / Maj / RT » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 16 | Ligne « Sauter, grimper » | 48, 456 | 744 × 36 | « Sauter, grimper / Espace / A » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). État montré : sélectionnée. |
| 17 | Ligne « S'accroupir » | 48, 496 | 744 × 36 | « S'accroupir / C ou Ctrl / B » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 18 | Ligne « Action : monter, parler, acheter, accepter » | 48, 536 | 744 × 36 | « Action : monter, parler, acheter, accepter / E / X » | Action en Barlow Medium 20 ; touches en capuchons de 28 de haut à x = 448 ; bouton de manette à x = 632 (pastille ronde ou texte). |
| 19 | Barre de défilement de la liste | 800, 256 | 6 × 316 | — | Barre de défilement : rail 6 de large, poignée gris clair. |
| 20 | Panneau d'explication | 816, 188 | 416 × 440 | — | Explique l'action sélectionnée et montre la manette. |
| 21 | Titre de l'explication | 840, 209 | 155 × 31 | « Sauter, grimper » | Barlow Condensed SemiBold 28. |
| 22 | Texte de l'explication | 840, 251 | 368 × 70 | « Koffi saute environ 1,10 m et monte sur les murets. En véhicule, la même touche sert de frein à main. » | Barlow Regular 18, interligne 25. |
| 23 | Schéma de la manette | 860, 358 | 340 × 190 | « A, B, X, Y » | Manette générique dessinée au trait (aucune marque) : deux sticks, une croix, quatre boutons A B X Y, deux boutons d'épaule, deux boutons centraux. Le bouton lié à l'action sélectionnée est rempli en or. |
| 24 | Rappel | 840, 591 | 226 × 18 | « Entrée : choisir une autre touche » | Barlow Regular 16, en bas du panneau. |
| 25 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Changer la touche · [Suppr] Touche d'origine · [R] Tout remettre · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de ligne | Flèches haut et bas, ou Z et S | Survol ; molette pour faire défiler la liste | Croix ou stick gauche, haut et bas |
| Changer la touche de l'action sélectionnée | Entrée, puis la nouvelle touche | Clic gauche sur la ligne, puis la nouvelle touche ou un bouton de souris | A, puis le nouveau bouton |
| Remettre la touche d'origine de la ligne | Suppr | Clic du milieu | X |
| Tout remettre par défaut | R | — | Y |
| Changer d'onglet | A et E | Clic sur l'onglet | LB et RB |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Onglets : `options_graphiques.md`, `options_audio.md`, `options_de_touches.md`, `choix_de_la_langue.md`. Le passage est immédiat, sans fondu ; l'ordre boucle (E sur « Langue » revient à « Graphismes »).
- Retour : l'écran d'où l'on vient (`menu_principal.md` ou `menu_pause.md`). Les réglages sont enregistrés à ce moment dans `user://reglages.cfg`.
- R ou Y : boîte de confirmation « Remettre les valeurs par défaut ? » (texte « Seuls les réglages de cet onglet sont concernés. », boutons « Remettre » et « Annuler », sélection sur « Annuler »).
- Entrée ou A sur une ligne : boîte d'écoute centrée (560 × 200, bord or) avec le titre de l'action (« Sauter, grimper ») et le texte « Appuie sur la nouvelle touche… (Échap pour annuler) ». Le clavier ne remplace que la colonne clavier, la manette que la colonne manette.
- Si la touche choisie sert déjà dans le même contexte (à pied, en véhicule ou partout) : boîte « Touche déjà utilisée » (texte « Espace sert déjà à « Sauter, grimper ». Échanger les deux ? », boutons « Échanger » et « Annuler »).

## Règles et états
- Seule la première touche du clavier se change ; la seconde (les flèches, Ctrl) reste en secours et ne s'affiche que si elle existe.
- Échap, Entrée, F3 et F4 ne peuvent pas être attribués à une action.
- « À pied » et « En véhicule » partagent des touches (Z, Espace, E) : ce n'est pas un conflit, les deux contextes ne sont jamais actifs ensemble.
- La colonne « Manette » affiche « — » quand aucune manette n'est branchée et le schéma de droite passe à 35 % d'opacité, avec le texte « Aucune manette branchée ».
- Les boutons de manette sont nommés par position, façon A B X Y (A en bas, B à droite, X à gauche, Y en haut) ; aucun dessin ni nom de marque.
- Les touches M, T, Tab, P et R sont des propositions de cette maquette : elles n'existent pas encore dans `scripts/main.gd`.

## Liste complète des actions et touches par défaut
Les touches du clavier sont enregistrées par position physique (`physical_keycode`), comme dans `scripts/main.gd` : « Z Q S D » sur un clavier AZERTY correspond à « W A S D » sur un clavier QWERTY. L'écran affiche le nom de la touche selon la disposition du joueur (`DisplayServer.keyboard_get_label_from_physical`).

### À pied

| Action | Clavier | Manette | Nom dans `InputMap` |
|---|---|---|---|
| Avancer | Z ou ↑ | Stick gauche | `up` |
| Reculer | S ou ↓ | Stick gauche | `down` |
| Aller à gauche | Q ou ← | Stick gauche | `left` |
| Aller à droite | D ou → | Stick gauche | `right` |
| Courir | Maj | RT | `run` |
| Sauter, grimper | Espace | A | `jump` |
| S'accroupir | C ou Ctrl | B | `crouch` |
| Action : monter, parler, acheter, accepter | E | X | `enter` |

### En véhicule

| Action | Clavier | Manette | Nom dans `InputMap` |
|---|---|---|---|
| Accélérer | Z ou ↑ | RT | `up` |
| Freiner, reculer | S ou ↓ | LT | `down` |
| Tourner à gauche | Q ou ← | Stick gauche | `left` |
| Tourner à droite | D ou → | Stick gauche | `right` |
| Frein à main (voiture), frein arrière (moto) | Espace | A | `brake` |
| Descendre | E | X | `enter` |
| Klaxon | H | Clic du stick gauche (L3) | `horn` |
| Phares | L | Croix gauche | `lights` |
| Clignotant gauche | J | LB | `blink_l` |
| Clignotant droit | K | RB | `blink_r` |
| Changer de caméra | V | Y | `cam` |
| Station de radio suivante | R | Croix droite | `radio (à créer)` |

### Partout

| Action | Clavier | Manette | Nom dans `InputMap` |
|---|---|---|---|
| Regarder autour | Souris | Stick droit | `—` |
| Téléphone | T | Croix haut | `phone (à créer)` |
| Grande carte | M | Vue (Select) | `map (à créer)` |
| Journal de missions | Tab | Croix bas | `journal (à créer)` |
| Mode photo | P | Depuis le menu pause | `photo (à créer)` |
| Pause | Échap | Start | `quit` |
| Niveau graphique suivant | F4 | — | `quality` |
| Compteur d'images par seconde | F3 | — | `fps` |

### Manette et souris (réglages placés à la fin de la liste)

| Réglage | Type | Valeurs | Par défaut |
|---|---|---|---|
| Sensibilité de la caméra (souris) | Curseur | 10 % à 100 %, pas de 5 | 50 % |
| Sensibilité de la caméra (manette) | Curseur | 10 % à 100 %, pas de 5 | 50 % |
| Inverser l'axe vertical | Interrupteur | Oui, Non | Non |
| Vibrations de la manette | Interrupteur | Oui, Non | Oui |
| Zone morte des sticks | Curseur | 5 % à 30 %, pas de 1 | 15 % |
| Affichage des aides | Liste | Automatique, Clavier, Manette | Automatique |

La liste compte donc 34 lignes (28 actions et 6 réglages) ; 8 sont visibles à la fois, entre y = 256 et y = 572.

## Menus (non modifiables)
Haut, bas, gauche, droite : flèches ou ZQSD, croix ou stick gauche. Valider : Entrée ou Espace, A. Retour : Échap, B. Onglets : A et E, LB et RB. Ces touches ne peuvent pas être réattribuées, pour qu'on puisse toujours revenir sur cet écran.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Liste dans un `ScrollContainer` (hauteur 316) qui suit la sélection (`ensure_control_visible`).
- Réattribution : `InputMap.action_erase_event` puis `action_add_event` avec un `InputEventKey` (`physical_keycode`) ou un `InputEventJoypadButton` / `InputEventJoypadMotion`.
- Gâchettes : `JOY_AXIS_TRIGGER_RIGHT` et `JOY_AXIS_TRIGGER_LEFT`, actives au-delà de 0,3 ; l'accélération est proportionnelle (`get_action_strength`).
- Enregistrer dans `user://reglages.cfg`, section `touches` (une clé par action).
