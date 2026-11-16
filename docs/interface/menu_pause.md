# Menu pause — maquette

- Tâche : T5164 (« Menu pause : dessiner la maquette »).
- Image : `menu_pause.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Mettre le jeu en pause et donner accès à tout ce qui n'est pas la conduite : carte, journal, sauvegarde, options, mode photo, statistiques, succès, sortie.

## Quand il s'affiche
En jeu, sur Échap (clavier) ou Start (manette). Le jeu est figé (`get_tree().paused = true`), le son du monde est coupé, la radio baisse de 12 dB.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 72 % d'opacité, par-dessus l'image du jeu. |
| 3 | Titre de l'écran | 48, 49 | 106 × 53 | « Pause » | Barlow Condensed Bold 48, crème. |
| 4 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 5 | Bouton « Reprendre » | 48, 148 | 360 × 44 | « Reprendre » | Ferme le menu et relance le jeu. État montré : sélectionné. |
| 6 | Bouton « Carte » | 48, 198 | 360 × 44 | « Carte » | Ouvre la grande carte. |
| 7 | Bouton « Journal de missions » | 48, 248 | 360 × 44 | « Journal de missions » | Ouvre le journal. |
| 8 | Bouton « Sauvegarder » | 48, 298 | 360 × 44 | « Sauvegarder » | Ouvre le choix de l'emplacement (1 à 3). Grisé pendant une mission. |
| 9 | Bouton « Charger une partie » | 48, 348 | 360 × 44 | « Charger une partie » | Ouvre l'écran Chargement de partie. |
| 10 | Bouton « Options » | 48, 398 | 360 × 44 | « Options » | Ouvre les options, onglet Graphismes. |
| 11 | Bouton « Mode photo » | 48, 448 | 360 × 44 | « Mode photo » | Passe en mode photo. Grisé pendant une scène d'histoire. |
| 12 | Bouton « Statistiques » | 48, 498 | 360 × 44 | « Statistiques » | Ouvre l'écran Statistiques. |
| 13 | Bouton « Succès » | 48, 548 | 360 × 44 | « Succès » | Ouvre l'écran Succès. |
| 14 | Bouton « Quitter » | 48, 598 | 360 × 44 | « Quitter » | Ouvre la boîte « Quitter la partie ? ». |
| 15 | Panneau « Où tu en es » | 736, 148 | 496 × 344 | — | Résumé de la partie en cours. |
| 16 | Étiquette du panneau | 760, 171 | 103 × 18 | « OÙ TU EN ES » | Barlow SemiBold 16, capitales, interlettrage 1,5. |
| 17 | Chapitre | 760, 199 | 231 × 33 | « Chapitre 1 — Le retour » | Barlow Condensed SemiBold 30. |
| 18 | Date du jeu et difficulté | 760, 237 | 231 × 20 | « 2017 · Jour 12 · 17 h 42 · Normal » | Barlow Regular 18. |
| 19 | Mission et objectif | 760, 284 | 448 × 72 | « Mission en cours / La moto de Romaric / Conduis le client à Ganhi » | Étiquette en Barlow SemiBold 16, nom en Barlow SemiBold 22, objectif en Barlow Regular 18 jaune pâle. Sans mission : « Aucune mission en cours ». |
| 20 | Lignes de résumé | 760, 378 | 448 × 100 | « Argent : 1 250 FCFA / Dette envers Tonton Gratien : 18 000 FCFA / Santé : 80 % / Temps de jeu : 3 h 42 » | Quatre lignes de 26 de haut : libellé à gauche (Barlow Regular 18, gris clair), valeur à droite (Barlow SemiBold 18 ; l'argent en vert clair). La ligne « Dette » disparaît quand la dette est remboursée. |
| 21 | Dernière sauvegarde | 736, 509 | 399 × 20 | « Dernière sauvegarde : il y a 6 minutes (automatique) » | Barlow Regular 18, gris clair. |
| 22 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Valider · [Échap] Reprendre » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Valider | Entrée ou Espace | Clic gauche | A |
| Reprendre le jeu | Échap | Clic droit | B ou Start |
| Premier ou dernier choix | Début, Fin | — | — |

## Enchaînements
- « Reprendre » : retour au jeu, sans décompte.
- « Carte » : `grande_carte.md`. « Journal de missions » : `journal_de_missions.md`.
- « Sauvegarder » : boîte « Sauvegarder dans quel emplacement ? » avec trois boutons (« Emplacement 1 — vide », « Emplacement 2 — Chapitre 1, 3 h 42 », « Emplacement 3 — vide ») et « Annuler » ; un emplacement occupé demande « Remplacer cette partie ? ». Après l'écriture : message « Partie sauvegardée » pendant 2 s en bas du panneau de droite.
- « Charger une partie » : `chargement_de_partie.md`.
- « Options » : `options_graphiques.md`, puis ses onglets.
- « Mode photo » : `mode_photo.md`. « Statistiques » : `statistiques.md`. « Succès » : `succes.md`.
- « Quitter » : boîte « Quitter la partie ? » (texte « Ce que tu as fait depuis la dernière sauvegarde sera perdu. », boutons « Menu principal », « Quitter le jeu » et « Annuler », sélection sur « Annuler »). « Menu principal » mène à `menu_principal.md`.
- Depuis chacun de ces écrans, Retour revient ici, sélection sur le bouton d'origine.

## Règles et états
- La pause ne s'ouvre pas pendant un écran de fin de mission, d'arrestation ou d'hôpital, ni pendant un chargement.
- Pendant une mission, « Sauvegarder » est grisé et son texte secondaire, aligné à droite du bouton, dit « après la mission ».
- Pendant une scène d'histoire, « Mode photo » est grisé.
- Si la manette se débranche en jeu, ce menu s'ouvre tout seul avec le message « Manette débranchée » à la place de « Dernière sauvegarde ».
- Si la fenêtre perd le focus en jeu, le menu s'ouvre aussi.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Le nœud du menu a `process_mode = PROCESS_MODE_WHEN_PAUSED`.
- Remplace le menu de pause actuel de `scripts/hud.gd` (`m.menu`, fond `Color(0.08, 0.04, 0.02, 0.72)`), dont le voile est repris à l'identique.
- `VBoxContainer` de 10 `Button` (séparation 6, taille minimale 360 × 44), navigation en boucle.
