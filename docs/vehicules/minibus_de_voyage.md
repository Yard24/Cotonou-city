# Minibus de voyage

Tâche T2183 · fichier modèle `assets/modeles/vehicules/vehicule_minibus_voyage_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Minibus plus grand et plus récent pour les trajets entre villes (Porto-Novo, Ouidah, Abomey, décision 87). Marque les départs et arrivées aux gares routières ; véhicule d'une mission d'escorte au chapitre 5.

## Où on le croise à Cotonou
Gares routières (Étoile Rouge, sortie nord, sortie ouest), stations-service, route du Nord.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 1,5 sur un total de 126,1 (voir `tableau.md`), soit environ 1,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « minibus »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,40 m |
| Largeur | 1,90 m |
| Hauteur | 2,30 m |
| Masse à vide | 2 300 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,40 × 1,90 × 2,30 m, origine au sol (ou à la ligne de flottaison), au centre |

Toit surélevé ; empattement 3,10 m ; roues de 0,70 m ; porte latérale battante à l'avant droit ; grande galerie sur toute la longueur (bagages : hauteur totale 2,80 m) avec échelle arrière.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 105 km/h (29,2 m/s) |
| Accélération au démarrage | 8,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 2,1 s |
| Freinage | 22 m/s² |
| Marche arrière | 25 km/h au plus |
| Rayon de braquage minimal | 6,6 m |
| Maniabilité | 2 / 5 |

Braquage 75 % de la référence. Chargement haut : au-delà de 70 km/h en virage serré, il ralentit de lui-même (pas de tonneau).

## Places et chargement
- Places : 18 (chauffeur + 17).
- Chargement : Chauffeur + 17 passagers ; 400 kg de bagages sur le toit.

## Solidité
- Coefficient de solidité : **0,85** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 20 points de dégâts sur 100 ; à sa vitesse maximale = 53 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,85.

## Couleurs
- Blanc `f4f1ea` avec deux bandes obliques de couleur (vert `008751` et jaune `fcd116`, ou bleu et rouge).
- Bâche de galerie bleue `2a86b5` ou verte, filet de corde.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_minibus_voyage_blanc.glb` | Base, galerie bâchée |
| `vehicule_minibus_voyage_vide.glb` | Galerie vide, en attente à la gare |
| `vehicule_minibus_voyage_nuit.glb` | Guirlande de petites lampes de couleur autour du pare-brise |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Nom de la ligne peint sur les flancs en texture : « COTONOU – PARAKOU », « COTONOU – ABOMEY ».
- Bagages très hauts sous bâche : valises, sacs de charbon, cartons, un matelas.
- Devise sur le hayon : « Bonne route ».
- Rideaux aux vitres, klaxon à plusieurs tons au départ.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Bus, camion » de `docs/style_graphique.md` : 10 000 triangles au plus en détail fin, 1 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 9 500 |
| Niveau 1 (environ 50 %) | 4 750 |
| Niveau 2, vu de loin (environ 15 %) | 1 420 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cabine, caisse et châssis soudés.
- Roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (sauf indication contraire plus bas) ; les roues avant pivotent.
- Portes de cabine : `porte_avg`, `porte_avd` (sauf indication contraire plus bas).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d`, `parechoc_av`, `parechoc_ar` : comme sur les voitures.
- Intérieur de cabine simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés, 800 triangles au plus.
- `porte_passagers`, `hayon`, `galerie`, `chargement_toit`, `echelle`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_klaxon_minibus_depart.ogg` : klaxon mélodique à 3 notes, joué une fois au départ de la gare.

## Consigne de génération 3D (à copier telle quelle)
> A high-roof long-distance passenger minibus: white body with two diagonal green and yellow stripes, 18 seats, curtains at the side windows, a full-length steel roof rack piled high with luggage under a blue tarpaulin and rope net, a ladder at the rear, dual rear wheels. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.40 m long, 1.90 m wide, 2.30 m high. About 9500 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
