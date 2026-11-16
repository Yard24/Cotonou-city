# Agla — plan des rues (T1071)

**Statut : NON FAIT (16 novembre 2026).** Le tracé des rues n'a pas pu être relevé : ce fichier ne contient que ce qui a été vérifié, et la marche à suivre pour finir. Aucun nom de rue, aucune longueur et aucune grille de jeu n'y figure, parce que rien de tout cela n'a pu être contrôlé sur une carte.

## Pourquoi le relevé a échoué
- API Overpass (overpass-api.de, overpass.kumi.systems, overpass.private.coffee), API Nominatim, API de carte et pages de recherche d'openstreetmap.org, photon.komoot.io : toutes refusées à l'outil de lecture web (interdiction par robots.txt ou erreur serveur).
- Depuis la ligne de commande, la sortie réseau de la session refuse ces hôtes (réponse 403 de la passerelle). Il faut les autoriser dans les réglages de la session, ou fournir un extrait OpenStreetMap du Bénin dans le dépôt.
- Les sources restantes (Wikipédia, GeoNames, annuaires dérivés) ne donnent ni tracé, ni nom de voie, ni croisement pour ce quartier.

## Ce qui est vérifié
- Aucun point de coordonnées propre à ce quartier n'a été trouvé (absent des résultats GeoNames consultés).
- Arrondissement : non vérifié.
- Le nom figure dans la liste toponymique de l'article Wikipédia « Cotonou ».
- Centre du 13e arrondissement selon GeoNames : 6,37034 N, 2,36391 E. Le rattachement d'Agla au 13e arrondissement n'a pas pu être lu dans une source ouverte pendant cette session : à confirmer.

## Ce qui manque (tout le cœur de la tâche)
- Limites du quartier et rectangle latitude/longitude.
- Quartiers voisins sur chaque côté.
- Voies principales : nom, type (boulevard, rue pavée, rue en terre), orientation, croisements.
- Carrefours et ronds-points notables.
- Repères : marchés, écoles, lieux de culte, berges.
- Type de bâti et densité.
- Plan simplifié pour le jeu (grille de voies avec longueurs en mètres).
- Fichier `docs/quartiers/donnees/agla.json` (non créé : aucune donnée OpenStreetMap obtenue).

## Marche à suivre dès que l'accès à OpenStreetMap est ouvert
1. Trouver l'emprise :
   `https://nominatim.openstreetmap.org/search?q=Agla,+Cotonou,+Bénin&format=json&polygon_geojson=1&limit=5`
   Noter `boundingbox` (sud, nord, ouest, est) et le type d'objet (contour ou simple point).
   Sans point de départ fiable, ne pas deviner le rectangle : il doit venir de Nominatim.
2. Relever les voies (remplacer le rectangle si Nominatim en donne un meilleur) :
   `https://overpass-api.de/api/interpreter?data=[out:json][timeout:60];way[highway](SUD,OUEST,NORD,EST);out tags geom;`
3. Relever les repères dans le même rectangle :
   `[out:json][timeout:60];(nwr[amenity~"marketplace|school|place_of_worship|hospital"](SUD,OUEST,NORD,EST);nwr[junction=roundabout](SUD,OUEST,NORD,EST);nwr[natural=water](SUD,OUEST,NORD,EST););out tags center;`
4. Classer les voies : `highway=trunk/primary/secondary` = boulevard ou avenue (14 m dans le jeu) ; `tertiary/residential` avec `surface=paving_stones/asphalt` = rue pavée (7 m) ; `surface=unpaved/sand/ground` ou sans revêtement = von en terre (5 m), selon `docs/monde.md`.
5. Simplifier chaque voie (un point tous les 30 à 50 m), enregistrer `docs/quartiers/donnees/agla.json` au format `{"attribution": "© les contributeurs d'OpenStreetMap, licence ODbL", "quartier": "Agla", "rectangle": [sud, ouest, nord, est], "voies": [{"nom": ..., "type": ..., "points": [[lat, lon], ...]}]}`. Une voie sans étiquette `name` reste sans nom (« voie sans nom n° … »), jamais baptisée.
6. Construire la grille du jeu en divisant les longueurs réelles par deux (carte condensée, `docs/monde.md`) et en ne gardant que les axes principaux et une rue de quartier sur trois.

## Sources consultées
- GeoNames, recherche « Cotonou », Bénin : https://www.geonames.org/search.html?q=Cotonou&country=BJ
- Wikipédia, « Cotonou » : https://fr.wikipedia.org/wiki/Cotonou
- Wikipédia, « 1er arrondissement de Cotonou » : https://fr.wikipedia.org/wiki/1er_arrondissement_de_Cotonou
- Mémoire en ligne reprenant le tableau INSAE des arrondissements et anciennes communes : https://www.memoireonline.com/02/12/5290/m_Contribution--l-etude-de-la-production-et-de-la-gestion-des-huiles-usagees-dans-la-ville-de-Coto8.html
- Wiki OpenStreetMap, « Cotonou » (aucune donnée de rues) : https://wiki.openstreetmap.org/wiki/Cotonou
- Non lu (accès refusé) : cahier des villages et quartiers de ville du Littoral, INStaD, qui donnerait la liste officielle des quartiers par arrondissement (instad.bj).
