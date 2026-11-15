# Style graphique, palette et budget de polygones

## Parti pris
Low-poly coloré : volumes simples, aplats de couleur, peu ou pas de textures. Le charme vient des couleurs chaudes de Cotonou et de la lumière de fin d'après-midi, pas du détail. Ce style reste lisible au niveau graphique « Bas » et supporte bien les modèles générés.

- Formes : arêtes franches, pas de lissage excessif ; silhouettes reconnaissables de loin (zémidjan jaune, taxi jaune à bande verte, parasols du marché).
- Couleur : une teinte par surface, portée par la matière (pas de texture photo). Textures réservées aux enseignes, plaques et panneaux.
- Lumière : soleil bas et chaud, brume légère couleur sable qui cache le fond de carte. Ombres dès le niveau « Moyen ».
- Personnages : proportions un peu trapues, visages simples, tenues très colorées (pagnes fictifs, maillots, uniformes).
- Texte dans le monde : enseignes et marques inventées, en français.

## Palette de référence (codes déjà utilisés dans le jeu)
| Usage | Couleurs |
|---|---|
| Terre rouge (latérite) | `b5653a` |
| Sable de la plage | `e8d3a0` |
| Mer et lagune | `2a86b5` |
| Bitume, marquage | `3a3a3d`, `e8e8e8` |
| Trottoirs et îlots | `a3957f` |
| Murs des bâtiments | `f2e6d0` `e8c99a` `d98c5f` `f4f1ea` `c4d4c8` `e2b3a0` `9fc3d9` `f0dc8a` `d6d0c4` |
| Vitres | `3c4b57`, `1e2a33` |
| Végétation | `2f7d32`, `3f9a3c`, `5f9a3a` ; troncs `8b6a43` |
| Bois des étals | `8b5a2b` |
| Accents (vert, jaune, rouge) | `008751`, `fcd116`, `e8112d` |
| Zémidjan et taxis | `f2c200`, bande `1f8a3a` |
| Ciel et brume | `f6cf96` ; lumière du soleil `ffdcaa` |
| Interface | or `f5c400`, argent gagné `8df59a`, conseils `ffe27a`, fond de menu `140a05` à 72 % |

Règles : pas plus de 3 couleurs vives par objet ; les couleurs très vives sont réservées à ce que le joueur doit repérer (objectif, zémidjans, enseignes).

## Budget de polygones (triangles)
Le budget se compte au niveau de détail le plus fin. Chaque modèle importé doit avoir 2 niveaux plus légers (environ 50 % et 15 %).

| Type d'objet | Détail fin | Vu de loin |
|---|---|---|
| Héros | 10 000 | 2 500 |
| Personnage important | 8 000 | 2 000 |
| Passant | 3 000 | 600 |
| Voiture, taxi | 8 000 | 1 200 |
| Moto, zémidjan (avec conducteur) | 5 000 | 900 |
| Bus, camion | 10 000 | 1 500 |
| Pirogue, petit bateau | 3 000 | 500 |
| Bâtiment courant | 1 500 | 200 |
| Monument (Amazone, Étoile Rouge, grand marché) | 15 000 | 2 500 |
| Étal, mobilier de rue | 300 | 60 |
| Arbre, palmier | 600 | 100 |
| Petit objet (colis, bouteille, panneau) | 150 | 30 |
| Arme | 1 500 | 300 |

Budget d'une image entière (ce que la caméra voit) :

| Niveau graphique | Triangles visibles | Appels de dessin |
|---|---|---|
| Bas | 250 000 | 600 |
| Moyen | 500 000 | 1 000 |
| Élevé | 1 000 000 | 1 800 |
| Ultra | 2 000 000 | 3 000 |

Matières : une seule par objet courant, trois au plus pour un véhicule ou un personnage. Textures : 512 px pour les objets, 1 024 px pour les héros et monuments, 2 048 px seulement en « Ultra ».

Ces chiffres sont un point de départ : ils seront ajustés d'après les mesures d'images par seconde que Bravo relèvera sur ses PC (tâche T0002).
