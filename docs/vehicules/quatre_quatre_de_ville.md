# 4x4 de ville

Tâche T2133 · fichier modèle `assets/modeles/vehicules/vehicule_4x4_ville_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Gros véhicule haut et brillant des gens aisés, des directeurs et de l'entourage de Monsieur Fortuné (décision 34). Solide et rapide : c'est la voiture des poursuivants dans les missions des chapitres 4 à 6.

## Où on le croise à Cotonou
Ganhi, Marina, quartiers résidentiels de l'ouest, parkings d'hôtels, devant les restaurants de Fidjrossè.

- Présence selon les chapitres : Rare au chapitre 1, courant à partir du chapitre 4.
- Part dans la circulation : poids de tirage 3 sur un total de 126,1 (voir `tableau.md`), soit environ 2,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « voiture »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,70 m |
| Largeur | 1,90 m |
| Hauteur | 1,75 m |
| Masse à vide | 1 900 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,70 × 1,90 × 1,75 m, origine au sol (ou à la ligne de flottaison), au centre |

Deux volumes hauts ; empattement 2,75 m ; grandes roues de 0,76 m ; garde au sol 0,22 m ; marchepieds latéraux.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 130 km/h (36,1 m/s) |
| Accélération au démarrage | 15 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,2 s |
| Freinage | 28 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,8 m |
| Maniabilité | 3 / 5 |

Monte les trottoirs sans dégât ni perte de vitesse. Caisse haute : roulis visuel jusqu'à 7° au lieu de 5°. Rues inondées franchies jusqu'à 0,45 m d'eau.

## Places et chargement
- Places : 5.
- Chargement : 5 personnes (7 avec strapontins), coffre de 600 litres.

## Solidité
- Coefficient de solidité : **0,80** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 18 points de dégâts sur 100 ; à sa vitesse maximale = 64 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,8. Dans un choc contre une voiture plus légère, c'est l'autre qui est repoussée.

## Couleurs
- Noir `1e2a33`, blanc `f4f1ea`, gris anthracite `3a3a3d`, champagne `e8c99a`.
- Calandre et marchepieds gris clair, vitres arrière très sombres `1e2a33`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_4x4_ville_noir.glb` | Base |
| `vehicule_4x4_ville_blanc.glb` | Organisation fictive : antenne longue, autocollant rond abstrait sur la porte |
| `vehicule_4x4_ville_fortune.glb` | Champagne, chauffeur en chemise blanche, pour l'entourage de Monsieur Fortuné |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Roue de secours sous housse rigide sur le hayon.
- Pare-buffle chromé discret, barres de toit.
- Toujours propre, garé à l'ombre avec un gardien assis à côté.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 8 000 |
| Niveau 1 (environ 50 %) | 4 000 |
| Niveau 2, vu de loin (environ 15 %) | 1 200 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : caisse, toit et planche de bord soudés.
- `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` : origine au centre de la roue ; les roues avant pivotent.
- Portes : `porte_avg`, `porte_avd`, `porte_arg`, `porte_ard` (sauf indication contraire plus bas), charnière à l'avant, ouverture de 65°.
- `capot` et `coffre` : ils se plient à 25 de dégâts (choc avant ou arrière).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d` : cassables séparément, matière émissive.
- `parechoc_av`, `parechoc_ar` : ils pendent à 50 de dégâts.
- Intérieur simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés au corps, 800 triangles au plus, absents des niveaux allégés.
- `hayon`, `roue_secours` séparés.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A large modern luxury SUV: tall glossy black two-box body, big chrome-look grille, high ground clearance, 18-inch alloy wheels, side steps, roof rails, very dark tinted rear windows, spare wheel under a hard cover on the tailgate. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.70 m long, 1.90 m wide, 1.75 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
