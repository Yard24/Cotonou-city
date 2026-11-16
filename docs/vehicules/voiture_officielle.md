# Voiture officielle

Tâche T2313 · fichier modèle `assets/modeles/vehicules/vehicule_officielle_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Grande berline noire de l'administration (décision 17 : douane, mairie, police ; aucun élu). Elle passe en convoi, escortée de motos de police, et bloque brièvement un carrefour : événement de circulation et prétexte de missions (livrer un pli, ne surtout pas la rayer).

## Où on le croise à Cotonou
Ganhi (quartier administratif), boulevard de la Marina, aéroport, direction du port.

- Présence selon les chapitres : Tous les chapitres ; convois plus fréquents au chapitre 4 (inaugurations de chantiers, sans personnage politique).
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA et de scènes écrites. La toucher à moins de 50 m de son escorte donne 1 étoile.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,95 m |
| Largeur | 1,88 m |
| Hauteur | 1,47 m |
| Masse à vide | 1 800 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,95 × 1,88 × 1,47 m, origine au sol (ou à la ligne de flottaison), au centre |

Grande tricorps statutaire ; empattement 2,95 m ; roues de 0,70 m ; porte-fanion sur l'aile avant droite (tige de 0,30 m, fanion uni sans emblème).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 135 km/h (37,5 m/s) |
| Accélération au démarrage | 15 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,2 s |
| Freinage | 30 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 5,9 m |
| Maniabilité | 3 / 5 |

En convoi : 50 km/h constants, ne s'arrête pas aux carrefours (l'escorte bloque la circulation 10 secondes).

## Places et chargement
- Places : 5.
- Chargement : Chauffeur + 4.

## Solidité
- Coefficient de solidité : **0,85** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 20 points de dégâts sur 100 ; à sa vitesse maximale = 71 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,85.

## Couleurs
- Noir brillant `1e2a33` uniquement.
- Baguettes et calandre gris clair `d6d0c4`, vitres arrière très sombres.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_officielle_noire.glb` | Base |
| `vehicule_officielle_convoi.glb` | Fanion uni vert `008751` sur l'aile, feux à éclats bleus derrière la calandre |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Plaque d'immatriculation de couleur différente des voitures privées (fond bleu, chiffres blancs, format inventé).
- Rideaux plissés aux vitres arrière, chauffeur en costume sombre.
- Journal plié sur la plage arrière.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Voiture, taxi » de `docs/style_graphique.md` : 8 000 triangles au plus en détail fin, 1 200 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 8 000 |
| Niveau 1 (environ 50 %) | 4 000 |
| Niveau 2, vu de loin (environ 15 %) | 1 200 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : caisse, toit et planche de bord soudés.
- `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` : origine au centre de la roue ; les roues avant pivotent.
- Portes : `porte_avg`, `porte_avd`, `porte_arg`, `porte_ard` (sauf indication contraire plus bas), charnière à l'avant, ouverture de 65°.
- `capot` et `coffre` : ils se plient à 25 de dégâts (choc avant ou arrière).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d` : cassables séparément, matière émissive.
- `parechoc_av`, `parechoc_ar` : ils pendent à 50 de dégâts.
- Intérieur simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés au corps, 800 triangles au plus, absents des niveaux allégés.
- `fanion` séparé (flotte par code).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `voiture_recente` (moteur à essence discret), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_voiture_recente_demarre.ogg`, `bruit_moteur_voiture_recente_ralenti.ogg` (boucle), `bruit_moteur_voiture_recente_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_voiture_recente_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sirene_escorte.ogg` : coup de sirène bref de l'escorte.

## Consigne de génération 3D (à copier telle quelle)
> A large formal black executive sedan for government officials: long glossy black four-door body, upright chrome-look grille, very dark tinted rear windows with pleated curtains, a small plain flag on a short pole on the front right fender, multi-spoke alloy wheels, no emblem and no text. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.95 m long, 1.88 m wide, 1.47 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
