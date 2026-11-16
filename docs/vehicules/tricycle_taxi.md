# Tricycle taxi

Tâche T2073 · fichier modèle `assets/modeles/vehicules/vehicule_tricycle_taxi_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Petit taxi à trois roues couvert, pour 3 passagers. Il apparaît au fil des années pour montrer que la ville change et concurrence les zémidjans (sujet de dialogues avec le Doyen).

## Où on le croise à Cotonou
Akpakpa, Fidjrossè, sorties de marché, abords de l'aéroport. Absent du centre de Ganhi au début.

- Présence selon les chapitres : Absent au chapitre 1, rare au chapitre 2, courant à partir du chapitre 4.
- Part dans la circulation : poids de tirage 3 sur un total de 126,1 (voir `tableau.md`), soit environ 2,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (rattaché à la famille « taxi » de la décision 55) ; les courses fonctionnent comme celles du zémidjan, avec 3 clients au plus pour une même destination.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 2,80 m |
| Largeur | 1,35 m |
| Hauteur | 1,75 m |
| Masse à vide | 360 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 2,80 × 1,35 × 1,75 m, origine au sol (ou à la ligne de flottaison), au centre |

Roue avant de 0,45 m sous un capot arrondi, deux roues arrière de 0,45 m ; banquette arrière large de 1,15 m ; ouvertures latérales sans portes (demi-portillons de 0,45 m de haut).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 58 km/h (16,1 m/s) |
| Accélération au démarrage | 9 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 2,0 s |
| Freinage | 14 m/s² |
| Marche arrière | 8 km/h au plus |
| Rayon de braquage minimal | 2,8 m |
| Maniabilité | 4 / 5 |

Demi-tour dans une rue de 7 m. Passe dans 1,7 m. Instable : au-delà de 40 km/h en virage serré, il se soulève et ralentit de lui-même (pas de tonneau).

## Places et chargement
- Places : 4 (pilote + 3).
- Chargement : Pilote + 3 passagers, petit porte-bagages sur le toit (40 kg).

## Solidité
- Coefficient de solidité : **1,10** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 25 points de dégâts sur 100 ; à sa vitesse maximale = 32 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Tôle fine et bâche : dégâts reçus × 1,1.

## Couleurs
- Carrosserie jaune `f2c200` avec bande verte `1f8a3a`, comme les taxis-ville (décision 44).
- Capote en toile noire `1e2a33` ou verte, châssis noir.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_tricycle_taxi_jaune.glb` | Base |
| `vehicule_tricycle_taxi_bache.glb` | Rideaux de pluie en plastique transparent roulés sur les côtés |
| `vehicule_tricycle_taxi_prive.glb` | Bleu `2a86b5`, sans bande, pour un commerçant |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Pare-brise plat avec un seul essuie-glace, guidon de moto à l'intérieur.
- Banquette en simili rouge, franges décoratives en haut du pare-brise.
- Devise sur le pare-chocs arrière : « On est ensemble ».
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 6 500 |
| Niveau 1 (environ 50 %) | 3 250 |
| Niveau 2, vu de loin (environ 15 %) | 980 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cadre, réservoir, selle, carrosserie soudés.
- `phare`, `feu_g`, `feu_d` : matière émissive.
- `roue_av`, `roue_arg`, `roue_ard`, `fourche`.
- `portillon_g`, `portillon_d`, `vitres` (pare-brise seul).
- `conducteur` séparé.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `tricycle` (monocylindre poussif, pétaradant), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_tricycle_demarre.ogg`, `bruit_moteur_tricycle_ralenti.ogg` (boucle), `bruit_moteur_tricycle_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_tricycle_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- `bruit_tricycle_capote.ogg` : toile qui claque au vent au-dessus de 40 km/h.

## Consigne de génération 3D (à copier telle quelle)
> A three-wheeled auto-rickshaw passenger taxi: rounded yellow sheet-metal body with a green horizontal stripe, single front wheel under a rounded nose, flat windshield with one wiper, black canvas roof, open sides with low half-doors, a rear bench seat for three passengers in red vinyl, motorcycle-style handlebar inside, small roof rack. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 2.80 m long, 1.35 m wide, 1.75 m high. About 6500 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
