# Voiture de sport

Tâche T2323 · fichier modèle `assets/modeles/vehicules/vehicule_sport_<variante>.glb` · ligne de budget « Voiture, taxi ».

## Rôle dans le jeu
Voiture la plus rapide du jeu. Très rare : celle d'un fils de famille à Fidjrossè, puis récompense de fin de jeu (branche « vendre » de la décision 98). Sert à deux missions de vitesse sur le boulevard de la Marina.

## Où on le croise à Cotonou
Devant les restaurants de plage de Fidjrossè le soir, parking de l'hôtel fictif de la Marina, garage de luxe fictif de Ganhi (vitrine).

- Présence selon les chapitres : Visible à partir du chapitre 3 (1 exemplaire), achetable au chapitre 6.
- Part dans la circulation : poids de tirage 0,3 sur un total de 126,1 (voir `tableau.md`), soit environ 0,2 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55, famille « voiture »).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 4,30 m |
| Largeur | 1,90 m |
| Hauteur | 1,22 m |
| Masse à vide | 1 300 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 4,30 × 1,90 × 1,22 m, origine au sol (ou à la ligne de flottaison), au centre |

Coupé 2 portes très bas ; empattement 2,50 m ; roues larges de 0,68 m (0,26 m de large à l'arrière) ; garde au sol 0,10 m ; aileron arrière discret.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 165 km/h (45,8 m/s) |
| Accélération au démarrage | 22 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 0,8 s |
| Freinage | 34 m/s² |
| Marche arrière | 30 km/h au plus |
| Rayon de braquage minimal | 5,5 m |
| Maniabilité | 5 / 5 |

Braquage 110 % de la référence et seulement 35 % de braquage perdu à pleine vitesse. Inutilisable hors bitume : sur terre et sable, vitesse −40 % ; les trottoirs et dos-d'âne pris à plus de 30 km/h abîment le dessous (5 points).

## Places et chargement
- Places : 2.
- Chargement : 2 personnes, 1 petit colis.

## Solidité
- Coefficient de solidité : **1,20** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 28 points de dégâts sur 100 ; à sa vitesse maximale = 100 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 1,2 : la plus chère à réparer.

## Couleurs
- Jaune vif `fcd116`, rouge `e8112d` ou bleu `2a86b5` (une seule couleur vive), toit et bas de caisse noirs `1e2a33`.
- Jantes noires, étriers rouges.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_sport_jaune.glb` | Base |
| `vehicule_sport_rouge.glb` | Exemplaire du fils de famille, bandes blanches |
| `vehicule_sport_koffi.glb` | Récompense : vert `008751`, liseré jaune |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Seule voiture sans poussière ni rayure ; on la voit toujours entourée de curieux quand elle est garée (3 passants qui regardent).
- Plaque temporaire en carton derrière le pare-brise (voiture tout juste importée).
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
- 2 portes seulement ; `aileron` soudé au corps.
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `sport` (moteur rauque qui monte haut dans les tours), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_sport_demarre.ogg`, `bruit_moteur_sport_ralenti.ogg` (boucle), `bruit_moteur_sport_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_sport_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_sport_retour_flamme.ogg` : claquements d'échappement au lever de pied.

## Consigne de génération 3D (à copier telle quelle)
> A low two-door mid-engine sports coupe: wide wedge-shaped body in bright yellow with a black roof, very low nose, large side air intakes, wide rear tires on black alloy wheels, a small rear spoiler, twin central exhaust tips, slim headlights. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 4.30 m long, 1.90 m wide, 1.22 m high. About 8000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
