# Fiyégnon — plan des rues (T1057)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.349 à 6.355 N, longitude 2.349 à 2.359 E (centre 6.352 N, 2.354 E).
- Emprise correspondante : environ 1110 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Fidjrossè à l'est et au nord, océan au sud, commune d'Abomey-Calavi à l'ouest.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Route des Pêches | piste côtière | WF, WV | traverse le secteur vers l'ouest, à vérifier |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Aucun attesté.

## Repères

- Quartiers Fiyégnon 1 et Fiyégnon 2 (MO)
- Plage

## Bâti et densité

Habitat de bord de mer, constructions basses, cocotiers, sable. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 320 m (est-ouest) × 210 m (nord-sud), soit 4 îlots sur 3.
- Pas de la grille : 80 m d'est en ouest, 70 m du nord au sud, mesurés d'axe à axe ; 5 voies nord-sud de 210 m et 4 voies est-ouest de 320 m.
- Gabarits : piste de 5 m parallèle à la mer ; plage de 60 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 1.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/fiyegnon.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- MO — Mémoire universitaire sur le 12e arrondissement (limites, liste des quartiers, 13,43 km²) : https://www.memoireonline.com/01/14/8472/m_Evolution-demographique-et-occupation-du-sol-en-milieu-urbain-Cas-du-12eme-arrondissement-de-Coto6.html
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
