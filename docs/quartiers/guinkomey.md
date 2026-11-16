# Guinkomey — plan des rues (T0847)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.354 à 6.360 N, longitude 2.431 à 2.437 E (centre 6.357 N, 2.434 E).
- Emprise correspondante : environ 660 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Ganhi au sud, Zongo à l'ouest, Missèbo au nord, Placodji et la lagune à l'est.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Avenue Steinmetz | avenue | LP | passe par le centre ; tronçon dans Guinkomey à relever |
| Avenue de la République, avenue van Vollenhoven | avenues | LP | rattachement non vérifié |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour Legba (étiquette LP ; position à relever)

## Repères

- Étiquette « Guinkomey » sur le plan LP entre Ganhi et Zongo

## Bâti et densité

Vieux centre : maisons anciennes à cour, immeubles commerciaux R+2 à R+4, voies pavées. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 280 m (est-ouest) × 280 m (nord-sud), soit 4 îlots sur 4.
- Pas de la grille : 70 m d'est en ouest, 70 m du nord au sud, mesurés d'axe à axe ; 5 voies nord-sud de 280 m et 5 voies est-ouest de 280 m.
- Gabarits : deux axes de 7 à 14 m, vons de 5 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/guinkomey.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
