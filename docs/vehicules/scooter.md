# Scooter

Tâche T2043 · fichier modèle `assets/modeles/vehicules/vehicule_scooter_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Deux-roues facile et lent, conduit surtout par des femmes, des étudiantes et des employés. Dans les missions : véhicule d'Afi (décision 41) et scooter de livraison de repas à partir du chapitre 3.

## Où on le croise à Cotonou
Ganhi, abords des lycées et de l'université, Fidjrossè, parkings des supermarchés fictifs. Rare à Dantokpa.

- Présence selon les chapitres : Rare aux chapitres 1-2, courant à partir du chapitre 3 (livraisons).
- Part dans la circulation : poids de tirage 5 sur un total de 126,1 (voir `tableau.md`), soit environ 4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (famille « moto »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 1,80 m |
| Largeur | 0,70 m |
| Hauteur | 1,15 m |
| Masse à vide | 100 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 1,80 × 0,70 × 1,15 m, origine au sol (ou à la ligne de flottaison), au centre |

Plancher plat à 0,28 m du sol ; selle à 0,76 m ; petites roues de 0,42 m ; tablier avant large de 0,45 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 80 km/h (22,2 m/s) |
| Accélération au démarrage | 15 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,2 s |
| Freinage | 18 m/s² |
| Marche arrière | 5 km/h au plus |
| Rayon de braquage minimal | 1,9 m |
| Maniabilité | 5 / 5 |

Le plus maniable au pas (demi-tour dans une von de 5 m), mais instable sur la terre : sur latérite et sable, vitesse maximale −25 %.

## Places et chargement
- Places : 2.
- Chargement : Pilote + 1 passager ; coffre sous la selle (1 petit colis).

## Solidité
- Coefficient de solidité : **1,10** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 25 points de dégâts sur 100 ; à sa vitesse maximale = 49 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Carénage en plastique : dégâts reçus × 1,1.

## Couleurs
- Carénage d'une seule couleur : blanc `f4f1ea`, rouge `e8112d`, bleu clair `9fc3d9`, rose saumon `e2b3a0` ou jaune pâle `f0dc8a`.
- Plancher, selle et poignées noirs `1e2a33`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_scooter_blanc.glb` | Base |
| `vehicule_scooter_afi.glb` | Bleu clair, panier à l'avant, autocollants fleurs |
| `vehicule_scooter_livraison.glb` | Caisson isotherme cubique vert `008751` à l'arrière, enseigne fictive en texture |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Sac à main ou sachet noir accroché au crochet du tablier.
- Housse de selle à fleurs (motif inventé).
- Tapis en caoutchouc découpé sur le plancher.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Moto, zémidjan (avec conducteur) » de `docs/style_graphique.md` : 5 000 triangles au plus en détail fin, 900 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 5 000 |
| Niveau 1 (environ 50 %) | 2 500 |
| Niveau 2, vu de loin (environ 15 %) | 750 |

- Répartition du détail fin : 3 200 triangles pour la moto, 1 800 pour son conducteur (le budget de la ligne s'entend conducteur compris).
- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cadre, réservoir, selle, moteur et échappement soudés.
- `roue_av`, `roue_ar` : elles tournent et penchent avec la moto.
- `fourche` : fourche, guidon et phare ensemble (pivot de direction, plongée au freinage).
- `bequille` : repliée en roulant, dépliée à l'arrêt (moto penchée de 8°).
- `phare`, `feu_ar` : petites pièces à matière émissive (pour les allumer ou les casser).
- `conducteur` séparé.
- `caisson` séparé (variante livraison).
- `selle` articulée (ouverture du coffre, facultatif).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `scooter` (bourdonnement continu de scooter à variateur), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_scooter_demarre.ogg`, `bruit_moteur_scooter_ralenti.ogg` (boucle), `bruit_moteur_scooter_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_scooter_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les deux-roues : `bruit_moto_bequille.ogg`, `bruit_moto_chute.ogg` (glissade et choc au sol).
- `bruit_scooter_coffre.ogg` : selle qui claque.

## Consigne de génération 3D (à copier telle quelle)
> A small 110 cc step-through scooter: rounded white plastic bodywork, flat footboard, wide front leg shield with a hook, small 12-inch wheels, one-piece black seat with storage underneath, small round mirrors on thin stalks, integrated front headlight in the handlebar cover. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 1.80 m long, 0.70 m wide, 1.15 m high. About 5000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
