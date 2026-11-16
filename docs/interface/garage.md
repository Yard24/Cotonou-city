# Garage — maquette

- Tâche : T5196 (« Garage : dessiner la maquette »).
- Image : `garage.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Entretenir et choisir ses véhicules : réparer, faire le plein, améliorer, repeindre, sortir avec un autre véhicule.

## Quand il s'affiche
En jeu, touche E devant un garage (icône `carte_garage.svg`), à pied ou sur un véhicule. Le jeu est en pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 123 × 53 | « Garage » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Sous-titre de l'écran | 48, 120 | 221 × 22 | « Atelier de Romaric · Ganhi » | Barlow Regular 20, gris clair. |
| 5 | Argent du joueur | 1105, 63 | 127 × 33 | « 12 450 FCFA » | Barlow Condensed Bold 30, vert clair 8df59a, aligné à droite. |
| 6 | Ligne « Moto de Romaric » | 48, 168 | 344 × 60 | « Moto de Romaric / Prêtée · 125 cm³ » | Nom Barlow Condensed SemiBold 22, état Barlow Regular 16. État montré : sélectionnée. |
| 7 | Ligne « Tricycle de livraison » | 48, 236 | 344 × 60 | « Tricycle de livraison / À acheter : 650 000 FCFA » | Nom Barlow Condensed SemiBold 22, état Barlow Regular 16. |
| 8 | Ligne « Berline « Lagune » » | 48, 304 | 344 × 60 | « Berline « Lagune » / À acheter : 1 800 000 FCFA » | Nom Barlow Condensed SemiBold 22, état Barlow Regular 16. |
| 9 | Vue du véhicule | 416, 168 | 432 × 300 | — | Fenêtre 3D (`SubViewport`) : le véhicule tourne lentement (20° par seconde) ; la maquette montre une moto dessinée. |
| 10 | Panneau des caractéristiques | 416, 484 | 432 × 156 | — | Panneau brun, coins arrondis 8, bord 1,5. |
| 11 | Jauge « État » | 440, 504 | 384 × 34 | « État : 62 % » | Libellé Barlow Regular 18, valeur Barlow SemiBold 18 à droite, barre 8 de haut (rail 6b4a30). |
| 12 | Jauge « Carburant » | 440, 548 | 384 × 34 | « Carburant : 3,5 l sur 10 » | Libellé Barlow Regular 18, valeur Barlow SemiBold 18 à droite, barre 8 de haut (rail 6b4a30). |
| 13 | Jauge « Vitesse maximale » | 440, 592 | 384 × 34 | « Vitesse maximale : 85 km/h » | Libellé Barlow Regular 18, valeur Barlow SemiBold 18 à droite, barre 8 de haut (rail 6b4a30). |
| 14 | Bouton « Réparer » | 872, 168 | 360 × 48 | « Réparer — 1 900 FCFA » | Remet l'état à 100 %. Prix : 50 FCFA par point manquant. État montré : sélectionné. |
| 15 | Bouton « Faire le plein » | 872, 224 | 360 × 48 | « Faire le plein — 3 250 FCFA » | Essence de station, 500 FCFA le litre. |
| 16 | Bouton « Améliorer » | 872, 280 | 360 × 48 | « Améliorer » | Ouvre la liste : moteur, freins, pneus. |
| 17 | Bouton « Repeindre » | 872, 336 | 360 × 48 | « Repeindre — 5 000 FCFA » | Ouvre le choix de 8 couleurs. |
| 18 | Bouton « Sortir avec ce véhicule » | 872, 392 | 360 × 48 | « Sortir avec ce véhicule » | Ferme le garage, Koffi sur le véhicule devant l'atelier. |
| 19 | Réplique de Romaric | 872, 461 | 360 × 45 | « « Les freins, c'est comme les amis : tu vois leur valeur quand ils lâchent. » — Romaric » | Barlow Regular 18, jaune pâle ; une réplique tirée au hasard à l'ouverture. |
| 20 | Barre d'aide | 0, 664 | 1280 × 56 | « [Gauche] [Droite] Liste ou actions · [Haut] [Bas] Choisir · [Entrée] Valider · [Échap] Sortir » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Passer de la liste des véhicules aux actions | Flèches gauche et droite, ou Q et D | Survol | Croix ou stick gauche, gauche et droite |
| Changer de ligne | Flèches haut et bas, ou Z et S | Survol ; molette pour faire défiler | Croix ou stick gauche, haut et bas |
| Valider | Entrée ou Espace | Clic gauche | A |
| Tourner le véhicule | — | Glisser dans la vue | Stick droit |
| Sortir | Échap | Clic droit | B |

## Enchaînements
- « Réparer », « Faire le plein » : paiement immédiat, les jauges se remplissent en 0,6 s, l'écran reste ouvert.
- « Améliorer » et « Repeindre » : sous-listes dans la colonne de droite ; Retour revient aux cinq boutons.
- « Sortir avec ce véhicule » ou Échap : retour au jeu.
- Un véhicule « À acheter » remplace les cinq boutons par « Acheter » (confirmation « Acheter ce véhicule ? »).

## Règles et états
- Un bouton dont le prix dépasse l'argent est grisé, prix en rouge e8112d.
- « Réparer » est grisé à 100 % d'état, « Faire le plein » quand le réservoir est plein.
- On garde ses véhicules après une arrestation (décision 76).
- Les noms de véhicules sont inventés, sans marque (décision 25). Pas d'explosion ni de véhicule détruit : l'état minimal est 0 %, le véhicule ne démarre plus et le garage le récupère pour 2 000 FCFA.

## Améliorations (liste ouverte par « Améliorer », à la place des cinq boutons)
| Amélioration | Niveaux | Prix par niveau (moto) | Effet par niveau |
|---|---|---|---|
| Moteur | 3 | 15 000, 30 000, 60 000 FCFA | +5 % de vitesse maximale et d'accélération |
| Freins | 3 | 8 000, 16 000, 32 000 FCFA | −8 % de distance de freinage |
| Pneus | 3 | 10 000, 20 000, 40 000 FCFA | +6 % d'adhérence, surtout sous la pluie |

Prix × 3 pour une voiture, × 5 pour un camion. Chiffres proposés, à caler avec `docs/systemes/`. Un véhicule prêté (la moto de Romaric au chapitre 1) ne peut être ni amélioré ni repeint : ces boutons sont grisés avec « Ce n'est pas ta moto ».

## Répliques de Romaric (une au hasard)
1. « Les freins, c'est comme les amis : tu vois leur valeur quand ils lâchent. »
2. « Tu me la ramènes rayée, tu me la ramènes payée. »
3. « Le kpayo, c'est bon pour ta poche, pas pour mon carburateur. »
4. « Elle tousse ? C'est toi qui conduis comme à Lagos. »

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Vue 3D : `SubViewportContainer` 432 × 300 avec sa propre caméra et le modèle du véhicule.
- État et carburant viennent des champs existants des scripts `car.gd` et `moto.gd`.
