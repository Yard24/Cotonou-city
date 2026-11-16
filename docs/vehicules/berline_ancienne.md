# Berline ancienne

Tâche T2093 · fichier modèle `assets/modeles/vehicules/vehicule_berline_ancienne_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Voiture d'occasion importée, la plus courante des voitures particulières. Première voiture abordable pour Koffi ; véhicule des petits adversaires (hommes de Capitaine au début).

## Où on le croise à Cotonou
Partout ; garée dans les rues de quartier, devant les maisons, en vente dans les parcs de voitures d'occasion fictifs de la route du port.

- Présence selon les chapitres : Tous les chapitres (la part diminue après le chapitre 4).
- Part dans la circulation : poids de tirage 8 sur un total de 126,1 (voir `tableau.md`), soit environ 6,3 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,50 m |
| Largeur | 1,72 m |
| Hauteur | 1,42 m |
| Masse à vide | 1 200 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,50 × 1,72 × 1,42 m, origine au sol (ou à la ligne de flottaison), au centre |

Tricorps anguleux ; empattement 2,60 m ; roues de 0,62 m ; garde au sol 0,15 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 108 km/h (30,0 m/s) |
| Accélération au démarrage | 12 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,5 s |
| Freinage | 26 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,3 m |
| Maniabilité | 3 / 5 |

Direction un peu floue : 90 % du braquage de la voiture de référence au-dessus de 80 km/h. Freins usés.

## Places et chargement
- Places : 5.
- Chargement : 5 personnes, coffre de 400 litres (8 colis moyens).

## Solidité
- Coefficient de solidité : **1,10** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 25 points de dégâts sur 100 ; à sa vitesse maximale = 71 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Tôle fatiguée : dégâts reçus × 1,1 ; la fumée claire apparaît dès 45 au lieu de 50.

## Couleurs
- Une teinte passée : gris `d6d0c4`, blanc cassé `f4f1ea`, vert d'eau `c4d4c8`, terre cuite `d98c5f`, bleu `9fc3d9`.
- Un élément souvent d'une autre teinte (portière ou capot remplacé).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_berline_ancienne_grise.glb` | Base |
| `vehicule_berline_ancienne_depareillee.glb` | Portière avant droite d'une autre couleur |
| `vehicule_berline_ancienne_galerie.glb` | Galerie de toit avec matelas roulé et bassines |
| `vehicule_berline_ancienne_capitaine.glb` | Noire, vitres sombres `1e2a33`, pour les hommes de main |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Enjoliveurs manquants, antenne tordue, autocollant d'origine étrangère à moitié arraché sur la lunette (formes abstraites, aucun texte lisible).
- Pare-soleil en carton derrière le pare-brise quand elle est garée.
- Housse de sièges à motif pagne inventé.
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
- `bruit_voiture_ancienne_demarre_mal.ogg` : démarreur qui insiste (une fois sur quatre).

## Consigne de génération 3D (à copier telle quelle)
> A worn 1990s mid-size four-door sedan: angular three-box body in faded grey paint, one front door in a slightly different shade, black plastic bumpers, steel wheels with a missing hubcap, bent radio antenna, simple rectangular headlights and tail lights. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.50 m long, 1.72 m wide, 1.42 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
