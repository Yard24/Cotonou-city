# Les Cocotiers — plan des rues (T0987)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.350 à 6.356 N, longitude 2.402 à 2.410 E (centre 6.353 N, 2.406 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Cadjèhoun au nord, Haie Vive à l'ouest, boulevard de la Marina et océan au sud.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Boulevard de la Marina | boulevard | LP, WV, NT | en limite sud, à vérifier |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Place de l'Amazone (NT ; WE la situe au bord de l'océan) : position par rapport au quartier à relever

## Repères

- Quartier cité avec Haie Vive parmi les secteurs aisés du 12e arrondissement (presse locale)
- Monument de l'Amazone (WE ; simplifié, décision 26)

## Bâti et densité

Villas, résidences et ambassades, rues arborées, faible densité. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 400 m (est-ouest) × 270 m (nord-sud), soit 4 îlots sur 3.
- Pas de la grille : 100 m d'est en ouest, 90 m du nord au sud, mesurés d'axe à axe ; 5 voies nord-sud de 270 m et 4 voies est-ouest de 400 m.
- Gabarits : axe sud = boulevard de la Marina (14 m).
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/les_cocotiers.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WE — Wikipédia en anglais, article Cotonou : https://en.wikipedia.org/wiki/Cotonou
- NT — Article de presse sur la fermeture du boulevard Saint-Michel (juillet-novembre 2026) : https://lanouvelletribune.info/2026/07/benin-rehabilitation-du-boulevard-saint-michel-voici-les-deviations-prevues/
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
