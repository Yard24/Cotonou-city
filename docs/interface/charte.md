# Charte de l'interface

- Tâche liée : T5245 (« Choisir les polices »). Ce fichier sert de base aux 25 maquettes du dossier (`<ecran>.svg` et `<ecran>.md`) et aux icônes (`icones/`, `icones_de_la_carte.md`, `icones_des_objets.md`).
- Jeu : « Marina City », sous-titre « Cotonou, 2017-2026 » (décisions 1 et 23). Le joueur est tutoyé, comme dans les textes déjà présents dans `scripts/hud.gd`.
- Choix faits par Claude, modifiables sur simple demande de Bravo.

## 1. Écran de référence
- 1280 × 720, origine en haut à gauche, comme `project.godot` (étirement `canvas_items`, aspect `expand`).
- Grille de 8 px. Marge de sécurité : 48 px sur les quatre bords (rien d'important au-delà).
- Titre d'écran : ligne de base y = 88, x = 48. Barre d'aide : y = 664 à 720. Zone utile entre les deux : y = 124 à 648.
- En 16:10 ou 21:9, ce qui est à gauche reste ancré à gauche, ce qui est à droite à droite, les blocs centrés restent centrés.

## 2. Couleurs
Codes repris de `docs/style_graphique.md` quand ils existent ; les bruns de panneau sont dérivés du « fond de menu » `140a05`.

| Rôle | Code | Emploi |
|---|---|---|
| Brun nuit | `140a05` | Fond de menu, voile à 72 % sur l'image du jeu (80 % pour échec, arrestation, hôpital), texte sur fond or |
| Brun panneau | `26170d` | Panneaux et boutons au repos (opacité 92 %) |
| Brun relief | `3a2516` | Tuiles d'image, carte sélectionnée, silhouette de ville du fond |
| Trait | `6b4a30` | Bords (1,5 px), filets, rails de jauge et de curseur |
| Crème | `f4f1ea` | Texte principal |
| Gris clair | `d6d0c4` | Texte secondaire |
| Brun clair | `a3957f` | Étiquettes, texte indisponible, notes |
| Or | `f5c400` | Sélection (fond du choix sélectionné), titre du jeu, remplissage des jauges |
| Vert | `008751` | Accent, « oui », « choisi », « obtenu » |
| Jaune | `fcd116` | Accent, travail (icônes de carte) |
| Rouge | `e8112d` | Accent, dépense, échec, action irréversible |
| Vert clair | `8df59a` | Argent et gains |
| Jaune pâle | `ffe27a` | Conseils, objectif en cours, tutoriel |
| Vert santé | `3fbf5a` | Jauge de santé (jaune `fcd116` sous 60 %, rouge `e8112d` sous 30 %, comme aujourd'hui) |
| Bleu lagune | `2a86b5` | Police sur la carte, commerces, eau |

Fond de menu : dégradé vertical `2b170b` vers `140a05`, silhouette de ville `3a2516` à 55 % en bas.

Contrastes mesurés (rapport WCAG ; 4,5 au moins pour un texte courant, 3 pour un gros titre) :

| Texte sur fond | Rapport |
|---|---|
| Crème `f4f1ea` sur panneau `26170d` | 15,4 |
| Gris clair `d6d0c4` sur panneau | 11,3 |
| Brun clair `a3957f` sur panneau | 5,9 |
| Brun nuit `140a05` sur or `f5c400` (choix sélectionné) | 11,9 |
| Vert clair `8df59a` sur panneau | 12,9 |
| Jaune pâle `ffe27a` sur panneau | 13,6 |
| Blanc sur rouge `e8112d` (bouton à risque) | 4,6 |
| Rouge `e8112d` sur panneau | 3,8 : réservé aux montants en Barlow SemiBold 18 et plus, et aux gros titres |
| Crème sur vert `008751` | 4,1 : réservé aux coches et pictogrammes, pas au texte courant |

Règles : le rouge et le vert ne portent jamais seuls une information (toujours un signe « + » ou « − », une coche, un mot). La bande tricolore vert, jaune, rouge (dans cet ordre) est la signature du jeu : sous chaque titre (96 × 6) et à gauche de l'élément sélectionné (6 px de large, à 10 px du bord).

## 3. Polices (T5245)
Deux familles de la même main, libres de droits, licence SIL Open Font License 1.1 (usage commercial, modification et fourniture avec le jeu autorisés ; joindre le fichier `OFL.txt`).

| Famille | Graisses utilisées | Emploi |
|---|---|---|
| Barlow Condensed | SemiBold (600), Bold (700) | Titres, boutons, noms de lieu, montants, bandeaux |
| Barlow | Regular (400), Medium (500), SemiBold (600), Bold (700 : seulement lettres des boutons de manette) | Textes, réglages, sous-titres, aides |

Pourquoi : dessin inspiré des panneaux routiers et des plaques, donc à sa place dans un jeu de conduite ; la version étroite permet de gros titres courts ; très lisible en petit ; tous les caractères du français sont présents (é è ê à ç ù œ, capitales accentuées É È À Ç, « » — … ’ × − et espace insécable), vérifié sur les fichiers.

Limite constatée : les flèches (← ↑ → ↓), l'étoile, la coche et l'espace fine insécable ne sont pas dans la police. Flèches, étoiles et coches sont donc toujours des dessins (triangles, polygones, traits), jamais du texte ; le séparateur de milliers est l'espace insécable ordinaire (U+00A0).

Fichiers à placer dans `assets/polices/` : `Barlow-Regular.ttf`, `Barlow-Medium.ttf`, `Barlow-SemiBold.ttf`, `Barlow-Bold.ttf`, `BarlowCondensed-SemiBold.ttf`, `BarlowCondensed-Bold.ttf`, plus `OFL.txt`. Mention pour les crédits : « Barlow et Barlow Condensed, © 2017 The Barlow Project Authors (licence SIL OFL 1.1) ».
Sources : https://github.com/jpt/barlow , https://github.com/google/fonts/tree/main/ofl/barlow , https://github.com/google/fonts/tree/main/ofl/barlowcondensed , licence : https://openfontlicense.org

Les SVG des maquettes nomment ces polices ; sur un poste où elles ne sont pas installées, le visionneur prend une police de secours un peu plus large. Les largeurs de texte des fiches ont été mesurées avec les vraies polices.

| Niveau | Police | Taille | Emploi |
|---|---|---|---|
| Titre du jeu | Barlow Condensed Bold | 136 (écran titre), 76 (menu, crédits) | « MARINA CITY », capitales, or |
| Bandeau | Barlow Condensed Bold | 96 | « MISSION RÉUSSIE », « ARRÊTÉ » |
| Titre d'écran | Barlow Condensed Bold | 48 | « Options », « Carte » |
| Titre de panneau | Barlow Condensed Bold ou SemiBold | 28 à 38 | Nom de mission, d'article |
| Bouton | Barlow Condensed SemiBold | 26 (24 pour un bouton de 44 ou 48 de haut) | |
| Texte fort | Barlow Medium | 20 à 26 | Réglages, raisons, conseils de chargement |
| Texte | Barlow Regular | 18 ou 20 | Descriptions |
| Petit texte | Barlow Regular ou SemiBold | 16 | Détails, étiquettes ; 16 est la taille minimale, rien en dessous |
| Étiquette | Barlow SemiBold, capitales, interlettrage 1,5 | 16 | « DERNIÈRE PARTIE », « OBJECTIFS » |
| Sous-titres de dialogue | Barlow Medium | 20, 24 ou 30 | Voir `options_audio.md` |

Interligne : 1,35 × la taille. Typographie française : espace insécable avant « : ; ? ! % » et dans les guillemets « », « FCFA » après le montant (« 12 450 FCFA »), heures « 17 h 42 », durées « 3 h 42 ».

## 4. Composants
| Composant | Mesures | Repos | Sélectionné | Indisponible |
|---|---|---|---|---|
| Bouton | Hauteur 52 ou 56 (44 ou 48 en liste dense), coins 6, texte à 24 du bord gauche (centré dans une boîte de dialogue) | Fond `26170d` à 92 %, bord `6b4a30` 1,5, texte crème | Fond or plein, texte `140a05`, bande tricolore verticale à gauche ; fond rouge et texte blanc pour une action irréversible | Fond à 60 %, bord à 50 %, texte `a3957f` ; sauté par la navigation |
| Panneau | Coins 8, marge intérieure 24 | Fond `26170d` à 92 %, bord `6b4a30` 1,5 | Bord or 4 (cartes de choix) | — |
| Onglet | 176 × 44, coins 6, espacement 8, texte centré 24 | Comme un bouton | Fond or, texte `140a05` | — |
| Ligne de réglage | Hauteur 36 à 44, libellé à gauche (Barlow Medium 20), valeur dans les 296 px de droite | Fond `26170d` | Fond or, bande tricolore | Texte `a3957f` |
| Liste à flèches | Deux triangles de 12 de part et d'autre de la valeur (Barlow SemiBold 20) | | | Flèche à 35 % en bout de liste |
| Curseur | Rail 208 × 6, poignée ronde de 18, valeur à droite | Remplissage or | Remplissage et poignée `140a05` | |
| Interrupteur | 48 × 24, pastille de 18 ; « Oui » vert `008751`, « Non » `6b4a30` ; le mot est toujours écrit | | | |
| Barre de défilement | Rail 6 de large `6b4a30` à 60 %, poignée `d6d0c4` | | | |
| Jauge | Barre 8 de haut, coins 4, rail `6b4a30` | | | |
| Boîte de confirmation | 560 de large, centrée, fond `26170d` opaque, bord or 2, coins 10, voile `140a05` à 60 % derrière ; titre Barlow Condensed Bold 34, filet tricolore 72 × 6, texte Barlow Regular 20, boutons de 48 en bas | | La sélection part toujours sur le choix qui ne détruit rien | |
| Barre d'aide | y = 664, hauteur 56, fond `140a05` à 88 %, filet `6b4a30` en haut ; aides alignées à droite (marge 48), espacées de 32 | | | |
| Capuchon de touche | Hauteur 28, largeur 28 ou texte + 16, coins 5, fond crème, liseré bas `d6d0c4` de 4, texte Barlow SemiBold 16 `140a05` | | | |
| Bouton de manette | Disque de 28, fond `3a2516`, bord crème 2, lettre Barlow Bold 16 | | | |

La sélection est unique : survoler à la souris sélectionne, exactement comme les flèches ou la croix. Elle est toujours visible par trois signes à la fois (fond or, bande tricolore, texte foncé), jamais par la couleur seule.

## 5. Commandes communes à tous les menus
| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Se déplacer | Flèches, ou Z Q S D | Survol | Croix ou stick gauche |
| Valider | Entrée ou Espace | Clic gauche | A (bouton du bas) |
| Retour, fermer | Échap | Clic droit | B (bouton de droite) |
| Onglet précédent, suivant | A, E | Clic sur l'onglet | LB, RB |
| Faire défiler | Flèches | Molette | Stick droit |
| Valeurs par défaut (options) | R | — | Y |
| Effacer, remettre (listes) | Suppr | Clic du milieu | X |

- Répétition : une direction maintenue se répète après 0,4 s, puis toutes les 0,1 s. Zone morte du stick en menu : 0,5.
- Les touches sont lues par position physique : « Z Q S D » et « A E » sur un clavier AZERTY (« W A S D » et « Q E » sur un QWERTY) ; les capuchons affichent la lettre du clavier du joueur.
- Boutons de manette nommés par position, façon A B X Y, LB RB, LT RT, Start, Vue ; dessins génériques, aucune marque.
- La barre d'aide montre les touches du dernier périphérique utilisé et change dès qu'on touche l'autre.
- En jeu (propositions, détail dans `options_de_touches.md`) : Échap ou Start = pause, M ou Vue = carte, T ou croix haut = téléphone, Tab ou croix bas = journal, P = mode photo.

## 6. Mouvement et sons
- Changement d'écran : fondu de 0,2 s (0,3 à 0,4 s vers ou depuis le jeu). Onglets : sans fondu. Élément sélectionné : passage de couleur en 0,08 s, sans rebond.
- Sons de menu à produire (noms selon `docs/conventions.md`) : `bruit_menu_deplacer.ogg`, `bruit_menu_valider.ogg`, `bruit_menu_retour.ogg`, `bruit_menu_refus.ogg`, `bruit_menu_achat.ogg`, `bruit_photo.ogg`, `bruit_succes.ogg`, `bruit_mission_echouee.ogg`, `musique_mission_reussie.ogg`.

## 7. Liste des écrans
| Écran | Fichiers | Tâche |
|---|---|---|
| Écran titre | `ecran_titre` | T5144 |
| Menu principal | `menu_principal` | T5148 |
| Nouvelle partie | `nouvelle_partie` | T5152 |
| Chargement de partie | `chargement_de_partie` | T5156 |
| Écran de chargement | `ecran_de_chargement` | T5160 |
| Menu pause | `menu_pause` | T5164 |
| Options graphiques | `options_graphiques` | T5168 |
| Options audio | `options_audio` | T5172 |
| Options de touches | `options_de_touches` | T5176 |
| Grande carte | `grande_carte` | T5180 |
| Journal de missions | `journal_de_missions` | T5184 |
| Téléphone | `telephone` | T5188 |
| Boutique | `boutique` | T5192 |
| Garage | `garage` | T5196 |
| Garde-robe | `garde_robe` | T5200 |
| Écran de mission réussie | `ecran_de_mission_reussie` | T5204 |
| Écran de mission échouée | `ecran_de_mission_echouee` | T5208 |
| Écran d'arrestation | `ecran_d_arrestation` | T5212 |
| Écran d'hôpital | `ecran_d_hopital` | T5216 |
| Statistiques | `statistiques` | T5220 |
| Succès | `succes` | T5224 |
| Crédits | `credits` | T5228 |
| Choix de la langue | `choix_de_la_langue` | T5232 |
| Mode photo | `mode_photo` | T5236 |
| Tutoriel à l'écran | `tutoriel_a_l_ecran` | T5240 |

Enchaînement général : écran titre → menu principal → (nouvelle partie ou chargement de partie) → écran de chargement → jeu. En jeu : pause (carte, journal, sauvegarde, options, mode photo, statistiques, succès), téléphone, boutique, garage, garde-robe, tutoriel ; fins : mission réussie, mission échouée, arrestation, hôpital.

## 8. Ce que les maquettes ne fixent pas
- Les noms de missions, de chapitres, de commerces et les prix sont des exemples cohérents avec `docs/decisions.md` ; les valeurs définitives viendront de `docs/histoire/` et des lots « économie » et « police ».
- Les fonds illustrés (coucher de soleil, rue) sont des dessins d'attente à remplacer par des images du jeu.
- Le logo du jeu (T5244) et l'image de couverture (T5248) ne sont pas traités ici : le titre est composé en Barlow Condensed Bold.
