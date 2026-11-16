# Saint-Michel — plan des rues (T0861)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.362 à 6.368 N, longitude 2.424 à 2.432 E (centre 6.365 N, 2.428 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Dantokpa à l'est, Zongo et Jonquet au sud, Gbégamey à l'ouest, Sikècodji au nord.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Boulevard Saint-Michel | boulevard | LP, WV, NT | NT décrit un tronçon du carrefour SONEB au carrefour de l'État-major de l'armée de l'air / Vice-Présidence, puis jusqu'au boulevard de la Marina |
| Rue 201A | rue | LP, WV | WV : un pâté de maisons au nord du boulevard, près du Hall des arts |
| Avenue Germain Olory Togbé (« avenue Togbé » sur LP) | avenue | LP, WV | WV : juste au nord du carrefour Saint-Michel |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour Saint-Michel (WV)
- Carrefour SONEB (NT)

## Repères

- Église Saint-Michel (donne son nom au quartier ; décor seulement, décision 18)
- Centre artisanal sur le boulevard (WV)
- Hall des arts, loisirs et sports (WF, WV)

## Bâti et densité

Immeubles R+2 à R+5 le long du boulevard, habitat à cour derrière. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 400 m (est-ouest) × 280 m (nord-sud), soit 5 îlots sur 4.
- Pas de la grille : 80 m d'est en ouest, 70 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 280 m et 5 voies est-ouest de 400 m.
- Gabarits : axe est-ouest = boulevard Saint-Michel (14 m).
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/saint_michel.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- NT — Article de presse sur la fermeture du boulevard Saint-Michel (juillet-novembre 2026) : https://lanouvelletribune.info/2026/07/benin-rehabilitation-du-boulevard-saint-michel-voici-les-deviations-prevues/
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
