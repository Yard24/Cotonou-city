# Dantokpa — plan des rues (T0819)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.365 à 6.371 N, longitude 2.433 à 2.441 E (centre 6.368 N, 2.437 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Berge de la lagune à l'est, Missèbo au sud, Saint-Michel à l'ouest.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Boulevard Saint-Michel | boulevard | LP, WV | WV : le grand marché est sur ce boulevard, au bord de la lagune |
| Avenue du Nouveau Pont | avenue | LP | nom lu sur le plan ; lien avec le marché à relever |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Tête de pont côté marché (WF : trois ponts franchissent la lagune, sans nom)
- Station de taxis de Dantokpa (WV)

## Repères

- Grand marché de Dantokpa, environ 20 hectares (WF)
- Berge de la lagune (WV)
- Étal de tissus de Nan Akouavi (décision 32) ; maison d'enfance de Koffi à proximité (décision 9)

## Bâti et densité

Halles couvertes, hangars et allées d'étals ; environ 20 ha de marché. Autour : boutiques à R+1. Densité piétonne maximale du jeu. (surface : WF ; reste : connaissance générale)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 450 m (est-ouest) × 440 m (nord-sud), soit 5 îlots sur 4.
- Pas de la grille : 90 m d'est en ouest, 110 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 440 m et 5 voies est-ouest de 450 m.
- Gabarits : emprise du marché 450 × 440 m à l'échelle réelle, soit environ 320 × 310 m à l'échelle du jeu ; boulevard Saint-Michel (14 m) en bordure.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/dantokpa.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
