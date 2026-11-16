# Car inter-villes

Tâche T2203 · fichier modèle `assets/modeles/vehicules/vehicule_car_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Grand autocar de ligne vers le Nord (Parakou) et les pays voisins. Décor des gares routières et de la route du Nord (décision 88) ; un départ de car sert de compte à rebours dans une mission (amener un colis avant le départ).

## Où on le croise à Cotonou
Gares routières des compagnies fictives (Étoile Rouge et sortie nord), stations-service, route du Nord.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 0,5 sur un total de 126,1 (voir `tableau.md`), soit environ 0,4 % des véhicules qui roulent.
- Pilotable par le joueur : Non (hors décision 55) : IA seulement.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 12,00 m |
| Largeur | 2,50 m |
| Hauteur | 3,50 m |
| Masse à vide | 13 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 12,00 × 2,50 × 3,50 m, origine au sol (ou à la ligne de flottaison), au centre |

Plancher haut au-dessus de soutes à bagages (3 trappes par côté, 1,60 × 0,70 m) ; empattement 6,10 m ; roues de 1,00 m ; 1 porte à l'avant droit ; rétroviseurs en « oreilles » descendant du toit.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 100 km/h (27,8 m/s) |
| Accélération au démarrage | 4,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 4,0 s |
| Freinage | 16 m/s² |
| Marche arrière | 8 km/h au plus |
| Rayon de braquage minimal | 11,5 m |
| Maniabilité | 1 / 5 |

Comme le bus de ville, en plus long. Sort de la gare en occupant toute la chaussée (la circulation attend 12 secondes).

## Places et chargement
- Places : 52 (chauffeur + convoyeur + 50).
- Chargement : Chauffeur + convoyeur + 50 passagers ; 2 000 kg en soute.

## Solidité
- Coefficient de solidité : **0,40** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 9 points de dégâts sur 100 ; à sa vitesse maximale = 24 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,4.

## Couleurs
- Deux compagnies fictives : blanc `f4f1ea` à grande vague rouge `e8112d`, ou bleu `2a86b5` à bande jaune `fcd116`.
- Bas de caisse et soutes gris `d6d0c4`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_car_rouge.glb` | Compagnie « Étoile du Nord » (nom inventé) |
| `vehicule_car_bleu.glb` | Compagnie « Trans-Nokoué » (nom inventé) |
| `vehicule_car_soutes.glb` | À quai, trappes ouvertes, bagages posés devant |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Destination sur un panneau derrière le pare-brise : « PARAKOU », « ABOMEY ».
- Rideaux à toutes les vitres, climatiseur bosselé sur le toit.
- Vendeuses qui tendent pain, eau et fruits vers les vitres à l'arrêt (passantes, décision 46).
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Bus, camion » de `docs/style_graphique.md` : 10 000 triangles au plus en détail fin, 1 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 10 000 |
| Niveau 1 (environ 50 %) | 5 000 |
| Niveau 2, vu de loin (environ 15 %) | 1 500 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cabine, caisse et châssis soudés.
- Roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (sauf indication contraire plus bas) ; les roues avant pivotent.
- Portes de cabine : `porte_avg`, `porte_avd` (sauf indication contraire plus bas).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d`, `parechoc_av`, `parechoc_ar` : comme sur les voitures.
- Intérieur de cabine simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés, 800 triangles au plus.
- `porte_av`, 6 `trappe_soute_*`, `chargement_soute`.
- 6 roues en 4 pièces, comme le bus.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_car_klaxon_route.ogg` : klaxon grave à deux tons, sur route seulement.
- `bruit_bus_frein_air.ogg` (partagé).
- `voix_gare_annonce_01.ogg` à `_03` : « Parakou, on embarque ! ».

## Consigne de génération 3D (à copier telle quelle)
> A long-distance intercity coach bus, 12 meters long: tall body with a high passenger floor above luggage bay hatches, white paint with a large red wave graphic along the sides, one front door, curtained side windows, a roof air-conditioning unit, mirrors hanging down from the roof corners like ears. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 12.00 m long, 2.50 m wide, 3.50 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
