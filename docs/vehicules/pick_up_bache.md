# Pick-up bâché

Tâche T2153 · fichier modèle `assets/modeles/vehicules/vehicule_pickup_bache_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Pick-up à plateau couvert d'une bâche sur arceaux : transport mixte de marchandises et de passagers assis sur des bancs. Véhicule de livraison intermédiaire de Koffi (chapitres 2 et 3 : vivres et médicaments).

## Où on le croise à Cotonou
Dantokpa côté lagune, gares routières, route du port, villages lacustres (embarcadère), marchés de quartier.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 3 sur un total de 126,1 (voir `tableau.md`), soit environ 2,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « camionnette »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,20 m |
| Largeur | 1,80 m |
| Hauteur | 2,00 m |
| Masse à vide | 1 700 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,20 × 1,80 × 2,00 m, origine au sol (ou à la ligne de flottaison), au centre |

Cabine simple 3 places ; plateau de 2,30 × 1,55 m, plancher à 0,80 m ; bâche sur 3 arceaux, hauteur intérieure 1,15 m ; empattement 3,05 m ; roues de 0,72 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 108 km/h (30,0 m/s) |
| Accélération au démarrage | 11,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,6 s |
| Freinage | 26 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 6,2 m |
| Maniabilité | 3 / 5 |

À vide l'arrière est léger : le frein à main fait pivoter plus vite (virage 15 % plus serré). Chargé : accélération −20 %.

## Places et chargement
- Places : 3 (+ 10 sur les bancs, circulation).
- Chargement : 1 000 kg ou 10 passagers sur deux bancs (circulation) ; 20 colis moyens.

## Solidité
- Coefficient de solidité : **0,80** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 18 points de dégâts sur 100 ; à sa vitesse maximale = 52 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,8.

## Couleurs
- Cabine blanche `f4f1ea`, bleue `2a86b5` ou rouge `e8112d`.
- Bâche verte `2f7d32`, bleue ou sable `e8d3a0`, rapiécée (un rectangle d'une autre teinte).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_pickup_bache_blanc.glb` | Bâche verte fermée |
| `vehicule_pickup_bache_passagers.glb` | Bâche relevée à l'arrière, 6 passagers visibles, un apprenti debout sur le pare-chocs |
| `vehicule_pickup_bache_vivres.glb` | Chapitre 3 : sacs de riz et cartons de médicaments, croix verte simple sur la bâche |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Bâche lacée par une corde en zigzag sur des crochets, ridelle arrière tenue par des chaînes.
- Bancs en bois le long des ridelles.
- Devise sur le hayon : « Tout chemin a une fin ».
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
- `ridelle_ar` articulée, `bache` séparée (matière à part, peut être retirée), `chargement`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_bache_claque.ogg` : bâche au vent (boucle au-dessus de 50 km/h).

## Consigne de génération 3D (à copier telle quelle)
> A single-cab pickup truck with a canvas-covered cargo bed: white two-door cab, long cargo bed covered by a dark green patched tarpaulin stretched over three metal hoops and laced with rope, wooden benches along the bed sides, tailgate held by chains, steel wheels, mud flaps. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.20 m long, 1.80 m wide, 2.00 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
