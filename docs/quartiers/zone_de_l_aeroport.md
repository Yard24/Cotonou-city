# Zone de l'aéroport — plan des rues (T1001)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.353 à 6.361 N, longitude 2.373 à 2.397 E (centre 6.357 N, 2.385 E).
- Emprise correspondante : environ 2650 m d'est en ouest sur 880 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Haie Vive et Cadjèhoun à l'est, Aïbatin au nord, Fidjrossè à l'ouest, plage au sud.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Route de l'Aéroport | route | LP, WV | — |
| Rue 230 | rue | WV | WV : rejoint le boulevard de la Marina près d'une aire de jeux de plage, à côté de la piste |
| Boulevard de la Marina | boulevard | WV | longe le sud |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Rond-point de l'aéroport (WV)

## Repères

- Aéroport international de Cotonou-Cadjèhoun (LP, WF) : une piste
- Plage au sud de la piste (WV)

## Bâti et densité

Emprise clôturée : une piste, aérogare, parkings ; aucun habitat. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 1200 m (est-ouest) × 300 m (nord-sud), soit 2 îlots sur 1.
- Pas de la grille : 600 m d'est en ouest, 300 m du nord au sud, mesurés d'axe à axe ; 3 voies nord-sud de 300 m et 2 voies est-ouest de 1200 m.
- Gabarits : piste de 1 200 m à l'échelle du jeu (environ 2 400 m réels, valeur à vérifier) ; route d'accès de 14 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 5 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/zone_de_l_aeroport.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
