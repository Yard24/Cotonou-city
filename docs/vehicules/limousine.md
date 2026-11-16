# Limousine

Tâche T2343 · fichier modèle `assets/modeles/vehicules/vehicule_limousine_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Très longue voiture de location pour mariages et cérémonies. Événement du samedi : cortège de mariage klaxonnant (exception voulue à la décision 59, limitée aux cortèges). Mission secondaire de chauffeur : amener les mariés à l'heure sans secousse.

## Où on le croise à Cotonou
Devant les salles de fête de Fidjrossè et d'Akpakpa, Place de l'Amazone (photos de mariage), hôtels de la Marina. Garée chez un loueur fictif à Ganhi.

- Présence selon les chapitres : À partir du chapitre 2 ; cortèges absents au chapitre 3.
- Part dans la circulation : poids de tirage 0,2 sur un total de 126,1 (voir `tableau.md`), soit environ 0,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui, uniquement dans la mission de chauffeur (famille « voiture »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 7,50 m |
| Largeur | 1,90 m |
| Hauteur | 1,50 m |
| Masse à vide | 2 700 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 7,50 × 1,90 × 1,50 m, origine au sol (ou à la ligne de flottaison), au centre |

Berline allongée 6 portes ; empattement 5,40 m ; roues de 0,70 m ; garde au sol 0,14 m (frotte sur les dos-d'âne) ; compartiment arrière avec deux banquettes face à face.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 105 km/h (29,2 m/s) |
| Accélération au démarrage | 8 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 2,3 s |
| Freinage | 24 m/s² |
| Marche arrière | 20 km/h au plus |
| Rayon de braquage minimal | 9,5 m |
| Maniabilité | 1 / 5 |

Ne tourne pas dans une rue de quartier de 7 m sans manœuvre ; impossible dans une von de 5 m. Braquage 55 % de la référence. Jauge de confort dans la mission : freinages au-delà de 15 m/s² et chocs la font baisser.

## Places et chargement
- Places : 10 (chauffeur + 9).
- Chargement : Chauffeur + 1 à l'avant, 8 à l'arrière.

## Solidité
- Coefficient de solidité : **0,90** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 21 points de dégâts sur 100 ; à sa vitesse maximale = 56 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,9.

## Couleurs
- Blanc `f4f1ea` (mariages) ou noir `1e2a33`.
- Rubans et nœuds de couleur sur le capot et les poignées (variante mariage).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_limousine_blanche.glb` | Base |
| `vehicule_limousine_mariage.glb` | Rubans roses `e2b3a0` et jaunes `f0dc8a` en V sur le capot, bouquet sur la calandre, nœuds aux poignées |
| `vehicule_limousine_noire.glb` | Location pour cérémonies |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Cortège : la limousine suivie de 4 à 6 voitures et de motos, warnings allumés, passagers qui saluent.
- Petite pancarte « Vive les mariés » en texture sur la lunette arrière.
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
- 6 portes : `porte_avg`, `porte_avd`, `porte_mg`, `porte_md`, `porte_arg`, `porte_ard`.
- `rubans` séparés.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_recente` (moteur à essence discret), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_recente_demarre.ogg`, `bruit_moteur_voiture_recente_ralenti.ogg` (boucle), `bruit_moteur_voiture_recente_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_recente_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_klaxon_cortege.ogg` : klaxons joyeux en rythme (boucle de 8 s, cortèges seulement).

## Consigne de génération 3D (à copier telle quelle)
> A stretched six-door white limousine: very long sedan body with an extended middle section, long row of dark tinted side windows, chrome-look trim, pink and yellow wedding ribbons in a V shape across the hood and bows on the door handles, multi-spoke wheels. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 7.50 m long, 1.90 m wide, 1.50 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
