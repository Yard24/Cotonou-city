# Haie Vive — plan des rues (T0973)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.352 à 6.356 N, longitude 2.394 à 2.400 E (centre 6.354 N, 2.397 E).
- Emprise correspondante : environ 660 m d'est en ouest sur 440 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Cadjèhoun à l'est et au nord, aéroport à l'ouest, Les Cocotiers au sud-est.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Rue principale de Haie Vive (nom non relevé) | rue pavée | WV | WV : tout le quartier s'organise le long d'une seule rue, qui se termine à la « fin pavé » |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour de Haie Vive (titre de la carte LP)

## Repères

- Restaurants et bars alignés sur la rue principale (WV) ; enseignes à inventer (décision 25)
- Aéroport tout proche (WV)

## Bâti et densité

Quartier aisé : villas clôturées, restaurants, immeubles bas. (WV, LP pour le standing ; détails non recoupés)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 270 m (est-ouest) × 240 m (nord-sud), soit 3 îlots sur 3.
- Pas de la grille : 90 m d'est en ouest, 80 m du nord au sud, mesurés d'axe à axe ; 4 voies nord-sud de 240 m et 4 voies est-ouest de 270 m.
- Gabarits : une rue principale de 7 m sur 400 m, vons de 5 m perpendiculaires.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 1.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/haie_vive.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
