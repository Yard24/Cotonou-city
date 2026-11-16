# Avion de ligne régional

Tâche T2413 · fichier modèle `assets/modeles/vehicules/vehicule_avion_regional_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Avion à hélices de 70 places : il fait l'aller-retour Cotonou-Parakou, qui sert de voyage rapide (décision 56). Non pilotable. On le voit au parking, au décollage et en approche au-dessus de la plage de Fidjrossè, 4 fois par journée de jeu.

## Où on le croise à Cotonou
Aéroport (parking devant l'aérogare, piste parallèle à la mer), ciel au-dessus de Fidjrossè et de la mer en approche à basse altitude.

- Présence selon les chapitres : Voyage rapide disponible quand Parakou existe (décision 87) ; décor dès le chapitre 1. Vols suspendus au chapitre 3.
- Part dans la circulation : aucune, il ne fait pas partie de la circulation routière tirée au hasard (placé à la main ou sur l'eau, dans le ciel, dans une enceinte).
- Pilotable par le joueur : Non (décision 56).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 27,00 m |
| Largeur | 27,00 m |
| Hauteur | 7,60 m |
| Masse à vide | 13 000 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 27,00 × 27,00 × 7,60 m, origine au sol (ou à la ligne de flottaison), au centre |

Largeur = envergure. Fuselage de 2,80 m de diamètre ; aile haute ; 2 moteurs à hélices de 6 pales, 3,90 m de diamètre ; empennage en T ; train tricycle (voie 4,10 m) ; porte passagers à l'arrière gauche avec escalier intégré (1,80 × 0,75 m) ; soute à l'avant droit.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 500 km/h (138,9 m/s) |
| Accélération au démarrage | 2,5 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Freinage | 3 m/s² |
| Marche arrière | aucune |
| Rayon de braquage minimal | 20,0 m |
| Maniabilité | 1 / 5 |

Entièrement animé sur une trajectoire fixe : roulage à 30 km/h, décollage à 210 km/h après 1 000 m de piste (ramenés à 600 m sur la carte condensée), montée à 8°, approche à 220 km/h sur une pente de 3°. Les 500 km/h de croisière ne sont jamais montrés.

## Places et chargement
- Places : 74 (4 d'équipage + 70).
- Chargement : 2 pilotes + 2 membres d'équipage + 70 passagers ; 22 000 kg au décollage.

## Solidité
- Sans objet : aucune collision possible avec l'avion en mouvement (la piste est clôturée ; une intrusion donne 2 étoiles). Au parking, c'est un obstacle fixe indestructible.

## Couleurs
- Compagnie inventée : fuselage blanc `f4f1ea`, dérive verte `008751` avec un disque jaune `fcd116`, fin liseré rouge `e8112d` le long des hublots.
- Dessous gris clair `d6d0c4`, hélices noires à bouts jaunes.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_avion_regional_parking.glb` | Portes ouvertes, escalier déployé, cales et cônes |
| `vehicule_avion_regional_vol.glb` | Train rentré, hélices remplacées par des disques translucides |
| `vehicule_avion_regional_roulage.glb` | Train sorti, hélices en disques, feux allumés |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Passagers qui marchent sur le tarmac entre l'aérogare et l'avion, en file, sous le soleil.
- Chariot à bagages tiré par un petit tracteur, groupe électrogène jaune, camion-citerne aéroport (variante « eau » du camion-citerne repeinte).
- Nom de compagnie inventé en texture : « Air Littoral ». Immatriculation fictive de 5 lettres sans préfixe de pays réel.
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
- `fuselage`, `helice_g`, `helice_d` (tournent), `disque_helice_g`, `disque_helice_d` (affichés à la place des pales en rotation), `train_av`, `train_g`, `train_d` (rentrent), `porte_passagers`, `porte_soute`, `volets`, `gouverne_direction`.
- Hors tableau du style : compté sur la ligne « bus, camion » (10 000 triangles). Vu de plus de 300 m, seul le niveau le plus léger (1 500) est affiché.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- `bruit_avion_turboprop_ralenti.ogg` : sifflement et hélices au sol (boucle).
- `bruit_avion_turboprop_decollage.ogg` : plein régime (20 s).
- `bruit_avion_survol.ogg` : passage au-dessus de la plage (12 s, avec effet de distance).
- `bruit_aerogare_annonce_01.ogg` à `_03` : carillon et annonce d'embarquement pour Parakou.

## Consigne de génération 3D (à copier telle quelle)
> A twin-engine turboprop regional airliner with about 70 seats: slim white fuselage with a row of small round-cornered windows and a thin red line along them, high-mounted straight wing carrying two engines with six-blade propellers, tall T-shaped tail painted green with a plain yellow disc, tricycle landing gear, rear passenger door with built-in stairs, no airline name. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 27.00 m long, 27.00 m wide, 7.60 m high. About 10000 triangles, clean closed topology, at most three materials (body paint, glass, details), propellers or rotors, landing gear and doors as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
