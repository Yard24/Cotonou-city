# Voiture de police

Tâche T2263 · fichier modèle `assets/modeles/vehicules/vehicule_police_voiture_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Voiture de patrouille (étoiles 2 et 3, décision 73). Elle poursuit, tente de bloquer et participe aux barrages. Ses agents descendent pour arrêter le joueur ; ils ne tirent pas (décision 75).

## Où on le croise à Cotonou
Devant le commissariat, en patrouille lente sur les boulevards, postée aux entrées des ponts et du port.

- Présence selon les chapitres : Tous les chapitres ; la livrée devient plus moderne au chapitre 4 (variante).
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA. Emprunter un véhicule de police n'est pas proposé (choix d'agent : cohérent avec le ton et avec la décision 76).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,60 m |
| Largeur | 1,80 m |
| Hauteur | 1,60 m |
| Masse à vide | 1 450 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,60 × 1,80 × 1,60 m, origine au sol (ou à la ligne de flottaison), au centre |

Berline récente surmontée d'une rampe lumineuse de 1,10 × 0,30 × 0,15 m (hauteur du toit 1,45 m) ; empattement 2,70 m ; roues de 0,66 m en tôle noire.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 135 km/h (37,5 m/s) |
| Accélération au démarrage | 17 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,1 s |
| Freinage | 32 m/s² |
| Marche arrière | 36 km/h au plus |
| Rayon de braquage minimal | 5,4 m |
| Maniabilité | 4 / 5 |

Un peu plus rapide que toutes les voitures courantes du joueur : on ne la sème pas en ligne droite, mais par les vons, les marchés, les embouteillages (à moto) et les rues inondées.

## Places et chargement
- Places : 4.
- Chargement : 2 agents à l'avant, 2 places à l'arrière (personne interpellée).

## Solidité
- Coefficient de solidité : **0,80** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 18 points de dégâts sur 100 ; à sa vitesse maximale = 67 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,8. À 80 de dégâts elle abandonne la poursuite (fumée noire, agents qui descendent).

## Couleurs
- Bleu nuit `1e2a33` avec portes et capot blancs `f4f1ea` (rappel de l'uniforme, décision 45).
- Bande réfléchissante jaune `fcd116` sous les vitres ; rampe bleue `2a86b5`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_police_voiture_2017.glb` | Berline ancienne repeinte, un seul gyrophare bleu aimanté |
| `vehicule_police_voiture_2021.glb` | Base : berline récente, rampe complète, numéro de véhicule sur le toit |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Mot « POLICE » en texture sur les portes et le coffre, écusson fictif (bouclier simple) ; numéro d'appel inventé à 3 chiffres.
- Grille de séparation derrière les sièges avant.
- Antenne radio longue sur l'aile arrière.
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
- `rampe` séparée (matière émissive, deux moitiés qui alternent).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_recente` (moteur à essence discret), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_recente_demarre.ogg`, `bruit_moteur_voiture_recente_ralenti.ogg` (boucle), `bruit_moteur_voiture_recente_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_recente_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sirene_police.ogg` : sirène deux tons (boucle).
- `bruit_radio_police_01.ogg` à `_04` : grésillements et messages brefs sans nom de personne.
- `voix_police_megaphone_01.ogg` à `_03` : « Conducteur, rangez-vous sur le côté ! ».

## Consigne de génération 3D (à copier telle quelle)
> A police patrol car with a fictional livery: modern four-door sedan painted dark navy blue with white doors and white hood, a yellow reflective stripe below the windows, a full-width blue light bar on the roof, black steel wheels, a long radio antenna on the rear fender, plain shield emblem with no text. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.60 m long, 1.80 m wide, 1.60 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
