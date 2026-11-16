# Coupé de luxe

Tâche T2333 · fichier modèle `assets/modeles/vehicules/vehicule_coupe_luxe_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Grand coupé élégant de Monsieur Fortuné (décision 34 : costume clair, poli) quand il conduit lui-même, et des hommes d'affaires du port. Voiture à suivre discrètement dans les missions de filature.

## Où on le croise à Cotonou
Devant les bureaux de transit du port, hôtels de la Marina, résidences de l'ouest, maquis chics de Fidjrossè.

- Présence selon les chapitres : À partir du chapitre 2 (apparition de Monsieur Fortuné).
- Part dans la circulation : poids de tirage 0,5 sur un total de 126,1 (voir `tableau.md`), soit environ 0,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « voiture ») ; achetable au chapitre 6.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,80 m |
| Largeur | 1,90 m |
| Hauteur | 1,36 m |
| Masse à vide | 1 750 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,80 × 1,90 × 1,36 m, origine au sol (ou à la ligne de flottaison), au centre |

Coupé 2 portes à long capot ; empattement 2,80 m ; roues de 0,72 m ; garde au sol 0,13 m ; portes longues de 1,35 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 150 km/h (41,7 m/s) |
| Accélération au démarrage | 18 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,0 s |
| Freinage | 32 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 5,7 m |
| Maniabilité | 4 / 5 |

Très stable à haute vitesse (40 % de braquage perdu à pleine vitesse), lourd dans les rues étroites. Hors bitume : vitesse −30 %.

## Places et chargement
- Places : 4.
- Chargement : 2 + 2 petites places arrière, coffre de 350 litres.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 95 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence.

## Couleurs
- Crème `f2e6d0` (exemplaire de Monsieur Fortuné, assorti à son costume), gris anthracite `3a3a3d`, bleu nuit `1e2a33`.
- Intérieur brun `8b5a2b`, jantes gris clair.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_coupe_luxe_creme.glb` | Exemplaire de Monsieur Fortuné, intérieur brun |
| `vehicule_coupe_luxe_anthracite.glb` | Hommes d'affaires |
| `vehicule_coupe_luxe_cabriolet.glb` | Toit en toile replié, 2 exemplaires à Fidjrossè |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Chapeau clair posé sur la plage arrière (exemplaire de Monsieur Fortuné).
- Toujours garé en travers de deux places, un gardien payé pour le surveiller.
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
- 2 portes ; `toit` séparé pour la variante cabriolet.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `sport` (moteur rauque qui monte haut dans les tours), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_sport_demarre.ogg`, `bruit_moteur_sport_ralenti.ogg` (boucle), `bruit_moteur_sport_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_sport_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A large luxury grand-touring two-door coupe: long hood, cream-colored elegant flowing body, wide chrome-look grille, long doors, low sloping roof, brown leather interior visible through the windows, 19-inch multi-spoke alloy wheels, twin oval exhausts. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.80 m long, 1.90 m wide, 1.36 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
