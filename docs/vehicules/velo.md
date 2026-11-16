# Vélo

Tâche T2353 · fichier modèle `assets/modeles/vehicules/vehicule_velo_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Véhicule de décor lent : livreurs de pain, gardiens, écoliers plus âgés, vendeurs ambulants. Sert d'obstacle lent dans la circulation et de moyen de fortune dans une mission du chapitre 3 (panne de carburant).

## Où on le croise à Cotonou
Vons en terre des quartiers, bord de lagune, abords des marchés, plage. Appuyé contre les murs et les étals.

- Présence selon les chapitres : Tous les chapitres ; plus nombreux au chapitre 3.
- Part dans la circulation : poids de tirage 2 sur un total de 126,1 (voir `tableau.md`), soit environ 1,6 % des véhicules qui roulent.
- Pilotable par le joueur : Hors de la liste de la décision 55 : pilotable seulement dans la mission prévue (réutilise la conduite moto, sans moteur).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 1,75 m |
| Largeur | 0,60 m |
| Hauteur | 1,05 m |
| Masse à vide | 14 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 1,75 × 0,60 × 1,05 m, origine au sol (ou à la ligne de flottaison), au centre |

Roues de 0,66 m, pneus de 0,04 m ; selle à 0,90 m ; porte-bagages arrière de 0,35 × 0,15 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 25 km/h (6,9 m/s) |
| Accélération au démarrage | 4 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 8 m/s² |
| Marche arrière | 4 km/h au plus |
| Rayon de braquage minimal | 1,6 m |
| Maniabilité | 5 / 5 |

Inclinaison limitée à 20°. Pas de jauge de carburant. Une côte (rampe de pont) fait tomber la vitesse à 14 km/h.

## Places et chargement
- Places : 1.
- Chargement : 1 cycliste + 30 kg sur le porte-bagages.

## Solidité
- Coefficient de solidité : **1,00** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repère : à sa vitesse maximale, un mur de face coûte 5,0 points sur 100 (rien en dessous de 18 km/h perdus d'un coup).
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Le cycliste tombe dès 12 km/h perdus d'un coup ; le vélo ne fume jamais, à 80 de dégâts la roue avant est voilée (vitesse 12 km/h).

## Couleurs
- Cadre noir `3a3a3d`, vert `2f7d32` ou bleu `2a86b5`, souvent repeint.
- Garde-boue et jantes gris clair `d6d0c4`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_velo_noir.glb` | Base, cadre droit à barre haute |
| `vehicule_velo_pain.glb` | Caisse en bois `8b5a2b` sur le porte-bagages, baguettes qui dépassent |
| `vehicule_velo_glacier.glb` | Glacière blanche à l'avant, clochette |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Grand vélo robuste à barre horizontale, freins à tringles, selle large à ressorts.
- Chambre à air nouée autour du porte-bagages en guise de tendeur.
- Sonnette au pouce.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Moto, zémidjan (avec conducteur) » de `docs/style_graphique.md` : 5 000 triangles au plus en détail fin, 900 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 1 200 |
| Niveau 1 (environ 50 %) | 600 |
| Niveau 2, vu de loin (environ 15 %) | 180 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `cadre` : cadre, selle, garde-boue et porte-bagages soudés.
- `roue_av`, `roue_ar`.
- `fourche` : fourche et guidon (pivot de direction).
- `bequille`.
- Budget : 1 200 triangles pour le vélo seul ; avec un cycliste « passant » (3 000) l'ensemble reste sous les 5 000 de la ligne « moto ».
- `pedalier` séparé (tourne avec la vitesse).
- `cycliste` séparé.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_velo_chaine.ogg` : roulement et cliquetis de chaîne (boucle, hauteur selon la vitesse).
- `bruit_velo_sonnette.ogg`.
- `bruit_velo_frein.ogg` : couinement des patins.
- `bruit_velo_chute.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> An old-fashioned heavy roadster bicycle: black steel diamond frame with a horizontal top bar, large 28-inch wheels with thin tires and metal fenders, wide sprung saddle, rod brakes, a flat rear luggage rack, upright handlebar with a thumb bell. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 1.75 m long, 0.60 m wide, 1.05 m high. About 1200 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
