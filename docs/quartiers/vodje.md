# Vodjè — plan des rues (T0945)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.365 à 6.371 N, longitude 2.406 à 2.414 E (centre 6.368 N, 2.410 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Cadjèhoun à l'ouest, Gbégamey au sud, Place de l'Étoile Rouge à l'est, Wologuèdè au nord-est.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Avenue du Canada (voie 12.528) | avenue en cours de pavage (2026) | BW | relie le carrefour de Cadjèhoun à l'Étoile Rouge en passant par le carrefour de Vodjè |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour de Vodjè (BW) : entre un supermarché et l'Étoile Rouge

## Repères

- « Vodjè kpota » figure dans la liste des quartiers du 12e arrondissement (MO)

## Bâti et densité

Résidentiel mixte, villas et immeubles R+1 à R+3. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 400 m (est-ouest) × 300 m (nord-sud), soit 5 îlots sur 4.
- Pas de la grille : 80 m d'est en ouest, 75 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 300 m et 5 voies est-ouest de 400 m.
- Gabarits : axe ouest-est = avenue du Canada (14 m).
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/vodje.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- BW — Article de presse sur les travaux de l'avenue du Canada (2026) : https://beninwebtv.com/en/cotonou-traffic-disruptions-announced-in-cadjehoun-vodje-and-etoile-rouge/
- MO — Mémoire universitaire sur le 12e arrondissement (limites, liste des quartiers, 13,43 km²) : https://www.memoireonline.com/01/14/8472/m_Evolution-demographique-et-occupation-du-sol-en-milieu-urbain-Cas-du-12eme-arrondissement-de-Coto6.html
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
