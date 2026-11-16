# Pick-up de chantier

Tâche T2163 · fichier modèle `assets/modeles/vehicules/vehicule_pickup_chantier_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Pick-up double cabine des entreprises de travaux et des chefs de chantier, très présent pendant les grands chantiers du chapitre 4 (décisions 91 et 96).

## Où on le croise à Cotonou
Chantiers de voirie, port, zone industrielle d'Akpakpa, carrières de sable de la plage.

- Présence selon les chapitres : Rare avant le chapitre 4, très courant aux chapitres 4 et 5.
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « camionnette »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,20 m |
| Largeur | 1,80 m |
| Hauteur | 1,80 m |
| Masse à vide | 1 750 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,20 × 1,80 × 1,80 m, origine au sol (ou à la ligne de flottaison), au centre |

Double cabine 4 portes ; plateau court de 1,50 × 1,55 m ; arceau porte-échelle à l'arrière de la cabine (hauteur totale 2,05 m avec l'arceau) ; empattement 3,05 m ; roues de 0,74 m ; garde au sol 0,22 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 105 km/h (29,2 m/s) |
| Accélération au démarrage | 11 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,6 s |
| Freinage | 26 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 6,2 m |
| Maniabilité | 3 / 5 |

Franchit trottoirs, tranchées peu profondes et sable sans perte. Bitume : comme le pick-up bâché.

## Places et chargement
- Places : 5.
- Chargement : 5 personnes + 800 kg.

## Solidité
- Coefficient de solidité : **0,75** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 17 points de dégâts sur 100 ; à sa vitesse maximale = 47 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,75.

## Couleurs
- Blanc `f4f1ea` avec bande orange `d98c5f` ou jaune `fcd116` sur les flancs.
- Poussière de ciment grise `d6d0c4` sur le plateau, boue rouge sur les roues.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_pickup_chantier_blanc.glb` | Base, plateau vide |
| `vehicule_pickup_chantier_outils.glb` | Brouette, pelles, 6 sacs de ciment, bétonnière miniature attelée (+ 600 triangles, niveau fin seulement) |
| `vehicule_pickup_chantier_geometre.glb` | Trépied et cônes orange dans le plateau |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Gyrophare orange sur le toit, bandes réfléchissantes rouges et blanches à l'arrière.
- Nom d'entreprise inventé en texture sur les portes (voir la liste des marques fictives du projet quand elle existera ; en attendant « Travaux du Littoral »).
- Casques de chantier jaunes posés sur le tableau de bord.
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
- `ridelle_ar`, `gyrophare`, `chargement`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_outils_plateau.ogg` : outils métalliques qui s'entrechoquent.

## Consigne de génération 3D (à copier telle quelle)
> A double-cab four-door work pickup truck for a construction company: white body with an orange stripe along the sides, short open cargo bed with a steel ladder rack behind the cab, an orange beacon on the roof, red and white reflective strips on the tailgate, muddy all-terrain tires, shovels and cement bags in the bed. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.20 m long, 1.80 m wide, 1.80 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
