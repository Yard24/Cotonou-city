# Moto de police

Tâche T2283 · fichier modèle `assets/modeles/vehicules/vehicule_moto_police_<variante>.glb` · ligne de budget « Moto, zémidjan (avec conducteur) ».

## Rôle dans le jeu
Première réponse motorisée de la police (étoiles 1 à 3 : « agent à pied ou à moto », décision 73). Elle suit le joueur dans les embouteillages, là où les voitures de patrouille restent bloquées.

## Où on le croise à Cotonou
Postée aux grands carrefours (Étoile Rouge, entrées des ponts, Place de l'Amazone), devant le commissariat ; en escorte de la voiture officielle.

- Présence selon les chapitres : Tous les chapitres.
- Part dans la circulation : poids de tirage 1 sur un total de 126,1 (voir `tableau.md`), soit environ 0,8 % des véhicules qui roulent.
- Pilotable par le joueur : Non : véhicule de l'IA (choix d'agent, voir tableau). Aucune mission ne demande de la conduire.

## Dimensions et masse
| Mesure | Valeur |
|---|---|
| Longueur | 2,15 m |
| Largeur | 0,85 m |
| Hauteur | 1,35 m |
| Masse à vide | 190 kg |
| Boîte de collision propre au véhicule (quand le code en aura une par modèle) | 2,15 × 0,85 × 1,35 m, origine au sol (ou à la ligne de flottaison), au centre |

Hauteur prise au sommet du pare-brise ; selle à 0,80 m ; roues de 0,64 m ; deux sacoches rigides de 0,45 × 0,20 × 0,30 m ; mât de gyrophare arrière à 1,30 m.

## Vitesse, accélération, maniabilité
| Réglage | Valeur |
|---|---|
| Vitesse maximale | 125 km/h (34,7 m/s) |
| Accélération au démarrage | 20 m/s² (elle diminue en approchant de la vitesse maximale, comme pour la moto et la voiture actuelles) |
| Temps indicatif pour atteindre 50 km/h | 0,9 s |
| Freinage | 24 m/s² |
| Marche arrière | 5 km/h au plus |
| Rayon de braquage minimal | 2,6 m |
| Maniabilité | 4 / 5 |

Plus rapide que toutes les motos du joueur sauf en accélération pure ; lourde, elle élargit ses virages (se couche à 80 % de la vitesse de la moto de référence). Le joueur la sème dans les vons et les marchés, pas sur les boulevards.

## Places et chargement
- Places : 2.
- Chargement : 1 agent, ou 2 agents en patrouille.

## Solidité
- Coefficient de solidité : **0,80** (les dégâts reçus selon le barème validé de `docs/systemes/conduite_voiture.md` sont multipliés par ce nombre ; 1,00 = voiture de référence).
- Repères : mur de face à 50 km/h = 18 points de dégâts sur 100 ; à sa vitesse maximale = 61 points. Rien en dessous de 18 km/h perdus d'un coup.
- Jamais d'explosion ni d'incendie (décision 57) ; à 100 de dégâts il avance encore, au ralenti.
- Dégâts reçus × 0,8. L'agent ne tombe qu'à 30 km/h perdus d'un coup, se relève et poursuit à pied.

## Couleurs
- Bleu nuit `1e2a33` et blanc `f4f1ea` (couleurs de l'uniforme inventé, décision 45).
- Bande réfléchissante jaune `fcd116` sur les sacoches ; gyrophare bleu `2a86b5`.
- Règle du style : pas plus de 3 couleurs vives sur un même exemplaire.

## Variantes
| Fichier | Description |
|---|---|
| `vehicule_moto_police_patrouille.glb` | Base, 1 agent |
| `vehicule_moto_police_escorte.glb` | 2 feux à éclats à l'avant, gants blancs de l'agent |

Les simples changements de teinte ne demandent pas de nouveau fichier : le code change la couleur de la matière `peinture`.

## Détails visuels typiques du Bénin
- Écusson fictif (bouclier simple, sans texte réel) sur le réservoir ; mot « POLICE » en texture sur les sacoches.
- Agent en uniforme bleu nuit, casque blanc, gilet réfléchissant aux heures de pointe.
- Aucune marque ni modèle réel : pas de logo, pas de calandre reconnaissable ; les inscriptions sont des noms inventés ou des mots communs. Plaque d'immatriculation de format inventé (2 lettres, 4 chiffres), texture commune à tous les véhicules.

## Budget de polygones
Ligne « Moto, zémidjan (avec conducteur) » de `docs/style_graphique.md` : 5 000 triangles au plus en détail fin, 900 vu de loin.

| Niveau | Triangles |
|---|---|
| Détail fin | 5 000 |
| Niveau 1 (environ 50 %) | 2 500 |
| Niveau 2, vu de loin (environ 15 %) | 750 |

- Répartition du détail fin : 3 200 triangles pour la moto, 1 800 pour son conducteur (le budget de la ligne s'entend conducteur compris).
- 3 matières au plus : `peinture` (teinte principale, changée par le code), `vitres` (`3c4b57`), `details` (tout le reste : une texture-palette de 512 px qui porte les aplats, la plaque et les inscriptions).
- Arêtes franches, pas de lissage ; pas de texture photo.

## Pièces à séparer
- `corps` : cadre, réservoir, selle, moteur et échappement soudés.
- `roue_av`, `roue_ar` : elles tournent et penchent avec la moto.
- `fourche` : fourche, guidon et phare ensemble (pivot de direction, plongée au freinage).
- `bequille` : repliée en roulant, dépliée à l'arrêt (moto penchée de 8°).
- `phare`, `feu_ar` : petites pièces à matière émissive (pour les allumer ou les casser).
- `agent` séparé.
- `gyrophare` séparé (matière émissive, clignote par code).
- `sacoche_g`, `sacoche_d` (soudées au corps au niveau de détail 2).
- Chaque pièce mobile a son origine sur son axe de rotation. Échelle : 1 unité = 1 m, Y vers le haut, avant du véhicule vers +Z (comme dans `scripts/car.gd`).

## Sons nécessaires
Format `.ogg`, dans `assets/sons/bruitages/` (voix dans `assets/sons/voix/`).
- Moteur, famille `moto_grosse` (moto plus grave et plus ronde), partagée avec d'autres véhicules (voir `tableau.md`) : `bruit_moteur_moto_grosse_demarre.ogg`, `bruit_moteur_moto_grosse_ralenti.ogg` (boucle), `bruit_moteur_moto_grosse_accel.ogg` (boucle dont la hauteur suit la vitesse), `bruit_moteur_moto_grosse_coupe.ogg`.
- Klaxon : `bruit_klaxon_moto.ogg`, joué rarement par la circulation (décision 59).
- Partagés par tous les véhicules à roues : `bruit_frein_crisse.ogg`, `bruit_roulement_bitume.ogg` et `bruit_roulement_terre.ogg` (boucles), `bruit_choc_tole_leger.ogg`, `bruit_choc_tole_fort.ogg`, `bruit_moteur_abime.ogg` (cliquetis ajouté à partir de 80 de dégâts).
- Partagés par les deux-roues : `bruit_moto_bequille.ogg`, `bruit_moto_chute.ogg` (glissade et choc au sol).
- `bruit_sirene_police_moto.ogg` : sirène courte deux tons (boucle).
- `bruit_sifflet_agent.ogg`.

## Consigne de génération 3D (à copier telle quelle)
> A police patrol motorcycle with a fictional livery: mid-size touring motorcycle in dark navy blue and white, short clear windshield, two rigid white side cases with a yellow reflective stripe, a blue beacon on a short pole at the rear, two small flashing lights at the front, crash bars around the engine, plain shield emblem without any text. Stylized low-poly game asset with flat solid colors, hard edges and simple readable volumes, warm West African city setting. No photo textures, no logos, no brand names, no manufacturer badges, no readable text. Real-world scale: 2.15 m long, 0.85 m wide, 1.35 m high. About 5000 triangles, clean closed topology, at most three materials (body paint, glass, details), wheels, front fork with handlebar, and any cargo as separate objects, no rider. Y axis up, front facing +Z, origin on the ground at the center of the model.

Après génération : vérifier les dimensions, renommer les pièces comme ci-dessus, produire les deux niveaux allégés, puis exporter en `.glb`.
