# Gbégamey — plan des rues (T0875)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.358 à 6.366 N, longitude 2.409 à 2.419 E (centre 6.362 N, 2.414 E).
- Emprise correspondante : environ 1110 m d'est en ouest sur 880 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Saint-Michel et Jonquet à l'est, Vodjè au nord, Cadjèhoun à l'ouest, Les Cocotiers au sud.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Rue de la Poste | rue | LP | WV situe un lieu « deux vons à l'est de la Poste » à Gbégamey |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Aucun attesté.

## Repères

- Bureau de poste (WV)
- Collège public de Gbégamey et son terrain de football (cité par un annuaire en ligne)

## Bâti et densité

Résidentiel de classe moyenne, villas et immeubles R+1 à R+3, damier régulier. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 400 m (est-ouest) × 400 m (nord-sud), soit 5 îlots sur 5.
- Pas de la grille : 80 m d'est en ouest, 80 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 400 m et 6 voies est-ouest de 400 m.
- Gabarits : axes de 7 m, vons de 5 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/gbegamey.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
