# Petite citadine

Tâche T2113 · fichier modèle `assets/modeles/vehicules/vehicule_citadine_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Petite voiture courte à hayon, économique. Voiture des jeunes salariés, de Rachidath (décision 37) et des auto-écoles fictives. Idéale pour les vons étroites et les livraisons légères.

## Où on le croise à Cotonou
Ganhi, quartiers résidentiels, université, parkings de supermarchés fictifs.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 4 sur un total de 126,1 (voir `tableau.md`), soit environ 3,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 3,60 m |
| Largeur | 1,60 m |
| Hauteur | 1,48 m |
| Masse à vide | 900 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 3,60 × 1,60 × 1,48 m, origine au sol (ou à la ligne de flottaison), au centre |

Deux volumes, 5 portes ; empattement 2,35 m ; petites roues de 0,56 m ; garde au sol 0,15 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 104 km/h (28,9 m/s) |
| Accélération au démarrage | 14 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,3 s |
| Freinage | 30 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 4,6 m |
| Maniabilité | 5 / 5 |

Braquage 115 % de la référence : demi-tour en une fois dans une rue de 7 m... à condition de mordre sur le trottoir d'en face. Légère, elle est poussée par tout ce qui pèse plus lourd.

## Places et chargement
- Places : 4.
- Chargement : 4 personnes, coffre de 200 litres (3 colis).

## Solidité
- Coefficient de solidité : **1,20** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 28 points de dégâts sur 100 ; à sa vitesse maximale = 74 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 1,2.

## Couleurs
- Couleurs franches : rouge `e8112d`, jaune pâle `f0dc8a`, bleu clair `9fc3d9`, vert `3f9a3c`, blanc.
- Pare-chocs noirs non peints sur la version de base.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_citadine_rouge.glb` | Base |
| `vehicule_citadine_rachidath.glb` | Bleu clair, carnets et appareil photo sur le siège passager |
| `vehicule_citadine_auto_ecole.glb` | Panneau de toit triangulaire blanc, double rétroviseur |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Désodorisant en forme de sapin au rétroviseur, coussin sur le siège conducteur.
- Baguette de protection de portière en caoutchouc noir, souvent décollée d'un côté.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 7 000 |
| Niveau 1 (environ 50 %) | 3 500 |
| Niveau 2, vu de loin (environ 15 %) | 1 050 |

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
- Hayon à la place du coffre : `hayon`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_recente` (moteur à essence discret), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_recente_demarre.ogg`, `bruit_moteur_voiture_recente_ralenti.ogg` (boucle), `bruit_moteur_voiture_recente_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_recente_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A tiny five-door city hatchback: short tall body in bright red, large windows, very short hood, unpainted black plastic bumpers, small 14-inch steel wheels with simple hubcaps, upright rear hatch with a small roof spoiler. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 3.60 m long, 1.60 m wide, 1.48 m high. About 7000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
