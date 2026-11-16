# Carte et GPS : fonctionnement attendu

Code : `scripts/minimap.gd` (existe : mini-carte ronde avec routes, joueur, colonne de mission, clients en points bleus). À ajouter : `scripts/carte.gd` (grande carte), `scripts/gps.gd` (graphe des routes, itinéraire), `scripts/lieux.gd` (icônes, découverte, repères). Vérifications : `scripts/selftest_carte.gd`, sur un réseau d'essai en damier de 5 × 5 carrefours espacés de 100 m.

Cadre : Cotonou condensée de 6 × 4 km (décision 83), découpée en zones de 250 m (`docs/monde.md`) ; lieux publics à leur vrai nom, commerces inventés (24, 25) ; quartiers construits dans l'ordre de la décision 84. Le nord est en haut sur toutes les cartes.

## Mini-carte
- **Place et forme** : disque de 200 pixels de diamètre (écran de 1 080 lignes), en bas à gauche, à 24 pixels des bords ; bord sombre de 3 pixels ; fond à 85 % d'opacité.
- **Orientation** : la carte tourne, le haut du disque est la direction du regard de la caméra ; une lettre « N » glisse sur le bord. Option des menus : nord fixe.
- **Échelle** : rayon affiché de 90 m à pied, 140 m en véhicule sous 40 km/h, 220 m au-delà ; passage en 0,5 s.
- **Contenu** : routes (boulevards clairs larges, rues plus fines, « vons » en pointillé), eau en bleu, plage en sable, emprise des bâtiments en gris foncé, ponts ; Koffi : flèche blanche au centre ; son véhicule garé : petite icône du véhicule ; objectif de mission : rond jaune ; itinéraire : trait jaune (mission) ou violet (repère personnel) ; clients de zémidjan : points bleus ; police pendant une recherche : points bleu foncé clignotants, cône de vue des agents à moins de 60 m ; zone de recherche : cercle bleu translucide ; barrages : trait bleu épais à moins de 150 m ; icônes de lieux (section plus bas) à l'intérieur du rayon.
- **Hors du disque** : l'objectif et le repère restent visibles, collés au bord dans leur direction, avec la distance en mètres dessous (« 850 m », puis « 1,2 km »).
- **Étage** : à l'intérieur d'un bâtiment, la mini-carte montre le plan de la pièce (murs, portes) à l'échelle fixe de 25 m de rayon.
- **Masquée** : pendant les cinématiques, les dialogues à choix plein écran, l'appareil photo ; option des menus pour la masquer toujours (touche F1 : afficher ou cacher l'interface).
- **Chapitres 1 à 3** : même mini-carte (c'est une aide de jeu, pas un objet de l'histoire) ; les embouteillages n'y figurent qu'à partir du chapitre 4.
- Coût : routes et bâtiments dessinés une fois par zone de 250 m dans une image ; seuls les points mobiles sont redessinés à chaque image.
- Test : à l'arrêt à pied, un point à 80 m est dans le disque, à 100 m sur le bord avec sa distance ; en véhicule à 60 km/h le rayon vaut 220 m ; en tournant la caméra de 90°, le « N » tourne de 90° ; pendant une recherche, le cercle a le rayon du niveau ; aucun client affiché quand le joueur est à pied ; temps de dessin inférieur à 0,5 ms par image.

## Grande carte
- **Ouverture** : touche **M** (manette : bouton « vue »), ou application du téléphone ; le jeu est en pause ; fond sonore étouffé. Fermeture : M ou Échap. Interdite pendant une cinématique.
- **Affichage** : toute la ville, 6 × 4 km, centrée sur Koffi à l'ouverture. **Zoom** : 5 crans, de la ville entière (1 pixel = 4 m sur un écran de 1 920) à 1 pixel = 0,25 m ; molette ou Maj/C ; déplacement aux flèches ou à la souris (clic maintenu) ; **Espace** : recentrer sur Koffi.
- **Dessin** : style plan de ville sobre aux couleurs du jeu : lagune et mer en bleu, plage en sable, îlots bâtis en beige, marchés hachurés, espaces verts, routes avec leur largeur, ponts, voie ferrée (décor) ; noms des quartiers en capitales espacées (visibles aux 3 premiers crans), noms des boulevards et des lieux publics (crans 3 à 5).
- **Curseur** : croix au centre ; le lieu sous le curseur affiche une étiquette (nom, type, horaires, « ouvert / fermé », distance par la route).
- **Actions** : **E** : poser ou retirer un repère personnel (voir plus bas) ; sur une icône : « E : y aller » (itinéraire jusqu'à ce lieu) ; **Tab** : faire défiler les objectifs de mission disponibles ; **L** : légende (liste des types d'icônes, chacune avec une case pour l'afficher ou la masquer ; le choix est sauvegardé).
- **Informations en bandeau** : en haut : chapitre, date et heure du jeu, météo ; en bas : aide des touches.
- **Calques selon l'histoire** : zone de recherche et barrages vus ; rues inondées en bleu hachuré (dès que le joueur les a vues, ou au chapitre 4 par l'application) ; chantiers du chapitre 4 (routes barrées en orange) ; quartier en coupure de courant (teinte plus sombre) ; lignes de minibus (3 traits de couleur, masquables).
- **Avant le chapitre 4** : plan papier (voir `telephone_du_joueur.md`) : même carte, rendu « encre sur papier », pas de trafic ni de flotte ; la position de Koffi est une croix au crayon exacte.
- **Autres villes** (décision 87) : quand elles existeront, un 6e cran de zoom arrière montre le pays simplifié avec les villes et les lignes d'autocar, d'avion et la route du Nord.
- Test : M met le jeu en pause et centre sur le joueur (moins de 2 pixels d'écart) ; 5 crans de zoom, bornés ; E au curseur pose un repère aux coordonnées du monde correspondantes (moins de 2 m d'écart au cran le plus fin) ; masquer un type d'icône dans la légende le retire de la carte et le choix survit à une sauvegarde ; M refusé en cinématique.

## Itinéraire
- **Graphe** : chaque carrefour est un nœud, chaque tronçon une arête avec : longueur, type (boulevard, rue, von, pont, allée piétonne), sens (les boulevards à terre-plein sont deux arêtes à sens unique), largeur, état (ouvert, chantier, inondé, barré).
- **Calcul** : plus court chemin en **temps** (algorithme A*), avec la vitesse de référence du type : boulevard 14 m/s, rue 10 m/s, von 6 m/s, pont 12 m/s. Coûts ajoutés : demi-tour 8 s ; tourner à gauche sur un boulevard 4 s ; heure de pointe sur les ponts et grands carrefours : temps × 2 en voiture, × 1,2 à moto (décisions 60, 61) ; tronçon inondé : interdit en moto et en voiture si l'eau dépasse leur seuil (voir `jour_nuit_et_meteo.md`), × 3 sinon ; chantier barré : interdit.
- **Selon le véhicule** : à pied : sens interdits ignorés, allées piétonnes et marchés permis ; moto : vons permis ; voiture et taxi : vons de 5 m permis mais × 1,5 ; camionnette, minibus, camion : vons interdits, ponts permis ; pirogue : graphe de l'eau (voir « Navigation sur l'eau »). Changer de véhicule recalcule.
- **Départ et arrivée** : point de route le plus proche de Koffi (dans son sens de marche s'il roule à plus de 20 km/h) et point de route le plus proche du but ; les 30 derniers mètres hors route sont un pointillé droit.
- **Affichage** : trait de 4 pixels sur la mini-carte et la grande carte, jaune pour une mission, violet pour un repère personnel, bleu pour une course de client ; sur la route elle-même, rien par défaut ; option « flèches au sol » (chevrons discrets tous les 15 m sur 60 m devant, aux carrefours seulement) activée en difficulté « Tranquille ».
- **Annonce** : distance restante par la route et temps estimé sous la mini-carte (« 1,4 km — 2 min »). Pas de voix de guidage : c'est Koffi qui commente parfois (« À gauche après la pharmacie. Enfin, là où il y avait la pharmacie. », 1 carrefour sur 5, décision 107).
- **Recalcul** : quand Koffi s'écarte de plus de 25 m du tracé pendant 2 s, quand un tronçon change d'état, à chaque changement de véhicule ; au plus un calcul par seconde ; durée d'un calcul inférieure à 5 ms sur la carte complète (environ 600 nœuds).
- **Un seul itinéraire à la fois** : priorité à la mission en cours, puis course de client, puis repère personnel (qui reste en mémoire et revient à la fin de la mission).
- **Ce que le GPS ignore** : barrages de police, contrôles, embouteillages du moment avant le chapitre 4 ; raccourcis hors route (plage, cours, terrains vagues) : au joueur de les trouver.
- **Arrivée** : à moins de 15 m du but, l'itinéraire s'efface ; un repère personnel atteint est retiré avec un son.
- Impossible d'atteindre le but (île, pont fermé à 5 étoiles) : tracé jusqu'au point le plus proche et mention « Pas de route jusque-là ».
- Test (damier) : de (0,0) à (4,4) : longueur 800 m ; un tronçon barré sur le chemin : contournement, longueur 800 ou 1 000 m selon le cas prévu ; sens unique respecté en voiture et ignoré à pied ; sortie de 30 m du tracé : recalcul en moins de 3 s ; arrivée à 14 m : effacé ; calcul sur un graphe de 600 nœuds en moins de 5 ms ; à 8 h, l'itinéraire voiture évite le pont si le détour coûte moins que le temps doublé.

## Icônes de lieux
- Pictogrammes blancs de 20 pixels sur pastille ronde de couleur (24 pixels sur la mini-carte, 32 sur la grande carte au cran le plus fin). Formes simples, lisibles sans texte ; aucun logo de marque (décision 25).

| Icône | Pastille | Lieu |
|---|---|---|
| Lettre du personnage (R, M, G, N, D, X, J…) | jaune | départ de mission principale (Romaric, Maman, Gratien, Nan Akouavi, Doyen, Expédit, Rachidath la journaliste) |
| Point d'interrogation | bleu clair | mission secondaire |
| Maison | vert | logement de Koffi (point de sauvegarde) |
| Clé | vert | propriété à vendre ; clé pleine : propriété à lui |
| Clé plate (outil) | orange | garage, atelier de Romaric |
| Pompe | orange | station-service ; bidon : vendeuse de kpayo |
| Goutte | orange | lavage |
| Pot de peinture | orange | peinture |
| Assiette | rouge brique | maquis ; parasol : vendeuse de rue |
| Chemise | violet | boutique de vêtements ; ciseaux : coiffeur |
| Sac | violet | boutique, quincaillerie, pièces détachées |
| Téléphone | violet | kiosque Zékôm |
| Billet | vert foncé | banque |
| Croix | blanc sur rouge | centre de santé |
| Écusson | bleu nuit | commissariat |
| Minibus | couleur de la ligne | arrêt et tête de ligne |
| Voiture « T » | jaune et vert | station de taxis |
| Casque | jaune | parc de zémidjans, le Doyen |
| Autocar | orange | gare routière |
| Avion | gris | aéroport |
| Pirogue | bleu | embarcadère |
| Drapeau à damier | noir et blanc | course de motos sur la plage |
| Appareil photo | gris clair | défi photo non réalisé |
| Étoile à 4 branches | blanc | monument ou lieu remarquable |
| Caisse | marron | panneau de livraisons |
- **Filtrage par zoom** (grande carte) : crans 1-2 : missions, logements, propriétés, lieux remarquables, commissariats, centres de santé ; cran 3 : + garages, stations, banque, gares, embarcadères ; crans 4-5 : tout. Sur la mini-carte : tout ce qui est dans le rayon, 12 icônes au plus (les plus proches, les missions toujours).
- **État** : lieu fermé à cette heure : icône à 50 % d'opacité ; lieu avec du nouveau (caisse à relever, tenue prête) : pastille orange ; pendant une mission : seules les icônes utiles à la mission et les services (santé, garage, station) restent.
- **Superposition** : deux icônes à moins de 20 pixels sont regroupées avec un chiffre ; zoomer les sépare.
- Les lieux de culte figurent comme bâtiments nommés à leur vrai type (« mosquée », « église », « temple »), sans icône d'action (décision 18).
- Test : chaque type de lieu de la scène d'essai a son icône et une seule ; au cran 1, aucune icône de boutique ; maquis à 4 h : icône à 50 % ; 15 lieux dans le rayon de la mini-carte : 12 icônes affichées, dont la mission ; deux icônes au même endroit : regroupées.

## Découverte progressive
- Au début, Koffi connaît son quartier : **Dantokpa et Missèbo** sont visibles en entier (il y a grandi, décision 9), ainsi que le tracé des boulevards de toute la ville et les grands repères (lagune, mer, ponts, aéroport) : il revient après trois ans, pas en étranger.
- **Le reste est « à redécouvrir »** : îlots en gris uni, sans rues secondaires, sans icônes ni noms de commerces.
- **Dévoilement** : par cases de 125 m (4 par zone de 250 m). Une case est dévoilée quand Koffi y entre, plus ses 8 voisines s'il est en véhicule ou sur un toit (hauteur supérieure à 6 m). En minibus : les cases le long de la ligne et les arrêts. Dévoilement en fondu de 1 s.
- **Icônes** : un lieu est ajouté à la carte quand Koffi passe à moins de 40 m (60 m pour les lieux remarquables), ou quand quelqu'un le lui indique (dialogue, message avec lieu, panneau d'information : un panneau dévoile les icônes de services dans un rayon de 300 m).
- **Plan acheté** : chaque kiosque Zékôm ou vendeur de journaux vend le « plan du quartier » : 500 FCFA, dévoile les cases et les icônes de services de ce quartier (10 quartiers). Au chapitre 4, le téléphone tactile dévoile toutes les **rues** de la ville ; les icônes restent à découvrir.
- **Quartiers** : en entrant pour la première fois dans un quartier, son nom s'affiche 3 s au centre de l'écran (« AKPAKPA ») ; compteur dans les statistiques : « Quartiers redécouverts : 4 sur 10 ».
- **Ce qui change avec les chapitres** (décision 91) : les routes neuves et les places rénovées apparaissent sur la carte au début du chapitre concerné, déjà dévoilées si la case l'était ; un lieu disparu (boutique fermée) est retiré.
- **Utilité** : la liste des destinations en zémidjan et en taxi ne contient que les lieux découverts ; le GPS calcule sur toutes les routes, même non dévoilées (le tracé traverse le gris).
- Progression : pourcentage de cases dévoilées affiché dans la légende ; 100 % : succès « Enfant du pays » (voir « Statistiques et succès », autre agent).
- Sauvegarde : un bit par case (48 × 32 = 1 536 cases, 192 octets) et la liste des lieux connus.
- Test : nouvelle partie : cases de Dantokpa et Missèbo dévoilées, une case d'Akpakpa non ; entrer à pied dans une case la dévoile seule, en voiture avec ses 8 voisines ; lieu à 35 m ajouté, à 50 m non ; achat du plan : toutes les cases du quartier ; état identique après sauvegarde et rechargement ; 1 536 cases exactement.

## Repères personnels
- **Poser** : sur la grande carte, **E** à l'emplacement du curseur : un repère violet (losange) est posé au point de route ou de terrain praticable le plus proche (25 m au plus ; au-delà, dans l'eau ou dans un bâtiment fermé : « Impossible de poser un repère ici. »). L'itinéraire violet se calcule aussitôt.
- **Un repère actif** à la fois : en poser un autre déplace le premier. E sur le repère : le retirer.
- **Dans le monde** : colonne de lumière violette fine (visible à 300 m, s'efface à 15 m), losange sur la mini-carte avec la distance.
- **Arrivée** : à moins de 15 m, le repère disparaît avec un son léger.
- **Favoris** : maintenir E 0,6 s sur un point : « Enregistrer ce lieu » ; 8 favoris au plus, chacun avec une icône au choix parmi 6 (étoile, cœur, croix, moto, panier, point d'exclamation) et un nom choisi dans une liste (« Raccourci », « Bon maquis », « Cachette », « Kpayo pas cher », « À revoir », « Rendez-vous », « Chez un ami », « Vue »), sans saisie au clavier. Les favoris restent sur la carte, se retirent avec R, et servent de destination aux zémidjans et taxis (« Mon repère », « Bon maquis »).
- **Sans ouvrir la carte** : touche **B** en jeu : pose un favori provisoire « Ici » à la position de Koffi (utile pour retrouver un véhicule ou une cachette) ; remplacé au prochain appui.
- **Véhicule** : le dernier véhicule de Koffi a son icône d'office ; E dessus : itinéraire pour y retourner.
- **En mission** : le repère personnel est masqué (l'itinéraire de mission prime) et revient à la fin.
- Sauvegardé : repère actif, favoris, « Ici ».
- Test : E au curseur sur une route : repère à moins de 2 m ; dans la lagune à 100 m de toute rive : refus et message ; second repère : un seul existe ; arrivée à 14 m : retiré ; 9e favori refusé ; B pose « Ici » à la position du joueur ; mission lancée : itinéraire jaune seul, violet de retour après la mission ; tout est restauré après rechargement.

## Choix faits par Claude (à confirmer)
- Dantokpa et Missèbo connus dès le départ, boulevards de toute la ville visibles ; le reste se redécouvre par cases de 125 m.
- Pas de voix de GPS ; Koffi commente.
- Touches M (carte), B (repère « Ici »), L (légende), F1 (interface).
- Le GPS n'évite les embouteillages qu'à partir du chapitre 4 (téléphone tactile).
