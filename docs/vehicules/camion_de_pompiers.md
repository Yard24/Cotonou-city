# Camion de pompiers

Tâche T2303 · fichier modèle `assets/modeles/vehicules/vehicule_pompiers_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Fourgon-pompe rouge. Il intervient sur les fumées de marché et les rues inondées (pompage après les grosses pluies, décision 90). Scène écrite du chapitre 5 : incendie d'entrepôt allumé par Capitaine, vu à distance, sans victime.

## Où on le croise à Cotonou
Caserne fictive près de Ganhi, Dantokpa (accès par les grandes allées seulement), port, rues inondées.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 0,3 sur un total de 126,1 (voir `tableau.md`), soit environ 0,2 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA et de scènes écrites.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 7,80 m |
| Largeur | 2,50 m |
| Hauteur | 3,20 m |
| Masse à vide | 12 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 7,80 × 2,50 × 3,20 m, origine au sol (ou à la ligne de flottaison), au centre |

Double cabine 6 places ; caisse à rideaux métalliques (3 par côté, 1,20 × 1,10 m) ; échelle coulissante de 4,50 m couchée sur le toit ; dévidoir à l'arrière ; cuve de 3 000 litres ; 2 essieux, roues de 1,00 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 90 km/h (25,0 m/s) |
| Accélération au démarrage | 5,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 3,3 s |
| Freinage | 16 m/s² |
| Marche arrière | 10 km/h au plus |
| Rayon de braquage minimal | 8,8 m |
| Maniabilité | 1 / 5 |

En urgence, la circulation se range comme pour l'ambulance. Il ne peut pas entrer dans les vons : les pompiers déroulent 40 m de tuyau à pied.

## Places et chargement
- Places : 6.
- Chargement : 6 pompiers ; 3 000 litres d'eau.

## Solidité
- Coefficient de solidité : **0,35** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 8 points de dégâts sur 100 ; à sa vitesse maximale = 18 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,35. Le gêner plus de 5 secondes en urgence donne 1 étoile.

## Couleurs
- Rouge `e8112d`, pare-chocs et bas de caisse blancs `f4f1ea`, bande réfléchissante jaune `fcd116`.
- Rideaux métalliques gris clair `d6d0c4`, échelle grise.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_pompiers_pompe.glb` | Base |
| `vehicule_pompiers_pompage.glb` | À l'arrêt, deux tuyaux déroulés vers une rue inondée, motopompe posée au sol |
| `vehicule_pompiers_ancien.glb` | Chapitres 1 à 3 : cabine simple à capot, rouge terni |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Mot « SAPEURS-POMPIERS » en texture, numéro d'urgence inventé à 3 chiffres.
- Pompiers en tenue bleu foncé et casque clair, assis en cabine arrière.
- Seaux et pelles accrochés à l'arrière, tuyaux enroulés visibles.
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
- `porte_avg`, `porte_avd`, `porte_arg`, `porte_ard`, 6 `rideau_*` (coulissent vers le haut), `echelle`, `devidoir`, `rampe`, `lance` (émet des particules d'eau).
- 6 roues en 4 pièces.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sirene_pompiers.ogg` : deux tons graves et lents (boucle).
- `bruit_pompe_eau.ogg` : pompe et jet (boucle).
- `bruit_camion_frein_air.ogg` (partagé).

## Consigne de génération 3D (à copier telle quelle)
> A red fire engine pumper truck: six-seat crew cab, bright red body with a white lower section and a yellow reflective stripe, three light-grey roll-up shutters on each side, an extension ladder lying on the roof, a hose reel at the rear, blue light bar on the cab roof, no real emblem. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 7.80 m long, 2.50 m wide, 3.20 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
