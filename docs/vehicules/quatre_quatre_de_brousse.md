# 4x4 de brousse

Tâche T2143 · fichier modèle `assets/modeles/vehicules/vehicule_4x4_brousse_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Tout-terrain utilitaire, carré et increvable. Véhicule d'accompagnement sur la route du Nord (chapitre 5, décision 88), des douaniers en tournée et des missions sur pistes et rues inondées.

## Où on le croise à Cotonou
Douane et port, services techniques, sortie nord de la ville, pistes de la lagune ; couvert de poussière rouge.

- Présence selon les chapitres : Présent dès le chapitre 1 (administration) ; conduit par le joueur au chapitre 5.
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « voiture »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,85 m |
| Largeur | 1,90 m |
| Hauteur | 1,95 m |
| Masse à vide | 2 200 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,85 × 1,90 × 1,95 m, origine au sol (ou à la ligne de flottaison), au centre |

Caisse cubique, capot plat, pare-brise presque vertical ; empattement 2,85 m ; roues de 0,82 m à gros crampons ; garde au sol 0,26 m ; galerie : hauteur totale 2,15 m ; prise d'air surélevée le long du montant droit.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 115 km/h (31,9 m/s) |
| Accélération au démarrage | 12 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,5 s |
| Freinage | 26 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 6,4 m |
| Maniabilité | 2 / 5 |

Aucune perte de vitesse sur sable, latérite, boue ; gué de 0,70 m. Sur bitume : lourd, large rayon de braquage, 80 % du braquage de la référence.

## Places et chargement
- Places : 5 (8 avec banquettes latérales).
- Chargement : 2 à l'avant + 2 banquettes latérales (8 en tout dans la circulation) ; 800 kg.

## Solidité
- Coefficient de solidité : **0,65** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 15 points de dégâts sur 100 ; à sa vitesse maximale = 45 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,65. Pare-buffle : les chocs avant sous 30 km/h ne comptent pas.

## Couleurs
- Blanc `f4f1ea` (le plus courant), beige sable `e8d3a0`, vert foncé `2f7d32`.
- Poussière de latérite `b5653a` en aplat sur les bas de caisse et l'arrière.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_4x4_brousse_blanc.glb` | Base |
| `vehicule_4x4_brousse_douane.glb` | Vert foncé, bande blanche, mot « DOUANE » en texture, gyrophare orange |
| `vehicule_4x4_brousse_expedition.glb` | Galerie avec 2 roues de secours, 4 jerricans, pelle et plaques de désensablage |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Pare-buffle en tube, treuil, deux longues antennes fouets.
- Jerricans métalliques sur la galerie, échelle arrière.
- Portes arrière à deux battants avec roue de secours.
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
- `porte_ar_g`, `porte_ar_d` (deux battants), `galerie`, `roue_secours`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_4x4_gue.ogg` : traversée d'eau (boucle).

## Consigne de génération 3D (à copier telle quelle)
> A rugged boxy off-road utility 4x4: square white body with a flat hood and near-vertical windshield, raised snorkel air intake along the right pillar, tubular bull bar with a winch, steel roof rack carrying metal jerrycans and a spare wheel, tall knobby tires, rear barn doors with a spare wheel, red dust on the lower body. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.85 m long, 1.90 m wide, 1.95 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
