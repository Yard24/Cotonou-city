# Statistiques — maquette

- Tâche : T5220 (« Statistiques : dessiner la maquette »).
- Image : `statistiques.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Montrer les chiffres de la partie en cours, en quatre blocs lisibles d'un coup d'œil, sans défilement.

## Quand il s'affiche
Depuis « Statistiques » du menu pause. Le jeu est en pause.

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Fond de menu | 0, 0 | 1280 × 720 | — | Dégradé vertical 2b170b vers 140a05, silhouette de la ville en 3a2516 à 55 % au bas de l'écran. |
| 2 | Titre de l'écran | 48, 49 | 209 × 53 | « Statistiques » | Barlow Condensed Bold 48, crème. |
| 3 | Filet tricolore | 48, 102 | 96 × 6 | — | Trois segments de 32 × 6 : vert, jaune, rouge. |
| 4 | Sous-titre de l'écran | 48, 120 | 304 × 22 | « Partie en cours · Chapitre 1 · Normal » | Barlow Regular 20, gris clair. |
| 5 | Bloc « Général » | 48, 160 | 584 × 236 | « Général / Avancement de l'histoire : 9 % / Temps de jeu : 3 h 42 / Jours passés à Cotonou : 12 / Missions principales réussies : 2 sur 48 / Missions secondaires réussies : 5 / Succès obtenus : 4 sur 24 / Photos prises : 3 » | Titre Barlow Condensed SemiBold 24 or ; 7 lignes de 26 : libellé Barlow Regular 18 gris clair, valeur Barlow SemiBold 18 crème alignée à droite. |
| 6 | Bloc « Sur la route » | 648, 160 | 584 × 236 | « Sur la route / Distance à moto : 86,4 km / Distance en voiture : 4,1 km / Distance à pied : 7,9 km / Distance à la nage : 120 m / Vitesse maximale atteinte : 97 km/h / Chutes à moto : 6 / Litres de kpayo achetés : 14 » | Titre Barlow Condensed SemiBold 24 or ; 7 lignes de 26 : libellé Barlow Regular 18 gris clair, valeur Barlow SemiBold 18 crème alignée à droite. |
| 7 | Bloc « Travail et argent » | 48, 408 | 584 × 236 | « Travail et argent / Argent gagné en tout : 41 300 FCFA / Argent dépensé en tout : 28 850 FCFA / Courses de zémidjan : 37 / Meilleur prix marchandé : 900 FCFA / Livraisons à l'heure : 4 sur 5 / Dette remboursée : 7 000 sur 25 000 FCFA / Repas pris : 11 » | Titre Barlow Condensed SemiBold 24 or ; 7 lignes de 26 : libellé Barlow Regular 18 gris clair, valeur Barlow SemiBold 18 crème alignée à droite. |
| 8 | Bloc « Police et santé » | 648, 408 | 584 × 236 | « Police et santé / Étoiles de recherche reçues : 9 / Poursuites semées : 3 / Arrestations : 2 / Amendes payées : 1 500 FCFA / Passages au centre de santé : 1 / Soins payés : 320 FCFA / Bagarres gagnées : 2 » | Titre Barlow Condensed SemiBold 24 or ; 7 lignes de 26 : libellé Barlow Regular 18 gris clair, valeur Barlow SemiBold 18 crème alignée à droite. |
| 9 | Barre d'aide | 0, 664 | 1280 × 56 | « [Échap] Retour » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Retour | Échap | Clic droit | B |
| Rien d'autre à sélectionner | — | — | — |

## Enchaînements
- Retour : `menu_pause.md`, sélection sur « Statistiques ».

## Règles et états
- Les statistiques appartiennent à la sauvegarde, pas au joueur : une nouvelle partie repart de zéro.
- Aucune statistique ne compte de victimes : les passants ne peuvent pas être tués (décision 4).
- Une valeur encore nulle s'affiche « 0 », jamais vide.
- Les valeurs de la maquette sont des exemples.

## Liste des statistiques
### Général
- Avancement de l'histoire (exemple : 9 %)
- Temps de jeu (exemple : 3 h 42)
- Jours passés à Cotonou (exemple : 12)
- Missions principales réussies (exemple : 2 sur 48)
- Missions secondaires réussies (exemple : 5)
- Succès obtenus (exemple : 4 sur 24)
- Photos prises (exemple : 3)
### Sur la route
- Distance à moto (exemple : 86,4 km)
- Distance en voiture (exemple : 4,1 km)
- Distance à pied (exemple : 7,9 km)
- Distance à la nage (exemple : 120 m)
- Vitesse maximale atteinte (exemple : 97 km/h)
- Chutes à moto (exemple : 6)
- Litres de kpayo achetés (exemple : 14)
### Travail et argent
- Argent gagné en tout (exemple : 41 300 FCFA)
- Argent dépensé en tout (exemple : 28 850 FCFA)
- Courses de zémidjan (exemple : 37)
- Meilleur prix marchandé (exemple : 900 FCFA)
- Livraisons à l'heure (exemple : 4 sur 5)
- Dette remboursée (exemple : 7 000 sur 25 000 FCFA)
- Repas pris (exemple : 11)
### Police et santé
- Étoiles de recherche reçues (exemple : 9)
- Poursuites semées (exemple : 3)
- Arrestations (exemple : 2)
- Amendes payées (exemple : 1 500 FCFA)
- Passages au centre de santé (exemple : 1)
- Soins payés (exemple : 320 FCFA)
- Bagarres gagnées (exemple : 2)

Formats : distances en km avec une décimale (en m sous 1 km), durées « 3 h 42 », argent avec espace des milliers et « FCFA ». « 2 sur 48 » = 6 chapitres × 8 missions (décision 100).

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Un dictionnaire `stats` dans la sauvegarde, une clé par ligne ; l'écran ne fait que mettre en forme.
- `GridContainer` 2 colonnes de 4 `PanelContainer`.
