# Écran d'hôpital — maquette

- Tâche : T5216 (« Écran d'hôpital : dessiner la maquette »).
- Image : `ecran_d_hopital.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Conclure un évanouissement (santé à zéro) : réveil au centre de santé, soins payants (décision 80). Personne ne meurt.

## Quand il s'affiche
Quand la santé de Koffi tombe à zéro (chute à moto, choc, bagarre, noyade évitée). Ralenti 1 s, fondu au noir 0,5 s, puis cet écran.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 80 % d'opacité, par-dessus l'image du jeu. |
| 3 | Bandeau | 336, 53 | 608 × 106 | « TU T'ES ÉVANOUI » | Barlow Condensed Bold 96, crème, centré. |
| 4 | Filet vert | 520, 154 | 240 × 8 | — | Rectangle vert 1f8a3a (couleur du centre de santé sur la carte). |
| 5 | Lieu et temps passé | 389, 186 | 502 × 26 | « Centre de santé de Dantokpa · 4 heures plus tard » | Barlow Medium 24. |
| 6 | Panneau des soins | 400, 236 | 480 × 236 | — | Panneau brun, coins arrondis 8, bord 1,5. |
| 7 | Mot de l'infirmière | 492, 261 | 356 × 45 | « « Repose-toi un peu, mon fils. La ville sera encore là demain. » » | Barlow Regular 18, jaune pâle ; une phrase au hasard parmi quatre. |
| 8 | Tableau de bilan | 432, 330 | 416 × 124 | « Ton argent : 12 450 FCFA / Soins (10 %) : −1 245 FCFA / Il te reste : 11 205 FCFA » | Lignes de 34 : libellé Barlow Regular 22 à gauche, valeur Barlow SemiBold 22 à droite ; filet ; total en Barlow Condensed Bold 34. |
| 9 | Jauge « Santé » | 400, 494 | 480 × 34 | « Santé : 100 % » | Libellé Barlow Regular 18, valeur Barlow SemiBold 18 à droite, barre 8 de haut (rail 6b4a30). |
| 10 | Bouton « Sortir du centre de santé » | 400, 552 | 480 × 52 | « Sortir du centre de santé » | Retour au jeu. État montré : sélectionné. |
| 11 | Phrase de fin | 490, 621 | 301 × 20 | « Ton véhicule t'attend là où tu l'as laissé. » | Barlow Regular 18, centré. |
| 12 | Barre d'aide | 0, 664 | 1280 × 56 | « [Entrée] Continuer » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Continuer | Entrée ou Espace | Clic sur le bouton | A |
| Aucun retour | Échap ne fait rien | — | B ne fait rien |

## Enchaînements
- « Sortir du centre de santé » : fondu 0,4 s, Koffi devant le centre de santé le plus proche (icône `carte_centre_de_sante.svg`), santé à 100 %, 0 étoile, heure avancée de 4 h ; puis `ecran_de_mission_echouee.md` si une mission était en cours.

## Règles et états
- Vocabulaire : « évanoui », « soins », jamais « mort » (décisions 42 et 53).
- Le bouton apparaît après 1 s.
- Le véhicule reste où il était, avec ses dégâts.
- Compte dans `statistiques.md` (« Passages au centre de santé », « Soins payés »).

## Prix des soins (décision du 16 novembre 2026)
10 % de l'argent du joueur, 2 000 FCFA au plus, rien s'il n'a rien (la ligne devient « Soins : offerts » et le total « Il te reste : 0 FCFA »). En Tranquille : 5 %, 1 000 au plus ; en Corsé : 15 %, 3 000 au plus (proposition de `nouvelle_partie.md`). Arrondi à 5 FCFA.

## Mots de l'infirmière
1. « Repose-toi un peu, mon fils. La ville sera encore là demain. »
2. « Encore toi ? Je vais finir par te garder un lit. »
3. « Le casque, c'est pour la tête. La prudence aussi. »
4. « Mange quelque chose avant de repartir. »

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Reprend la règle déjà codée pour l'évanouissement (10 %, 2 000 FCFA au plus) et lui donne un écran.
