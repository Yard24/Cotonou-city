# Moto de ville

Tâche T2033 · fichier modèle `assets/modeles/vehicules/vehicule_moto_ville_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Moto de particulier, plus puissante et mieux entretenue que celle des zémidjans. Récompense de milieu de jeu : plus rapide, mais ne permet pas de prendre des clients (pas de chemise jaune, les clients ne lèvent pas le bras).

## Où on le croise à Cotonou
Garée devant les bureaux de Ganhi, les maquis de Fidjrossè et les boutiques de la Marina ; en circulation sur les boulevards. Une est à vendre chez Tonton Gratien à Missèbo.

- Présence selon les chapitres : Circulation dès le chapitre 1 ; achetable à partir du chapitre 2.
- Part dans la circulation : poids de tirage 6 sur un total de 126,1 (voir `tableau.md`), soit environ 4,8 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « moto »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 2,00 m |
| Largeur | 0,80 m |
| Hauteur | 1,10 m |
| Masse à vide | 140 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 2,00 × 0,80 × 1,10 m, origine au sol (ou à la ligne de flottaison), au centre |

Hauteur de selle 0,80 m ; roues de 0,62 m, pneus plus larges (0,12 m) ; empattement 1,32 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 112 km/h (31,1 m/s) |
| Accélération au démarrage | 20 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 0,9 s |
| Freinage | 22 m/s² |
| Marche arrière | 5 km/h au plus |
| Rayon de braquage minimal | 2,5 m |
| Maniabilité | 4 / 5 |

Plus stable à haute vitesse que la moto de zémidjan (se couche un peu moins vite : 85 % de `PENCHE_VITE`), freine mieux grâce au disque avant.

## Places et chargement
- Places : 2.
- Chargement : Pilote + 1 passager.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 23 points de dégâts sur 100 ; à sa vitesse maximale = 68 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Comme la moto de référence.

## Couleurs
- Réservoir anguleux en noir `1e2a33`, rouge `e8112d`, bleu `2a86b5` ou blanc `f4f1ea`, avec une bande contrastée.
- Moteur et échappement noir mat `3a3a3d`, jantes à bâtons noires.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_moto_ville_noire.glb` | Base |
| `vehicule_moto_ville_rouge.glb` | Bande blanche sur le réservoir |
| `vehicule_moto_ville_coffre.glb` | Top-case carré à l'arrière (employé de bureau) |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Housse de selle en simili à coutures apparentes.
- Antivol en U accroché au cadre, casque pendu au rétroviseur quand elle est garée.
- Protège-mains en plastique sur le guidon, utile sous la pluie.
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
- `conducteur` séparé (habillé en civil, casque intégral).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `moto_grosse` (moto plus grave et plus ronde), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_moto_grosse_demarre.ogg`, `bruit_moteur_moto_grosse_ralenti.ogg` (boucle), `bruit_moteur_moto_grosse_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_moto_grosse_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les deux-roues : `bruit_moto_bequille.ogg`, `bruit_moto_chute.ogg` (glissade et choc au sol).

## Consigne de génération 3D (à copier telle quelle)
> A 150-200 cc naked street motorcycle: angular black fuel tank with a contrasting stripe, stepped two-person seat, small front fender, front disc brake, black cast wheels with five spokes, short upswept exhaust, small rectangular headlight with a tiny fly screen, plastic hand guards on the handlebar. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 2.00 m long, 0.80 m wide, 1.10 m high. About 5000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
