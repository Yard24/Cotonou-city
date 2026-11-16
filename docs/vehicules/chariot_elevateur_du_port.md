# Chariot élévateur du port

Tâche T2453 · fichier modèle `assets/modeles/vehicules/vehicule_chariot_elevateur_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Chariot à fourches des entrepôts du port et des dépôts de grossistes. Décor animé (il charge les camions) et outil de deux missions : charger des palettes dans un temps donné, déplacer discrètement une caisse dans l'entrepôt de Monsieur Fortuné.

## Où on le croise à Cotonou
Entrepôts et quais du port, dépôts de boissons, entrepôt du joueur (décision 69), zone de fret de l'aéroport.

- Présence selon les chapitres : Tous les chapitres ; utilisable par le joueur à partir du chapitre 2.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Hors de la liste de la décision 55 : conduit seulement dans les missions prévues, à l'intérieur du port et des entrepôts (il ne sort pas sur la route).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 3,60 m |
| Largeur | 1,50 m |
| Hauteur | 2,40 m |
| Masse à vide | 4 500 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 3,60 × 1,50 × 2,40 m, origine au sol (ou à la ligne de flottaison), au centre |

Châssis de 2,40 m plus fourches de 1,20 m ; mât replié à 2,40 m, déployé à 4,50 m ; toit de protection en tube à 2,20 m ; roues pleines de 0,65 m à l'avant, 0,50 m à l'arrière ; contrepoids arrière arrondi.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 22 km/h (6,1 m/s) |
| Accélération au démarrage | 4 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 10 m/s² |
| Marche arrière | 22 km/h au plus |
| Rayon de braquage minimal | 2,4 m |
| Maniabilité | 5 / 5 |

Ce sont les roues arrière qui braquent : l'arrière balaie large, à l'inverse d'une voiture. Aussi rapide en arrière qu'en avant. Fourches : monter et descendre (1 m/s). Palette levée à plus de 1,5 m : vitesse limitée à 8 km/h, sinon elle tombe.

## Places et chargement
- Places : 1.
- Chargement : 1 conducteur ; 3 000 kg sur les fourches (1 palette de 1,2 × 1,0 m).

## Solidité
- Coefficient de solidité : **0,50** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 1,4 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,5. Les palettes tombées se cassent (mission échouée ou pénalité).

## Couleurs
- Orange `d98c5f` ou jaune `fcd116`, contrepoids et mât noirs `3a3a3d`.
- Siège noir, bouteille de gaz grise `d6d0c4` couchée à l'arrière.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_chariot_elevateur_orange.glb` | Base |
| `vehicule_chariot_elevateur_palette.glb` | Avec une palette de cartons filmés |
| `vehicule_chariot_elevateur_gerbeur.glb` | Décor du terminal : grand gerbeur de conteneurs de 11 × 4 × 4,5 m à bras télescopique, non pilotable (modèle distinct, budget « bus, camion ») |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Gyrophare orange sur le toit de protection, peinture écaillée aux angles.
- Numéro d'engin peint en blanc au pochoir (2 chiffres).
- Cariste en gilet orange et casque.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 6 000 |
| Niveau 1 (environ 50 %) | 3 000 |
| Niveau 2, vu de loin (environ 15 %) | 900 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `mat` (2 éléments télescopiques), `tablier_fourches` (glisse sur le mât), `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (les arrière pivotent), `volant`, `gyrophare`.
- `palette` séparée (objet de décor, 150 triangles).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `engin` (diesel lent d'engin, régime presque constant), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_engin_demarre.ogg`, `bruit_moteur_engin_ralenti.ogg` (boucle), `bruit_moteur_engin_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_engin_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- `bruit_chariot_mat.ogg` : chaîne et hydraulique du mât (boucle).
- `bruit_chariot_fourches_pose.ogg` : palette posée.
- `bruit_bip_recul.ogg` (partagé).
- `bruit_palette_casse.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A compact industrial counterbalance forklift truck: orange body with a rounded black rear counterweight, a black two-stage vertical mast with two steel forks at the front, an open operator seat under a tubular overhead guard, solid rubber tires with smaller rear steering wheels, a grey gas cylinder lying on the back, an orange beacon. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 3.60 m long, 1.50 m wide, 2.40 m high. About 6000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, lifting arms, buckets or mast and forks as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
