# Écran titre — maquette

- Tâche : T5144 (« Écran titre : dessiner la maquette »).
- Image : `ecran_titre.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Premier écran du jeu : il affiche le nom « Marina City », le sous-titre et attend une action du joueur. Il sert aussi à savoir si le joueur utilise le clavier ou la manette.

## Quand il s'affiche
Au lancement de `MarinaCity.exe`, après le logo du moteur. On y revient depuis le menu principal après 3 minutes sans action, jamais depuis une partie.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Illustration de fond | 0, 0 | 1280 × 720 | — | Coucher de soleil sur la lagune : ciel en dégradé (1d0f08, 8a3d1e, f09a4e, f6cf96), soleil ffdcaa, ville et pont en silhouette 2b170b sur la ligne y = 470, eau 2a86b5 vers 143f58, pirogue et palmiers en 140a05. À remplacer par une image du jeu quand la carte sera construite. |
| 2 | Titre du jeu | 310, 148 | 661 × 150 | « MARINA CITY » | Barlow Condensed Bold 136, or f5c400, interlettrage 4, ombre 140a05 à 55 % décalée de 4 px. Centré sur x = 640. |
| 3 | Bande tricolore | 460, 284 | 360 × 8 | — | Trois segments de 120 × 8 : vert 008751, jaune fcd116, rouge e8112d (repris de l'écran actuel). |
| 4 | Sous-titre | 493, 310 | 294 × 37 | « Cotonou, 2017-2026 » | Barlow Medium 34, crème. Centré. |
| 5 | Invitation | 440, 552 | 400 × 56 | « Appuie sur une touche » | Plaque 140a05 à 72 %, coins 8 ; texte Barlow Condensed SemiBold 30. L'opacité du texte bat entre 100 % et 40 % (période 1,6 s). À la manette : « Appuie sur un bouton ». |
| 6 | Version | 48, 679 | 154 × 18 | « Version 0.1 · Chapitre 1 » | Barlow Medium 16, gris clair. Le numéro vient de la configuration du projet. |
| 7 | Mention | 799, 679 | 433 × 18 | « Jeu gratuit, sans publicité ni achat · Conseillé à partir de 12 ans » | Barlow Medium 16, aligné à droite sur x = 1232 (décisions 6 et 71). |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Continuer | N'importe quelle touche sauf Échap, F3 et F4 | Clic gauche n'importe où | N'importe quel bouton |
| Quitter | Échap : ouvre la boîte « Quitter le jeu ? » | — | — |

## Enchaînements
- Une touche, un clic ou un bouton : fondu de 0,3 s vers `menu_principal.md`.
- Échap : boîte de confirmation « Quitter le jeu ? » (boutons « Quitter » et « Rester », sélection sur « Rester ») ; « Quitter » ferme le jeu.
- Si aucun fichier de réglages n'existe (tout premier lancement), le menu principal s'ouvre normalement : la langue est le français sans passer par `choix_de_la_langue.md` tant qu'une seule langue existe (décision 117).

## Règles et états
- Le périphérique qui a servi à passer l'écran fixe l'affichage des aides : touches du clavier ou boutons de manette. Il change ensuite dès que l'autre périphérique est utilisé.
- La musique du menu démarre ici (thème du jeu, bus « Musique »), en fondu de 1 s.
- Pas de vidéo ni de mode de démonstration : l'écran reste fixe, seul le texte d'invitation bat et le reflet du soleil scintille (facultatif).
- Le titre de la fenêtre est « Marina City » (décision 1).

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Scène proposée : `ecran_titre.tscn` avec `TextureRect` (fond), deux `Label` (titre, sous-titre), `HBoxContainer` de 3 `ColorRect` (bande), `Label` d'invitation animé par un `Tween` en boucle.
- Lire l'entrée dans `_unhandled_input` : `InputEventKey` (appui), `InputEventMouseButton`, `InputEventJoypadButton` ; ignorer les axes de manette pour éviter un départ involontaire.
- Remplace le titre et le sous-titre aujourd'hui construits dans `scripts/hud.gd` (`m.menu_title`, 84 px) ; les mêmes couleurs sont conservées.
