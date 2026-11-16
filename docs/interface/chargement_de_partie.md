# Chargement de partie — maquette

- Tâche : T5156 (« Chargement de partie : dessiner la maquette »).
- Image : `chargement_de_partie.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Choisir la partie à reprendre parmi la sauvegarde automatique et les trois emplacements manuels (décision 115), ou en effacer une.

## Quand il s'affiche
Depuis « Charger une partie » du menu principal ou du menu pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 325 × 53 | « Charger une partie » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Sous-titre de l'écran | 48, 120 | 433 × 22 | « Le jeu sauvegarde tout seul après chaque mission. » | Barlow Regular 20, gris clair. |
| 5 | Ligne « Sauvegarde automatique » | 48, 160 | 1184 × 112 | « Sauvegarde automatique / Chapitre 1 — Le retour (2017) · Mission 4 sur 8 / Normal · 3 h 42 de jeu / 12 450 FCFA / 14 novembre 2026, 18 h 07 » | Vignette 160 × 90 à (x + 12, y + 11) ; nom en Barlow Condensed SemiBold 28 ; chapitre et mission en Barlow Medium 20 ; difficulté et durée en Barlow Regular 18 ; argent en Barlow Condensed Bold 30 et date en Barlow Regular 18, alignés à droite (x = 1208). État montré : sélectionnée. |
| 6 | Ligne « Emplacement 1 » | 48, 284 | 1184 × 112 | « Emplacement 1 / Chapitre 1 — Le retour (2017) · Mission 2 sur 8 / Normal · 1 h 05 de jeu / 3 200 FCFA / 12 novembre 2026, 21 h 30 » | Vignette 160 × 90 à (x + 12, y + 11) ; nom en Barlow Condensed SemiBold 28 ; chapitre et mission en Barlow Medium 20 ; difficulté et durée en Barlow Regular 18 ; argent en Barlow Condensed Bold 30 et date en Barlow Regular 18, alignés à droite (x = 1208). |
| 7 | Ligne « Emplacement 2 » | 48, 408 | 1184 × 112 | « Emplacement 2 / Chapitre 1 — Le retour (2017) · Mission 7 sur 8 / Tranquille · 6 h 18 de jeu / 41 750 FCFA / 9 novembre 2026, 16 h 12 » | Vignette 160 × 90 à (x + 12, y + 11) ; nom en Barlow Condensed SemiBold 28 ; chapitre et mission en Barlow Medium 20 ; difficulté et durée en Barlow Regular 18 ; argent en Barlow Condensed Bold 30 et date en Barlow Regular 18, alignés à droite (x = 1208). |
| 8 | Ligne « Emplacement 3 » | 48, 532 | 1184 × 112 | « Emplacement 3 / Vide » | Vignette 160 × 90 à (x + 12, y + 11) ; nom en Barlow Condensed SemiBold 28 ; chapitre et mission en Barlow Medium 20 ; difficulté et durée en Barlow Regular 18 ; argent en Barlow Condensed Bold 30 et date en Barlow Regular 18, alignés à droite (x = 1208). État montré : emplacement vide, non sélectionnable (cadre pointillé à la place de la vignette). |
| 9 | Barre d'aide | 0, 664 | 1280 × 56 | « [Haut] [Bas] Choisir · [Entrée] Charger · [Suppr] Effacer · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de choix | Flèches haut et bas, ou Z et S | Survol : le choix sous le pointeur est sélectionné | Croix ou stick gauche, haut et bas |
| Charger la partie sélectionnée | Entrée ou Espace | Clic gauche sur la ligne | A |
| Effacer la partie sélectionnée | Suppr | Clic du milieu sur la ligne | X |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Charger depuis le menu principal : `ecran_de_chargement.md`, puis le jeu.
- Charger depuis le menu pause : boîte de confirmation « Charger cette partie ? » (texte « Ce que tu as fait depuis la dernière sauvegarde sera perdu. », boutons « Charger » et « Annuler », sélection sur « Annuler »), puis `ecran_de_chargement.md`.
- Effacer : boîte « Effacer cette partie ? » (texte « Emplacement 1 : chapitre 1, 1 h 05 de jeu. Cette action est définitive. », boutons « Effacer » en rouge et « Annuler », sélection sur « Annuler »). La ligne devient « Vide ».
- Retour : l'écran d'où l'on vient (`menu_principal.md` ou `menu_pause.md`).

## Règles et états
- Ordre fixe : sauvegarde automatique, puis emplacements 1, 2 et 3. La sélection part sur la plus récente.
- Une ligne vide est sautée par la navigation et ne réagit pas au clic.
- La sauvegarde automatique ne peut pas être effacée : sur cette ligne, l'aide « Effacer » disparaît.
- Un fichier illisible affiche « Sauvegarde abîmée » en rouge e8112d à la place du chapitre ; on peut seulement l'effacer.
- Les dates sont celles du PC, écrites en toutes lettres (« 14 novembre 2026, 18 h 07 »). Le temps de jeu s'écrit « 3 h 42 ».

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- `VBoxContainer` de 4 lignes (séparation 12, hauteur 112). Chaque ligne est un `Button` plat qui contient vignette et textes.
- La vignette est une capture 320 × 180 enregistrée avec la sauvegarde (`.png` à côté du `.sav`).
