# Taxi jaune

Tâche T2083 · fichier modèle `assets/modeles/vehicules/vehicule_taxi_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Taxi-ville jaune à bande verte (décision 44), repère visuel de la circulation. Métier jouable (décision 67) : courses plus longues et mieux payées qu'en zémidjan, jusqu'à 4 clients qui partagent la voiture.

## Où on le croise à Cotonou
Têtes de station de l'Étoile Rouge, de Dantokpa, de l'aéroport et de la gare routière ; en maraude sur tous les boulevards. Peu présent dans les vons.

- Présence selon les chapitres : Tous les chapitres ; métier ouvert au chapitre 2.
- Part dans la circulation : poids de tirage 9 sur un total de 126,1 (voir `tableau.md`), soit environ 7,1 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,40 m |
| Largeur | 1,75 m |
| Hauteur | 1,45 m |
| Masse à vide | 1 150 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,40 × 1,75 × 1,45 m, origine au sol (ou à la ligne de flottaison), au centre |

Berline tricorps ancienne ; empattement 2,55 m ; roues de 0,62 m ; garde au sol 0,16 m ; coffre souvent entrouvert sur des bagages (variante). Gabarit de collision : celui de la voiture de `docs/monde.md` (2,0 × 4,4 m).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 110 km/h (30,6 m/s) |
| Accélération au démarrage | 13 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,4 s |
| Freinage | 30 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,2 m |
| Maniabilité | 3 / 5 |

Direction de la voiture de référence, moteur fatigué. Avec 4 clients : accélération −15 %.

## Places et chargement
- Places : 5 (conducteur + 4).
- Chargement : Conducteur + 4 clients ; 150 kg de bagages (coffre + galerie).

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 66 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence.

## Couleurs
- Carrosserie jaune `f2c200`, bande verte `1f8a3a` de 0,18 m de haut sur les flancs, à hauteur des poignées.
- Pare-chocs et bas de caisse gris `d6d0c4`, jantes en tôle grises sans enjoliveur.
- Numéro de taxi noir sur les portes avant (texture, 4 chiffres).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_taxi_jaune.glb` | Base |
| `vehicule_taxi_galerie.glb` | Galerie de toit avec deux valises et un sac (aéroport, gare routière) |
| `vehicule_taxi_fatigue.glb` | Aile avant d'un jaune plus pâle `f0dc8a`, pare-chocs arrière attaché par un fil de fer |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Lumineux « TAXI » sur le toit (petit boîtier jaune), allumé la nuit.
- Collier de perles de couleur ou petit fanion uni suspendu au rétroviseur, housse de volant en fourrure synthétique.
- Bras du conducteur à la fenêtre ; il annonce sa destination en ralentissant devant les piétons.
- Devise sur la lunette arrière : « Le travail avant tout ».
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
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_ancienne` (moteur à essence fatigué, léger cliquetis), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_ancienne_demarre.ogg`, `bruit_moteur_voiture_ancienne_ralenti.ogg` (boucle), `bruit_moteur_voiture_ancienne_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_ancienne_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `voix_taxi_destination_01.ogg` à `_06` : le chauffeur crie un quartier (« Étoile ! Étoile Rouge ! », « Dantokpa, une place ! »).

## Consigne de génération 3D (à copier telle quelle)
> An old 1990s compact four-door sedan used as a city taxi: boxy three-box shape, body painted bright yellow with one horizontal green stripe along both sides at door-handle height, small yellow roof light box, grey plastic bumpers, plain grey steel wheels without hubcaps, slightly sagging rear suspension. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.40 m long, 1.75 m wide, 1.45 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
