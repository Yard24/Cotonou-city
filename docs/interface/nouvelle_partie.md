# Nouvelle partie — maquette

- Tâche : T5152 (« Nouvelle partie : dessiner la maquette »).
- Image : `nouvelle_partie.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Créer une partie : choisir l'une des trois difficultés (décision 116) et l'un des trois emplacements de sauvegarde manuelle (décision 115).

## Quand il s'affiche
Depuis « Nouvelle partie » du menu principal.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 263 × 53 | « Nouvelle partie » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Sous-titre de l'écran | 48, 120 | 474 × 22 | « Choisis la difficulté, puis l'emplacement de sauvegarde. » | Barlow Regular 20, gris clair. |
| 5 | Intertitre « Difficulté » | 48, 167 | 102 × 29 | « 1. Difficulté » | Barlow Condensed SemiBold 26. |
| 6 | Carte de difficulté « Tranquille » | 48, 204 | 384 × 216 | « Tranquille / Pour découvrir la ville sans pression. / Dégâts reçus : −40 % / Chronos : +30 % de temps / Amendes et soins : moitié prix » | Nom en Barlow Condensed Bold 34, phrase en Barlow Medium 20, trois lignes en Barlow Regular 18 avec puce or. |
| 7 | Carte de difficulté « Normal » | 448, 204 | 384 × 216 | « Normal / Le jeu tel qu'il est prévu. / Dégâts reçus : normaux / Chronos : normaux / Amendes et soins : prix normal / Recommandé » | Nom en Barlow Condensed Bold 34, phrase en Barlow Medium 20, trois lignes en Barlow Regular 18 avec puce or. État montré : sélectionnée (bord or 4, bandeau or, pastille « Recommandé » 136 × 28 en haut à droite). |
| 8 | Carte de difficulté « Corsé » | 848, 204 | 384 × 216 | « Corsé / Pour qui connaît déjà les rues. / Dégâts reçus : +40 % / Chronos : −15 % de temps / Amendes et soins : +50 % » | Nom en Barlow Condensed Bold 34, phrase en Barlow Medium 20, trois lignes en Barlow Regular 18 avec puce or. |
| 9 | Note sur la difficulté | 48, 437 | 320 × 20 | « La difficulté est fixée pour toute la partie. » | Barlow Regular 18, brun clair. |
| 10 | Intertitre « Emplacement » | 48, 479 | 288 × 29 | « 2. Emplacement de sauvegarde » | Barlow Condensed SemiBold 26. |
| 11 | Emplacement 1 | 48, 516 | 384 × 64 | « Emplacement 1 / Vide » | Barlow Condensed SemiBold 24 et Barlow Regular 16 (jaune pâle si une partie sera remplacée). État montré : choisi (bord vert 3, pastille verte avec coche). |
| 12 | Emplacement 2 | 448, 516 | 384 × 64 | « Emplacement 2 / Chapitre 1 · 3 h 42 · sera remplacée » | Barlow Condensed SemiBold 24 et Barlow Regular 16 (jaune pâle si une partie sera remplacée). |
| 13 | Emplacement 3 | 848, 516 | 384 × 64 | « Emplacement 3 / Vide » | Barlow Condensed SemiBold 24 et Barlow Regular 16 (jaune pâle si une partie sera remplacée). |
| 14 | Bouton « Retour » | 48, 596 | 200 × 52 | « Retour » | Revient au menu principal sans rien créer. |
| 15 | Bouton « Commencer » | 952, 596 | 280 × 52 | « Commencer » | Crée la partie avec la difficulté et l'emplacement choisis. |
| 16 | Barre d'aide | 0, 664 | 1280 × 56 | « [Gauche] [Droite] Choisir · [Haut] [Bas] Changer de ligne · [Entrée] Valider · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Changer de carte ou d'emplacement dans la ligne | Flèches gauche et droite, ou Q et D | Survol | Croix ou stick gauche, gauche et droite |
| Passer d'une ligne à l'autre (difficulté, emplacement, boutons) | Flèches haut et bas, ou Z et S | Survol | Croix ou stick gauche, haut et bas |
| Choisir la carte ou l'emplacement, ou activer le bouton | Entrée ou Espace | Clic gauche | A |
| Commencer directement | — | Clic sur « Commencer » | Start |
| Retour | Échap | Clic droit | B |

## Enchaînements
- « Commencer » : si l'emplacement est vide, `ecran_de_chargement.md`, puis la première mission du chapitre 1.
- « Commencer » sur un emplacement occupé : boîte de confirmation « Remplacer cette partie ? » (texte « L'emplacement 2 contient une partie de 3 h 42. Elle sera effacée. », boutons « Remplacer » en rouge et « Annuler », sélection sur « Annuler »).
- « Retour », Échap ou B : `menu_principal.md`.

## Règles et états
- À l'ouverture : difficulté « Normal » sélectionnée et choisie ; premier emplacement vide choisi (s'ils sont tous pleins, le plus ancien, avec l'avertissement « sera remplacée »).
- Valider une carte de difficulté la choisit (coche) et descend la sélection sur la ligne des emplacements ; valider un emplacement descend sur « Commencer ».
- Proposition de réglages par difficulté (à ajuster aux essais) : dégâts reçus × 0,6 / × 1 / × 1,4 ; durée des chronos × 1,3 / × 1 / × 0,85 ; amendes × 0,5 / × 1 / × 1,5 ; soins du centre de santé 5 % de l'argent (1 000 FCFA au plus) / 10 % (2 000 au plus, valeur validée) / 15 % (3 000 au plus).
- La difficulté ne change ni l'histoire ni les récompenses des missions.
- La sauvegarde automatique est commune : commencer une nouvelle partie remplace aussi `auto.sav` à la fin de la première mission, pas avant.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Trois lignes de sélection : `HBoxContainer` de 3 cartes (`PanelContainer` focalisables), `HBoxContainer` de 3 emplacements, puis les deux boutons. Régler `focus_neighbor_*` à la main entre les lignes.
- La partie créée contient : difficulté (0, 1, 2), emplacement (1 à 3), chapitre 1, argent 0 FCFA (décision 11), date de création.
