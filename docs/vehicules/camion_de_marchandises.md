# Camion de marchandises

Tâche T2223 · fichier modèle `assets/modeles/vehicules/vehicule_camion_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Porteur à ridelles et bâche, surchargé : le camion du commerce avec le Nord. Métier de camionneur (décision 67) et ligne de camions de Koffi au chapitre 5 (décisions 88 et 97). Cible des sabotages de Capitaine.

## Où on le croise à Cotonou
Port, entrepôts d'Akpakpa, Dantokpa côté lagune (déchargement de nuit), sortie nord, parkings de camions de la route du port.

- Présence selon les chapitres : Tous les chapitres ; conduit par le joueur au chapitre 5.
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 8,50 m |
| Largeur | 2,45 m |
| Hauteur | 3,40 m |
| Masse à vide | 7 500 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 8,50 × 2,45 × 3,40 m, origine au sol (ou à la ligne de flottaison), au centre |

Cabine à capot ou avancée (2,20 m de long), plateau de 6,00 × 2,35 m, plancher à 1,20 m ; ridelles en bois de 1,00 m ; chargement bâché jusqu'à 3,40 m (surcharge visuelle : 4,00 m en variante) ; empattement 4,80 m ; roues de 1,00 m, jumelées à l'arrière.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 85 km/h (23,6 m/s) |
| Accélération au démarrage | 5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 3,6 s |
| Freinage | 15 m/s² |
| Marche arrière | 10 km/h au plus |
| Rayon de braquage minimal | 9,0 m |
| Maniabilité | 1 / 5 |

Braquage 60 % de la référence ; il lui faut les deux voies pour un angle droit. Chargé : accélération −35 %, freinage −25 %, 45 km/h au plus dans la rampe des ponts. Marche arrière avec bip.

## Places et chargement
- Places : 3.
- Chargement : 3 en cabine ; 10 000 kg (200 sacs de 50 kg).

## Solidité
- Coefficient de solidité : **0,40** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 9 points de dégâts sur 100 ; à sa vitesse maximale = 19 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,4. Il pousse voitures et motos sans ralentir de plus de 10 %.

## Couleurs
- Cabine bleue `2a86b5`, verte `2f7d32`, rouge `e8112d` ou jaune `f0dc8a`.
- Ridelles en bois peintes de la couleur de la cabine avec filets blancs, bâche sable `e8d3a0` ou bleue.
- Châssis et jantes noirs, boue rouge `b5653a`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_camion_bleu.glb` | Chargé et bâché |
| `vehicule_camion_vide.glb` | Plateau vide, bâche roulée derrière la cabine |
| `vehicule_camion_surcharge.glb` | Chargement débordant à 4,00 m, penché de 3° d'un côté, 2 hommes assis dessus |
| `vehicule_camion_koffi.glb` | Livrée de l'entreprise du joueur, vert et jaune |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Devise en grandes lettres au-dessus du pare-brise et sur la ridelle arrière : « Courage », « Le temps arrange tout », « Loin n'est pas loin » (devises neutres, sans référence religieuse, par respect de la décision 18).
- Ridelles décorées de losanges et de filets peints à la main, bavettes arrière illustrées (étoile, palmier).
- Cales en bois pendues à une chaîne, bidon d'eau et natte sous le plateau (les apprentis dorment dessous).
- Pare-brise bordé de franges et de petits fanions de couleur unie.
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
- `porte_g`, `porte_d`, `ridelle_ar`, `bache`, `chargement`.
- 10 roues en 6 pièces (`roue_avg`, `roue_avd`, 2 jumelages par côté à l'arrière).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_camion_frein_air.ogg`.
- `bruit_bip_recul.ogg` (partagé).
- `bruit_camion_chargement_grince.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> An old heavy two-axle cargo truck heavily loaded for long-distance trade in West Africa: blue cab, long flatbed with tall wooden side boards hand-painted with white lines and diamond shapes, a towering load of sacks covered by a sand-colored tarpaulin tied with ropes, dual rear wheels, mud flaps decorated with a star, wooden wheel chocks hanging on a chain. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 8.50 m long, 2.45 m wide, 3.40 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
