# Téléphone — maquette

- Tâche : T5188 (« Téléphone : dessiner la maquette »).
- Image : `telephone.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Le téléphone de Koffi : appeler ses contacts, lire ses messages, puis payer par KwabôPay et suivre ses motos quand l'histoire les débloque. C'est aussi un raccourci vers la carte, le journal, la radio et le mode photo.

## Quand il s'affiche
En jeu sur T (clavier) ou croix haut (manette). Le jeu ne se met pas en pause : la ville continue derrière, l'affichage en jeu reste visible. Le téléphone occupe la gauche de l'écran (48, 96, 320 × 560).

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Argent (affichage en jeu) | 18, 17 | 113 × 33 | « 1 250 FCFA » | Position reprise de scripts/hud.gd (18, 12), taille 30, vert clair 8df59a. |
| 3 | Jauge de santé | 18, 56 | 204 × 18 | — | Fond noir à 60 %, remplissage 200 × 14 : vert 3fbf5a, jaune fcd116 sous 60 %, rouge e8112d sous 30 %. |
| 4 | Mini-carte | 1074, 16 | 190 × 190 | — | Position reprise de scripts/hud.gd : 190 × 190 à 16 du bord haut et droit. Nord en haut, joueur au centre. |
| 5 | Étoiles de recherche | 1104, 216 | 146 × 24 | — | Cinq étoiles de 22 sous la mini-carte ; pleines et or selon le niveau de recherche (1 à 5), creuses sinon. |
| 6 | Heure du jeu | 1198, 250 | 58 × 22 | « 17 h 42 » | Sous les étoiles, alignée à droite (x = 1256). Étoiles et heure sont sur une plaque 140a05 à 60 % (1074, 212, 190 × 64) ; argent et santé aussi (10, 8, 220 × 74) : ajout de cette maquette pour la lisibilité sur ciel clair. |
| 7 | Coque du téléphone | 48, 96 | 320 × 560 | — | Rectangle 1e2a33, coins 30, bord 140a05 ; ombre noire à 30 % décalée de (6, 8). Téléphone générique, sans marque. Il glisse depuis le bas en 0,2 s. |
| 8 | Écran du téléphone | 60, 108 | 296 × 536 | — | Fond 26170d, coins 20. Tout le contenu du téléphone tient dans cette zone de 296 × 536. |
| 9 | Barre d'état | 60, 108 | 296 × 36 | « 17 h 42 / Lagune Mobile » | Heure du jeu à gauche (Barlow SemiBold 16), opérateur fictif au centre (Barlow Regular 16), réseau et batterie à droite (décoratifs). |
| 10 | Salutation | 76, 159 | 143 × 33 | « Bonsoir, Koffi » | Barlow Condensed SemiBold 30. « Bonjour, Koffi » de 5 h à 17 h 59 du jeu, « Bonsoir, Koffi » ensuite. |
| 11 | Application « Contacts » | 70, 202 | 92 × 104 | « Contacts » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 12 | Application « Messages » | 162, 202 | 92 × 104 | « Messages » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. État montré : sélectionnée, avec pastille rouge « 2 » (messages non lus). |
| 13 | Application « Carte » | 254, 202 | 92 × 104 | « Carte » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 14 | Application « Missions » | 70, 306 | 92 × 104 | « Missions » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 15 | Application « KwabôPay » | 162, 306 | 92 × 104 | « KwabôPay » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. État montré : pas encore disponible (35 % d'opacité). |
| 16 | Application « Mes motos » | 254, 306 | 92 × 104 | « Mes motos » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. État montré : pas encore disponible (35 % d'opacité). |
| 17 | Application « Radio » | 70, 410 | 92 × 104 | « Radio » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 18 | Application « Photo » | 162, 410 | 92 × 104 | « Photo » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 19 | Application « Réglages » | 254, 410 | 92 × 104 | « Réglages » | Case de 92 × 104 : tuile 64 × 64 (3a2516, coins 14) et libellé Barlow Medium 16 centré dessous. |
| 20 | Aperçu du dernier message | 72, 532 | 272 × 88 | « ROMARIC · IL Y A 2 MIN / Tu es où ? Le client attend devant l'atelier. » | Carte 3a2516, coins 10 ; expéditeur et ancienneté en Barlow SemiBold 16 capitales, texte en Barlow Regular 16 sur 2 lignes au plus. |
| 21 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] [Gauche] [Droite] Choisir · [Entrée] Ouvrir · [T] Ranger le téléphone » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer d'application ou de ligne | Flèches ou Z Q S D | Survol | Croix |
| Ouvrir, valider | Entrée ou E | Clic gauche | A |
| Revenir à l'accueil du téléphone | Retour arrière | Clic droit | B |
| Ranger le téléphone | T ou Échap | Clic hors du téléphone | Croix haut, ou B depuis l'accueil |
| Faire défiler une liste | Flèches haut et bas | Molette | Croix haut et bas |

## Enchaînements
- « Carte » : `grande_carte.md`. « Missions » : `journal_de_missions.md`. « Photo » : `mode_photo.md`. « Réglages » puis « Options du jeu » : `options_graphiques.md`.
- Ranger le téléphone : il redescend en 0,2 s, le jeu reprend les commandes.
- Échap avec le téléphone sorti range le téléphone ; un second appui ouvre `menu_pause.md`.

## Règles et états
- Tant que le téléphone est sorti, les touches de déplacement servent au téléphone : Koffi reste sur place. Le stick gauche et la souris continuent de tourner la caméra.
- En véhicule, le téléphone ne sort que sous 5 km/h ; au-delà, l'aide du bas affiche « Arrête-toi pour sortir ton téléphone. ». S'il est sorti et que le véhicule dépasse 5 km/h, il se range.
- Impossible de le sortir en nageant, en tombant, pendant une bagarre ou une scène d'histoire.
- La pastille rouge (22 de diamètre, chiffre blanc Barlow Bold 15) compte les messages non lus ; au-delà de 9 elle affiche « 9+ ».
- « Lagune Mobile » est un opérateur inventé (décision 25), à vérifier avec le lot des marques fictives. KwabôPay est le paiement mobile fictif de la décision 66.
- Au chapitre 1, le téléphone dessiné est un modèle simple à écran ; son habillage pourra évoluer avec les chapitres sans changer la disposition.

## Applications
| Application | Disponible | Contenu (dans l'écran du téléphone, 296 × 536) |
|---|---|---|
| Contacts | Chapitre 1 | Liste de lignes de 56 de haut : pastille avec l'initiale, nom, rôle. Dans l'ordre : « Romaric — mécanicien », « Maman Koffi », « Afi — petite sœur », « Tonton Gratien — pièces détachées », « Le Doyen — chef des zémidjans », puis ceux qu'on rencontre (« Nan Akouavi — tissus », « Expédit — transitaire », « Rachidath — journaliste »). Valider : « Appeler » (lance la mission ou une réplique), « Voir sur la carte ». |
| Messages | Chapitre 1 | Liste des conversations (nom, début du dernier message, heure) ; valider ouvre le fil, bulles alignées à gauche (reçus, 3a2516) et à droite (envoyés, vert 008751). Koffi ne tape pas de texte : deux réponses toutes faites au plus. |
| Carte | Chapitre 1 | Ferme le téléphone et ouvre `grande_carte.md`. |
| Missions | Chapitre 1 | Ferme le téléphone et ouvre `journal_de_missions.md`. |
| KwabôPay | Chapitre 2, après la leçon d'Afi (décisions 41 et 66) | Solde (Barlow Condensed Bold 38, vert clair), boutons « Envoyer de l'argent », « Payer une dette », et les 10 derniers mouvements. |
| Mes motos | Chapitre 4 (décision 68) | Une ligne par moto confiée : conducteur, recette du jour, état ; total « Recette du jour : 7 500 FCFA » ; bouton « Encaisser ». |
| Radio | Chapitre 1 | Les 4 stations fictives (décision 109) : « Moderne », « Traditionnelle », « Zouk et rétro », « Parlée » (noms définitifs à fixer avec le lot audio) ; interrupteur « Éteinte ». À pied, la radio joue dans les écouteurs. |
| Photo | Chapitre 1 | Ferme le téléphone et ouvre `mode_photo.md`. |
| Réglages | Chapitre 1 | « Sonnerie : Oui / Non », « Vibreur : Oui / Non », « Sauvegarder la partie » (hors mission), « Revoir les conseils » (réaffiche les cartes de `tutoriel_a_l_ecran.md` déjà vues), « Options du jeu » (ouvre `options_graphiques.md`). |

Une application pas encore disponible reste visible à 35 % ; la valider affiche en bas de l'écran du téléphone « Pas encore. Afi t'expliquera. » pour KwabôPay et « Il te faut d'abord une moto à toi. » pour Mes motos.

## Appel entrant
Le téléphone monte tout seul à mi-hauteur (seuls les 200 px du haut dépassent, y = 520) avec « Romaric t'appelle » (Barlow Condensed SemiBold 26) et deux aides : « E Répondre » et « Retour arrière Refuser ». Sans réponse au bout de 8 s, l'appel devient un message. Aucun appel pendant une poursuite (2 étoiles ou plus).

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Le téléphone est un `Control` ancré en bas à gauche, animé par un `Tween` sur `position.y` (de 720 à 96).
- Pendant qu'il est sorti, le script du joueur ignore `up`, `down`, `left`, `right`, `jump`, `enter` (drapeau `telephone_sorti`).
- Action à ajouter dans `InputMap` : `phone` (T, croix haut).
