# Engin de chantier

Tâche T2443 · fichier modèle `assets/modeles/vehicules/vehicule_tractopelle_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Chargeuse-pelleteuse (tractopelle) : l'engin emblématique des grands chantiers du chapitre 4 (décisions 91 et 96). Obstacle très lent, décor animé des chantiers, et outil d'une mission (dégager une rue barrée par des gravats ou une épave).

## Où on le croise à Cotonou
Chantiers de voirie du chapitre 4 (boulevard de la Marina, Étoile Rouge, Akpakpa), berges de la lagune, carrière de sable, port.

- Présence selon les chapitres : 2 exemplaires aux chapitres 1 à 3 ; une douzaine au chapitre 4 ; 4 ensuite.
- Part dans la circulation : poids de tirage 0,3 sur un total de 126,1 (voir `tableau.md`), soit environ 0,2 % des véhicules qui roulent.
- Pilotable par le joueur : Hors de la liste de la décision 55 : conduit seulement dans la mission prévue.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,90 m |
| Largeur | 2,30 m |
| Hauteur | 3,50 m |
| Masse à vide | 8 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,90 × 2,30 × 3,50 m, origine au sol (ou à la ligne de flottaison), au centre |

Longueur godet avant posé et bras arrière replié ; cabine vitrée de 1,50 × 1,40 m à 1,60 m du sol ; godet avant de 2,30 m de large (0,9 m³) ; bras de pelle arrière : portée 5,40 m déplié ; grandes roues arrière de 1,40 m, avant de 0,90 m ; deux béquilles stabilisatrices.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 35 km/h (9,7 m/s) |
| Accélération au démarrage | 3 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 10 m/s² |
| Marche arrière | 20 km/h au plus |
| Rayon de braquage minimal | 4,5 m |
| Maniabilité | 2 / 5 |

Très lent mais tourne court. Godet avant : touche d'action pour lever et baisser (2 s) ; godet baissé, il pousse gravats, épaves et véhicules de moins de 3 000 kg. Le bras arrière n'est animé que par l'IA.

## Places et chargement
- Places : 1.
- Chargement : 1 conducteur ; 1 500 kg dans le godet.

## Solidité
- Coefficient de solidité : **0,30** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 3,7 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,3 ; c'est le véhicule qui inflige le plus de dégâts aux autres (× 1,5).

## Couleurs
- Jaune `fcd116` (seule couleur vive), bras et godets noirs `3a3a3d` ou gris usé `d6d0c4`.
- Cabine aux montants noirs, vitres `3c4b57`, gyrophare orange.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_tractopelle_tractopelle.glb` | Base |
| `vehicule_tractopelle_niveleuse.glb` | Décor : niveleuse de 8,5 m à longue lame centrale, même palette (modèle distinct, mêmes sons) |
| `vehicule_tractopelle_compacteur.glb` | Décor : rouleau compacteur de 5 m, cylindre avant lisse |
| `vehicule_tractopelle_arret.glb` | Garé pour la nuit, godet posé, ruban rouge et blanc autour |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Terre rouge collée aux godets et aux roues.
- Ouvriers en gilet orange autour, un homme-trafic avec un fanion rouge.
- Panneau de chantier à côté (objet séparé) : « Chantier – Ralentir », nom d'entreprise inventé.
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
- `godet_av`, `bras_av_g`, `bras_av_d` (pivots), `fleche`, `balancier`, `godet_ar` (3 articulations), `bequille_g`, `bequille_d`, `porte_cabine`, `gyrophare`.
- 4 roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard`.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `engin` (diesel lent d'engin, régime presque constant), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_engin_demarre.ogg`, `bruit_moteur_engin_ralenti.ogg` (boucle), `bruit_moteur_engin_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_engin_coupe.ogg`.
- Klaxon : `bruit_klaxon_camion.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_engin_hydraulique.ogg` : mouvement des bras (boucle).
- `bruit_engin_godet_racle.ogg` : godet sur le sol.
- `bruit_bip_recul.ogg` (partagé).

## Consigne de génération 3D (à copier telle quelle)
> A yellow backhoe loader construction machine: glass operator cab in the middle, wide front loader bucket on two lifting arms, an articulated excavator arm with a small bucket folded at the rear, two stabilizer legs, large ribbed rear tractor tires and smaller front tires, an orange beacon on the cab roof, red mud on the buckets. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.90 m long, 2.30 m wide, 3.50 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, lifting arms, buckets or mast and forks as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
