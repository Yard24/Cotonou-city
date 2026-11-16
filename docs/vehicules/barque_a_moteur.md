# Barque à moteur

Tâche T2383 · fichier modèle `assets/modeles/vehicules/vehicule_barque_moteur_<variante>.glb` · ligne de budget « Pirogue, petit bateau ».

## Rôle dans le jeu
Grande pirogue à moteur hors-bord : la « pirogue à moteur » pilotable de la décision 55. Bateau-taxi vers le village lacustre, transport du kpayo par la lagune la nuit (décision 5), poursuites sur l'eau aux chapitres 2 et 4.

## Où on le croise à Cotonou
Embarcadères de la lagune (Dantokpa, pieds des ponts), village lacustre, chenal vers la mer.

- Présence selon les chapitres : À partir du chapitre 2.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 8,50 m |
| Largeur | 1,40 m |
| Hauteur | 0,90 m |
| Masse à vide | 350 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 8,50 × 1,40 × 0,90 m, origine au sol (ou à la ligne de flottaison), au centre |

Coque en planches à fond plat, étrave relevée ; franc-bord 0,45 m ; tirant d'eau 0,30 m ; tableau arrière renforcé portant un moteur hors-bord (0,45 × 0,35 × 1,20 m, dont 0,55 m au-dessus du bord) ; 4 bancs ; variante à toit en tôle sur 4 poteaux : hauteur 2,00 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 32 km/h (8,9 m/s) |
| Accélération au démarrage | 3 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 3 m/s² |
| Marche arrière | 6 km/h au plus |
| Rayon de braquage minimal | 8,0 m |
| Maniabilité | 3 / 5 |

Glisse en virage : elle dérape de l'arrière et met 2 secondes à reprendre son cap. Elle se déjauge à partir de 20 km/h (l'avant se lève de 6°). Ralentit de moitié dans les jacinthes d'eau et les filets (zones vertes à contourner). Passe sous les ponts.

## Places et chargement
- Places : 9 (pilote + 8).
- Chargement : Pilote + 8 passagers, ou 800 kg.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 10,1 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence. Voie d'eau à 80 de dégâts, comme la pirogue ; le moteur cale 3 secondes après un gros choc. Kpayo de mauvaise qualité : ratés du moteur (décision 58).

## Couleurs
- Coque peinte : bleu `2a86b5` ou vert `2f7d32` dehors, blanc cassé `f4f1ea` dedans ; liseré rouge `e8112d` ou jaune `fcd116`.
- Moteur au capot gris `d6d0c4` ou noir, sans marque.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_barque_moteur_bleue.glb` | Base |
| `vehicule_barque_moteur_taxi.glb` | Toit en tôle sur 4 poteaux, 8 passagers, gilets orange accrochés au toit |
| `vehicule_barque_moteur_kpayo.glb` | 20 bidons jaunes et 4 fûts bleus sous une bâche noire, sans feux la nuit |
| `vehicule_barque_moteur_koffi.glb` | Achetée au chapitre 4 : vert et jaune de l'entreprise |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Nom du bateau peint à la main sur l'étrave en texture : « La Paix », « Espoir », « Bonne Chance ».
- Petit drapeau uni au bout d'une tige à l'avant, pneus usés accrochés sur les flancs en guise de défenses.
- Réservoir rouge posé au fond, relié au moteur par un tuyau.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Pirogue, petit bateau » de `docs/style_graphique.md` : 3 000 triangles au plus en détail fin, 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 3 000 |
| Niveau 1 (environ 50 %) | 1 500 |
| Niveau 2, vu de loin (environ 15 %) | 450 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `coque`, `moteur` (pivote de ± 35° pour diriger, se relève de 60°), `helice`, `toit`, `chargement`, `pilote`.
- Ligne de flottaison à la hauteur 0.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `hors_bord` (petit hors-bord deux-temps nasillard), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_hors_bord_demarre.ogg`, `bruit_moteur_hors_bord_ralenti.ogg` (boucle), `bruit_moteur_hors_bord_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_hors_bord_coupe.ogg`.
- `bruit_bateau_choc_bois.ogg` : choc de coque ; `bruit_moteur_cale.ogg` : moteur qui cale.
- `bruit_eau_sillage.ogg` : sillage et coups de coque sur le clapot (boucle, volume selon la vitesse).
- `bruit_eau_coque.ogg` (partagé).

## Consigne de génération 3D (à copier telle quelle)
> A long open wooden motor boat used as a lagoon water taxi in West Africa: flat-bottomed plank hull painted blue outside and off-white inside with a red trim line, raised pointed bow, four plank benches, a small grey outboard motor on a reinforced transom, a red fuel tank on the floor, old tires hung along the sides as fenders, a corrugated metal roof on four wooden posts. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 8.50 m long, 1.40 m wide, 0.90 m high. About 3000 triangles, clean closed topology, at most three materials (body paint, glass, details), hull, engine and cargo as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
