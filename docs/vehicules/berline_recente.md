# Berline récente

Tâche T2103 · fichier modèle `assets/modeles/vehicules/vehicule_berline_recente_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Voiture de la classe moyenne et des cadres. **Voiture de référence du jeu** : la voiture rouge actuelle garée au départ, avec les réglages de `scripts/car.gd` (122 km/h, 16 m/s²). Signe de réussite de Koffi au chapitre 4.

## Où on le croise à Cotonou
Ganhi, Marina, quartiers résidentiels de l'ouest, parkings des hôtels et des banques fictives, aéroport.

- Présence selon les chapitres : Rare au chapitre 1, courante à partir du chapitre 3.
- Part dans la circulation : poids de tirage 6 sur un total de 126,1 (voir `tableau.md`), soit environ 4,8 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,60 m |
| Largeur | 1,80 m |
| Hauteur | 1,45 m |
| Masse à vide | 1 350 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,60 × 1,80 × 1,45 m, origine au sol (ou à la ligne de flottaison), au centre |

Formes arrondies, ligne de toit fuyante ; empattement 2,70 m ; roues de 0,66 m à jantes à bâtons ; garde au sol 0,15 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 122 km/h (33,9 m/s) |
| Accélération au démarrage | 16 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,1 s |
| Freinage | 30 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,4 m |
| Maniabilité | 4 / 5 |

Référence : 48° tournés en 0,5 s à 36 km/h, 45 % de braquage en moins à pleine vitesse.

## Places et chargement
- Places : 5.
- Chargement : 5 personnes, coffre de 450 litres.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 75 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence (mur de face à pleine vitesse : 75 points).

## Couleurs
- Blanc `f4f1ea`, gris argent `d6d0c4`, noir `1e2a33`, rouge `e8112d` (la voiture de départ), bleu `2a86b5`.
- Vitres `3c4b57`, jantes gris clair.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_berline_recente_rouge.glb` | Voiture de départ |
| `vehicule_berline_recente_blanche.glb` | La plus fréquente |
| `vehicule_berline_recente_noire.glb` | Vitres plus sombres |
| `vehicule_berline_recente_vtc.glb` | À partir du chapitre 5 : petit autocollant d'une application fictive sur le pare-brise |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Housses de sièges claires, boîte de mouchoirs sur la plage arrière.
- Film teinté sur les vitres arrière, baguettes chromées.
- Souvent lavée : aucune poussière, contrairement aux autres véhicules.
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
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_recente` (moteur à essence discret), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_recente_demarre.ogg`, `bruit_moteur_voiture_recente_ralenti.ogg` (boucle), `bruit_moteur_voiture_recente_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_recente_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_voiture_bip_verrou.ogg` : double bip de verrouillage.

## Consigne de génération 3D (à copier telle quelle)
> A modern mid-size four-door family sedan from the 2010s: smooth rounded body in clean white paint, sloping roofline, slim swept-back headlights, alloy wheels with five spokes, body-colored bumpers, chrome window trim, tinted rear windows. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.60 m long, 1.80 m wide, 1.45 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
