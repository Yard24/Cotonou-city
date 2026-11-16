# Camionnette de livraison

Tâche T2213 · fichier modèle `assets/modeles/vehicules/vehicule_camionnette_<variante>.glb` · ligne de budget « Bus, camion ».

## Rôle dans le jeu
Fourgon tôlé : premier vrai véhicule de l'entreprise de Koffi (« premiers véhicules achetés », chapitre 4, décision 96). Livraisons chronométrées (décision 103), marchandises du port, colis fragiles.

## Où on le croise à Cotonou
Entrepôts du port et d'Akpakpa, arrière des boutiques de Ganhi, Dantokpa côté grossistes, entrepôt du joueur (décision 69).

- Présence selon les chapitres : Circulation dès le chapitre 1 ; achetée par le joueur au chapitre 4.
- Part dans la circulation : poids de tirage 3 sur un total de 126,1 (voir `tableau.md`), soit environ 2,4 % des véhicules qui roulent.
- Pilotable par le joueur : Oui (décision 55).

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 5,00 m |
| Largeur | 1,90 m |
| Hauteur | 2,20 m |
| Masse à vide | 1 900 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 5,00 × 1,90 × 2,20 m, origine au sol (ou à la ligne de flottaison), au centre |

Fourgon à capot court ; empattement 3,00 m ; roues de 0,70 m ; volume utile 2,60 × 1,60 × 1,50 m (6 m³) ; porte latérale coulissante à droite, deux portes arrière battantes (ouverture 1,45 × 1,40 m, seuil à 0,55 m).

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 105 km/h (29,2 m/s) |
| Accélération au démarrage | 10 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 1,8 s |
| Freinage | 24 m/s² |
| Marche arrière | 25 km/h au plus |
| Rayon de braquage minimal | 6,0 m |
| Maniabilité | 3 / 5 |

Braquage 85 % de la référence. Pas de vision arrière en vue intérieure (cloison pleine). Chargée : accélération −20 %, freinage −15 %. Les colis fragiles se cassent au-delà de 12 m/s² de freinage ou de choc.

## Places et chargement
- Places : 3.
- Chargement : 3 en cabine ; 1 200 kg ou 30 colis moyens.

## Solidité
- Coefficient de solidité : **0,85** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 20 points de dégâts sur 100 ; à sa vitesse maximale = 53 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,85.

## Couleurs
- Blanc `f4f1ea` (courant), bleu `2a86b5`, jaune pâle `f0dc8a`.
- Flotte de Koffi : vert `008751` avec bande jaune `fcd116` et nom de l'entreprise (texte laissé au choix du joueur ou de l'histoire).
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_camionnette_blanche.glb` | Base, sans marquage |
| `vehicule_camionnette_koffi.glb` | Livrée de l'entreprise du joueur |
| `vehicule_camionnette_boulangerie.glb` | Enseigne inventée « Pain Doré du Littoral », épi de blé stylisé |
| `vehicule_camionnette_frigo.glb` | Groupe froid sur le toit de la cabine, caisse isotherme |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Numéro de téléphone fictif au pochoir sur les flancs, « Location – Déménagement – Livraison ».
- Portes arrière fermées par un cadenas, bandes rouges et blanches peintes sur le pare-chocs.
- Apprenti assis à côté du chauffeur, coude à la fenêtre.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Bus, camion » de `docs/style_graphique.md` : 10 000 triangles au plus en détail fin, 1 500 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 8 500 |
| Niveau 1 (environ 50 %) | 4 250 |
| Niveau 2, vu de loin (environ 15 %) | 1 280 |

- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cabine, caisse et châssis soudés.
- Roues : `roue_avg`, `roue_avd`, `roue_arg`, `roue_ard` (sauf indication contraire plus bas) ; les roues avant pivotent.
- Portes de cabine : `porte_avg`, `porte_avd` (sauf indication contraire plus bas).
- `vitres` : un seul objet, matière à part.
- `phare_g`, `phare_d`, `feu_g`, `feu_d`, `parechoc_av`, `parechoc_ar` : comme sur les voitures.
- Intérieur de cabine simplifié pour la vue intérieure (décision 62) : `volant` séparé, sièges et tableau de bord soudés, 800 triangles au plus.
- `porte_avg`, `porte_avd`, `porte_coulissante`, `porte_ar_g`, `porte_ar_d`, `chargement` (colis visibles portes ouvertes).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `diesel_leger` (diesel de camionnette, claquant au ralenti), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_diesel_leger_demarre.ogg`, `bruit_moteur_diesel_leger_ralenti.ogg` (boucle), `bruit_moteur_diesel_leger_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_diesel_leger_coupe.ogg`.
- Klaxon : `bruit_klaxon_voiture.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les véhicules à portes : `bruit_portiere_ouvre.ogg`, `bruit_portiere_ferme.ogg`, `bruit_clignotant.ogg`.
- `bruit_porte_coulissante.ogg` (partagé).
- `bruit_colis_glisse.ogg` : chargement qui bouge.
- `bruit_bip_recul.ogg` : bip de marche arrière.

## Consigne de génération 3D (à copier telle quelle)
> A mid-size white panel delivery van: short sloping hood, tall windowless cargo body, a sliding side door on the right, two rear barn doors, black plastic bumpers with red and white painted strips, steel wheels, a plain white unmarked body. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 5.00 m long, 1.90 m wide, 2.20 m high. About 8500 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, doors, hood, trunk or tailgate and window glass as separate objects. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
