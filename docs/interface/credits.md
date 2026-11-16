# Crédits — maquette

- Tâche : T5228 (« Crédits : dessiner la maquette »).
- Image : `credits.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Dire qui a fait le jeu et avec quoi, et porter les mentions de licence obligatoires.

## Quand il s'affiche
Depuis « Crédits » du menu principal, et automatiquement après la scène de fin de l'histoire (les deux fins).

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Illustration de fond | 0, 0 | 1280 × 720 | — | Coucher de soleil sur la lagune : ciel en dégradé (1d0f08, 8a3d1e, f09a4e, f6cf96), soleil ffdcaa, ville et pont en silhouette 2b170b sur la ligne y = 470, eau 2a86b5 vers 143f58, pirogue et palmiers en 140a05. À remplacer par une image du jeu quand la carte sera construite. |
| 2 | Voile sombre | 0, 0 | 1280 × 720 | — | 140a05 à 72 %. |
| 3 | Titre du jeu | 457, 58 | 367 × 84 | « MARINA CITY » | Barlow Condensed Bold 76, or, centré. |
| 4 | Bande tricolore | 532, 136 | 216 × 6 | — | Trois segments de 72 × 6. |
| 5 | Colonne des crédits | 240, 184 | 800 × 380 | « UNE IDÉE ET UNE DIRECTION DE : Bravo / PROGRAMMATION, TEXTES, MAQUETTES : Claude, assistant d'Anthropic / VOIX ET MUSIQUE : Voix générées · Musique générée ou composée pour le jeu / MOTEUR : Godot Engine (licence MIT) / POLICES : Barlow et Barlow Condensed (licence SIL OFL 1.1) » | Colonne centrée de 800 de large qui défile vers le haut à 40 px par seconde. Rubrique en Barlow SemiBold 16 capitales brun clair, noms en Barlow Medium 24 crème ; 32 entre rubrique et nom, 44 entre blocs. |
| 6 | Avertissement | 200, 599 | 880 × 40 | « Marina City est une fiction. Les personnages, les commerces et les marques sont inventés ; toute ressemblance avec des personnes réelles serait fortuite. » | Barlow Regular 16, centré, fixe en bas (ne défile pas). |
| 7 | Barre d'aide | 0, 664 | 1280 × 56 | « [Bas] Accélérer · [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Accélérer le défilement (× 4) | Maintenir Bas, S ou Espace | Maintenir le clic gauche ; molette pour avancer ou reculer | Maintenir A ou stick gauche vers le bas |
| Revenir en arrière | Maintenir Haut ou Z | Molette vers le haut | Stick gauche vers le haut |
| Retour | Échap | Clic droit | B |

## Enchaînements
- Retour, ou 5 s après « Merci d'avoir joué. » : `menu_principal.md`.
- Après la fin de l'histoire, Retour ne marche qu'après 3 s (éviter de sauter la fin par accident), puis mène au jeu libre : Koffi devant son logement.

## Règles et états
- Durée totale visée : 60 à 90 s sans accélérer.
- Musique : thème du jeu, version longue.
- L'avertissement du bas reste fixe pendant tout le défilement.
- Pas de lien cliquable ni d'adresse de site (décision 71 : pas de connexion).

## Texte complet, dans l'ordre de défilement
1. « MARINA CITY » / « Cotonou, 2017-2026 »
2. UNE IDÉE ET UNE DIRECTION DE — Bravo
3. PROGRAMMATION, TEXTES, MAQUETTES — Claude, assistant d'Anthropic
4. VOIX ET MUSIQUE — Voix générées · Musique générée ou composée pour le jeu (décisions 108 et 110)
5. MOTEUR — Godot Engine (licence MIT) ; le texte complet de la licence et la liste des bibliothèques tierces du moteur suivent en Barlow Regular 16
6. POLICES — Barlow et Barlow Condensed, © 2017 The Barlow Project Authors (licence SIL OFL 1.1)
7. MODÈLES 3D ET SONS — une ligne par outil ou par source, avec sa licence (à compléter au fil de la production)
8. ESSAIS — prénoms ou pseudonymes des testeurs qui l'acceptent
9. REMERCIEMENTS — « À Cotonou, à ses zémidjans, à ses vendeuses, à ceux qui nous ont raconté la ville. »
10. « Merci d'avoir joué. » (Barlow Condensed SemiBold 34, or), qui s'arrête au centre de l'écran.

Les noms de moteur, de polices et d'outils sont de vraies mentions légales exigées par leurs licences : elles ne tombent pas sous la décision 25, qui vise les marques du monde du jeu. Aucune autre personne réelle n'est citée sans son accord.

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un `VBoxContainer` dans un `Control` avec `clip_contents`, déplacé par code ; le texte vient d'un fichier `credits.txt` à la racine des ressources.
