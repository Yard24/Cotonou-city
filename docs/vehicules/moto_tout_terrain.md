# Moto tout-terrain

Tâche T2053 · fichier modèle `assets/modeles/vehicules/vehicule_moto_cross_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Moto haute pour les pistes, la plage et les rues inondées. Véhicule des courses de motos sur la plage (décision 103) et de certaines missions du chapitre 5 sur la route du Nord.

## Où on le croise à Cotonou
Plage de Fidjrossè (courses), vons en terre d'Akpakpa, chantiers du chapitre 4. Garée devant les services techniques et les ONG fictives.

- Présence selon les chapitres : Disponible à partir du chapitre 2 (première course sur la plage).
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (famille « moto »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 2,10 m |
| Largeur | 0,85 m |
| Hauteur | 1,25 m |
| Masse à vide | 120 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 2,10 × 0,85 × 1,25 m, origine au sol (ou à la ligne de flottaison), au centre |

Selle à 0,90 m ; grande roue avant de 0,70 m, arrière de 0,64 m, pneus à crampons ; garde au sol 0,30 m ; garde-boue avant haut, à 0,25 m au-dessus du pneu.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 105 km/h (29,2 m/s) |
| Accélération au démarrage | 21 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 0,9 s |
| Freinage | 20 m/s² |
| Marche arrière | 5 km/h au plus |
| Rayon de braquage minimal | 2,4 m |
| Maniabilité | 4 / 5 |

Aucune perte de vitesse ni d'adhérence sur sable, latérite et eau jusqu'à 0,40 m (les autres deux-roues perdent 25 %). Sur bitume, un peu moins précise : inclinaison maximale 34° au lieu de 38°.

## Places et chargement
- Places : 2.
- Chargement : Pilote + 1 passager (selle étroite).

## Solidité
- Coefficient de solidité : **0,90** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 21 points de dégâts sur 100 ; à sa vitesse maximale = 56 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Conçue pour tomber : dégâts reçus × 0,9 ; la chute du pilote ne se déclenche qu'à 30 km/h perdus d'un coup.

## Couleurs
- Plastiques en une couleur vive : orange `d98c5f`, vert `3f9a3c`, bleu `2a86b5` ou rouge `e8112d`.
- Cadre et moteur noirs, selle noire, plaque avant ovale blanche `f4f1ea` (numéro de course en variante).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_moto_cross_orange.glb` | Base |
| `vehicule_moto_cross_course.glb` | Plaques numérotées 1 à 8, une couleur par concurrent |
| `vehicule_moto_cross_service.glb` | Blanche, sacoches en toile, pour agents de terrain |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Boue rouge de latérite sur le bas du cadre (couleur `b5653a` en aplat).
- Jerrican de 5 litres sanglé à l'arrière sur la variante service.
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
- `conducteur` séparé (casque à visière longue).
- `fourche` à grand débattement : pivot séparé pour l'animation de plongée.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `moto_grosse` (moto plus grave et plus ronde), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_moto_grosse_demarre.ogg`, `bruit_moteur_moto_grosse_ralenti.ogg` (boucle), `bruit_moteur_moto_grosse_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_moto_grosse_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les deux-roues : `bruit_moto_bequille.ogg`, `bruit_moto_chute.ogg` (glissade et choc au sol).
- `bruit_moto_sable.ogg` : roue qui patine sur le sable (boucle).

## Consigne de génération 3D (à copier telle quelle)
> A lightweight dirt bike / enduro motorcycle: tall narrow frame, high front fender well above a large knobby front tire, long-travel front fork with rubber gaiters, flat narrow orange seat running onto the tank, orange plastic side panels, oval white front number plate, high-mounted exhaust, long ground clearance, no fairing. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 2.10 m long, 0.85 m wide, 1.25 m high. About 5000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
