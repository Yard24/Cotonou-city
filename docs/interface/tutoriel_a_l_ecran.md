# Tutoriel à l'écran — maquette

- Tâche : T5240 (« Tutoriel à l'écran : dessiner la maquette »).
- Image : `tutoriel_a_l_ecran.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Apprendre les gestes du jeu au moment où ils servent, par de courtes cartes affichées pendant qu'on joue, sans arrêter la partie.

## Quand il s'affiche
En jeu, pendant les premières missions et à la première occurrence de certaines situations. Le jeu n'est pas en pause ; l'affichage en jeu reste visible.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Vue du jeu en cours | 0, 0 | 1280 × 720 | — | Image du jeu (caméra du joueur). Dans la maquette : rue de Ganhi en fin d'après-midi, dessin simplifié. |
| 2 | Argent (affichage en jeu) | 18, 17 | 72 × 33 | « 0 FCFA » | Position reprise de scripts/hud.gd (18, 12), taille 30, vert clair 8df59a. |
| 3 | Jauge de santé | 18, 56 | 204 × 18 | — | Fond noir à 60 %, remplissage 200 × 14 : vert 3fbf5a, jaune fcd116 sous 60 %, rouge e8112d sous 30 %. |
| 4 | Objectif en cours | 518, 18 | 245 × 24 | « Prends ton premier client » | Centré en haut entre x = 260 et x = 1020, sur une plaque 140a05 à 60 %. |
| 5 | Mini-carte | 1074, 16 | 190 × 190 | — | Position reprise de scripts/hud.gd : 190 × 190 à 16 du bord haut et droit. Nord en haut, joueur au centre. |
| 6 | Étoiles de recherche | 1104, 216 | 146 × 24 | — | Cinq étoiles de 22 sous la mini-carte ; pleines et or selon le niveau de recherche (1 à 5), creuses sinon. |
| 7 | Heure du jeu | 1198, 250 | 58 × 22 | « 17 h 42 » | Sous les étoiles, alignée à droite (x = 1256). Étoiles et heure sont sur une plaque 140a05 à 60 % (1074, 212, 190 × 64) ; argent et santé aussi (10, 8, 220 × 74) : ajout de cette maquette pour la lisibilité sur ciel clair. |
| 8 | Vitesse | 1144, 660 | 116 × 48 | « 0 km/h » | En bas à droite, taille 44, seulement en véhicule. |
| 9 | Anneau de mise en évidence | 775, 394 | 112 × 112 | — | Cercle jaune pâle ffe27a, épaisseur 4, autour de ce que le conseil désigne (ici le client qui lève le bras) ; il bat entre 100 % et 120 % de taille, période 1 s. |
| 10 | Carte de tutoriel | 400, 496 | 480 × 140 | — | Plaque 140a05 à 88 %, bord jaune pâle ffe27a de 2, barre jaune pâle de 6 à gauche, coins 8. Centrée en bas, au-dessus de la zone des conseils courts. |
| 11 | Titre du conseil | 424, 511 | 158 × 29 | « Prendre un client » | Barlow Condensed SemiBold 26, jaune pâle. |
| 12 | Compteur d'étapes | 810, 517 | 46 × 18 | « 2 sur 5 » | Barlow SemiBold 16, aligné à droite. |
| 13 | Texte du conseil | 424, 548 | 432 × 54 | « Arrête ta moto près du client qui lève le bras, puis appuie sur [E] pour accepter la course. » | Barlow Regular 20, interligne 28, 2 lignes au plus ; la touche est dessinée en capuchon (ou en pastille de manette : X). |
| 14 | Aide pour passer | 424, 606 | 330 × 22 | « Maintiens [Retour arrière] pour passer les conseils » | Barlow Regular 16, brun clair ; capuchon de 22 de haut. À la manette : « Maintiens [Vue] ». |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Faire ce que demande la carte | La touche montrée (ici E) | — | Le bouton montré (ici X) |
| Passer la carte en cours | Retour arrière, maintenu 0,8 s | — | Vue (Select), maintenu 0,8 s |
| Tout le reste | Les commandes du jeu restent actives | La souris tourne la caméra | Idem |

## Enchaînements
- La carte disparaît (fondu 0,2 s) dès que le geste est fait, puis la suivante arrive après 0,5 s.
- Elle ne mène à aucun autre écran. Échap ouvre `menu_pause.md` comme d'habitude ; la carte revient à la reprise.
- Réactiver les conseils déjà vus : `options_de_touches.md` n'est pas concerné ; le réglage « Revoir les conseils » est dans le téléphone, application « Réglages » (voir `telephone.md`).

## Règles et états
- Une seule carte à la fois ; une carte reste 20 s au plus si le geste n'est pas fait, puis se réduit à son titre (plaque de 480 × 48) jusqu'à ce qu'il le soit.
- Les touches affichées suivent les réglages du joueur et le dernier périphérique utilisé.
- Aucune carte pendant un dialogue sous-titré : elle attend la fin de la réplique.
- En difficulté « Corsé », seules les étapes 1 à 5 du premier tutoriel s'affichent.
- Chaque conseil vu est noté dans la sauvegarde et ne revient pas.

## Étapes du premier tutoriel (chapitre 1, mission 2)
| N° | Titre | Texte exact (clavier) | Texte à la manette | Se valide quand |
|---|---|---|---|---|
| 1 | Monter sur la moto | « Approche-toi de la moto et appuie sur [E] pour monter. » | [X] | Koffi est sur la moto |
| 2 | Prendre un client | « Arrête ta moto près du client qui lève le bras, puis appuie sur [E] pour accepter la course. » | [X] | Course acceptée |
| 3 | Rouler | « [Z] pour accélérer, [S] pour freiner, [Q] et [D] pour tourner. » | [RT], [LT], stick gauche | 100 m parcourus |
| 4 | Suivre la colonne bleue | « Conduis ton client jusqu'à la colonne bleue. Le pointillé de la mini-carte montre le chemin. » | identique | À 30 m de la colonne |
| 5 | Encaisser | « Arrête-toi dans la colonne : le client paie et descend. » | identique | Course payée |

## Autres conseils, affichés une seule fois chacun
| Moment | Titre | Texte exact |
|---|---|---|
| Premier embouteillage | Se faufiler | « À moto, tu peux passer entre les voitures arrêtées. Doucement. » |
| Première étoile | Recherché | « Un agent t'a vu. Éloigne-toi et reste hors de sa vue : l'étoile s'effacera. » |
| Santé sous 30 % | Manger | « Tu es mal en point. Un maquis ou une vendeuse de rue te remettra d'aplomb. » |
| Réservoir sous 15 % | Carburant | « Presque à sec. Station : sûr mais cher. Kpayo : moins cher, plus risqué. » |
| Premier virage serré | Frein arrière | « [Espace] : le frein arrière aide à tourner serré. » |
| Première nuit | Phares | « [L] allume tes phares. » |
| Premier marchandage | Marchander | « Propose ton prix avec [Q] et [D], valide avec [E]. Trois échanges au plus. » |
| Première sauvegarde automatique | Sauvegarde | « Le jeu sauvegarde tout seul après chaque mission. » |

## Position des éléments d'aide en jeu
- Carte de tutoriel : (400, 496), 480 × 140.
- Conseil court existant de `scripts/hud.gd` (`l_hint`, jaune ffe27a, taille 22, centré, bas de l'écran, entre y = 600 et y = 700) : il est masqué tant qu'une carte de tutoriel est affichée.
- L'affichage en jeu de la maquette (argent, jauge de santé, objectif, mini-carte, étoiles, heure, vitesse) reprend les positions de `scripts/hud.gd`.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un conseil = identifiant, titre, texte avec balises de touche (`[enter]`, `[up]`) remplacées à l'affichage par le capuchon de la touche liée à l'action, condition de fin (fonction), cible à entourer (nœud 3D projeté à l'écran avec `Camera3D.unproject_position`).
- La carte est un `PanelContainer` ancré en bas au centre ; le texte est un `RichTextLabel` (images en ligne pour les capuchons).
