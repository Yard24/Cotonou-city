# Écran de chargement — maquette

- Tâche : T5160 (« Écran de chargement : dessiner la maquette »).
- Image : `ecran_de_chargement.svg` (1280 × 720, l'origine est en haut à gauche, les mesures sont en pixels).
- Règles communes (couleurs, polices, boutons, touches par défaut) : `charte.md`.

## Rôle
Faire patienter pendant que la carte se charge, dire où l'on arrive et glisser un conseil de jeu.

## Quand il s'affiche
Entre le menu et le jeu (nouvelle partie, « Continuer », chargement d'une sauvegarde), et lors d'un voyage rapide (avion Cotonou-Parakou, décision 56).

## Éléments
Du fond vers le premier plan. « Position » = coin haut-gauche de l'élément.

| N° | Élément | Position (x, y) | Taille (l × h) | Texte exact | Rôle, style, état |
|---|---|---|---|---|---|
| 1 | Illustration du quartier | 0, 0 | 1280 × 720 | — | Coucher de soleil sur la lagune : ciel en dégradé (1d0f08, 8a3d1e, f09a4e, f6cf96), soleil ffdcaa, ville et pont en silhouette 2b170b sur la ligne y = 470, eau 2a86b5 vers 143f58, pirogue et palmiers en 140a05. À remplacer par une image du jeu quand la carte sera construite. |
| 2 | Dégradé du bas | 0, 440 | 1280 × 280 | — | Dégradé vertical de transparent à 140a05 à 92 %, pour la lisibilité du conseil. |
| 3 | Nom du lieu | 48, 58 | 154 × 84 | « Ganhi » | Barlow Condensed Bold 76, crème. Quartier où la partie reprend. |
| 4 | Filet tricolore | 48, 136 | 96 × 6 | — | Trois segments de 32 × 6. |
| 5 | Ville, année, chapitre | 48, 156 | 245 × 24 | « Cotonou · 2017 · Chapitre 1 » | Barlow Medium 22. |
| 6 | Étiquette « Conseil » | 48, 531 | 72 × 18 | « CONSEIL » | Barlow SemiBold 16, capitales, interlettrage 1,5, jaune pâle ffe27a. |
| 7 | Texte du conseil | 48, 557 | 900 × 63 | « Les motos se faufilent entre les voitures : dans un embouteillage, passe par le milieu. » | Barlow Medium 26, interligne 34, largeur 900 au plus, 2 lignes au plus. |
| 8 | Barre de progression | 48, 644 | 1184 × 8 | — | Rail 6b4a30, remplissage or f5c400, coins 4. Ici 64 %. |
| 9 | Pourcentage | 1079, 613 | 153 × 20 | « Chargement… 64 % » | Barlow Medium 18, aligné à droite au-dessus de la barre. |
| 10 | Barre d'aide | 0, 664 | 1280 × 56 | « [Droite] Conseil suivant » | Rappel des touches, aligné à droite (marge 48). Affiche les touches du clavier ou les boutons de la manette selon le dernier périphérique utilisé. |

## Commandes

| Action | Clavier | Souris | Manette |
|---|---|---|---|
| Conseil suivant | Flèche droite, D ou Espace | Clic gauche | A ou croix droite |
| Aucune autre action | Échap ne fait rien | — | B ne fait rien |

## Enchaînements
- À 100 % : fondu au noir de 0,4 s, puis le jeu (Koffi devant son logement, ou au point de contrôle de la mission en cours).
- Aucun retour en arrière possible pendant le chargement.
- En cas d'échec de lecture de la sauvegarde : retour à `chargement_de_partie.md` avec la mention « Sauvegarde abîmée ».

## Règles et états
- L'écran reste affiché au moins 1,5 s, même si le chargement est plus court, pour laisser lire le lieu.
- La barre ne recule jamais ; le pourcentage est arrondi à l'entier.
- L'illustration dépend du quartier d'arrivée (une image par quartier listé plus bas) ; tant qu'elles n'existent pas, on utilise le coucher de soleil de l'écran titre.
- La musique du menu baisse de 12 dB pendant le chargement et s'arrête au fondu.
- Lors d'un voyage rapide, le nom du lieu est celui de la destination et la troisième ligne devient « Vol Cotonou-Parakou · 1 h 05 ».

## Liste des conseils
Un conseil est tiré au hasard à l'ouverture, puis change toutes les 8 secondes ou à la demande, sans répétition avant d'avoir fait le tour.

1. « Les motos se faufilent entre les voitures : dans un embouteillage, passe par le milieu. »
2. « À moto, le frein arrière (Espace) aide à tourner serré. »
3. « Le kpayo coûte moins cher que la station, mais il peut faire tousser ton moteur. »
4. « Manger dans un maquis ou chez une vendeuse de rue rend de la santé. »
5. « De 7 h à 9 h et de 17 h à 20 h, les grands carrefours et les ponts sont bouchés. »
6. « Un client lève le bras ? Arrête-toi près de lui et appuie sur E pour accepter la course. »
7. « Tu peux marchander le prix d'une course : trois échanges au plus. »
8. « Emprunter un véhicule devant un policier, c'est une étoile assurée. »
9. « Devant un agent droit, proposer un petit geste double l'amende. »
10. « Le jeu sauvegarde tout seul après chaque mission. »
11. « Koffi sait nager : entre dans l'eau et maintiens Maj pour aller plus vite. »
12. « On roule à droite. Les autres aussi, en principe. »
13. « Rembourse Tonton Gratien avant qu'il ne vienne te chercher lui-même. »
14. « Appuie sur M pour ouvrir la grande carte et poser un repère. »

## Noms de lieu affichés
« Ganhi », « La Marina », « Dantokpa », « Missèbo », « Étoile Rouge », « Place de l'Amazone », « Akpakpa », « Le port », « Fidjrossè », « L'aéroport ». Les autres villes, plus tard : « Porto-Novo », « Ouidah », « Abomey », « Parakou ».

## Pour le codage (Godot 4.3)
- Écran construit en nœuds `Control` dans un `CanvasLayer` ; la fenêtre de référence est 1280 × 720 (`canvas_items`, aspect `expand`) : ancrer les éléments au bord indiqué pour que l'écran reste juste en 16:10 et 21:9.
- Chargement en arrière-plan avec `ResourceLoader.load_threaded_request` ; la progression vient de `load_threaded_get_status` (tableau `progress`).
- Les conseils sont dans un tableau de chaînes (fichier de traduction, clés `CONSEIL_01` à `CONSEIL_14`) pour préparer l'anglais (décision 117).
