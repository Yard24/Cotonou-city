# Charrette à bras (pousse-pousse)

Tâche T2363 · fichier modèle `assets/modeles/vehicules/vehicule_pousse_pousse_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Charrette à deux roues poussée par un homme, qui transporte les ballots entre les camions et les étals. Obstacle lent typique des marchés ; mission secondaire « coup de main » (pousser un chargement sur 150 m sans le renverser).

## Où on le croise à Cotonou
Dantokpa et Missèbo surtout, quais de la lagune, entrée du port, gares routières.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Hors de la liste de la décision 55 : poussée à pied par le joueur dans les missions prévues (touche E pour saisir les brancards, puis déplacement à pied ralenti).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 2,40 m |
| Largeur | 1,20 m |
| Hauteur | 1,00 m |
| Masse à vide | 90 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 2,40 × 1,20 × 1,00 m, origine au sol (ou à la ligne de flottaison), au centre |

Plateau de 1,60 × 1,10 m à 0,65 m du sol ; deux brancards de 0,80 m ; deux roues de voiture récupérées de 0,60 m ; avec chargement, hauteur totale jusqu'à 2,00 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 7 km/h (1,9 m/s) |
| Accélération au démarrage | 1,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 3 m/s² |
| Marche arrière | 3 km/h au plus |
| Rayon de braquage minimal | 1,5 m |
| Maniabilité | 3 / 5 |

Vitesse du pousseur : 2 m/s chargée (7 km/h), 3 m/s à vide. Pivote sur place autour de son essieu. Chargée, elle ne s'arrête pas net : 1,5 m de glissade.

## Places et chargement
- Places : 0 (1 pousseur à pied).
- Chargement : Jusqu'à 400 kg (8 sacs de 50 kg ou 6 ballots de tissu).

## Solidité
- Coefficient de solidité : **0,70** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 0,0 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Bois et fer : dégâts reçus × 0,7. Un choc de plus de 20 km/h renverse le chargement (sacs éparpillés, ramassables), sans blesser le pousseur (décision 4 : il tombe et se relève).

## Couleurs
- Bois brut `8b5a2b` et planches plus claires `a3957f`.
- Roues noires `3a3a3d`, moyeux rouillés `b5653a`.
- Chargement : sacs blancs `f4f1ea`, ballots emballés de plastique bleu `2a86b5`, cartons `e8c99a`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_pousse_pousse_vide.glb` | Base |
| `vehicule_pousse_pousse_sacs.glb` | 8 sacs empilés + bâche |
| `vehicule_pousse_pousse_ballots.glb` | 6 ballots de tissu cerclés, pour Nan Akouavi |
| `vehicule_pousse_pousse_bidons.glb` | 12 bidons jaunes `fcd116` de 25 litres |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Plateau en planches clouées sur un essieu de voiture récupéré, brancards en tube soudé.
- Prénom ou devise peinte à la main sur la ridelle arrière (texture) : « La patience paie », « Merci Maman ».
- Corde de chanvre en boucle sur un brancard, cale en bois pendue par une ficelle.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Moto, zémidjan (avec conducteur) » de `docs/style_graphique.md` : 5 000 triangles au plus en détail fin, 900 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 900 |
| Niveau 1 (environ 50 %) | 450 |
| Niveau 2, vu de loin (environ 15 %) | 140 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `roue_g`, `roue_d` séparées.
- `chargement` séparé (remplaçable selon la variante, disparaît quand il est renversé).
- `pousseur` : passant séparé (3 000 triangles), animation de poussée.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_charrette_roule.ogg` : grincement d'essieu et roulement sur terre (boucle).
- `bruit_charrette_renverse.ogg` : sacs qui tombent.
- `voix_pousseur_attention_01.ogg` à `_03` : « Attention ! », « Chaud devant ! », « Pardon, pardon ! ».

## Consigne de génération 3D (à copier telle quelle)
> A two-wheeled wooden hand cart used by market porters: flat plank platform on a salvaged car axle with two old car wheels, two welded steel push handles at one end, a low wooden tailboard, a coil of rope hanging on one handle, raw brown weathered wood and rusty metal. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 2.40 m long, 1.20 m wide, 1.00 m high. About 900 triangles, clean closed topology, at most three materials (body paint, glass, details), the two wheels as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
