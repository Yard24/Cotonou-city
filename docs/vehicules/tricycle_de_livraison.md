# Tricycle de livraison

Tâche T2063 · fichier modèle `assets/modeles/vehicules/vehicule_tricycle_benne_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Moto à trois roues avec une benne à l'arrière. Deuxième véhicule de travail de Koffi : métier de livreur (décision 67) et livraisons pour Nan Akouavi au chapitre 2. Transporte aussi les bidons de kpayo (décision 5).

## Où on le croise à Cotonou
Dantokpa, Missèbo, quais de la lagune, dépôts de boissons, chantiers. Garé en file devant les grossistes.

- Présence selon les chapitres : Circulation dès le chapitre 1 ; conduit par le joueur à partir du chapitre 2.
- Part dans la circulation : poids de tirage 6 sur un total de 126,1 (voir `tableau.md`), soit environ 4,8 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 3,30 m |
| Largeur | 1,30 m |
| Hauteur | 1,45 m |
| Masse à vide | 380 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 3,30 × 1,30 × 1,45 m, origine au sol (ou à la ligne de flottaison), au centre |

Avant de moto (guidon, une roue de 0,58 m), benne de 1,80 × 1,25 × 0,40 m dont le plancher est à 0,60 m du sol ; deux roues arrière de 0,58 m, voie 1,10 m ; variante à toit : hauteur 1,80 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 62 km/h (17,2 m/s) |
| Accélération au démarrage | 9 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 2,0 s |
| Freinage | 14 m/s² |
| Marche arrière | 8 km/h au plus |
| Rayon de braquage minimal | 3,0 m |
| Maniabilité | 3 / 5 |

Se conduit comme une voiture étroite (ne penche pas). Passe dans 1,7 m de large : il se faufile là où une voiture bloque, mais pas dans le couloir de 1,4 m des motos. Virage pris à plus de 45 km/h en charge : la roue intérieure se lève et le chargement glisse (colis perdus), sans tonneau.

## Places et chargement
- Places : 1 (+ 1 passager assis dans la benne, circulation seulement).
- Chargement : 500 kg dans la benne (20 casiers, 10 sacs ou 16 bidons de 25 litres).

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 32 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 1,0. Le pilote n'est pas éjecté, mais il perd de la santé comme à moto (pas de carrosserie).

## Couleurs
- Benne et réservoir d'une couleur vive : bleu `2a86b5`, rouge `e8112d` ou vert `008751`.
- Châssis noir `3a3a3d`, intérieur de benne gris `d6d0c4` rayé.
- Chargement : casiers jaunes `fcd116` ou rouges, sacs blancs, bidons jaunes.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_tricycle_benne_bleu.glb` | Benne nue |
| `vehicule_tricycle_benne_toit.glb` | Arceau et toit en tôle au-dessus du pilote, pare-brise plat |
| `vehicule_tricycle_benne_casiers.glb` | 20 casiers de boissons fictives |
| `vehicule_tricycle_benne_kpayo.glb` | 16 bidons jaunes et 2 dames-jeannes de carburant de contrebande, entonnoir |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Ridelles rabattables fermées par des crochets, numéro de téléphone fictif peint au pochoir (8 chiffres commençant par 00).
- Devise peinte à l'arrière : « Qui va doucement va loin ».
- Bâche pliée sous un tendeur, roue de secours couchée dans la benne.
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
- `corps` : cadre, réservoir, selle, carrosserie soudés.
- `phare`, `feu_g`, `feu_d` : matière émissive.
- `roue_av`, `roue_arg`, `roue_ard`, `fourche` (pivot de direction).
- `ridelle_ar` articulée, `chargement` séparé.
- `conducteur` séparé (1 800 triangles, compris dans les 6 000).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `tricycle` (monocylindre poussif, pétaradant), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_tricycle_demarre.ogg`, `bruit_moteur_tricycle_ralenti.ogg` (boucle), `bruit_moteur_tricycle_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_tricycle_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- `bruit_tricycle_benne_claque.ogg` : ridelle.
- `bruit_casiers_tintent.ogg` : bouteilles qui s'entrechoquent sur les bosses (variante casiers).

## Consigne de génération 3D (à copier telle quelle)
> A three-wheeled cargo motorcycle: motorcycle front end with handlebar, single front wheel, fuel tank and saddle, attached to a rectangular blue steel cargo bed with low drop sides on a two-wheel rear axle, exposed black frame, a spare wheel lying in the bed, a folded tarpaulin strapped on. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 3.30 m long, 1.30 m wide, 1.45 m high. About 6000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
