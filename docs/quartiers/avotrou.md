# Avotrou — plan des rues (T1323)

**Statut : NON FAIT (16 novembre 2026).** Le tracé des rues n'a pas pu être relevé : ce fichier ne contient que ce qui a été vérifié, et la marche à suivre pour finir. Aucun nom de rue, aucune longueur et aucune grille de jeu n'y figure, parce que rien de tout cela n'a pu être contrôlé sur une carte.

## Pourquoi le relevé a échoué
- API Overpass (overpass-api.de, overpass.kumi.systems, overpass.private.coffee), API Nominatim, API de carte et pages de recherche d'openstreetmap.org, photon.komoot.io : toutes refusées à l'outil de lecture web (interdiction par robots.txt ou erreur serveur).
- Depuis la ligne de commande, la sortie réseau de la session refuse ces hôtes (réponse 403 de la passerelle). Il faut les autoriser dans les réglages de la session, ou fournir un extrait OpenStreetMap du Bénin dans le dépôt.
- Les sources restantes (Wikipédia, GeoNames, annuaires dérivés) ne donnent ni tracé, ni nom de voie, ni croisement pour ce quartier.

## Ce qui est vérifié
- Point de repère GeoNames (geonames.org, licence CC BY 4.0) : 6,37523 N, 2,47525 E (point « Avotrou », section de lieu habité). C'est un point, pas un contour.
- Arrondissement : 1er (liste des quartiers de l'article Wikipédia « 1er arrondissement de Cotonou » ; ancienne commune du 1er avec Dandji).
- Autres quartiers du 1er arrondissement cités par Wikipédia : Dandji, Donaten, Finagnon, Tchanhounkpamè, Tokplégbé, N'vènamèdé, Suru-Léré, Tanto, Yagbé.
- Centre du 1er arrondissement selon GeoNames : 6,36620 N, 2,47551 E ; point « Tokplegbe » : 6,36425 N, 2,48149 E.

## Ce qui manque (tout le cœur de la tâche)
- Limites du quartier et rectangle latitude/longitude.
- Quartiers voisins sur chaque côté.
- Voies principales : nom, type (boulevard, rue pavée, rue en terre), orientation, croisements.
- Carrefours et ronds-points notables.
- Repères : marchés, écoles, lieux de culte, berges.
- Type de bâti et densité.
- Plan simplifié pour le jeu (grille de voies avec longueurs en mètres).
- Fichier `docs/quartiers/donnees/avotrou.json` (non créé : aucune donnée OpenStreetMap obtenue).

## Marche à suivre dès que l'accès à OpenStreetMap est ouvert
1. Trouver l'emprise :
   `https://nominatim.openstreetmap.org/search?q=Avotrou,+Cotonou,+Bénin&format=json&polygon_geojson=1&limit=5`
   Noter `boundingbox` (sud, nord, ouest, est) et le type d'objet (contour ou simple point).
   À défaut de réponse, rectangle de recherche provisoire de 1,3 km de côté autour du point GeoNames (ce n'est PAS la limite du quartier) : sud 6,36923, ouest 2,46925, nord 6,38123, est 2,48125.
2. Relever les voies (remplacer le rectangle si Nominatim en donne un meilleur) :
   `https://overpass-api.de/api/interpreter?data=[out:json][timeout:60];way[highway](6.36923,2.46925,6.38123,2.48125);out tags geom;`
3. Relever les repères dans le même rectangle :
   `[out:json][timeout:60];(nwr[amenity~"marketplace|school|place_of_worship|hospital"](6.36923,2.46925,6.38123,2.48125);nwr[junction=roundabout](6.36923,2.46925,6.38123,2.48125);nwr[natural=water](6.36923,2.46925,6.38123,2.48125););out tags center;`
4. Classer les voies : `highway=trunk/primary/secondary` = boulevard ou avenue (14 m dans le jeu) ; `tertiary/residential` avec `surface=paving_stones/asphalt` = rue pavée (7 m) ; `surface=unpaved/sand/ground` ou sans revêtement = von en terre (5 m), selon `docs/monde.md`.
5. Simplifier chaque voie (un point tous les 30 à 50 m), enregistrer `docs/quartiers/donnees/avotrou.json` au format `{"attribution": "© les contributeurs d'OpenStreetMap, licence ODbL", "quartier": "Avotrou", "rectangle": [sud, ouest, nord, est], "voies": [{"nom": ..., "type": ..., "points": [[lat, lon], ...]}]}`. Une voie sans étiquette `name` reste sans nom (« voie sans nom n° … »), jamais baptisée.
6. Construire la grille du jeu en divisant les longueurs réelles par deux (carte condensée, `docs/monde.md`) et en ne gardant que les axes principaux et une rue de quartier sur trois.

## Sources consultées
- GeoNames, recherche « Cotonou », Bénin : https://www.geonames.org/search.html?q=Cotonou&country=BJ
- Wikipédia, « Cotonou » : https://fr.wikipedia.org/wiki/Cotonou
- Wikipédia, « 1er arrondissement de Cotonou » : https://fr.wikipedia.org/wiki/1er_arrondissement_de_Cotonou
- Mémoire en ligne reprenant le tableau INSAE des arrondissements et anciennes communes : https://www.memoireonline.com/02/12/5290/m_Contribution--l-etude-de-la-production-et-de-la-gestion-des-huiles-usagees-dans-la-ville-de-Coto8.html
- Wiki OpenStreetMap, « Cotonou » (aucune donnée de rues) : https://wiki.openstreetmap.org/wiki/Cotonou
- Non lu (accès refusé) : cahier des villages et quartiers de ville du Littoral, INStaD, qui donnerait la liste officielle des quartiers par arrondissement (instad.bj).
