# Choix de la langue — maquette

- Tâche : T5232 (« Choix de la langue : dessiner la maquette »).
- Image : `choix_de_la_langue.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Choisir la langue des textes. À la sortie, seul le français existe (décision 117) : l'écran montre déjà la place de l'anglais, indisponible.

## Quand il s'affiche
Depuis les options, quatrième onglet. Une variante plein écran est prévue pour le premier lancement (voir plus bas).

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 131 × 53 | « Options » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Onglet « Graphismes » | 88, 124 | 176 × 44 | « Graphismes » | Onglet inactif. |
| 5 | Onglet « Audio » | 272, 124 | 176 × 44 | « Audio » | Onglet inactif. |
| 6 | Onglet « Touches » | 456, 124 | 176 × 44 | « Touches » | Onglet inactif. |
| 7 | Onglet « Langue » | 640, 124 | 176 × 44 | « Langue » | Onglet actif (fond or, texte brun). |
| 8 | Touches de changement d'onglet | 48, 132 | 804 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 9 | Ligne « Français » | 48, 188 | 744 × 72 | « Français / Textes, sous-titres et voix / Langue actuelle » | Nom en Barlow Condensed SemiBold 30, détail en Barlow Regular 16, mention et pastille verte à coche alignées à droite. État montré : sélectionnée et active. |
| 10 | Ligne « English » | 48, 268 | 744 × 72 | « English / Textes et sous-titres / Bientôt disponible » | Même mise en page. État montré : indisponible (décision 117), non sélectionnable. Le nom d'une langue s'écrit toujours dans cette langue. |
| 11 | Note | 48, 365 | 744 × 45 | « Les voix restent en français parlé de Cotonou dans toutes les langues ; seuls les textes et les sous-titres seront traduits. » | Barlow Regular 18, gris clair. |
| 12 | Panneau d'explication | 816, 188 | 416 × 440 | — | Explique le réglage sélectionné ; son contenu change avec la sélection. |
| 13 | Titre de l'explication | 840, 209 | 72 × 31 | « Langue » | Barlow Condensed SemiBold 28. Reprend le nom du réglage sélectionné. |
| 14 | Texte de l'explication | 840, 253 | 368 × 70 | « Change la langue des menus, des sous-titres et des panneaux d'aide. Le changement est immédiat, sans relancer le jeu. » | Barlow Regular 18, interligne 25, largeur 368. |
| 15 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Valider · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Choisir la langue sélectionnée | Entrée ou Espace | Clic gauche sur la ligne | A |
| Changer d'onglet | A et E | Clic sur l'onglet | LB et RB |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Onglets : `options_graphiques.md`, `options_audio.md`, `options_de_touches.md`, `choix_de_la_langue.md`. Le passage est immédiat, sans fondu ; l'ordre boucle (E sur « Langue » revient à « Graphismes »).
- Retour : l'écran d'où l'on vient (`menu_principal.md` ou `menu_pause.md`). Les réglages sont enregistrés à ce moment dans `user://reglages.cfg`.

## Règles et états
- La langue active porte la pastille verte et la mention « Langue actuelle » ; valider une autre langue déplace la pastille et retraduit l'écran tout de suite.
- Une langue indisponible est affichée mais sautée par la navigation.
- R et Y (valeurs par défaut) n'existent pas sur cet onglet.
- Ordre des langues : français, puis les autres par ordre alphabétique de leur nom.

## Variante « premier lancement » (à activer quand une deuxième langue existera)
- Elle s'affiche une seule fois, avant l'écran titre, si `user://reglages.cfg` n'a pas de langue enregistrée et si le jeu contient au moins deux langues.
- Pas d'onglets ni de titre « Options » : fond de menu, titre « Langue / Language » (Barlow Condensed Bold 48, centré, ligne de base y = 200), filet tricolore centré (592, 214, 96 × 6), puis les lignes de langue centrées (x = 400, largeur 480, hauteur 72, première ligne à y = 264, pas de 80).
- La sélection part sur la langue du système (`OS.get_locale_language()`), à défaut sur « Français ».
- Valider enregistre la langue et passe à `ecran_titre.md`. Il n'y a pas de retour.
- Tant que seul le français existe, cette variante ne s'affiche jamais.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- `TranslationServer.set_locale("fr")` ; tous les textes du jeu passent par `tr()` avec des clés, même tant qu'il n'y a qu'une langue.
- Enregistrer dans `user://reglages.cfg`, section `jeu`, clé `langue`.
