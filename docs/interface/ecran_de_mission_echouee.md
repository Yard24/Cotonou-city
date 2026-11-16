# Écran de mission échouée — maquette

- Tâche : T5208 (« Écran de mission échouée : dessiner la maquette »).
- Image : `ecran_de_mission_echouee.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Dire pourquoi la mission a échoué, sans punir, et relancer vite.

## Quand il s'affiche
Dès qu'une condition d'échec est remplie, après 1 s de ralenti. Le jeu est figé, voile à 80 %. Son `bruit_mission_echouee.ogg`.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | Rectangle 140a05 à 80 % d'opacité, par-dessus l'image du jeu. |
| 3 | Bandeau | 317, 111 | 646 × 106 | « MISSION ÉCHOUÉE » | Barlow Condensed Bold 96, rouge e8112d, interlettrage 3, centré. |
| 4 | Filet rouge | 520, 212 | 240 × 8 | — | Rectangle rouge plein (pas de tricolore sur un échec). |
| 5 | Nom de la mission | 520, 240 | 240 × 37 | « La moto de Romaric » | Barlow Condensed SemiBold 34. |
| 6 | Raison de l'échec | 280, 298 | 720 × 26 | « Le client est descendu : tu as mis trop de temps. » | Barlow Medium 24, centré, 2 lignes au plus. |
| 7 | Bouton « Reprendre au dernier point de contrôle » | 400, 372 | 480 × 56 | « Reprendre au dernier point de contrôle » | Recharge le dernier point de contrôle de la mission (décision 101). État montré : sélectionné. |
| 8 | Bouton « Recommencer la mission » | 400, 436 | 480 × 56 | « Recommencer la mission » | Reprend la mission au début. |
| 9 | Bouton « Abandonner » | 400, 500 | 480 × 56 | « Abandonner » | Retour au jeu libre ; la mission reste disponible. |
| 10 | Conseil | 280, 581 | 720 × 20 | « Conseil : à moto, passe entre les voitures arrêtées pour gagner du temps. » | Barlow Regular 18, jaune pâle, lié à la raison de l'échec. |
| 11 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Valider » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Valider | Entrée ou Espace | Clic gauche | A |
| Aucun retour | Échap ne fait rien | — | B ne fait rien |

## Enchaînements
- « Reprendre au dernier point de contrôle » : fondu 0,3 s et reprise, sans écran de chargement.
- « Recommencer la mission » : idem, depuis le début.
- « Abandonner » : retour au jeu, Koffi là où il est ; la mission repasse dans « Disponibles » du journal.
- Si l'échec vient d'une arrestation ou d'un évanouissement, `ecran_d_arrestation.md` ou `ecran_d_hopital.md` passe d'abord, puis cet écran.

## Règles et états
- Sans point de contrôle atteint, le premier bouton est absent et la sélection part sur « Recommencer la mission ».
- L'échec ne coûte ni argent ni récompense future ; l'argent revient à sa valeur du point de contrôle.
- Jamais le mot « mort » ni « tué » (décisions 4 et 42).
- Après trois échecs au même point, une quatrième ligne de conseil propose : « Tu peux passer en difficulté Tranquille pour cette mission. » avec le bouton « Reprendre en Tranquille » (la difficulté de la partie ne change pas).

## Raisons d'échec et conseils associés
| Raison (texte exact) | Conseil (texte exact) |
|---|---|
| « Le client est descendu : tu as mis trop de temps. » | « Conseil : à moto, passe entre les voitures arrêtées pour gagner du temps. » |
| « Le temps est écoulé. » | « Conseil : ouvre la carte (M) avant de partir pour repérer le chemin. » |
| « Le véhicule est hors d'usage. » | « Conseil : freine avant le virage, pas dedans. » |
| « La marchandise est abîmée. » | « Conseil : les nids-de-poule se prennent doucement. » |
| « Tu t'es trop éloigné. » | « Conseil : suis le pointillé sur la mini-carte. » |
| « La police t'a arrêté. » | « Conseil : hors de vue des agents, les étoiles s'effacent. » |
| « Tu t'es évanoui. » | « Conseil : un plat au maquis rend 40 points de santé. » |

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un point de contrôle = position, véhicule, argent, heure du jeu, objectif courant.
