# Ganhi — plan des rues (T0749)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.348 à 6.356 N, longitude 2.428 à 2.438 E (centre 6.352 N, 2.433 E).
- Emprise correspondante : environ 1110 m d'est en ouest sur 880 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Guinkomey et Zongo au nord, Placodji/Xwlacodji à l'est, zone portuaire à l'ouest, boulevard de la Marina et océan au sud.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Boulevard de la Marina | boulevard | LP, WV, WE | longe le front de mer ; orientation générale est-ouest (WE le place entre la ville et l'océan) |
| Avenue Steinmetz (« boulevard Steinmetz » sur le plan LP) | avenue | LP, WV | WV signale un passage supérieur sur cette avenue, côté Ganhi |
| Avenue Clozel | avenue | LP | étiquette voisine de « Plakodji » et d'un poste de police sur le plan |
| Avenue Jean-Paul II | avenue | LP, NT | axe ouvert pendant la fermeture du boulevard Saint-Michel |
| Avenue du Gouverneur Fourn, rue du Gouverneur Bayol, avenue Dodds (« avenue du général Dodds » selon WF) | avenues et rue | LP, WF | présentes sur la carte du centre ; rattachement à Ganhi probable mais non vérifié |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Carrefour « Trois Banques » (NT) : sur l'itinéraire de déviation entre le port et la direction de l'immigration ; position exacte à relever
- Carrefour de la BCEAO (étiquette LP ; c'est une institution publique, à représenter sans inscription)

## Repères

- Marché Ganhi (LP)
- Commissariat central (LP)
- Front de mer et plage au sud du boulevard de la Marina (WV)
- Passants étrangers prévus par la décision 49

## Bâti et densité

Quartier d'affaires : immeubles de bureaux de 3 à 10 étages, banques et commerces en rez-de-chaussée, voies bitumées ou pavées ; densité bâtie forte, peu d'habitat. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 450 m (est-ouest) × 320 m (nord-sud), soit 5 îlots sur 4.
- Pas de la grille : 90 m d'est en ouest, 80 m du nord au sud, mesurés d'axe à axe ; 6 voies nord-sud de 320 m et 5 voies est-ouest de 450 m.
- Gabarits : axe sud = boulevard de la Marina (14 m) ; un axe nord-sud = avenue Steinmetz (14 m).
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/ganhi.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WE — Wikipédia en anglais, article Cotonou : https://en.wikipedia.org/wiki/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- NT — Article de presse sur la fermeture du boulevard Saint-Michel (juillet-novembre 2026) : https://lanouvelletribune.info/2026/07/benin-rehabilitation-du-boulevard-saint-michel-voici-les-deviations-prevues/
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
