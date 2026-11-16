# Grande carte — maquette

- Tâche : T5180 (« Grande carte : dessiner la maquette »).
- Image : `grande_carte.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Montrer toute la ville, où est Koffi, où sont les missions et les services, et poser un repère pour être guidé.

## Quand il s'affiche
En jeu sur M (clavier) ou Vue/Select (manette), ou depuis « Carte » du menu pause. Le jeu est en pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Plan de la ville | 0, 0 | 1280 × 664 | « ÉTOILE ROUGE, DANTOKPA, MISSÈBO, GANHI, AKPAKPA, AÉROPORT, FIDJROSSÈ, PLACE DE L'AMAZONE, PORT ; Lac Nokoué, Lagune, Océan Atlantique » | Plein écran, nord en haut. Eau 1f6a90, terre 4a3524, îlots bâtis 5e4631, grandes rues e8d3a0 (6 de large), rues secondaires 8a7458 (3), plage e8d3a0, trois ponts. Noms de quartier en Barlow Condensed SemiBold 20, capitales, interlettrage 1 ; noms d'eau en Barlow Medium 18 bleu pâle 9fd4ee. Tracé schématique : le vrai plan sera produit à partir de la carte du jeu (tâche T0029). |
| 2 | Itinéraire | 500, 250 | 300 × 150 | — | Pointillé or (points de 5, pas de 12) le long des rues, du joueur au repère ou à l'objectif suivi. |
| 3 | Icônes de lieux | 324, 124 | 840 × 470 | — | Icônes de `icones/carte_*.svg` affichées en 32 × 32, centrées sur le lieu. Ici 20 icônes d'exemple. Elles gardent leur taille quand on zoome. |
| 4 | Marqueur du joueur | 782, 382 | 36 × 36 | — | Icône `carte_joueur.svg` en 36 × 36, tournée selon la direction de Koffi ; elle bat doucement (échelle 1 à 1,15, période 1,2 s). |
| 5 | Curseur | 649, 379 | 82 × 82 | — | Cercle de 48 de diamètre et quatre traits, crème, épaisseur 2,5. Il reste au centre à la manette (la carte glisse dessous) et suit le pointeur à la souris. |
| 6 | Bulle du lieu survolé | 726, 390 | 244 × 60 | « Maquis « Chez Tantie » / Manger · à 780 m » | Plaque 140a05 à 92 %, bord or 1,5 ; nom en Barlow SemiBold 18, fonction et distance en Barlow Regular 16. Apparaît quand le curseur est à moins de 20 px d'une icône. |
| 7 | Panneau de légende | 24, 24 | 264 × 616 | — | Titre, heure, filtres. Fond 26170d à 92 %. |
| 8 | Titre de l'écran | 48, 37 | 94 × 53 | « Carte » | Barlow Condensed Bold 48. |
| 9 | Filet tricolore | 48, 90 | 96 × 6 | — | Trois segments de 32 × 6. |
| 10 | Date et heure du jeu | 48, 111 | 163 × 20 | « 2017 · Jour 12 · 17 h 42 » | Barlow Regular 18. |
| 11 | Étiquette des filtres | 48, 155 | 82 × 18 | « AFFICHER » | Barlow SemiBold 16, capitales. |
| 12 | Filtre « Missions » | 36, 184 | 240 × 40 | « Missions » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). État montré : sélectionné. |
| 13 | Filtre « Travail » | 36, 228 | 240 × 40 | « Travail » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). |
| 14 | Filtre « Commerces » | 36, 272 | 240 × 40 | « Commerces » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). |
| 15 | Filtre « Carburant » | 36, 316 | 240 × 40 | « Carburant » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). |
| 16 | Filtre « Services » | 36, 360 | 240 × 40 | « Services » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). |
| 17 | Filtre « Transports » | 36, 404 | 240 × 40 | « Transports » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). État montré : décoché, libellé à 50 %. |
| 18 | Filtre « Lieux de Koffi » | 36, 448 | 240 × 40 | « Lieux de Koffi » | Icône 28, libellé Barlow Medium 20, case à cocher 22 × 22 (verte et cochée = famille affichée). |
| 19 | Objectif suivi | 48, 504 | 220 × 74 | « OBJECTIF SUIVI / La dette de Tonton Gratien / Étoile Rouge · à 1,6 km » | Étiquette Barlow SemiBold 16, nom Barlow SemiBold 18, lieu et distance Barlow Regular 16. |
| 20 | Échelle | 48, 606 | 140 × 20 | « 500 m » | Trait de 80 px au zoom « ville » (1 px = 6,25 m) ; la longueur suit le zoom, la valeur reste ronde (100 m, 250 m, 500 m, 1 km). |
| 21 | Rose du nord | 1192, 40 | 48 × 48 | « N » | Disque 140a05 à 85 %, bord crème, triangle rouge vers le haut. Le nord est toujours en haut. |
| 22 | Barre d'aide | 0, 664 | 1280 × 56 | « [Z] [Q] [S] [D] Déplacer · [Molette] Zoom · [Entrée] Poser un repère · [F] Filtres · [Espace] Recentrer · [Échap] Fermer » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Déplacer la carte | Z Q S D ou flèches | Glisser avec le bouton gauche | Stick gauche |
| Zoomer, dézoomer | Page préc. et Page suiv., ou + et − | Molette | RT et LT |
| Poser ou retirer un repère sous le curseur | Entrée | Clic gauche (sans glisser) | A |
| Suivre la mission sous le curseur | Entrée sur une icône de mission | Clic gauche sur l'icône | A |
| Aller dans les filtres, en sortir | F | Clic sur un filtre | Y |
| Cocher ou décocher un filtre | Haut et bas, puis Entrée | Clic sur la ligne | Croix haut et bas, puis A |
| Recentrer sur Koffi | Espace | Clic du milieu | Clic du stick droit (R3) |
| Fermer | Échap ou M | Clic droit | B ou Vue |

## Enchaînements
- Fermer : retour au jeu si la carte a été ouverte en jeu, à `menu_pause.md` si elle vient de la pause.
- Depuis `journal_de_missions.md`, « Voir sur la carte » ouvre cet écran centré sur l'objectif ; Fermer revient alors au journal.
- Poser un repère trace l'itinéraire ici et sur la mini-carte ; une colonne rouge apparaît dans la rue. Arrivé à moins de 15 m, le repère s'efface.

## Règles et états
- Un seul repère à la fois : en poser un nouveau déplace l'ancien. Entrée sur le repère existant le retire.
- Suivre une mission remplace le repère par l'icône de la mission ; l'encadré « Objectif suivi » se met à jour.
- Le curseur s'aimante sur l'icône la plus proche à moins de 20 px (manette et clavier seulement).
- Les quartiers pas encore visités sont couverts d'un voile 140a05 à 45 % ; les icônes n'y apparaissent qu'après une première visite, sauf missions principales, centre de santé et commissariat.
- Les patrouilles de police (`carte_police.svg`) ne s'affichent que si le joueur est recherché (1 étoile ou plus).
- La carte ne peut pas sortir de ses limites : le bord de la carte s'arrête au bord de l'écran.

## Filtres et icônes
| Filtre | Icônes concernées (`icones/carte_<nom>.svg`) |
|---|---|
| Missions | `mission_principale`, `mission_secondaire`, `personnage` |
| Lieux de Koffi | `domicile`, `garage`, `entrepot`, `a_vendre`, `vehicule` |
| Commerces | `boutique`, `vetements`, `maquis`, `coiffeur`, `marche`, `banque` |
| Carburant | `station_service`, `kpayo` |
| Services | `centre_de_sante`, `commissariat`, `police` |
| Transports | `port`, `aeroport`, `embarcadere` |
| Travail | `client_zem`, `livraison`, `course`, `depannage`, `objet_perdu` |

Les icônes de la famille « Repères » (`joueur`, `destination`, `repere`) sont toujours affichées. Le détail de chaque icône est dans `icones_de_la_carte.md`.

## Zoom
| Niveau | Échelle | Ce qu'on voit |
|---|---|---|
| Ville (à l'ouverture si aucun objectif) | 1 px = 6,25 m | Toute la carte de 6 × 4 km |
| Quartier (à l'ouverture, centré sur Koffi) | 1 px = 3 m | Environ 3,8 × 2 km |
| Rue | 1 px = 1,5 m | Environ 1,9 × 1 km ; noms des commerces affichés |

Le zoom est continu entre ces trois niveaux à la molette et aux gâchettes.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Le plan est une texture produite à partir de la carte du jeu (même source que `scripts/minimap.gd`), affichée dans un `Control` avec `_draw()` ou un `TextureRect` déplacé par code ; les icônes sont des `TextureRect` enfants repositionnés à chaque déplacement.
- Conversion monde vers écran : `ecran = centre + (monde - camera_carte) / echelle`, avec l'axe Z du monde vers le bas de l'écran une fois la carte reconstruite (voir `docs/monde.md`).
- Actions à ajouter dans `InputMap` : `map` (M, bouton Vue).
