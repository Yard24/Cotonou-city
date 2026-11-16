# Petit avion

Tâche T2423 · fichier modèle `assets/modeles/vehicules/vehicule_petit_avion_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Monomoteur à hélice de 4 places (aéroclub, avion-taxi, épandage). Décor de l'aéroport et du ciel ; au chapitre 4, Monsieur Fortuné en descend lors d'une scène écrite. Non pilotable (décision 56).

## Où on le croise à Cotonou
Hangar et parking de l'aviation légère à l'aéroport ; un passage par heure de jeu le long de la côte à 300 m d'altitude, avec banderole en variante.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Non (décision 56).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 8,30 m |
| Largeur | 11,00 m |
| Hauteur | 2,70 m |
| Masse à vide | 800 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 8,30 × 11,00 × 2,70 m, origine au sol (ou à la ligne de flottaison), au centre |

Largeur = envergure. Aile haute haubanée ; cabine de 1,10 m de large à 2 portes ; hélice bipale de 1,90 m ; train tricycle fixe caréné (voie 2,60 m).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 220 km/h (61,1 m/s) |
| Accélération au démarrage | 2,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 3 m/s² |
| Marche arrière | aucune |
| Rayon de braquage minimal | 10,0 m |
| Maniabilité | 1 / 5 |

Animé sur trajectoire : décollage à 100 km/h en 300 m, croisière de décor à 180 km/h, virages inclinés à 25°.

## Places et chargement
- Places : 4.
- Chargement : Pilote + 3 passagers ; 1 100 kg au décollage.

## Solidité
- Sans objet en vol. Au parking : obstacle fixe ; le percuter donne 1 étoile et ne l'abîme pas visiblement.

## Couleurs
- Blanc `f4f1ea` avec deux filets de couleur le long du fuselage (bleu `2a86b5` et rouge `e8112d`, ou vert et jaune).
- Carénages de roues blancs, hélice noire.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_petit_avion_blanc.glb` | Base, au parking, amarré par 3 cordes |
| `vehicule_petit_avion_vol.glb` | Hélice remplacée par un disque translucide |
| `vehicule_petit_avion_banderole.glb` | Tire une banderole de 12 × 1,5 m portant une fausse publicité (marque inventée), le long de la plage |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Cales jaunes sous les roues, housse grise sur le pare-brise contre le soleil.
- Manche à air rouge et blanche à côté du hangar (objet séparé).
- Immatriculation fictive de 5 lettres.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 6 000 |
| Niveau 1 (environ 50 %) | 3 000 |
| Niveau 2, vu de loin (environ 15 %) | 900 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `fuselage`, `helice`, `disque_helice`, `porte_g`, `porte_d`, `roue_av`, `roue_g`, `roue_d`, `volets`, `banderole` (ondule par code).
- Hors tableau du style : compté sur la ligne « voiture » avec un plafond de 6 000 triangles.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_petit_avion_moteur.ogg` : moteur à pistons (boucle, hauteur selon le régime).
- `bruit_petit_avion_survol.ogg` : passage (8 s).

## Consigne de génération 3D (à copier telle quelle)
> A small single-engine four-seat high-wing light aircraft: white fuselage with a blue and a red pinstripe along the sides, straight braced high wing with two struts, two-blade propeller, fixed tricycle landing gear with streamlined wheel fairings, two cabin doors, large side windows. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 8.30 m long, 11.00 m wide, 2.70 m high. About 6000 triangles, clean closed topology, at most three materials (body paint, glass, details), propellers or rotors, landing gear and doors as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
