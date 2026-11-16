# Performance : fonctionnement attendu

Déjà dans le jeu (`scripts/main.gd`, `scripts/hud.gd`) : quatre niveaux graphiques (touche F4), compteur d'images par seconde (touche F3), une carte de 420 × 400 m construite d'un bloc par le code. Ce document décrit la cible pour la carte de 6 × 4 km. Code prévu : `scripts/zone.gd` (chargement par zones), `scripts/detail.gd` (niveaux de détail), `scripts/qualite.gd` (réglages graphiques), `scripts/mesure.gd` (mesures). Vérifications prévues : `scripts/selftest_perf.gd` et un parcours de mesure `--bench`.

Références : budgets de triangles et d'appels de dessin de `docs/style_graphique.md` (adoptés par décision du 16 novembre) ; zones carrées de 250 m (`docs/monde.md`, tâche T0030) ; Godot 4.3 ; Windows d'abord (décision 118).

## Objectifs chiffrés
| Niveau | Machine visée (indicative, à ajuster avec les mesures de Bravo, tâche T0002) | Résolution | Images par seconde visées | Minimum toléré |
|---|---|---|---|---|
| Bas | portable de bureau, puce graphique intégrée, 8 Go de mémoire | 1280 × 720 | 30 | 25 |
| Moyen | carte graphique d'entrée de gamme d'il y a 6 à 8 ans, 8 Go | 1920 × 1080 | 60 | 45 |
| Élevé | carte graphique de milieu de gamme récente, 16 Go | 1920 × 1080 | 60 | 55 |
| Ultra | carte graphique haut de gamme, 16 Go | 2560 × 1440 | 60 | 55 |

- Le « minimum toléré » est le 1 % des images les plus lentes pendant le parcours de mesure.
- Rendu : « Compatibilité » (OpenGL) au niveau Bas, pour les vieilles puces ; « Forward+ » (Vulkan) pour les autres. Le changement de rendu demande un redémarrage du jeu ; le jeu le dit.

## Niveaux de détail
- Chaque modèle existe en **3 niveaux** (décision du style graphique) : fin (100 % des triangles), moyen (environ 50 %), loin (environ 15 %), plus un 4e état, **masqué**. Pour les modèles importés, Godot génère les niveaux à l'import ; pour ce qui est construit par le code, `detail.gd` fabrique les versions simples (un bâtiment loin = une boîte colorée avec son toit ; un arbre loin = deux plans croisés).
- **Distances de bascule** (au niveau « Moyen » ; multiplier par 0,6 en Bas, 1,5 en Élevé, 2 en Ultra) :

| Objet | Fin jusqu'à | Moyen jusqu'à | Loin jusqu'à | Ensuite |
|---|---|---|---|---|
| Héros | toujours fin | — | — | — |
| Personnage important | 20 m | 45 m | 120 m | masqué |
| Passant | 12 m | 30 m | 80 m | masqué |
| Voiture, taxi, moto | 25 m | 60 m | 200 m | masqué |
| Bus, camion | 30 m | 80 m | 300 m | masqué |
| Bâtiment courant | 60 m | 150 m | limite d'affichage | fondu dans la brume |
| Monument | 150 m | 400 m | toute la carte | silhouette toujours visible |
| Étal, mobilier de rue | 20 m | 45 m | 90 m | masqué |
| Arbre, palmier | 30 m | 80 m | 250 m | masqué |
| Petit objet | 10 m | 20 m | 40 m | masqué |

- **Pas de saut visible** : la bascule se fait avec une marge (5 % plus loin pour s'alléger que pour s'affiner), et les objets qui disparaissent le font en fondu de 0,5 seconde (grain qui s'éclaircit), jamais d'un coup devant le joueur.
- **Animation** : un passant au niveau « moyen » est animé 15 fois par seconde ; au niveau « loin », 5 fois par seconde, sans mouvement des bras ; un véhicule loin n'a plus de roues qui tournent ni de feux actifs.
- **Simulation** : même logique pour le comportement. À plus de 80 m, un passant suit son chemin sans éviter finement les autres ; à plus de 150 m, il n'existe plus (il est recréé à l'approche). Les véhicules de circulation existent jusqu'à 250 m.
- **Regroupement** : les objets identiques et fixes d'une zone (étals, arbres, lampadaires, fenêtres) sont dessinés en un seul appel par type (instances groupées). Les bâtiments d'une zone vus de loin sont fusionnés en **un seul maillage** par zone (« zone loin », 5 000 triangles au plus).
- **Contrôle du budget** : à l'import, un modèle qui dépasse le budget de sa catégorie de plus de 10 % est refusé par le script d'import, avec le chiffre mesuré.
- Cas limites : en cinématique, les acteurs sont forcés au niveau fin ; en mode photo, tout ce qui est dans le cadre à moins de 60 m passe au niveau fin avant la prise ; vue du haut d'un toit : les distances sont mesurées en 3D, pas au sol.
- Test : un passant placé à 10, 20, 50 et 100 m de la caméra a respectivement les niveaux fin, moyen, loin, masqué (niveau Moyen) ; aller-retour autour d'un seuil : pas plus d'une bascule par seconde ; chaque modèle du dossier `assets/modeles/` a ses 3 niveaux et respecte le budget de sa catégorie ; sur le parcours de mesure, les triangles visibles restent sous 250 000 en Bas et 500 000 en Moyen.

## Distance d'affichage
- **Limite d'affichage** (au-delà, rien n'est dessiné sauf le ciel, la mer, la silhouette des monuments et les « zones loin ») :

| Niveau | Limite d'affichage | Brume : début / opaque | Zones chargées autour du joueur |
|---|---|---|---|
| Bas | 350 m | 200 m / 350 m | 3 × 3 |
| Moyen | 600 m | 350 m / 600 m | 5 × 5 |
| Élevé | 1 000 m | 600 m / 1 000 m | 7 × 7 |
| Ultra | 1 600 m | 1 000 m / 1 600 m | 9 × 9 |

- **Brume** : couleur sable `f6cf96` le jour (style graphique), plus dense par harmattan (limites divisées par 2), bleu nuit la nuit. Elle cache la limite : aucun objet ne doit « apparaître » nettement ; il sort de la brume.
- **Mer, lagune et lac** : un seul grand plan, toujours dessiné jusqu'à l'horizon ; le ciel et le soleil aussi.
- **Monuments et repères** (Place de l'Amazone, Étoile Rouge, halle de Dantokpa, les trois ponts, tour de contrôle de l'aéroport, grues du port) : silhouette simplifiée visible de toute la carte, pour s'orienter.
- **La nuit** : les fenêtres éclairées et les lampadaires lointains sont des points lumineux très peu coûteux, visibles jusqu'à la limite d'affichage.
- **Réglage** : dans les options, un curseur « Distance d'affichage » de 50 à 150 % de la valeur du niveau choisi.
- **Vitesse** : à plus de 90 km/h, la zone située devant le véhicule est chargée une rangée plus loin que les autres (anticipation), pour ne jamais rouler vers du vide.
- **En hauteur** (toit de la halle, pont du nord) : la limite d'affichage ne change pas, mais les « zones loin » fusionnées sont dessinées jusqu'à 1,5 fois la limite.
- Cas limites : caméra du mode photo → mêmes limites ; cinématique avec plan large → la scène peut demander une limite plus grande pendant ses plans (2 000 m au plus), rétablie à la fin ; vol en avion → la carte entière au niveau « zone loin ».
- Test : au niveau Bas, aucun objet courant dessiné à plus de 350 m (compte des objets visibles par distance) ; la silhouette de l'Étoile Rouge est visible depuis la Marina à chaque niveau ; à 120 km/h sur le boulevard, aucune zone à moins de 200 m devant le joueur n'est absente ; en passant de Moyen à Ultra, le nombre de zones chargées passe de 25 à 81.

## Chargement progressif du monde
- La carte de 6 × 4 km est découpée en **384 zones** de 250 × 250 m (24 colonnes d'ouest en est, 16 rangées du nord au sud), nommées `zone_CC_RR` (colonne et rangée sur deux chiffres). Chaque zone est un fichier : sol et routes, bâtiments, mobilier, points d'apparition des passants et de la circulation, objets à collecter, marqueurs de mission.
- **Trois anneaux** autour de la zone où se trouve le joueur :
  1. **actif** (la zone du joueur et ses 8 voisines) : tout est là, collisions, passants, circulation, objets renversables ;
  2. **visible** (jusqu'au nombre de zones du niveau graphique) : décor et collisions des routes et des bâtiments, pas de petits objets, passants et circulation seulement le long des grands axes ;
  3. **loin** (au-delà, jusqu'à la limite d'affichage) : le maillage fusionné « zone loin », sans collision.
- **Chargement** : en arrière-plan, sur un autre fil d'exécution ; puis les objets sont ajoutés au monde **par petits paquets**, 2 millisecondes au plus par image, pour ne jamais faire sauter l'image. Une zone complète arrive en 0,5 seconde au plus sur disque SSD, 1,5 seconde sur disque dur.
- **Déchargement** : une zone sortie de l'anneau visible est gardée 20 secondes (au cas où le joueur fait demi-tour), puis libérée. Marge de 30 m aux frontières, pour ne pas charger et décharger sans arrêt quand on roule sur la limite.
- **Ordre de priorité** : d'abord les zones dans la direction du déplacement, puis les côtés, puis l'arrière.
- **État des zones** : ce que le joueur a changé (véhicule garé, étal cassé, objet ramassé) est gardé en mémoire par zone tant que la session dure pour les changements passagers, et dans la sauvegarde pour les changements durables (objets ramassés, véhicules possédés, propriétés).
- **Véhicules du joueur** : un véhicule possédé laissé dans une zone déchargée est noté (position, dégâts, carburant) et recréé au retour. Un véhicule emprunté abandonné disparaît quand sa zone est déchargée.
- **Passants et circulation** : jamais créés ni retirés dans le champ de la caméra à moins de 80 m ; ils apparaissent derrière un coin, hors champ ou dans la brume.
- **Démarrage** : au lancement ou au chargement d'une sauvegarde, écran de chargement jusqu'à ce que l'anneau actif (9 zones) soit complet : 5 secondes visées au niveau Moyen, 10 secondes au plus au niveau Bas.
- **Téléportations** (réveil au centre de santé, arrestation, voyage rapide) : fondu au noir, chargement de l'anneau actif d'arrivée, puis fondu d'ouverture ; jamais de chute dans le vide : le joueur est tenu immobile tant que le sol de sa zone n'a pas de collision.
- **Filet de sécurité** : si le joueur se retrouve quand même sous le sol (−20 m), il est replacé au dernier point au sol connu, et une ligne est écrite dans le journal.
- **Mémoire** : 1,5 Go visés au niveau Bas, 3 Go en Ultra, pour le jeu entier.
- **Intérieurs** : un intérieur est une petite scène chargée à la porte (fondu de 0,3 seconde) ; l'extérieur reste chargé derrière, sa simulation réduite.
- Cas limites : fichier de zone manquant ou abîmé → la zone est remplacée par un sol plat couleur terre et des murs invisibles à sa frontière, un message discret est écrit dans le journal, le jeu continue ; changement de niveau graphique → les anneaux sont recalculés sans écran de chargement ; vitesse extrême (outil de téléportation) → fondu forcé.
- Test : traverser la carte d'ouest en est à 120 km/h : aucune image de plus de 50 ms due à un chargement (niveau Moyen, machine de test), jamais moins de 9 zones actives, le joueur n'est jamais à moins de 200 m d'une zone non chargée dans sa direction ; après un aller-retour complet, la mémoire revient à ±10 % de sa valeur de départ ; une moto possédée laissée à Dantokpa est retrouvée à 1 m près après un trajet jusqu'à Fidjrossè et retour ; un fichier de zone supprimé ne fait pas planter le jeu ; aucun passant n'apparaît dans le champ de la caméra à moins de 80 m pendant 5 minutes simulées.

## Masquage des objets cachés
- But : ne pas dessiner ce que le joueur ne peut pas voir. Trois mécanismes, du moins coûteux au plus coûteux.
- **1. Hors champ** : ce qui est en dehors du cône de la caméra n'est pas dessiné (fait par le moteur). Chaque objet a une boîte englobante juste ; les objets regroupés d'une zone sont découpés en **paquets de 50 × 50 m**, pour qu'un regroupement à moitié hors champ ne soit pas dessiné en entier.
- **2. Masquage par les bâtiments** : les grands bâtiments (plus de 6 m de haut et 8 m de large), les murs de concession longs et les piles de conteneurs du port sont déclarés **occulteurs** : une boîte simplifiée, légèrement plus petite que le bâtiment (retrait de 0,3 m), sert à décider que ce qui se trouve entièrement derrière n'est pas dessiné. Actif aux niveaux Moyen et plus ; au niveau Bas, seulement les 20 occulteurs les plus grands autour du joueur (le calcul lui-même coûte). Les objets fins (grillages, arbres, étals, véhicules) ne cachent jamais rien.
- **3. Intérieurs** : dedans, l'extérieur n'est dessiné que par les portes et fenêtres ouvertes (une « fenêtre de vue » par ouverture) ; dehors, l'intérieur d'un bâtiment n'est pas dessiné tant que sa porte est fermée ou à plus de 25 m.
- **Par distance** : chaque famille d'objets a sa distance de disparition (tableau des niveaux de détail).
- **Ce qui n'est jamais masqué par erreur** : l'objectif de mission, le véhicule du joueur, les poursuivants et la police ont une marge de sécurité (boîte agrandie de 20 %).
- **Les ombres** : un objet masqué pour la caméra peut encore projeter son ombre dans l'image ; les grands bâtiments gardent donc leur ombre.
- **Simulation** : le masquage ne concerne que le dessin ; la physique et le comportement dépendent des anneaux de zones et des distances, pas de ce que voit la caméra — sauf les animations de passants, suspendues hors champ.
- **Le son** suit la même idée : au plus 24 sons en même temps en Bas (32 au-delà) ; les sons trop lointains ou couverts ne sont pas joués.
- **Outil de contrôle** : la console de débogage a `voir occulteurs` (affiche les boîtes en rouge translucide) et `voir masques` (colore en violet ce qui est masqué) ; l'écran de mesure (F3 deux fois) donne le nombre d'objets dessinés et masqués.
- Cas limites : caméra à l'intérieur d'un occulteur (collée à un mur) → les occulteurs à moins de 1 m de la caméra sont ignorés ; bâtiment en chantier au chapitre 4 (structure ajourée) → pas d'occulteur ; vue d'un toit → peu de masquage, c'est la distance d'affichage qui protège.
- Test : dans une rue de Ganhi bordée d'immeubles, le nombre d'objets dessinés est au moins 40 % plus bas avec le masquage qu'avec le masquage coupé (commande de débogage), et l'image est identique à 0,5 % des points près ; l'objectif de mission placé derrière un coin apparaît sans retard quand la caméra tourne (aucune image où il manque alors que son centre est visible) ; à l'intérieur d'un maquis porte fermée, moins de 5 % des objets extérieurs sont dessinés ; caméra collée à un mur : pas d'écran vide.

## Niveaux graphiques bas, moyen, élevé, ultra
- **Choisir** : touche F4 en jeu (existe) ou menu Options → Graphismes. Le niveau est enregistré dans `user://reglages.cfg` et repris au lancement suivant. Chaque réglage du tableau peut aussi être changé un par un : le niveau affiché devient alors « Personnalisé ».

| Réglage | Bas | Moyen | Élevé | Ultra |
|---|---|---|---|---|
| Triangles visibles (budget) | 250 000 | 500 000 | 1 000 000 | 2 000 000 |
| Appels de dessin (budget) | 600 | 1 000 | 1 800 | 3 000 |
| Échelle de rendu | 75 % | 100 % | 100 % | 100 % |
| Lissage des bords | aucun | FXAA | MSAA ×2 | MSAA ×4 + lissage temporel |
| Ombres du soleil | aucune (disque sombre sous les personnages et véhicules) | 1 024 px, 2 cascades, 60 m | 2 048 px, 3 cascades, 120 m | 4 096 px, 4 cascades, 200 m |
| Lumières avec ombre (lampadaires, phares) | 0 | 0 | 4 | 8 |
| Lumières réelles la nuit | phares du joueur seulement | 8 | 16 | 32 |
| Occlusion ambiante | non | non | oui | oui, qualité haute |
| Reflets | aucun | ciel seulement | ciel + reflets à l'écran sur l'eau | idem + flaques et carrosseries |
| Eau | aplat animé | vagues simples | vagues, écume au bord | idem + reflets et transparence au bord |
| Éblouissement, halo | non | léger | oui | oui |
| Flou d'arrière-plan (cinématiques, photo) | non | non | oui | oui |
| Brume volumétrique | non | non | non | oui |
| Distance d'affichage | 350 m | 600 m | 1 000 m | 1 600 m |
| Distances de niveaux de détail | ×0,6 | ×1 | ×1,5 | ×2 |
| Passants autour du joueur (au plus) | 25 | 50 | 80 | 120 |
| Véhicules de circulation (au plus) | 15 | 30 | 45 | 60 |
| Objets renversables actifs | 40 | 80 | 150 | 150 |
| Textures | 512 px | 512 px, 1 024 pour héros et monuments | idem | 2 048 px |
| Herbe, détritus, petits détails au sol | non | peu | oui | dense |
| Particules (fumée, poussière, pluie) | 30 % | 60 % | 100 % | 100 % |
| Rendu | Compatibilité | Forward+ | Forward+ | Forward+ |

- **Le jeu reste le même** à tous les niveaux : mêmes règles, mêmes distances de perception des adversaires, mêmes passants indispensables aux missions. Seul change ce qui est décoratif. La densité plus faible en Bas ne change pas les embouteillages des heures de pointe (les grands carrefours gardent la priorité dans le budget de véhicules).
- **Premier lancement** : un essai de 5 secondes sur une scène fixe choisit le niveau : plus de 90 images par seconde en Moyen → Élevé ; moins de 45 → Bas ; plus de 90 en Élevé → Ultra. Le joueur peut changer ensuite.
- **Autres options** : plein écran, fenêtre sans bord ou fenêtre ; résolution ; synchronisation verticale (activée au départ) ; plafond d'images par seconde (30, 60, 120, sans limite ; 60 au départ) ; champ de vision ; échelle de rendu de 50 à 100 %.
- **Échelle automatique** (option, activée au niveau Bas) : si la moyenne passe sous 27 images par seconde pendant 3 secondes, l'échelle de rendu baisse de 5 points (plancher 50 %) ; elle remonte au-dessus de 35 pendant 10 secondes.
- **Application** : immédiate, sans redémarrage, sauf le passage Compatibilité ↔ Forward+ (au prochain lancement). Un changement de niveau ne fait jamais perdre la partie en cours.
- Cas limites : puce graphique sans Vulkan → le jeu démarre en Compatibilité et grise les niveaux Élevé et Ultra, avec une phrase d'explication ; fichier de réglages abîmé → valeurs par défaut (Moyen) ; résolution enregistrée plus grande que l'écran → ramenée à celle de l'écran.
- Test : F4 fait défiler Bas, Moyen, Élevé, Ultra puis Bas ; chaque valeur du tableau est bien appliquée (lecture des réglages du moteur après changement) ; le niveau est conservé après fermeture et relance ; au niveau Bas, aucune lumière avec ombre n'existe dans la scène ; changer un seul réglage affiche « Personnalisé » ; l'échelle automatique baisse quand on simule 20 images par seconde pendant 3 secondes et ne descend pas sous 50 %.

## Ombres et éclairage de qualité
- **Le soleil** : une seule lumière directionnelle, couleur `ffdcaa`, qui suit le cycle jour-nuit (48 minutes réelles par jour de jeu, décision 89). Elle se déplace par petits pas (toutes les 2 secondes réelles : 0,25°) pour que les ombres ne tremblent pas. Hauteur maximale à midi 80° ; lever 6 h 30, coucher 18 h 45 toute l'année (on est près de l'équateur).
- **Ombres du soleil** : cascades selon le tableau des niveaux graphiques. Au niveau Bas, pas d'ombre calculée : un **disque sombre** (opacité 45 %) sous chaque personnage et un rectangle sous chaque véhicule ; les bâtiments ont une bande sombre peinte au pied, du côté opposé au soleil (deux orientations possibles : matin, après-midi).
- **Qui projette une ombre** : bâtiments, véhicules, personnages, arbres, étals couverts. Jamais : petits objets, détritus, fils, particules. Au niveau Moyen, les passants à plus de 30 m n'en projettent plus.
- **Douceur** : bords doux (pénombre de 5 cm au pied de l'objet à 40 cm à 10 m de lui) en Élevé et Ultra ; bords nets, filtrés une fois, en Moyen.
- **Lumière ambiante** : pas d'éclairage global calculé en temps réel. Une lumière de ciel (bleu clair en haut, sable à l'horizon, ocre venant du sol) donne de la couleur aux zones à l'ombre ; son intensité et sa teinte suivent l'heure : 10 moments clés (nuit, aube, matin, midi, après-midi, fin d'après-midi dorée, coucher, crépuscule, début de nuit, nuit profonde) entre lesquels on interpole.
- **Occlusion ambiante** (Élevé, Ultra) : assombrit légèrement les coins, le dessous des étals et des véhicules ; rayon 1 m, intensité 1,2.
- **La nuit** : lumière de lune bleutée très faible (les silhouettes restent lisibles : on ne joue jamais dans le noir complet) ; lampadaires, enseignes lumineuses, fenêtres (matière lumineuse, sans vraie lumière), lampes des étals de nuit, phares. Nombre de vraies lumières selon le niveau ; les plus proches du joueur sont choisies, avec un fondu de 0,3 seconde quand une lumière entre ou sort de la sélection.
- **Phares** : cône de 40 m, 35° ; ombres seulement en Élevé et Ultra, pour le véhicule du joueur. Les autres véhicules ont des optiques lumineuses et, à partir du niveau Moyen, une tache claire au sol devant eux.
- **Météo** : harmattan — soleil voilé, ombres à 40 % d'intensité, ciel blanc-jaune ; orage — ciel gris, pas d'ombre du soleil, éclairs (éclair blanc de 0,1 seconde, 1 à 3 par minute) ; après la pluie — sol plus sombre et brillant pendant 10 minutes réelles.
- **Intérieurs** : éclairés par 1 à 3 lumières fixes sans ombre et la lumière du jour par les ouvertures ; éclairage figé dans les couleurs des murs au niveau Bas.
- **Exposition** : adaptation automatique douce (1 seconde) quand on sort d'un intérieur ou d'un tunnel de conteneurs, bornée pour que l'image ne devienne jamais ni blanche ni noire ; désactivée au niveau Bas (valeur fixe selon l'heure).
- **Couleurs finales** : la courbe de tons garde les aplats vifs du style graphique (pas de rendu délavé) ; saturation légèrement renforcée en fin d'après-midi, heure « signature » du jeu (17 h à 18 h 30).
- Cas limites : soleil très bas (avant 7 h, après 18 h) → longueur des ombres plafonnée à 25 m et intensité réduite, pour éviter les grandes ombres qui tremblent ; cinématique → la scène peut ajouter 2 lumières de visage, retirées à la fin ; passage sous un pont → pas de variation d'exposition de plus de 1 cran.
- Test : au niveau Bas, zéro texture d'ombre allouée et un disque sous chaque personnage ; en Moyen, la texture d'ombre mesure 1 024 px et couvre 60 m ; à midi, l'ombre d'un poteau de 9 m mesure entre 1 et 2,5 m, à 17 h 30 entre 15 et 25 m ; la nuit, pas plus de 8, 16, 32 lumières réelles selon le niveau ; la luminosité moyenne de l'image à minuit en plein air est au-dessus de 6 % (jamais d'écran noir) ; faire avancer l'horloge de 6 h à 19 h ne produit aucune variation de luminosité de plus de 3 % entre deux images.

## Reflets et eau
- L'eau compte beaucoup à Cotonou : mer au sud, lagune au milieu, lac au nord. Elle est faite d'**un seul grand plan** par plan d'eau, avec une matière animée — jamais de simulation de fluide.

| | Bas | Moyen | Élevé | Ultra |
|---|---|---|---|---|
| Couleur | aplat `2a86b5`, bande claire au bord | dégradé selon la profondeur (clair au bord, foncé au large) | idem | idem + transparence sur 1 m de fond |
| Vagues | texture qui défile, surface plate | surface qui ondule (2 ondes, 15 cm) | 4 ondes, 25 cm en mer, 5 cm en lagune | idem + crêtes |
| Écume | non | trait blanc fixe au rivage | écume animée au rivage et autour des pirogues | idem + sillage détaillé |
| Reflets | aucun | reflet du ciel (couleur) | ciel + reflets à l'écran (bâtiments, ponts, pirogues) | idem + soleil qui scintille |
| Coût visé | moins de 0,5 ms | 1 ms | 2 ms | 3 ms |

- **Physique** : la hauteur de l'eau utilisée par le jeu (nage, bateaux) est la même à tous les niveaux : surface plate à −0,3 m (valeur actuelle `WATER_Y`), plus les ondes calculées par la même formule que l'image, pour que les pirogues montent et descendent avec les vagues visibles (au niveau Bas : pas d'ondes, bateaux à plat avec un léger balancement d'animation).
- **Mer** : vagues qui arrivent sur la plage toutes les 6 secondes (bande d'écume qui avance de 4 m et se retire) ; au niveau Bas, bande claire fixe. Drapeau rouge : vagues de 60 cm.
- **Lagune et lac** : eau calme, plus brune près des berges et du marché, clapot de 5 cm ; jacinthes d'eau et reflets des maisons sur pilotis au village lacustre (à partir d'Élevé).
- **Sillages** : barque à moteur — deux traînées blanches de 15 m qui s'effacent en 4 secondes ; pirogue — rides de 3 m ; nageur — cercles de 1 m. Au niveau Bas : une seule traînée courte pour la barque du joueur.
- **Pluie et rues inondées** (décision 90) : flaques sur la chaussée (plans sombres et brillants posés dans les creux prévus par la carte) et rues basses sous 10 à 30 cm d'eau après une grosse pluie — même matière que la lagune, en plus brun. Reflets sur les flaques : ciel dès Moyen, lumières et véhicules en Ultra. Gerbes d'eau sous les roues à tous les niveaux (particules, quantité selon le niveau).
- **Autres reflets** : vitres des immeubles de Ganhi (reflet du ciel, couleur fixe en Bas) ; carrosseries (léger reflet du ciel dès Moyen, de l'environnement en Ultra) ; sol mouillé. Pas de miroir réel (les rétroviseurs sont des surfaces grises) ; dans les salons de coiffure, le « miroir » est une seconde caméra limitée à la pièce, seulement pendant l'écran de choix (image fixe du visage au niveau Bas).
- **Sous l'eau** : la caméra ne passe jamais sous la surface.
- **Harmattan et nuit** : reflets ternes par harmattan ; la nuit, reflet de la lune et des lumières de la rive (points étirés) à partir d'Élevé.
- Cas limites : reflets à l'écran qui manquent sur les bords de l'image → fondu vers le reflet du ciel, jamais de trou noir ; eau vue du pont du nord (grande surface à l'image) → le coût reste dans le budget, sinon la qualité de l'eau baisse d'un cran automatiquement tant que la caméra est là ; pirogue au niveau Bas → pas d'écart visible de plus de 10 cm entre coque et surface.
- Test : au niveau Bas, la matière de l'eau n'utilise ni reflet ni déformation de surface ; la hauteur d'eau renvoyée par le jeu en un point et la hauteur dessinée diffèrent de moins de 5 cm (niveaux Moyen à Ultra) ; la nage et la vitesse des bateaux sont identiques aux quatre niveaux (mêmes tests que « Navigation sur l'eau » rejoués à chaque niveau) ; sur le parcours de mesure au bord de la lagune, le coût de l'eau reste sous sa cible ; après une grosse pluie, les flaques apparaissent aux emplacements prévus et disparaissent après 10 minutes réelles de soleil.

## Mesure des images par seconde
- **Affichage simple** (existe) : F3 affiche en haut à gauche « 58 images/s · Graphismes : Moyen (F4) ».
- **Affichage détaillé** : F3 une deuxième fois ajoute : temps d'une image en millisecondes (moyenne et pire des 2 dernières secondes), temps de calcul du jeu et temps de dessin séparés, triangles et appels de dessin, objets dessinés et masqués, zones chargées, passants et véhicules actifs, objets physiques actifs, mémoire utilisée, et une petite courbe des 5 dernières secondes (verte sous 16,7 ms, jaune sous 33 ms, rouge au-delà). Une troisième fois : tout disparaît. Texte en français, chiffres alignés, fond sombre à 60 %.
- **Budget par image à 60 images par seconde (16,7 ms)** : jeu et comportements 4 ms, physique 2 ms, dessin 8 ms, marge 2,7 ms. À 30 images par seconde (niveau Bas) : 8, 4, 16 et 5 ms.
- **Parcours de mesure** : lancé par `MarinaCity.exe -- --bench` (ou le menu Options → « Mesurer les performances »). La caméra suit un trajet fixe de **120 secondes** : départ place de l'Amazone, boulevard de la Marina en voiture, traversée du marché Dantokpa à pied, pont sur la lagune, port, retour à l'heure de pointe, puis 20 secondes de nuit sous la pluie. Même hasard à chaque fois (graine fixe), même heure, mêmes passants.
- **Résultat** : un écran de résumé et un fichier `user://mesures/bench_AAAA-MM-JJ_HHhMM.json` contenant : version du jeu, niveau graphique et réglages, résolution, processeur, carte graphique, mémoire, système ; images par seconde moyennes, médianes, 1 % les plus lentes, 0,1 % les plus lentes ; nombre d'images de plus de 33 ms et de plus de 50 ms ; maximum de triangles et d'appels de dessin ; mémoire maximale ; durée des chargements. Une ligne de résumé est aussi écrite dans la sortie : `BENCH Moyen 1920x1080 moy=61 p1=47 pire=38ms`.
- **Verdict affiché au joueur**, en clair : « Fluide » (1 % les plus lentes au-dessus de l'objectif du niveau), « Correct » (au-dessus du minimum toléré), « Trop lourd pour ce PC : essaie le niveau inférieur » (en dessous). Un bouton « Copier le résumé » pour l'envoyer à Bravo ou à Claude ; rien n'est envoyé automatiquement (décision 71).
- **Mesures pendant le jeu** : une image de plus de 100 ms en jeu (hors chargement) est notée dans le journal avec la position, l'heure de jeu et ce qui se passait (zone en chargement, nombre d'objets physiques) ; 20 notes au plus par session.
- **Suivi dans le temps** : à chaque lot de travail, le passage automatique peut lancer `--bench --headless` sur une version réduite (30 secondes, sans affichage) qui mesure le temps de calcul du jeu et de la physique seulement — sans carte graphique sur la machine de travail, le temps de dessin ne se mesure que sur les PC de Bravo (tâche T0002). Le résultat va dans le journal du lot ; une hausse de plus de 20 % du temps de calcul par rapport au lot précédent est signalée.
- **Limiteur** : plafond d'images par seconde réglable (voir niveaux graphiques) ; quand la fenêtre n'a pas le focus ou en pause : 15 images par seconde, pour ne pas chauffer la machine.
- Cas limites : synchronisation verticale activée → la mesure le dit (« plafonné à 60 par l'écran ») et le parcours de mesure la désactive le temps de l'essai ; parcours interrompu par Échap → pas de fichier, pas de verdict ; écriture du fichier impossible → résumé à l'écran quand même.
- Test : F3 fait défiler aucun affichage, simple, détaillé ; le parcours `--bench --headless` dure 30 secondes ± 1, se termine sans erreur et écrit un fichier JSON valide contenant tous les champs listés ; deux parcours de suite donnent le même nombre d'objets, de passants et de zones chargées à chaque seconde (hasard fixé) ; une image artificiellement ralentie à 150 ms produit une note dans le journal ; fenêtre sans focus : 15 images par seconde.
