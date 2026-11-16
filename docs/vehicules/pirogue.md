# Pirogue

Tâche T2373 · fichier modèle `assets/modeles/vehicules/vehicule_pirogue_<variante>.glb` · ligne de budget « Pirogue, petit bateau ».

## Rôle dans le jeu
Pirogue en bois à perche ou à pagaie : le moyen de transport de la lagune et du village lacustre, visitable à partir du chapitre 2 (décision 86). Koffi y est passager (un piroguier le conduit) ; il peut aussi la manier lui-même sur de courtes distances.

## Où on le croise à Cotonou
Berges de la lagune sous les ponts, embarcadère de Dantokpa, village lacustre (c'est la « rue » : marché flottant, enfants qui vont à l'école en pirogue, sur l'eau seulement en décor).

- Présence selon les chapitres : Décor dès le chapitre 1 ; utilisable à partir du chapitre 2.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Oui, lentement (rattachée à la « pirogue » de la décision 55 ; la version à moteur est la barque à moteur).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 7,00 m |
| Largeur | 1,00 m |
| Hauteur | 0,60 m |
| Masse à vide | 150 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 7,00 × 1,00 × 0,60 m, origine au sol (ou à la ligne de flottaison), au centre |

Coque étroite à fond plat, extrémités relevées et pointues ; franc-bord 0,30 m (0,15 m chargée) ; tirant d'eau 0,20 m ; 3 bancs ; perche de 4,00 m, pagaie de 1,60 m à pale en forme de feuille.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 7 km/h (1,9 m/s) |
| Accélération au démarrage | 1 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 1,5 m/s² |
| Marche arrière | 3 km/h au plus |
| Rayon de braquage minimal | 4,0 m |
| Maniabilité | 4 / 5 |

Sur l'eau, pas de frein : elle glisse (arrêt en 5 m). Pivote presque sur place à la perche. À la perche, elle ne quitte pas les fonds de moins de 2 m. Les vagues d'une vedette la font tanguer et ralentir, sans chavirer.

## Places et chargement
- Places : 6 (piroguier + 5).
- Chargement : 1 piroguier + 5 passagers, ou 400 kg de marchandises.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 0,0 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence appliqué aux chocs sur l'eau. À 80 de dégâts elle prend l'eau : vitesse 3 km/h, il faut écoper (touche d'action) ; elle ne coule pas. Koffi sait nager (décision 82).

## Couleurs
- Bois sombre `8b5a2b`, intérieur plus clair `a3957f`.
- Liseré peint en haut de la coque : bleu `2a86b5`, blanc, rouge `e8112d` ou vert `008751`, parfois en triangles alternés.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_pirogue_vide.glb` | Base |
| `vehicule_pirogue_marche.glb` | Vendeuse assise à l'arrière, bassines de tomates, de poisson fumé et de pain |
| `vehicule_pirogue_peche.glb` | Filet épervier en tas, nasse en osier, 2 pêcheurs |
| `vehicule_pirogue_taxi.glb` | 5 passagers, parapluies ouverts contre le soleil |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Écope taillée dans une calebasse ou un bidon découpé.
- Piroguier debout à l'arrière, chapeau de paille à large bord.
- Voile carrée faite de sacs cousus, sur une perche (variante par vent d'harmattan).
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
- Pas de roues. `coque` (une matière), `perche`, `pagaie`, `chargement`, `piroguier` (passant séparé).
- Ligne de flottaison à la hauteur 0 de l'objet ; origine au centre, sur l'eau.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_pirogue_perche.ogg` : perche qui plonge et pousse (cycle de 3 s).
- `bruit_pirogue_pagaie.ogg`.
- `bruit_eau_coque.ogg` : clapotis contre la coque (boucle).
- `bruit_pirogue_choc_bois.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A long narrow traditional West African dugout-style wooden canoe (pirogue): flat-bottomed dark brown plank hull, pointed upswept bow and stern, three simple plank seats, a thin painted blue and white stripe along the top edge, a long wooden pole and a leaf-shaped paddle lying inside, a bailing scoop made from a cut plastic jerrycan. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 7.00 m long, 1.00 m wide, 0.60 m high. About 3000 triangles, clean closed topology, at most three materials (body paint, glass, details), hull, engine and cargo as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
