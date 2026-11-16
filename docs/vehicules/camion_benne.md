# Camion-benne

Tâche T2253 · fichier modèle `assets/modeles/vehicules/vehicule_benne_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Camion de chantier qui transporte sable, gravier et latérite. Très présent pendant les chantiers du chapitre 4 ; ses allers-retours ralentissent des quartiers entiers. Mission de camionneur : livrer du sable de la carrière au chantier.

## Où on le croise à Cotonou
Chantiers de voirie, carrière de sable près de la plage, berges de la lagune (sable dragué), zone industrielle d'Akpakpa.

- Présence selon les chapitres : Rare avant le chapitre 4, très courant aux chapitres 4 et 5.
- Part dans la circulation : poids de tirage 1,5 sur un total de 126,1 (voir `tableau.md`), soit environ 1,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui, dans les missions (décision 55, famille « camion »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 7,50 m |
| Largeur | 2,45 m |
| Hauteur | 3,10 m |
| Masse à vide | 11 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 7,50 × 2,45 × 3,10 m, origine au sol (ou à la ligne de flottaison), au centre |

Cabine avancée de 2,10 m ; benne de 4,60 × 2,30 × 1,10 m avec casquette au-dessus de la cabine ; benne levée à 50° : hauteur 5,60 m ; 3 essieux, roues de 1,05 m à crampons ; garde au sol 0,35 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 80 km/h (22,2 m/s) |
| Accélération au démarrage | 4,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 4,0 s |
| Freinage | 14 m/s² |
| Marche arrière | 10 km/h au plus |
| Rayon de braquage minimal | 8,5 m |
| Maniabilité | 1 / 5 |

Aucune perte sur terre et sable. Benne : touche d'action à l'arrêt, 6 secondes pour lever, le chargement se déverse en tas (objet de 3 m de large). Rouler benne levée est limité à 10 km/h.

## Places et chargement
- Places : 2.
- Chargement : 2 en cabine ; 12 000 kg (8 m³ de sable).

## Solidité
- Coefficient de solidité : **0,35** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 8 points de dégâts sur 100 ; à sa vitesse maximale = 16 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,35.

## Couleurs
- Cabine jaune `fcd116`, orange `d98c5f` ou blanche ; benne grise `d6d0c4` cabossée ou de la couleur de la cabine.
- Chargement : sable `e8d3a0`, latérite `b5653a`, gravier gris.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_benne_sable.glb` | Benne pleine de sable, en dôme |
| `vehicule_benne_laterite.glb` | Pleine de terre rouge |
| `vehicule_benne_vide.glb` | Benne vide, intérieur rayé |
| `vehicule_benne_levee.glb` | État : benne à 50° |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Filet ou bâche à moitié mis sur le chargement, sable qui s'envole en petites particules (effet léger).
- Pelle coincée derrière la cabine, apprenti assis sur le tas.
- Devise sur la porte arrière de la benne : « Petit à petit ».
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
- `benne` (pivot à l'arrière du châssis), `porte_benne` (articulée en haut), `verin`, `chargement`, `porte_g`, `porte_d`.
- 10 roues en 6 pièces.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_benne_leve.ogg` : vérin hydraulique (6 s).
- `bruit_benne_deverse.ogg` : sable qui coule.
- `bruit_bip_recul.ogg` (partagé).
- `bruit_camion_frein_air.ogg` (partagé).

## Consigne de génération 3D (à copier telle quelle)
> A three-axle construction dump truck: yellow cab-over cab, dented grey steel tipping bed with a cab-protecting overhang, loaded with a mound of sand, hydraulic ram under the bed, large knobby tires, high ground clearance, mud and red dust on the chassis. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 7.50 m long, 2.45 m wide, 3.10 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
