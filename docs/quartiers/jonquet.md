# Jonquet — plan des rues (T0833)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

Remarque : WF nomme le quartier « Avlékété-Jonquet ».

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.356 à 6.362 N, longitude 2.420 à 2.428 E (centre 6.359 N, 2.424 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Zongo et Guinkomey à l'est, Gbégamey à l'ouest, Saint-Michel au nord, zone portuaire au sud.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Rue des Cheminots | rue | LP, WV | WV : « rue des bars » de Jonquet |
| Rue Caporal Bertrand Anani, rue Dako Donou, rue Capitaine Adjovi | rues | LP | présentes sur la carte du centre ; rattachement à Jonquet non vérifié |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Gare routière de Jonquet (WV : station de taxis et de cars)

## Repères

- Gare routière de Jonquet (WV)
- Gare ferroviaire (étiquette LP) et voie ferrée
- Quartier animé la nuit (bars et maquis ; à traiter selon les décisions 5 et 70 : ni prostitution ni jeux d'argent)

## Bâti et densité

Parcellaire en damier, maisons à cour et immeubles R+1 à R+3, bars en rez-de-chaussée. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 350 m (est-ouest) × 280 m (nord-sud), soit 5 îlots sur 4.
- Pas de la grille : 70 m d'est en ouest, 70 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 280 m et 5 voies est-ouest de 350 m.
- Gabarits : un axe de 7 m = rue des Cheminots ; vons de 5 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/jonquet.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
