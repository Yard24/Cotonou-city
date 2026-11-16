# Placodji — plan des rues (T0777)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

Remarque : WF écrit « Xwlacodji ou Placodji » : les deux noms désignent le même secteur. Le CSV en fait deux lots ; choix : Placodji = moitié ouest (côté Ganhi), Xwlacodji = moitié est (berge et plage). Découpage de jeu, pas un découpage administratif vérifié.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.348 à 6.354 N, longitude 2.435 à 2.443 E (centre 6.351 N, 2.439 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Ganhi à l'ouest, chenal de la lagune à l'est, océan au sud, Guinkomey et Missèbo au nord.

## Voies principales attestées

| Voie | Type | Source | Ce que dit la source |
|---|---|---|---|
| Avenue Clozel | avenue | LP | étiquette proche de « Plakodji » |
| Boulevard de la Marina | boulevard | LP | extrémité est, non vérifiée |

Orientation précise, longueur et liste des croisements : **non relevées** (géométrie indisponible).

## Carrefours et ronds-points notables

- Débouché de l'ancien pont (« Ancien Pont » et « avenue du Nouveau Pont » lisibles sur LP ; lequel des deux touche le quartier reste à relever)

## Repères

- Cathédrale de Cotonou « près de l'ancien pont » (WV)
- Port de pêche artisanale (WF)
- Lagune de Cotonou, chenal creusé en 1855 (WF)

## Bâti et densité

Ancien village de pêcheurs : parcelles serrées, maisons basses en dur et en tôle, ruelles sableuses. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 240 m (est-ouest) × 240 m (nord-sud), soit 4 îlots sur 4.
- Pas de la grille : 60 m d'est en ouest, 60 m du nord au sud, mesurés d'axe à axe ; 5 voies nord-sud de 240 m et 5 voies est-ouest de 240 m.
- Gabarits : un axe ouest-est = avenue Clozel (7 m) ; le reste en vons de 5 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 1 × 1.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/placodji.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- LP — Plan de ville d'un guide de voyage (PDF, deux cartes : centre et Cadjèhoun/Haie Vive) : https://media.lonelyplanet.com/ebookmaps/Africa/cotonou.pdf — seul le texte des étiquettes a pu être lu, pas le dessin : les noms sont attestés, leur position exacte et leurs croisements ne le sont pas.
- WV — Guide de voyage collaboratif (copie hors ligne de Wikivoyage, article Cotonou) : https://kwx.liehendr.com/content/wikivoyage_en_all_maxi_2025-02/A/Cotonou
- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
