# Fidjrossè — plan des rues (T1043)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.352 à 6.360 N, longitude 2.359 à 2.373 E (centre 6.356 N, 2.366 E).
- Emprise correspondante : environ 1550 m d'est en ouest sur 880 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Aéroport à l'est, Fiyégnon à l'ouest et au sud-ouest, océan au sud, Aïbatin au nord-est.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Route des Pêches | piste côtière puis route | WF, WV, LP | part de Fidjrossè vers Ouidah en longeant la mer |
| Rue du Collège Père Aupiais | rue | LP | étiquette de la carte Cadjèhoun/Fidjrossè ; position à relever |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Place Calvaire (WV)
- « Fin pavé » de Fidjrossè (WV) : bout de la voie pavée, départ de la piste

## Repères

- Plage et maquis de plage (WV)
- Quartiers Fidjrossè centre et Fidjrossè kpota (MO)

## Bâti et densité

Résidentiel en bord de mer, villas et petits immeubles, vons sableux. (WV pour le caractère ; reste non recoupé)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 540 m (est-ouest) × 320 m (nord-sud), soit 6 îlots sur 4.
- Pas de la grille : 90 m d'est en ouest, 80 m du nord au sud, mesurés d'axe à axe ; 7 voies nord-sud de 320 m et 5 voies est-ouest de 540 m.
- Gabarits : axe pavé de 7 m sur 540 m jusqu'à la « fin pavé », puis piste de 5 m ; plage de 60 m de large au sud.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 3 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/fidjrosse.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- MO — Mémoire universitaire sur le 12e arrondissement (limites, liste des quartiers, 13,43 km²) : https://www.memoireonline.com/01/14/8472/m_Evolution-demographique-et-occupation-du-sol-en-milieu-urbain-Cas-du-12eme-arrondissement-de-Coto6.html
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
