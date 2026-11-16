# Moto de zémidjan

Tâche T2023 · fichier modèle `assets/modeles/vehicules/vehicule_zem_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Premier véhicule de Koffi (décision 51) et véhicule le plus courant du jeu. Sert aux courses de zémidjan (métier, décision 67), aux petites livraisons et à se faufiler dans les embouteillages (décision 61). C'est aussi la moto que le joueur achète et confie à des conducteurs (décision 68).

## Où on le croise à Cotonou
Partout. Très dense à Dantokpa, Missèbo, l'Étoile Rouge, sur les trois ponts et aux têtes de station (grappes de 6 à 12 motos garées en épi au bord des carrefours). Plus rare dans l'enceinte du port et sur la piste de l'aéroport (interdit).

- Présence selon les chapitres : Tous les chapitres. Au chapitre 3 (ville à l'arrêt), densité divisée par 3.
- Part dans la circulation : poids de tirage 38 sur un total de 126,1 (voir `tableau.md`), soit environ 30,1 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55), dès la mission 1.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 1,90 m |
| Largeur | 0,80 m |
| Hauteur | 1,10 m |
| Masse à vide | 110 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 1,90 × 0,80 × 1,10 m, origine au sol (ou à la ligne de flottaison), au centre |

Hauteur de selle 0,78 m ; roues de 0,60 m de diamètre, pneus fins (0,09 m) ; empattement 1,25 m ; guidon large de 0,72 m (le gabarit de collision reste 0,8 × 1,8 m, comme dans `docs/monde.md`).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 94 km/h (26,1 m/s) |
| Accélération au démarrage | 18 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,0 s |
| Freinage | 20 m/s² |
| Marche arrière | 5 km/h au plus |
| Rayon de braquage minimal | 2,2 m |
| Maniabilité | 5 / 5 |

C'est la moto de référence : tous les réglages actuels de `scripts/moto.gd` sont les siens (inclinaison 38°, 120° par seconde à 29 km/h). Avec client : accélération −15 %, freinage −10 %.

## Places et chargement
- Places : 2 (pilote + 1 client).
- Chargement : Pilote + 1 client (joueur). Les motos de la circulation portent parfois 2 passagers ou un chargement (voir variantes).

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 55 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Barème de référence des motos : chute du pilote à partir de 25 km/h perdus d'un coup, fumée à 50 de dégâts, 56 km/h au plus à 80.

## Couleurs
- Réservoir et caches latéraux : rouge `e8112d`, bleu `2a86b5`, noir `1e2a33` ou vert `008751` (tirage au hasard, une seule couleur vive par moto).
- Cadre, moteur, jantes : gris `d6d0c4` et noir `3a3a3d`.
- Selle longue noire `1e2a33`, parfois recouverte d'une housse à rayures (variante).
- Le jaune `f2c200` est porté par la chemise du conducteur (décision 43), pas par la moto.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_zem_jaune.glb` | Modèle de base, conducteur en chemise jaune numérotée (le fichier garde le nom donné en exemple dans `docs/conventions.md`) |
| `vehicule_zem_koffi.glb` | Moto de Romaric prêtée à Koffi : réservoir rouge cabossé, autocollant étoile, rétroviseur gauche manquant |
| `vehicule_zem_charge.glb` | Circulation seulement : casier de bouteilles, sac de 50 kg ou régime de bananes sanglé sur le porte-bagages (+ 300 triangles) |
| `vehicule_zem_famille.glb` | Circulation seulement : pilote + 2 passagers, aux abords des écoles et le dimanche |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Selle très longue et plate, porte-bagages arrière en tube chromé, repose-pieds passager larges.
- Pare-jambes en tube devant les genoux du pilote, sandow (tendeur) enroulé sur le porte-bagages.
- Chiffon coincé sous la selle, petite bouteille de carburant de secours accrochée au cadre.
- Numéro de la chemise du conducteur repris en petit à la peinture blanche sur le garde-boue arrière.
- Garde-boue arrière prolongé d'une bavette en caoutchouc à motif inventé (losanges).
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
- `conducteur` : personnage séparé (1 800 triangles), posé sur la moto ; il est remplacé par Koffi quand le joueur monte.
- `porte_bagages` séparé pour pouvoir y poser un chargement.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `moto_petite` (petit monocylindre de moto, aigu et saccadé), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_moto_petite_demarre.ogg`, `bruit_moteur_moto_petite_ralenti.ogg` (boucle), `bruit_moteur_moto_petite_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_moto_petite_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les deux-roues : `bruit_moto_bequille.ogg`, `bruit_moto_chute.ogg` (glissade et choc au sol).
- `bruit_zem_client_monte.ogg` : amortisseur qui se tasse quand le client s'assoit.

## Consigne de génération 3D (à copier telle quelle)
> A small 125 cc commuter motorcycle used as a motorcycle taxi in West Africa: slim teardrop fuel tank in bright red, very long flat black two-person seat, chromed tubular rear luggage rack, tubular leg guards in front of the rider's knees, thin spoked wheels, round headlight, single exhaust on the right, simple side stand, wide passenger footrests, a rubber mud flap on the rear fender. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 1.90 m long, 0.80 m wide, 1.10 m high. About 5000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
