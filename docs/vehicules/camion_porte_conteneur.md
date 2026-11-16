# Camion porte-conteneur

Tâche T2243 · fichier modèle `assets/modeles/vehicules/vehicule_porte_conteneur_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Tracteur et semi-remorque portant un conteneur de 12 m : le trafic du port, au cœur de l'histoire (décisions 13 et 36). Missions de filature d'un conteneur, de pesée et de contrôle douanier ; conduit par Koffi sur la route du Nord.

## Où on le croise à Cotonou
Port (files d'attente à l'entrée), route du port, boulevard de la Marina de nuit, sortie nord, parkings de transit.

- Présence selon les chapitres : Tous les chapitres ; files très longues au chapitre 4 ; conduit par le joueur au chapitre 5.
- Part dans la circulation : poids de tirage 1,5 sur un total de 126,1 (voir `tableau.md`), soit environ 1,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui, dans les missions de camionneur (décision 55, famille « camion »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 15,50 m |
| Largeur | 2,50 m |
| Hauteur | 4,00 m |
| Masse à vide | 14 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 15,50 × 2,50 × 4,00 m, origine au sol (ou à la ligne de flottaison), au centre |

Tracteur de 6,00 × 2,50 × 3,00 m (2 essieux) ; semi-remorque squelette de 12,40 m (3 essieux) ; conteneur de 12,2 × 2,44 × 2,60 m posé à 1,40 m ; point d'articulation à 4,60 m de l'avant ; roues de 1,00 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 78 km/h (21,7 m/s) |
| Accélération au démarrage | 3,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 5,2 s |
| Freinage | 13 m/s² |
| Marche arrière | 6 km/h au plus |
| Rayon de braquage minimal | 12,5 m |
| Maniabilité | 1 / 5 |

Seul véhicule articulé : la remorque suit le tracteur avec un angle de 70° au plus. Pour le code, deux corps reliés par un pivot ; en version simplifiée, un seul corps rigide de 15,5 m interdit de rues de quartier. Marche arrière réservée aux missions (assistance : la remorque reste alignée).

## Places et chargement
- Places : 2.
- Chargement : 2 en cabine ; conteneur chargé jusqu'à 26 000 kg.

## Solidité
- Coefficient de solidité : **0,35** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 8 points de dégâts sur 100 ; à sa vitesse maximale = 15 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,35. Le conteneur ne s'abîme pas ; il peut glisser de la remorque dans une scène écrite, jamais en jeu libre.

## Couleurs
- Tracteur blanc `f4f1ea`, rouge `e8112d` ou bleu `2a86b5`.
- Conteneur d'une seule couleur : terre cuite `d98c5f`, bleu `2a86b5`, vert `2f7d32`, gris `d6d0c4`, jaune `f0dc8a`.
- Remorque noire `3a3a3d`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_porte_conteneur_12m.glb` | Base, un conteneur de 12 m |
| `vehicule_porte_conteneur_2x6m.glb` | Deux conteneurs de 6 m de couleurs différentes |
| `vehicule_porte_conteneur_vide.glb` | Remorque squelette vide |
| `vehicule_porte_conteneur_fortune.glb` | Conteneur gris marqué du sigle inventé de la société de transit de Monsieur Fortuné |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Conteneurs marqués de sigles inventés de 4 lettres et de 7 chiffres (texture), aucun armateur réel.
- Plombs et scellés jaunes sur les portes, rouille aux angles.
- Apprenti qui marche à côté pour guider les manœuvres à l'entrée du port.
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
- `tracteur` et `semi_remorque` : deux objets séparés (6 500 et 2 300 triangles), pivot à la sellette.
- `conteneur` séparé (1 200 triangles, réutilisé comme objet de décor du port), `porte_conteneur_g`, `porte_conteneur_d`.
- 22 roues en 10 pièces.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_camion_frein_air.ogg` (partagé).
- `bruit_remorque_claque.ogg` : conteneur qui cogne sur ses verrous dans les bosses.

## Consigne de génération 3D (à copier telle quelle)
> A semi-trailer truck carrying a 40-foot shipping container: white two-axle cab-over tractor unit, black skeletal three-axle container trailer, one corrugated terracotta-colored container with locking bars and yellow seals on its rear doors, some rust at the corners, no company name. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 15.50 m long, 2.50 m wide, 4.00 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
