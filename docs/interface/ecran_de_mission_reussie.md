# Écran de mission réussie — maquette

- Tâche : T5204 (« Écran de mission réussie : dessiner la maquette »).
- Image : `ecran_de_mission_reussie.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Fêter la réussite et montrer d'un coup d'œil ce que la mission a rapporté et coûté.

## Quand il s'affiche
À la fin d'une mission principale ou secondaire réussie, 1 s après le dernier objectif. Le jeu est figé ; jingle `musique_mission_reussie.ogg` (4 s).

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 72 % d'opacité, par-dessus l'image du jeu. |
| 3 | Bandeau | 330, 71 | 621 × 106 | « MISSION RÉUSSIE » | Barlow Condensed Bold 96, or, interlettrage 3, centré. Arrive en 0,3 s (échelle 1,3 vers 1). |
| 4 | Bande tricolore | 520, 172 | 240 × 8 | — | Trois segments de 80 × 8. |
| 5 | Nom de la mission | 520, 198 | 240 × 37 | « La moto de Romaric » | Barlow Condensed SemiBold 34, centré. |
| 6 | Panneau de bilan | 400, 256 | 480 × 268 | — | Panneau brun, coins arrondis 8, bord 1,5. |
| 7 | Tableau de bilan | 432, 284 | 416 × 192 | « Récompense : +500 FCFA / Prime de rapidité (6 min 12) : +100 FCFA / Réparation de la moto : −150 FCFA / Remboursé à Tonton Gratien : −200 FCFA / Tu gagnes : +250 FCFA » | Lignes de 34 : libellé Barlow Regular 22 à gauche, valeur Barlow SemiBold 22 à droite ; filet ; total en Barlow Condensed Bold 34. |
| 8 | Témoin de sauvegarde | 464, 543 | 151 × 20 | « Partie sauvegardée » | Pastille verte à coche et Barlow Regular 18 ; apparaît quand la sauvegarde automatique est écrite (décision 115). |
| 9 | Déblocage | 629, 543 | 219 × 20 | « Nouveau contact : Le Doyen » | Barlow Medium 18, jaune pâle, aligné à droite ; une ligne par déblocage (contact, véhicule, quartier), 2 au plus. |
| 10 | Bouton « Rejouer » | 400, 584 | 232 × 52 | « Rejouer » | Relance la mission depuis le début (la récompense n'est pas donnée deux fois). |
| 11 | Bouton « Continuer » | 648, 584 | 232 × 52 | « Continuer » | Retour au jeu. État montré : sélectionné. |
| 12 | Barre d'aide | 0, 664 | 1280 × 56 | « [Gauche] [Droite] Choisir · [Entrée] Valider » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de bouton | Flèches gauche et droite, ou Q et D | Survol | Croix ou stick gauche |
| Valider | Entrée ou Espace | Clic gauche | A |
| Continuer | Échap | Clic droit | B |

## Enchaînements
- « Continuer » : retour au jeu, à l'endroit où la mission s'est terminée ; si la mission ferme un chapitre, enchaînement sur la scène de fin de chapitre.
- « Rejouer » : confirmation, puis `ecran_de_chargement.md` et la mission.
- Un succès obtenu s'affiche en haut à droite (voir `succes.md`) par-dessus cet écran.

## Règles et états
- Les boutons n'apparaissent qu'après 1,2 s, le temps que les lignes du bilan arrivent une à une (0,15 s chacune) : pas de validation par accident.
- Lignes possibles, dans cet ordre, affichées seulement si elles ne valent pas zéro : « Récompense », « Prime de rapidité (<temps>) », « Prime : véhicule intact », « Réparation de <véhicule> », « Amende », « Remboursé à Tonton Gratien ». 5 lignes au plus.
- Gains en vert clair 8df59a avec « + », dépenses en rouge e8112d avec « − » ; le total est vert s'il est positif, rouge sinon et s'intitule alors « Tu perds ».
- Pour une course de zémidjan ordinaire, pas d'écran : seul le gain s'affiche en jeu.
- Les montants de la maquette sont des exemples (les missions d'essai paient 500, 750 et 300 FCFA).

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Remplace la bannière `m.l_banner` (taille 52, or) de `scripts/hud.gd` pour les missions.
- La sauvegarde automatique s'écrit pendant l'affichage ; le témoin attend le signal de fin d'écriture.
