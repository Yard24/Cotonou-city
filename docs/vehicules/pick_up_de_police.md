# Pick-up de police

Tâche T2273 · fichier modèle `assets/modeles/vehicules/vehicule_police_pickup_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Pick-up d'intervention : deux agents en cabine, quatre à six assis sur des bancs dos à dos dans le plateau. Sert aux barrages (étoile 3) et, proposé pour les étoiles 4 et 5 encore à valider (décision 73), au renfort en nombre.

## Où on le croise à Cotonou
Commissariat, barrages aux ponts, grands carrefours aux heures de pointe, entrée du port, marchés en cas d'attroupement.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,25 m |
| Largeur | 1,85 m |
| Hauteur | 1,95 m |
| Masse à vide | 1 900 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,25 × 1,85 × 1,95 m, origine au sol (ou à la ligne de flottaison), au centre |

Double cabine ; plateau de 1,50 × 1,55 m avec arceau et deux bancs longitudinaux dos à dos ; hauteur prise au sommet de l'arceau et de la rampe ; roues de 0,76 m ; garde au sol 0,23 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 125 km/h (34,7 m/s) |
| Accélération au démarrage | 14 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,3 s |
| Freinage | 28 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 6,2 m |
| Maniabilité | 3 / 5 |

Suit le joueur sur le sable, les trottoirs et dans l'eau jusqu'à 0,50 m : c'est lui qui coupe les fuites par la plage. Moins vif que la voiture de patrouille.

## Places et chargement
- Places : 5 (+ 6 sur les bancs).
- Chargement : 5 en cabine + 6 sur les bancs.

## Solidité
- Coefficient de solidité : **0,70** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 16 points de dégâts sur 100 ; à sa vitesse maximale = 54 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,7 ; pare-buffle (chocs avant sous 30 km/h sans effet). Sert d'obstacle fixe aux barrages.

## Couleurs
- Bleu nuit `1e2a33`, capot et bande latérale blancs `f4f1ea`.
- Bancs et arceau noirs, rampe bleue.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_police_pickup_patrouille.glb` | Base, 4 agents sur les bancs |
| `vehicule_police_pickup_barrage.glb` | À l'arrêt, en travers, avec 2 barrières et 4 cônes posés à côté (objets séparés) |
| `vehicule_police_pickup_douane.glb` | Vert foncé `2f7d32` et blanc, mot « DOUANE » |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Agents assis dos à dos dans le plateau, se tenant à l'arceau.
- « POLICE » en texture sur les portes et la ridelle, écusson fictif.
- Projecteur orientable sur le toit de la cabine.
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
- `rampe`, `ridelle_ar`, `bancs` ; `agents` séparés (4 personnages au niveau « passant »).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sirene_police.ogg` (partagé).
- `bruit_police_descend.ogg` : bottes qui sautent du plateau.

## Consigne de génération 3D (à copier telle quelle)
> A police double-cab pickup truck with a fictional livery: dark navy blue body with a white hood and a white side stripe, blue light bar on the cab roof, tubular bull bar, open cargo bed fitted with a roll bar and two back-to-back longitudinal benches for officers, a spotlight on the roof, plain shield emblem with no text. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.25 m long, 1.85 m wide, 1.95 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
