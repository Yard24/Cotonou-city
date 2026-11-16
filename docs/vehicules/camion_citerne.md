# Camion-citerne

Tâche T2233 · fichier modèle `assets/modeles/vehicules/vehicule_citerne_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Transport de carburant officiel entre le port et les stations (décision 58). Obstacle dangereux sans explosion (décision 57) : percé, il perd son chargement en flaque glissante. Mission du chapitre 2 opposant le circuit officiel au kpayo.

## Où on le croise à Cotonou
Dépôt pétrolier fictif du port, stations-service, route du port, sortie nord.

- Présence selon les chapitres : Tous les chapitres ; file de citernes à l'arrêt au chapitre 3.
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Oui, dans les missions de camionneur (décision 55, famille « camion »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 9,00 m |
| Largeur | 2,50 m |
| Hauteur | 3,20 m |
| Masse à vide | 9 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 9,00 × 2,50 × 3,20 m, origine au sol (ou à la ligne de flottaison), au centre |

Cabine avancée de 2,20 m ; cuve cylindrique ovale de 6,20 m de long, 2,30 m de large et 1,70 m de haut, posée sur un châssis à 1,30 m ; passerelle et 3 trous d'homme sur le dessus ; échelle arrière ; 3 essieux, roues de 1,00 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 80 km/h (22,2 m/s) |
| Accélération au démarrage | 4,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 4,0 s |
| Freinage | 14 m/s² |
| Marche arrière | 8 km/h au plus |
| Rayon de braquage minimal | 9,5 m |
| Maniabilité | 1 / 5 |

Plein, le liquide pousse : la distance de freinage augmente de 30 % et le camion continue de pencher 1 seconde après la sortie du virage (effet visuel). Vitesse conseillée en virage : 40 km/h.

## Places et chargement
- Places : 2.
- Chargement : 2 en cabine ; 18 000 litres (environ 14 000 kg).

## Solidité
- Coefficient de solidité : **0,40** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 9 points de dégâts sur 100 ; à sa vitesse maximale = 18 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,4. À 50 de dégâts : fuite (flaque sombre de 6 m de long derrière lui, adhérence divisée par 2 pour tous, pendant 60 s). Jamais de feu ni d'explosion.

## Couleurs
- Cuve gris clair `d6d0c4` ou blanche avec une bande de couleur (rouge `e8112d` ou vert `008751`) ; cabine blanche ou rouge.
- Losange de danger orange uni à l'arrière (sans numéro réel).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_citerne_carburant.glb` | Base, bande rouge, compagnie inventée « Pétro-Littoral » |
| `vehicule_citerne_eau.glb` | Cuve bleue `2a86b5`, mot « EAU » : livre les chantiers et les quartiers sans réseau |
| `vehicule_citerne_fuite.glb` | État : traînée sombre au sol |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Seau métallique et entonnoir pendus à l'arrière, extincteur rouge sur le côté de la cabine.
- Inscription « DANGER » et « DÉFENSE DE FUMER » en texture.
- Apprenti sur la passerelle à l'arrêt, jauge en bois à la main.
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
- `porte_g`, `porte_d`, `cuve` (matière à part), `echelle`, `vanne_ar`.
- 10 roues en 6 pièces.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_camion_frein_air.ogg` (partagé).
- `bruit_citerne_ballotte.ogg` : liquide qui cogne dans la cuve au freinage.
- `bruit_citerne_fuite.ogg` : écoulement (boucle).

## Consigne de génération 3D (à copier telle quelle)
> A three-axle fuel tanker truck: white cab-over tractor cab, long light-grey oval cylindrical tank with a red horizontal band, a walkway with three manhole covers on top, a ladder at the rear, valves and a hose box under the tank, a plain orange hazard diamond at the back, a fire extinguisher beside the cab. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 9.00 m long, 2.50 m wide, 3.20 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
