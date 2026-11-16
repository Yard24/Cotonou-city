# Écran d'arrestation — maquette

- Tâche : T5212 (« Écran d'arrestation : dessiner la maquette »).
- Image : `ecran_d_arrestation.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Conclure une arrestation : amende, temps perdu, retour devant le commissariat. On garde ses véhicules (décision 76).

## Quand il s'affiche
Quand un policier rattrape Koffi à pied ou l'immobilise 3 s dans son véhicule. Fondu au noir 0,5 s, puis cet écran sur une image du commissariat le plus proche.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 80 % d'opacité, par-dessus l'image du jeu. |
| 3 | Bandeau | 500, 53 | 281 × 106 | « ARRÊTÉ » | Barlow Condensed Bold 96, crème, centré. |
| 4 | Filet bleu | 520, 154 | 240 × 8 | — | Rectangle bleu 2a86b5 (couleur de la police sur la carte). |
| 5 | Lieu et temps passé | 420, 186 | 440 × 26 | « Commissariat de Ganhi · 3 heures plus tard » | Barlow Medium 24. |
| 6 | Panneau de l'amende | 400, 232 | 480 × 240 | — | Panneau brun, coins arrondis 8, bord 1,5. |
| 7 | Motif | 432, 257 | 357 × 20 | « Motif : conduite dangereuse, refus de s'arrêter » | Barlow Regular 18 ; un ou deux motifs séparés par une virgule. |
| 8 | Étoiles au moment de l'arrestation | 432, 288 | 136 × 24 | — | Cinq étoiles de 22 ; ici 2 pleines. |
| 9 | Tableau de bilan | 432, 330 | 416 × 124 | « Ton argent : 12 450 FCFA / Amende (2 étoiles) : −1 000 FCFA / Il te reste : 11 450 FCFA » | Lignes de 34 : libellé Barlow Regular 22 à gauche, valeur Barlow SemiBold 22 à droite ; filet ; total en Barlow Condensed Bold 34. |
| 10 | Bouton « Payer l'amende » | 400, 492 | 480 × 52 | « Payer l'amende » | Paie et sort du commissariat. État montré : sélectionné. |
| 11 | Bouton « Proposer un petit geste (risqué) » | 400, 552 | 480 × 52 | « Proposer un petit geste (risqué) » | Tente de payer moins ; voir les règles. |
| 12 | Phrase de fin | 366, 621 | 549 × 20 | « Tu gardes tes véhicules. L'adjudant Barnabé te raccompagne à la porte. » | Barlow Regular 18, jaune pâle, centré. |
| 13 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Valider » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Valider | Entrée ou Espace | Clic gauche | A |
| Aucun retour | Échap ne fait rien | — | B ne fait rien |

## Enchaînements
- « Payer l'amende » : fondu 0,4 s, Koffi devant le commissariat, 0 étoile, heure avancée ; puis `ecran_de_mission_echouee.md` si une mission était en cours.
- « Proposer un petit geste » : le panneau affiche le résultat (voir plus bas), puis un bouton unique mène à la même sortie.

## Règles et états
- Pas d'arme, pas de violence montrée : l'écran arrive après un fondu (décision 3).
- Les marchandises illégales transportées (kpayo en gros, faux papiers) sont saisies : une ligne « Marchandise saisie » s'ajoute au bilan, sans montant.
- La santé est remise à 50 % au moins.
- L'arrestation compte dans `statistiques.md` (« Arrestations », « Amendes payées »).

## Barème proposé (à caler avec le système de police ; décisions 73, 76 et 77)
| Étoiles | Amende | Temps passé au poste |
|---|---|---|
| 1 | 500 FCFA | 1 heure de jeu |
| 2 | 1 000 FCFA | 3 heures |
| 3 | 2 500 FCFA | 6 heures |
| 4 | 5 000 FCFA | 12 heures |
| 5 | 10 000 FCFA | 24 heures |

L'amende est multipliée par 0,5 en Tranquille et 1,5 en Corsé, et ne dépasse jamais l'argent du joueur : sans argent, la ligne devient « Amende : tu n'as rien, tu balaies la cour » et le temps passé double.

## « Proposer un petit geste »
- Le geste coûte la moitié de l'amende. L'agent est droit 2 fois sur 3 (toujours droit si c'est l'adjudant Barnabé, décision 38).
- Agent droit : texte « L'agent n'a pas apprécié. L'amende est doublée. » ; l'amende double (décision 77), bouton unique « Payer ».
- Agent qui accepte : texte « L'agent empoche et te laisse filer. » ; le joueur paie la moitié. À la sortie, la radio parlée annonce dans la journée qu'un agent du commissariat a été sanctionné (décision 19 : la corruption est toujours réprimée) et cet agent n'apparaît plus.
- Le bouton est absent si le joueur a moins que la moitié de l'amende.

## Motifs (textes exacts)
« conduite dangereuse », « refus de s'arrêter », « véhicule emprunté sans accord », « bagarre sur la voie publique », « marchandise sans papiers », « passant bousculé ».

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Le point de retour est le commissariat le plus proche (icône `carte_commissariat.svg`).
