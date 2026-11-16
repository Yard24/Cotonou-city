# Vedette rapide

Tâche T2403 · fichier modèle `assets/modeles/vehicules/vehicule_vedette_<variante>.glb` · ligne de budget « Pirogue, petit bateau ».

## Rôle dans le jeu
Bateau rapide à coque rigide de la brigade fluviale et de la douane : la réponse de la police sur l'eau (poursuites en barque des chapitres 2 et 4). Une version civile blanche appartient à Monsieur Fortuné.

## Où on le croise à Cotonou
Ponton de la douane au port, chenal entre la lagune et la mer, patrouille lente sur la lagune la nuit, ponton privé de la Marina.

- Présence selon les chapitres : À partir du chapitre 2.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Non : véhicule de l'IA (police et douane) ; la version civile est conduite une fois, dans une mission du chapitre 6.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 9,50 m |
| Largeur | 2,80 m |
| Hauteur | 2,60 m |
| Masse à vide | 4 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 9,50 × 2,80 × 2,60 m, origine au sol (ou à la ligne de flottaison), au centre |

Hauteur au-dessus de l'eau, arceau compris ; coque en V, franc-bord 0,90 m, tirant d'eau 0,55 m ; console centrale avec pare-brise et toit rigide de 2,00 × 1,60 m ; arceau arrière portant feux et antennes ; 2 moteurs hors-bord.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 70 km/h (19,4 m/s) |
| Accélération au démarrage | 6 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 3,0 s |
| Freinage | 5 m/s² |
| Marche arrière | 10 km/h au plus |
| Rayon de braquage minimal | 14,0 m |
| Maniabilité | 4 / 5 |

Deux fois plus rapide que la barque du joueur : on ne la sème qu'en passant là où elle ne passe pas (hauts-fonds de moins de 0,60 m, allées du village lacustre de moins de 3,5 m de large, jacinthes). Son sillage secoue les pirogues.

## Places et chargement
- Places : 6.
- Chargement : Pilote + 5 agents.

## Solidité
- Coefficient de solidité : **0,60** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 14 points de dégâts sur 100 ; à sa vitesse maximale = 22 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,6. Elle n'éperonne pas : elle se met en travers, projecteur braqué, et les agents ordonnent de couper le moteur.

## Couleurs
- Police et douane : coque bleu nuit `1e2a33`, superstructure blanche `f4f1ea`, bande oblique jaune `fcd116`.
- Version civile : blanc `f4f1ea`, liseré crème `f2e6d0`, sièges bruns.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_vedette_police.glb` | Base, mot « POLICE » |
| `vehicule_vedette_douane.glb` | Mot « DOUANE », bande verte `008751` |
| `vehicule_vedette_fortune.glb` | Civile, blanche, banquette arrière, sans feux bleus |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Défenses cylindriques blanches, bouée de sauvetage orange sur la console.
- Projecteur orientable et gyrophare bleu sur l'arceau.
- Agents en gilet de sauvetage orange par-dessus l'uniforme bleu nuit.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Pirogue, petit bateau » de `docs/style_graphique.md` : 3 000 triangles au plus en détail fin, 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 3 000 |
| Niveau 1 (environ 50 %) | 1 500 |
| Niveau 2, vu de loin (environ 15 %) | 450 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `coque`, `moteur_g`, `moteur_d` (pivotent ensemble), `console`, `arceau`, `projecteur` (pivot), `gyrophare`, `vitres`.
- Ligne de flottaison à la hauteur 0.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `hors_bord_gros` (deux gros hors-bord, grondement grave), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_hors_bord_gros_demarre.ogg`, `bruit_moteur_hors_bord_gros_ralenti.ogg` (boucle), `bruit_moteur_hors_bord_gros_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_hors_bord_gros_coupe.ogg`.
- `bruit_bateau_choc_bois.ogg` : choc de coque ; `bruit_moteur_cale.ogg` : moteur qui cale.
- `bruit_sirene_police_eau.ogg` : coups de corne brefs.
- `voix_police_megaphone_eau_01.ogg` à `_02` : « Coupez le moteur ! ».
- `bruit_eau_sillage.ogg` (partagé).

## Consigne de génération 3D (à copier telle quelle)
> A fast rigid-hull patrol boat, 9.5 meters long, with a fictional police livery: deep-V dark navy blue hull, white center console with a windshield and a hard top, a diagonal yellow stripe on the hull, a rear arch carrying a blue beacon, a searchlight and antennas, two outboard engines, white cylindrical fenders, an orange lifebuoy. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 9.50 m long, 2.80 m wide, 2.60 m high. About 3000 triangles, clean closed topology, at most three materials (body paint, glass, details), hull, engine and cargo as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
