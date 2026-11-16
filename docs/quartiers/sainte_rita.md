# Sainte-Rita — plan des rues (T0931)

**État : RELEVÉ INCOMPLET — ne pas utiliser comme plan vérifié.** Le 16 novembre 2026, les données OpenStreetMap n'ont pas pu être obtenues (voir « Ce qui manque »). Ce fichier sépare ce qui est attesté par une source de ce qui ne l'est pas. Aucun nom de voie n'a été inventé.

Remarque : Aucune source consultée ne décrit ce quartier.

## Limites et coordonnées

- Rectangle **approximatif, donné de mémoire, non vérifié sur carte** : latitude 6.375 à 6.381 N, longitude 2.411 à 2.419 E (centre 6.378 N, 2.415 E).
- Emprise correspondante : environ 880 m d'est en ouest sur 660 m du nord au sud (1° ≈ 110,6 km à cette latitude).
- À remplacer par le rectangle réel dès que la carte est accessible.

## Quartiers voisins (non vérifié sur carte)

Wologuèdè au sud, Vodjè au sud-ouest.

## Voies principales attestées

Aucune voie nommée n'est attestée par les sources consultées. Rien n'est inventé ici.

## Carrefours et ronds-points notables

- Aucun attesté.

## Repères

- Église Sainte-Rita (donne son nom au quartier ; décor seulement, décision 18)

## Bâti et densité

Habitat populaire, zones basses inondables en saison des pluies. (connaissance générale, non recoupée)

## Proposition de plan simplifié pour le jeu (provisoire)

Échelle du jeu : la moitié des distances réelles (`docs/monde.md`). Cette grille est un gabarit de travail, pas un relevé.
- Emprise de jeu : 280 m (est-ouest) × 280 m (nord-sud), soit 4 îlots sur 4.
- Pas de la grille : 70 m d'est en ouest, 70 m du nord au sud, mesurés d'axe à axe ; 5 voies nord-sud de 280 m et 5 voies est-ouest de 280 m.
- Gabarits : vons de 5 m ; un axe pavé de 7 m.
- Les voies sans nom attesté restent sans nom dans le jeu (repérées N1…, E1… dans le code) tant que le relevé n'est pas fait.
- Zones de chargement de 250 m : 2 × 2.

## Ce qui manque pour déclarer la tâche faite

1. Le tracé réel des voies (points latitude/longitude), leur revêtement et leurs croisements : requête Overpass `way["highway"]` sur le rectangle du quartier.
2. Le rectangle exact et les voisins, vérifiés sur la carte.
3. Le fichier `docs/quartiers/donnees/sainte_rita.json` (non créé : aucune donnée OpenStreetMap obtenue).

Accès tentés et refusés ou en erreur : API Nominatim, API Overpass (serveur principal et six miroirs, dont un seul a répondu mais ne couvre que la Suisse), API et recherche d'openstreetmap.org, Photon ; l'accès direct par la ligne de commande est bloqué par le proxy (403).

## Sources

- Aucune source exploitable trouvée pour ce quartier.
- Liste des quartiers et graphies : `plan/taches.csv`, `docs/decisions.md`.
