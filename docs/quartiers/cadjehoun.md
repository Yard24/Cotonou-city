# Cadjèhoun — plan des rues (T0959)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.354 à 6.362 N, longitude 2.395 à 2.405 E (centre 6.358 N, 2.400 E).
- Emprise correspondante : environ 1110 m d'est en ouest sur 880 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Haie Vive et l'aéroport à l'ouest, Vodjè au nord-est, Les Cocotiers au sud-est, Houéyiho au nord.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Avenue du Canada (voie 12.528) | avenue | BW | part du carrefour de Cadjèhoun vers Vodjè et l'Étoile Rouge |
| Route de l'Aéroport | route | LP, WV | — |
| Avenue Jean-Paul II | avenue | LP, WV | — |
| Route de Lomé | route | LP | sortie ouest |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour de Cadjèhoun, « le grand feu » (BW, WV)
- Place de Bulgarie, rond-point (LP, WV)

## Repères

- Quartiers Cadjèhoun, Cadjèhoun 2, Cadjèhoun 3 et Cadjèhoun kpota (MO)
- Arrêt de taxis-brousse (LP)

## Bâti et densité

Résidentiel et administratif, villas, immeubles R+2 à R+4. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 425 m (est-ouest) × 400 m (nord-sud), soit 5 îlots sur 5.
- Pas de la grille : 85 m d'est en ouest, 80 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 400 m et 6 voies est-ouest de 425 m.
- Gabarits : axes de 14 m : route de l'Aéroport et avenue du Canada.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/cadjehoun.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- BW — Article de presse sur les travaux de l'avenue du Canada (2026) : https://beninwebtv.com/en/cotonou-traffic-disruptions-announced-in-cadjehoun-vodje-and-etoile-rouge/
- MO — Mémoire universitaire sur le 12e arrondissement (limites, liste des quartiers, 13,43 km²) : https://www.memoireonline.com/01/14/8472/m_Evolution-demographique-et-occupation-du-sol-en-milieu-urbain-Cas-du-12eme-arrondissement-de-Coto6.html
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
