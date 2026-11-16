# Voiture épave

Tâche T2463 · fichier modèle `assets/modeles/vehicules/vehicule_epave_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Carcasse de voiture abandonnée : décor, obstacle fixe et cachette (on s'accroupit derrière pour échapper au regard d'un policier). Source de pièces pour les missions de dépannage de Romaric et de Tonton Gratien (décisions 28 et 31).

## Où on le croise à Cotonou
Vons d'Akpakpa, terrains vagues près de la lagune, arrière des garages de Missèbo, casse fictive de la route du port (une vingtaine empilées par deux).

- Présence selon les chapitres : Tous les chapitres ; moins nombreuses après les rénovations du chapitre 5 (décision 91).
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Non : objet de décor fixe. Elle n'a ni moteur ni conducteur.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,40 m |
| Largeur | 1,70 m |
| Hauteur | 1,25 m |
| Masse à vide | 800 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,40 × 1,70 × 1,25 m, origine au sol (ou à la ligne de flottaison), au centre |

Berline ancienne posée sur ses jantes ou sur 4 parpaings (hauteur 1,25 m sur jantes, 1,45 m sur parpaings) ; capot ouvert en variante (+ 0,60 m).

## Vitesse, accélération, maniabilité
Immobile : pas de vitesse, d'accélération ni de freinage.

Immobile. Corps statique par défaut ; poussée seulement par un véhicule de plus de 5 000 kg (camion, engin de chantier), à 10 km/h au plus.

## Places et chargement
- Places : 0.
- Chargement : Aucune. Coffre fouillable (1 objet de mission).

## Solidité
- Indestructible : c'est déjà une épave. Elle inflige des dégâts normaux à qui la percute.

## Couleurs
- Rouille `b5653a` et brun `8b5a2b` sur 60 % de la surface, restes de peinture : bleu `9fc3d9`, blanc `f4f1ea` ou vert `c4d4c8`.
- Vitres absentes ou étoilées (aplat `3c4b57` avec un trou).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_epave_jantes.glb` | Posée sur ses jantes, sans vitres |
| `vehicule_epave_parpaings.glb` | Sur 4 parpaings, capot ouvert, moteur absent |
| `vehicule_epave_herbe.glb` | Envahie d'herbes `5f9a3a`, un arbuste qui sort du capot |
| `vehicule_epave_brulee.glb` | Noire `3a3a3d` et grise, ancienne ; aucune flamme ni fumée (décision 57) |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Sert de banc, d'étal ou de séchoir : pagne étendu sur le toit, bassine posée sur le capot.
- Poules ou cabri autour (objets séparés).
- Inscription à la craie sur la portière : « À vendre » barré.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 4 000 |
| Niveau 1 (environ 50 %) | 2 000 |
| Niveau 2, vu de loin (environ 15 %) | 600 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- Tout est soudé : un seul maillage, une seule matière. Seules `porte_avg` (entrouverte, pour la fouille) et `coffre` sont articulés.
- Pas de niveau « vue intérieure ».
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_epave_tole.ogg` : tôle qui résonne quand on la percute ou qu'on monte dessus.
- `bruit_epave_coffre.ogg` : coffre rouillé qui grince.

## Consigne de génération 3D (à copier telle quelle)
> An abandoned wrecked 1990s sedan car resting on four concrete blocks: no wheels, no engine, hood open, missing windows, body mostly rusty brown with patches of faded light blue paint, one door hanging ajar, dented roof, weeds growing around it. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.40 m long, 1.70 m wide, 1.25 m high. About 4000 triangles, clean closed topology, at most three materials (body paint, glass, details), single merged mesh except one door and the trunk lid. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
