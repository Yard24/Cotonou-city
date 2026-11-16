# Minibus tokpa-tokpa

Tâche T2173 · fichier modèle `assets/modeles/vehicules/vehicule_minibus_tokpa_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Minibus de transport en commun urbain qui relie Dantokpa (d'où son nom) aux quartiers et aux communes voisines. Métier jouable de chauffeur de minibus (décision 67) : ligne à arrêts, on remplit et on vide, l'apprenti encaisse.

## Où on le croise à Cotonou
Gare de Dantokpa, Étoile Rouge, les trois ponts, grandes avenues vers l'ouest et le nord. S'arrête n'importe où pour charger : source d'embouteillages (décision 60).

- Présence selon les chapitres : Tous les chapitres ; métier ouvert au chapitre 3.
- Part dans la circulation : poids de tirage 4 sur un total de 126,1 (voir `tableau.md`), soit environ 3,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,70 m |
| Largeur | 1,70 m |
| Hauteur | 1,95 m |
| Masse à vide | 1 700 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,70 × 1,70 × 1,95 m, origine au sol (ou à la ligne de flottaison), au centre |

Fourgon à cabine avancée ; empattement 2,55 m ; roues de 0,66 m ; porte latérale coulissante à droite (1,00 × 1,25 m), hayon ; 4 rangées de bancs ; avec galerie chargée : 2,45 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 95 km/h (26,4 m/s) |
| Accélération au démarrage | 9 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 2,0 s |
| Freinage | 22 m/s² |
| Marche arrière | 25 km/h au plus |
| Rayon de braquage minimal | 5,8 m |
| Maniabilité | 3 / 5 |

Braquage 85 % de la référence. Plein : accélération −25 %, freinage −15 %, roulis visuel 7°. Chaque arrêt brusque fait râler les passagers (jauge de satisfaction du métier).

## Places et chargement
- Places : 15 (chauffeur + 14).
- Chargement : Chauffeur + 14 passagers (jusqu'à 18 serrés dans la circulation) ; 200 kg sur la galerie.

## Solidité
- Coefficient de solidité : **0,90** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 21 points de dégâts sur 100 ; à sa vitesse maximale = 50 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,9.

## Couleurs
- Blanc cassé `f4f1ea` ou jaune pâle `f0dc8a`, bas de caisse d'une couleur vive (bleu `2a86b5` ou vert `008751`).
- Rouille `b5653a` autour des passages de roue, pare-chocs peints à la main en rouge et blanc.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_minibus_tokpa_blanc.glb` | Base |
| `vehicule_minibus_tokpa_plein.glb` | Porte coulissante ouverte, apprenti debout sur le marchepied, bras tendu |
| `vehicule_minibus_tokpa_galerie.glb` | Sacs, bassines et un vélo sur le toit |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Apprenti (rabatteur) accroché à la porte, qui crie la destination et tape deux coups sur la tôle pour repartir.
- Devises peintes en grand sur le pare-brise et le hayon : « La patience paie », « Courage », « Ça va aller ».
- Porte coulissante retenue par un sandow, vitres latérales coulissantes ouvertes, bancs en tube et skaï.
- Destination écrite sur un carton derrière le pare-brise : « DANTOKPA », « ÉTOILE ROUGE ».
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Bus, camion » de `docs/style_graphique.md` : 10 000 triangles au plus en détail fin, 1 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 9 000 |
| Niveau 1 (environ 50 %) | 4 500 |
| Niveau 2, vu de loin (environ 15 %) | 1 350 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cabine, caisse et châssis soudés.
- Roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (sauf indication contraire plus bas) ; les roues avant pivotent.
- Portes de cabine : `porte_avg`, `porte_avd` (sauf indication contraire plus bas).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d`, `parechoc_av`, `parechoc_ar` : comme sur les voitures.
- Intérieur de cabine simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés, 800 triangles au plus.
- `porte_coulissante` (glisse de 1,0 m vers l'arrière), `hayon`, `galerie`, `chargement_toit`.
- `apprenti` séparé (passant).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `voix_apprenti_destination_01.ogg` à `_06` : « Tokpa ! Tokpa ! Tokpa ! », « Étoile, deux places ! ».
- `bruit_minibus_tape_tole.ogg` : deux coups sur la carrosserie.
- `bruit_porte_coulissante.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> An old cab-over passenger minibus van used as shared public transport in West Africa: boxy off-white body with a bright blue lower band, sliding side door on the right, rows of small sliding side windows, rust around the wheel arches, red and white hand-painted bumpers, a steel roof rack loaded with sacks and plastic basins. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.70 m long, 1.70 m wide, 1.95 m high. About 9000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
