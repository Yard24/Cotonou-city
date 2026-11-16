# Hélicoptère

Tâche T2433 · fichier modèle `assets/modeles/vehicules/vehicule_helicoptere_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Hélicoptère léger de la police et des secours. Non pilotable (décision 56). Proposé pour les étoiles 4 et 5, encore à valider (décision 73) : il suit le joueur avec un projecteur et signale sa position aux patrouilles, sans jamais tirer (décisions 3 et 75). En décor : survols du port, évacuation sanitaire.

## Où on le croise à Cotonou
Aire de pose près de la tour de l'aéroport, toit-terrasse de l'hôpital fictif, ciel au-dessus du port et de la lagune.

- Présence selon les chapitres : Décor dès le chapitre 1 ; poursuite à partir du chapitre 4 si l'usage aux étoiles 4 et 5 est confirmé.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Non (décision 56).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 10,50 m |
| Largeur | 2,00 m |
| Hauteur | 3,30 m |
| Masse à vide | 1 500 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 10,50 × 2,00 × 3,30 m, origine au sol (ou à la ligne de flottaison), au centre |

Fuselage et poutre de queue : 10,5 m (12,6 m rotor tournant) ; largeur aux patins 2,00 m ; rotor principal à 3 pales de 10,7 m de diamètre, à 3,10 m du sol ; rotor de queue de 1,90 m ; cabine vitrée bulle ; train à patins.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 220 km/h (61,1 m/s) |
| Accélération au démarrage | 4 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 4 m/s² |
| Marche arrière | aucune |
| Rayon de braquage minimal | sans objet (pivote sur place) |
| Maniabilité | 5 / 5 |

En poursuite : vol à 60 m de haut, 120 km/h au plus, cercle de 80 m de rayon autour du joueur, projecteur de 12 m de diamètre au sol. Tant que le joueur est dans le faisceau, la recherche ne retombe pas ; on lui échappe sous un pont, un auvent de marché, des arbres ou dans un bâtiment (10 secondes hors de vue).

## Places et chargement
- Places : 6.
- Chargement : Pilote + 5 ; 2 200 kg au décollage.

## Solidité
- Sans objet : hors d'atteinte. Posé, c'est un obstacle fixe (s'en approcher à moins de 15 m rotor tournant fait reculer Koffi).

## Couleurs
- Police : bleu nuit `1e2a33`, ventre et bande blancs `f4f1ea`, mot « POLICE » sous le ventre.
- Secours : blanc avec bande orange `d98c5f` et croix verte simple `008751`, comme l'ambulance.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_helicoptere_police.glb` | Projecteur sous le nez |
| `vehicule_helicoptere_secours.glb` | Porte latérale coulissante ouverte, civière |
| `vehicule_helicoptere_pose.glb` | Rotor arrêté, pales qui pendent de 4°, housses rouges sur les entrées d'air |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Poussière rouge et sable soulevés en anneau sous l'appareil à l'atterrissage (particules, rayon 15 m) ; les parasols du marché tremblent à son passage.
- Immatriculation fictive, écusson inventé.
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
- `fuselage`, `rotor_principal`, `disque_rotor` (affiché à la place des pales en rotation), `rotor_queue`, `disque_queue`, `porte_g`, `porte_d`, `projecteur` (pivot sur 2 axes, cône lumineux), `vitres`.
- Hors tableau du style : compté sur la ligne « voiture, taxi » (8 000 triangles).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_helico_rotor.ogg` : battement des pales (boucle, avec effet de distance et de passage).
- `bruit_helico_turbine.ogg` : sifflement de turbine au sol (boucle).
- `voix_police_helico_01.ogg` à `_03` : haut-parleur, « Arrêtez votre véhicule ! ».

## Consigne de génération 3D (à copier telle quelle)
> A light single-engine utility helicopter with a fictional police livery: rounded glazed bubble cabin, dark navy blue body with a white belly and a white side stripe, three-blade main rotor, slim tail boom with a small tail rotor and vertical fin, skid landing gear, a searchlight under the nose, plain shield emblem with no text. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 10.50 m long, 2.00 m wide, 3.30 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), propellers or rotors, landing gear and doors as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
