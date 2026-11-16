# Bus de ville

Tâche T2193 · fichier modèle `assets/modeles/vehicules/vehicule_bus_ville_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Grand bus urbain d'une régie fictive, signe de la modernisation de la ville. Obstacle large et lent sur les boulevards ; mission du chapitre 4 où Koffi doit le dépasser pour livrer à temps.

## Où on le croise à Cotonou
Boulevards seulement : Marina, grande avenue est-ouest, ponts, Étoile Rouge. Arrêts avec abri (une dizaine sur la carte).

- Présence selon les chapitres : Absent aux chapitres 1 à 3 ; 2 lignes au chapitre 4, 4 lignes aux chapitres 5 et 6.
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Non (hors décision 55) : IA seulement.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 11,00 m |
| Largeur | 2,50 m |
| Hauteur | 3,10 m |
| Masse à vide | 11 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 11,00 × 2,50 × 3,10 m, origine au sol (ou à la ligne de flottaison), au centre |

Plancher bas ; empattement 5,80 m ; roues de 0,96 m (jumelées à l'arrière) ; 2 portes doubles à droite (1,25 × 2,00 m) ; porte-à-faux avant 2,70 m : il déborde sur la voie voisine en tournant.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 75 km/h (20,8 m/s) |
| Accélération au démarrage | 5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 3,6 s |
| Freinage | 16 m/s² |
| Marche arrière | 10 km/h au plus |
| Rayon de braquage minimal | 10,5 m |
| Maniabilité | 1 / 5 |

Ne circule que sur les voies de 3,5 m. Il occupe deux voies dans les virages à angle droit. S'arrête 8 secondes à chaque arrêt, clignotant droit allumé.

## Places et chargement
- Places : 31 assis (chauffeur + 30), 40 debout.
- Chargement : Chauffeur + 30 assis + 40 debout.

## Solidité
- Coefficient de solidité : **0,40** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 9 points de dégâts sur 100 ; à sa vitesse maximale = 16 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,4. Une voiture qui le percute ne le déplace pas.

## Couleurs
- Livrée fictive : vert `008751` en bas, blanc `f4f1ea` en haut, liseré jaune `fcd116` (3 couleurs vives au plus, règle du style).
- Vitres `3c4b57` sur toute la longueur.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_bus_ville_ligne_1.glb` | Girouette « 1 MARINA » |
| `vehicule_bus_ville_ligne_2.glb` | Girouette « 2 AKPAKPA » |
| `vehicule_bus_ville_pub.glb` | Flanc gauche couvert d'une fausse publicité (marque inventée, texture 512 px) |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Girouette lumineuse à l'avant avec numéro et terminus (noms de lieux réels, décision 24).
- Passagers debout visibles aux heures de pointe (silhouettes simples, 8 au plus).
- Nom de régie inventé : « Bus Littoral ».
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
- `porte_av_1`, `porte_av_2`, `porte_ar_1`, `porte_ar_2` (vantaux qui pivotent), `girouette` (matière émissive).
- 6 roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (les jumelées forment une seule pièce par côté).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_lourd` (gros diesel grave, avec sifflement de turbo), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_lourd_demarre.ogg`, `bruit_moteur_diesel_lourd_ralenti.ogg` (boucle), `bruit_moteur_diesel_lourd_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_lourd_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_bus_portes.ogg` : chuintement pneumatique.
- `bruit_bus_frein_air.ogg` : décharge d'air à l'arrêt.
- `bruit_bus_sonnette_arret.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A modern low-floor single-deck city transit bus, 11 meters long: flat front with a large windshield and a destination display above it, two double doors on the right side, continuous band of side windows, livery green on the lower half and white on the upper half with a thin yellow line, dual rear wheels. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 11.00 m long, 2.50 m wide, 3.10 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
