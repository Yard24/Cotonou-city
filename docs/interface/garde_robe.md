# Garde-robe — maquette

- Tâche : T5200 (« Garde-robe : dessiner la maquette »).
- Image : `garde_robe.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Changer la tenue de Koffi et acheter des vêtements. On change la tenue, jamais le visage ni la corpulence (décision 50).

## Quand il s'affiche
En jeu, touche E devant l'armoire d'un logement de Koffi ou devant le comptoir d'une boutique de vêtements. Le jeu est en pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 196 × 53 | « Garde-robe » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Sous-titre de l'écran | 48, 120 | 244 × 22 | « Chambre de Koffi · Dantokpa » | Barlow Regular 20, gris clair. |
| 5 | Argent du joueur | 1105, 63 | 127 × 33 | « 12 450 FCFA » | Barlow Condensed Bold 30, vert clair 8df59a, aligné à droite. |
| 6 | Catégorie « Haut » | 48, 168 | 232 × 48 | « Haut » | Filtre la grille. État montré : sélectionné. |
| 7 | Catégorie « Bas » | 48, 224 | 232 × 48 | « Bas » | Filtre la grille. |
| 8 | Catégorie « Chaussures » | 48, 280 | 232 × 48 | « Chaussures » | Filtre la grille. |
| 9 | Catégorie « Tête » | 48, 336 | 232 × 48 | « Tête » | Filtre la grille. |
| 10 | Catégorie « Accessoire » | 48, 392 | 232 × 48 | « Accessoire » | Filtre la grille. |
| 11 | Catégorie « Tenues complètes » | 48, 448 | 232 × 48 | « Tenues complètes » | Filtre la grille. |
| 12 | Vêtement « Maillot vert » | 304, 168 | 172 × 224 | « Maillot vert / Porté » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). |
| 13 | Vêtement « Chemise jaune n° 27 » | 488, 168 | 172 × 224 | « Chemise jaune n° 27 / À toi » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). État montré : sélectionnée. |
| 14 | Vêtement « Chemise à motifs » | 672, 168 | 172 × 224 | « Chemise à motifs / À toi » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). |
| 15 | Vêtement « Polo blanc » | 304, 404 | 172 × 224 | « Polo blanc / 2 500 FCFA » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). |
| 16 | Vêtement « Chemise du dimanche » | 488, 404 | 172 × 224 | « Chemise du dimanche / 6 000 FCFA » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). |
| 17 | Vêtement « Veste claire » | 672, 404 | 172 × 224 | « Veste claire / Chapitre 4 » | Carte 172 × 224 : image 152 × 140, nom Barlow Condensed SemiBold 20, état Barlow SemiBold 16 (« Porté » avec pastille verte, « À toi », prix en vert clair, ou chapitre de déblocage en brun clair). |
| 18 | Aperçu de Koffi | 872, 168 | 360 × 400 | — | Fenêtre 3D : Koffi en pied avec le vêtement sélectionné, il tourne avec le stick droit ou en glissant la souris. Visage et corpulence ne changent pas (décision 50). |
| 19 | Bouton « Porter » | 872, 584 | 360 × 48 | « Porter » | Met le vêtement sélectionné. Devient « Acheter et porter — 2 500 FCFA » pour un article en vente. |
| 20 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] [Gauche] [Droite] Choisir · [Entrée] Porter · [Échap] Sortir » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Se déplacer entre catégories, grille et bouton | Flèches ou Z Q S D | Survol | Croix ou stick gauche |
| Porter ou acheter | Entrée ou Espace | Clic sur le bouton ou double clic sur la carte | A |
| Tourner Koffi | — | Glisser dans l'aperçu | Stick droit |
| Catégorie précédente ou suivante | A et E | Clic sur la catégorie | LB et RB |
| Sortir | Échap | Clic droit | B |

## Enchaînements
- « Porter » : l'aperçu et le personnage changent tout de suite, la pastille verte se déplace.
- « Acheter et porter » : confirmation seulement au-dessus de 5 000 FCFA (« Acheter ce vêtement ? »).
- Sortir : retour au jeu avec la tenue portée.

## Règles et états
- La grille montre 6 cartes (3 × 2) et défile par rangée.
- Un vêtement trop cher reste sélectionnable (pour l'essayer dans l'aperçu), mais le bouton est grisé « Pas assez d'argent ».
- En sortant sans acheter, Koffi reprend la tenue qu'il portait.
- Le casque n'est pas un vêtement : il se met tout seul à moto (décision 52).
- Motifs de pagne et de chemise inventés (décision 46).

## Deux modes, un seul écran
- Chez Koffi (armoire de son logement) : titre « Garde-robe », seuls les vêtements possédés et ceux du chapitre sont listés, bouton « Porter ».
- En boutique de vêtements (icône `carte_vetements.svg`) : titre = nom de la boutique, articles en vente d'abord, bouton « Acheter et porter — <prix> ».

## Tenue de départ et progression (décision 27)
Chapitre 1 : maillot vert, jean, sandales. La chemise jaune numérotée s'obtient en gagnant sa place parmi les zémidjans (décision 43). Les tenues plus habillées se débloquent chapitre après chapitre ; une carte verrouillée affiche « Chapitre N » et son image est à 35 % d'opacité. Les prix de la maquette sont des propositions.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un vêtement = identifiant, catégorie, nom, prix, chapitre de déblocage, maillage ou matière à appliquer sur le modèle de Koffi.
- Aperçu : `SubViewportContainer` 360 × 400.
