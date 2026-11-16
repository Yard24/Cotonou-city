# Ambulance

Tâche T2293 · fichier modèle `assets/modeles/vehicules/vehicule_ambulance_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Fourgon de secours. Elle vient chercher Koffi quand sa santé tombe à zéro (décision 80 : réveil au centre de santé) et passe en urgence dans la circulation, qui se range. Très présente au chapitre 3.

## Où on le croise à Cotonou
Centre de santé et hôpital fictifs, grands axes ; garée devant les urgences.

- Présence selon les chapitres : Tous les chapitres ; 3 fois plus de passages au chapitre 3.
- Part dans la circulation : poids de tirage 0,5 sur un total de 126,1 (voir `tableau.md`), soit environ 0,4 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA (choix d'agent : aucune mission ne doit pousser à gêner les secours).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,40 m |
| Largeur | 1,95 m |
| Hauteur | 2,50 m |
| Masse à vide | 2 400 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,40 × 1,95 × 2,50 m, origine au sol (ou à la ligne de flottaison), au centre |

Fourgon à toit haut (2,30 m) plus rampe lumineuse ; empattement 3,20 m ; roues de 0,70 m ; deux portes arrière battantes (1,50 × 1,70 m), porte latérale coulissante à droite ; cellule : brancard de 1,95 × 0,55 m et un siège.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 120 km/h (33,3 m/s) |
| Accélération au démarrage | 11 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,6 s |
| Freinage | 26 m/s² |
| Marche arrière | 25 km/h au plus |
| Rayon de braquage minimal | 6,3 m |
| Maniabilité | 3 / 5 |

En urgence : 70 km/h en ville, les véhicules de l'IA se rangent à droite à 40 m devant elle. Gêner son passage plus de 5 secondes donne 1 étoile.

## Places et chargement
- Places : 4 (2 + patient + soignant).
- Chargement : Chauffeur + 1 à l'avant ; 1 patient couché + 1 soignant à l'arrière.

## Solidité
- Coefficient de solidité : **0,85** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 20 points de dégâts sur 100 ; à sa vitesse maximale = 62 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,85. La percuter volontairement donne 1 étoile.

## Couleurs
- Blanc `f4f1ea` avec bande orange `d98c5f` bordée de jaune `fcd116` sur les flancs.
- Croix simple verte `008751` à quatre branches égales (emblème inventé : ni croix rouge ni croissant, qui sont des emblèmes protégés).
- Rampe bleue `2a86b5`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_ambulance_blanche.glb` | Base |
| `vehicule_ambulance_ancienne.glb` | Chapitres 1 et 2 : fourgon plus bas (2,10 m), un seul gyrophare, peinture ternie |
| `vehicule_ambulance_urgence.glb` | État : rampe allumée, portes arrière ouvertes à l'arrêt |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Mot « AMBULANCE » en texture, écrit aussi à l'envers sur le capot.
- Numéro d'urgence inventé à 3 chiffres sur les flancs.
- Vitres arrière dépolies (aplat clair `c4d4c8`).
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
- `porte_avg`, `porte_avd`, `porte_coulissante`, `porte_ar_g`, `porte_ar_d`, `rampe` (émissive), `brancard` (sort par l'arrière).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sirene_ambulance.ogg` : sirène montante-descendante lente (boucle), bien distincte de celle de la police.
- `bruit_brancard_roule.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A high-roof van ambulance with a fictional livery: white body with an orange side band edged in yellow, a plain green equal-armed cross on the sides and rear doors (not a red cross), a blue light bar on the roof, frosted rear windows, two rear barn doors and a sliding side door. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.40 m long, 1.95 m wide, 2.50 m high. About 9000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
