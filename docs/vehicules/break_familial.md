# Break familial

Tâche T2123 · fichier modèle `assets/modeles/vehicules/vehicule_break_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Longue voiture à grand coffre, utilisée comme taxi-brousse entre Cotonou et les villes voisines, et comme voiture de famille. Sert aux missions de transport de colis volumineux avant l'achat d'une camionnette.

## Où on le croise à Cotonou
Gares routières (Étoile Rouge, sortie nord), route du port, Dantokpa côté lagune ; chargé jusqu'au toit.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 3 sur un total de 126,1 (voir `tableau.md`), soit environ 2,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,70 m |
| Largeur | 1,76 m |
| Hauteur | 1,50 m |
| Masse à vide | 1 350 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,70 × 1,76 × 1,50 m, origine au sol (ou à la ligne de flottaison), au centre |

Tricorps allongé, toit plat jusqu'au hayon ; empattement 2,75 m ; roues de 0,62 m ; avec galerie chargée : hauteur 2,10 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 112 km/h (31,1 m/s) |
| Accélération au démarrage | 12,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,4 s |
| Freinage | 28 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,6 m |
| Maniabilité | 3 / 5 |

Arrière lourd : chargé, 85 % du braquage de la référence et +10 % de distance de freinage.

## Places et chargement
- Places : 5 (7 en taxi-brousse).
- Chargement : 5 personnes (7 avec la banquette du coffre, circulation seulement) ; 500 kg ou 12 colis moyens.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 68 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence.

## Couleurs
- Blanc cassé `f4f1ea`, beige `e8c99a`, bleu `9fc3d9`, vert d'eau `c4d4c8`.
- Variante taxi-brousse : jaune `f2c200` sans bande (la bande verte est réservée aux taxis-ville).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_break_beige.glb` | Base |
| `vehicule_break_brousse.glb` | Galerie surchargée : sacs, régime de bananes, bidons ; arrière affaissé de 5 cm |
| `vehicule_break_famille.glb` | Sièges enfants suggérés, ballon sur la plage arrière |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Galerie en fer soudé avec filet de corde, bâche bleue `2a86b5`.
- Troisième rangée face à la route, hayon tenu entrouvert par une corde.
- Devise sur le hayon : « Bonne arrivée ».
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
- `hayon`, `galerie`, `chargement_toit` séparés.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_ancienne` (moteur à essence fatigué, léger cliquetis), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_ancienne_demarre.ogg`, `bruit_moteur_voiture_ancienne_ralenti.ogg` (boucle), `bruit_moteur_voiture_ancienne_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_ancienne_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_galerie_grince.ogg` : chargement qui bouge au freinage.

## Consigne de génération 3D (à copier telle quelle)
> A long 1990s station wagon estate car: flat roofline extending to an upright rear tailgate, beige paint, a welded steel roof rack loaded with sacks, jerrycans and a blue tarpaulin tied down with rope, sagging rear suspension, steel wheels, grey bumpers. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.70 m long, 1.76 m wide, 1.50 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
