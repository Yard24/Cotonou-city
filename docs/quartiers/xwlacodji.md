# Xwlacodji — plan des rues (T0791)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

Remarque : Même secteur que Placodji selon WF (voir placodji.md). Aucun nom de voie attesté pour cette moitié est.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.347 à 6.353 N, longitude 2.439 à 2.445 E (centre 6.350 N, 2.442 E).
- Emprise correspondante : environ 660 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Placodji à l'ouest, chenal de la lagune à l'est (Akpakpa en face), océan au sud.

## Voies principales attestées

Aucune voie nommée n'est attestée par les sources consultées. Rien n'est inventé ici.

## Carrefours et ronds-points notables

- Embouchure du chenal de la lagune (WF)

## Repères

- Port de pêche artisanale (WF)
- Plage et embouchure
- Lagune de Cotonou (WF)

## Bâti et densité

Habitat de pêcheurs, pirogues tirées sur le sable, fumoirs à poisson ; bâti bas et dense. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 180 m (est-ouest) × 240 m (nord-sud), soit 3 îlots sur 4.
- Pas de la grille : 60 m d'est en ouest, 60 m du nord au sud, mesurés d'axe à axe ; 4 voies nord-sud de 240 m et 5 voies est-ouest de 180 m.
- Gabarits : uniquement des vons de 5 m et une piste de berge.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 1 × 1.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/xwlacodji.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- WF — Wikipédia en français, article Cotonou : https://fr.wikipedia.org/wiki/Cotonou
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
