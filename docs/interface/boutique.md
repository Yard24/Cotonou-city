# Boutique — maquette

- Tâche : T5192 (« Boutique : dessiner la maquette »).
- Image : `boutique.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Acheter dans un commerce : nourriture qui rend de la santé (décision 81), carburant, petit équipement.

## Quand il s'affiche
En jeu, touche E devant un vendeur ou un comptoir. Le jeu est en pause, l'image du jeu reste visible sous le voile.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 72 % d'opacité, par-dessus l'image du jeu. |
| 3 | Titre de l'écran | 48, 49 | 454 × 53 | « Boutique « Chez Da Félix » » | Barlow Condensed Bold 48, crème. |
| 4 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 5 | Sous-titre de l'écran | 48, 120 | 254 × 22 | « Missèbo · ouverte de 7 h à 21 h » | Barlow Regular 20, gris clair. |
| 6 | Argent du joueur | 1105, 63 | 127 × 33 | « 12 450 FCFA » | Barlow Condensed Bold 30, vert clair 8df59a, aligné à droite. |
| 7 | Onglet « Manger » | 88, 156 | 176 × 44 | « Manger » | Onglet actif (fond or, texte brun). |
| 8 | Onglet « Carburant » | 272, 156 | 176 × 44 | « Carburant » | Onglet inactif. |
| 9 | Onglet « Équipement » | 456, 156 | 176 × 44 | « Équipement » | Onglet inactif. |
| 10 | Touches de changement d'onglet | 48, 164 | 620 × 28 | « [A] … [E] » | Capuchons de touche de part et d'autre des onglets ; à la manette ils affichent LB et RB. |
| 11 | Ligne « Beignets (5) » | 48, 216 | 560 × 60 | « Beignets (5) / +10 de santé / 100 FCFA » | Icône d'objet 40, nom Barlow Condensed SemiBold 22, effet Barlow Regular 16, prix Barlow Condensed Bold 22 à droite. |
| 12 | Ligne « Bol de bouillie » | 48, 284 | 560 × 60 | « Bol de bouillie / +15 de santé / 150 FCFA » | Icône d'objet 40, nom Barlow Condensed SemiBold 22, effet Barlow Regular 16, prix Barlow Condensed Bold 22 à droite. |
| 13 | Ligne « Riz sauce arachide » | 48, 352 | 560 × 60 | « Riz sauce arachide / +40 de santé / 500 FCFA » | Icône d'objet 40, nom Barlow Condensed SemiBold 22, effet Barlow Regular 16, prix Barlow Condensed Bold 22 à droite. État montré : sélectionnée. |
| 14 | Ligne « Sachet d'eau » | 48, 420 | 560 × 60 | « Sachet d'eau / +5 de santé / 25 FCFA » | Icône d'objet 40, nom Barlow Condensed SemiBold 22, effet Barlow Regular 16, prix Barlow Condensed Bold 22 à droite. |
| 15 | Panneau de l'article | 632, 216 | 600 × 424 | — | Détail de l'article sélectionné. |
| 16 | Image de l'article | 656, 240 | 144 × 144 | — | Icône `icones/objet_plat.svg` en 112 sur une tuile 3a2516. |
| 17 | Nom de l'article | 824, 252 | 232 × 37 | « Riz sauce arachide » | Barlow Condensed Bold 34. |
| 18 | Description | 824, 299 | 384 × 45 | « Une assiette bien servie. Rend 40 points de santé, mangée sur place. » | Barlow Regular 18, 3 lignes au plus. |
| 19 | Jauge « Santé après le repas » | 656, 416 | 552 × 34 | « Santé après le repas : de 60 à 100 » | Libellé Barlow Regular 18, valeur Barlow SemiBold 18 à droite, barre 8 de haut (rail 6b4a30). |
| 20 | Quantité | 656, 484 | 552 × 36 | « Quantité : 1 » | De 1 à 9, limitée par l'argent disponible ; la nourriture se mange tout de suite, quantité fixée à 1. |
| 21 | Total | 656, 546 | 552 × 32 | « Total : 500 FCFA » | Prix × quantité ; rouge e8112d si le joueur n'a pas assez. |
| 22 | Bouton « Acheter » | 656, 580 | 552 × 44 | « Acheter » | Paie et donne l'article. Devient « Pas assez d'argent » (grisé) si le total dépasse l'argent. |
| 23 | Barre d'aide | 0, 664 | 1280 × 56 | « [A] [E] Rayon · [Haut] [Bas] Choisir · [Gauche] [Droite] Quantité · [Entrée] Acheter · [Échap] Sortir » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer d'onglet | A et E | Clic sur l'onglet | LB et RB |
| Changer de ligne | Flèches haut et bas, ou Z et S | Survol ; molette pour faire défiler | Croix ou stick gauche, haut et bas |
| Changer la quantité | Flèches gauche et droite, ou Q et D | Clic sur ‹ ou › | Croix gauche et droite |
| Acheter | Entrée ou Espace | Clic sur « Acheter » ou double clic sur la ligne | A |
| Sortir | Échap | Clic droit | B |

## Enchaînements
- Acheter : l'argent baisse (le compteur défile 0,4 s), son `bruit_menu_achat.ogg`, l'écran reste ouvert.
- Sortir : retour au jeu, Koffi devant le comptoir.
- À partir du chapitre 2, un choix « Payer : Espèces / KwabôPay » apparaît au-dessus du total (même effet, statistique différente).

## Règles et états
- La nourriture est consommée tout de suite ; si la santé est déjà à 100, « Acheter » est grisé avec « Tu n'as pas faim ».
- Pas de crédit : sans argent, le bouton est grisé.
- Commerce fermé (hors horaires) : l'écran ne s'ouvre pas, l'aide en jeu dit « Fermé. Ouvre à 7 h. ».
- « Chez Da Félix » est un nom inventé (décision 25).

## Rayons et articles (prix de 2017, à faire évoluer par chapitre, décision 63)
| Rayon | Article | Prix | Effet |
|---|---|---|---|
| Manger | Beignets (5) | 100 FCFA | +10 de santé |
| Manger | Bol de bouillie | 150 FCFA | +15 de santé |
| Manger | Riz sauce arachide | 500 FCFA | +40 de santé |
| Manger | Sachet d'eau | 25 FCFA | +5 de santé |
| Carburant | Kpayo, le litre | 350 FCFA | Plein moins cher ; 1 risque sur 10 de moteur qui tousse 60 s |
| Carburant | Jerrican de station (5 l) | 2 750 FCFA | Plein de secours, sans risque |
| Équipement | Caisse à outils | 3 000 FCFA | Une réparation sur place (+30 d'état du véhicule) |
| Équipement | Recharge de téléphone | 500 FCFA | Débloque 10 appels (à partir du chapitre 2) |

Ces prix sont des propositions proches de la réalité ; ils seront fixés avec le lot « économie ». Le même écran sert à tous les commerces (maquis, vendeuse de rue, vendeur de kpayo, pièces détachées) : seuls le titre, les rayons et la liste changent ; un commerce à un seul rayon n'affiche pas les onglets.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un commerce = une ressource avec nom, quartier, horaires, rayons et articles (identifiant, nom, prix, effet, icône).
- Argent en entier FCFA (`docs/conventions.md`).
