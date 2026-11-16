# Succès — maquette

- Tâche : T5224 (« Succès : dessiner la maquette »).
- Image : `succes.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Lister les défis du jeu et ceux déjà réussis.

## Quand il s'affiche
Depuis « Succès » du menu principal ou du menu pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 125 × 53 | « Succès » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Compteur | 1118, 45 | 114 × 42 | « 4 sur 24 » | Barlow Condensed Bold 38, or, aligné à droite. |
| 5 | Barre du compteur | 1032, 92 | 200 × 8 | — | Rail 6b4a30, remplissage or. |
| 6 | Carte « Retour au bercail » | 48, 148 | 384 × 156 | « Retour au bercail / Finir la première mission. / Obtenu » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. État montré : sélectionnée (bord or 4). |
| 7 | Carte « Numéro dans le dos » | 448, 148 | 384 × 156 | « Numéro dans le dos / Recevoir ta chemise jaune de zémidjan. / Obtenu » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. |
| 8 | Carte « Bon payeur » | 848, 148 | 384 × 156 | « Bon payeur / Rembourser toute la dette de Tonton Gratien. / À obtenir » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. Non obtenu : icône à 30 %, textes en brun clair. |
| 9 | Carte « Roi du faufilage » | 48, 316 | 384 × 156 | « Roi du faufilage / Passer entre 50 voitures arrêtées sans les toucher. / Obtenu » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. |
| 10 | Carte « Marchandeur » | 448, 316 | 384 × 156 | « Marchandeur / Obtenir 1 000 FCFA pour une course. / À obtenir » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. Non obtenu : icône à 30 %, textes en brun clair. |
| 11 | Carte « Ventre plein » | 848, 316 | 384 × 156 | « Ventre plein / Manger dans 5 maquis différents. / Obtenu » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. |
| 12 | Carte « Ni vu ni connu » | 48, 484 | 384 × 156 | « Ni vu ni connu / Semer une poursuite à 3 étoiles. / À obtenir » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. Non obtenu : icône à 30 %, textes en brun clair. |
| 13 | Carte « Trois ponts » | 448, 484 | 384 × 156 | « Trois ponts / Traverser les trois ponts dans la même journée. / À obtenir » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. Non obtenu : icône à 30 %, textes en brun clair. |
| 14 | Carte « Photographe » | 848, 484 | 384 × 156 | « Photographe / Prendre 10 photos. / À obtenir » | Icône 56, titre Barlow Condensed SemiBold 26, condition Barlow Regular 16 sur 3 lignes au plus, état en bas à gauche. Non obtenu : icône à 30 %, textes en brun clair. |
| 15 | Barre de défilement | 1250, 148 | 6 × 492 | — | Barre de défilement : rail 6 de large, poignée gris clair. |
| 16 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] [Gauche] [Droite] Choisir · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de carte | Flèches ou Z Q S D | Survol ; molette pour faire défiler | Croix ou stick gauche |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Retour : l'écran d'où l'on vient (`menu_principal.md` ou `menu_pause.md`).

## Règles et états
- Les succès sont communs à toutes les parties (fichier `user://succes.cfg`), contrairement aux statistiques.
- Grille de 3 colonnes ; 9 cartes visibles, défilement par rangée. Ordre : obtenus d'abord (du plus récent au plus ancien), puis les autres dans l'ordre de la liste.
- Le succès « Marina City » (finir l'histoire) affiche « ??? » comme condition tant qu'il n'est pas obtenu.
- Pas de connexion ni de compte (décision 71) : tout est local.

## Liste des 24 succès (propositions)
| N° | Titre | Condition |
|---|---|---|
| 1 | Retour au bercail | Finir la première mission. |
| 2 | Numéro dans le dos | Recevoir ta chemise jaune de zémidjan. |
| 3 | Bon payeur | Rembourser toute la dette de Tonton Gratien. |
| 4 | Roi du faufilage | Passer entre 50 voitures arrêtées sans les toucher. |
| 5 | Marchandeur | Obtenir 1 000 FCFA pour une course. |
| 6 | Ventre plein | Manger dans 5 maquis différents. |
| 7 | Ni vu ni connu | Semer une poursuite à 3 étoiles. |
| 8 | Trois ponts | Traverser les trois ponts dans la même journée. |
| 9 | Photographe | Prendre 10 photos. |
| 10 | Cent courses | Faire 100 courses de zémidjan. |
| 11 | À l'heure | Réussir 10 livraisons chronométrées de suite. |
| 12 | Patron | Confier 5 motos à des conducteurs. |
| 13 | Propriétaire | Acheter ta première propriété. |
| 14 | Citoyen modèle | Passer 7 jours de jeu sans étoile. |
| 15 | Poisson de lagune | Nager 1 km en tout. |
| 16 | Sable chaud | Gagner une course de motos sur la plage. |
| 17 | Village sur l'eau | Visiter le village lacustre en pirogue. |
| 18 | Route du Nord | Arriver à Parakou en camion. |
| 19 | Sans une rayure | Finir une mission de conduite sans aucun choc. |
| 20 | Dépanneur | Réussir 10 dépannages. |
| 21 | Objets trouvés | Rapporter 10 objets perdus. |
| 22 | Mélomane | Écouter les 4 stations de radio. |
| 23 | Chapitre clos | Finir un chapitre. |
| 24 | Marina City | Finir l'histoire. |

Aucun succès ne récompense une violence ni un délit (décisions 2, 4 et 102). Les icônes réutilisent celles de la carte et des objets en attendant des dessins propres à chaque succès.

## Avis de succès en jeu
Plaque 360 × 72 en haut à droite, sous la mini-carte (904, 284) : fond 140a05 à 92 %, bord or 1,5, icône 48, « Succès obtenu » (Barlow SemiBold 16, or) et le titre (Barlow Condensed SemiBold 24). Elle glisse depuis la droite, reste 4 s, repart ; son `bruit_succes.ogg`. Jamais pendant un dialogue : elle attend.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un succès = identifiant, titre, condition, icône, compteur et seuil éventuels (« 50 voitures »), date d'obtention.
