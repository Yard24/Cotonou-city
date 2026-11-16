# Piétons : fonctionnement attendu

Code proposé : `scripts/pieton.gd` (un passant : marche, états, réactions), `scripts/foule.gd` (création, retrait, densité, routines), `scripts/tenue.gd` (apparence tirée au hasard). Vérifications : `scripts/selftest_pieton.gd`, sur un tronçon d'essai : une rue de 200 m avec deux trottoirs de 2,5 m et un passage piéton, tirage fixé.

Règles qui s'imposent partout : les passants ne meurent jamais (décision 4) ; au moins la moitié sont des femmes (47) ; enfants en uniforme kaki aux heures d'école, sur les trottoirs seulement, jamais impliqués dans une action (48) ; quelques étrangers à Ganhi et sur la plage (49) ; aucune moquerie (104). Temps : 1 heure de jeu = 2 minutes réelles.

## Déplacement sur les trottoirs
- Chaque trottoir porte deux **files de marche** parallèles (une par sens), à 0,6 m et 1,6 m de la bordure pour un trottoir de 2,5 m. Les passants suivent ces files, pas la chaussée. On marche à droite de son sens.
- Vitesses : marche tranquille 1,2 m/s (40 % des passants), marche normale 1,5 m/s (45 %), pas pressé 1,9 m/s (15 %). Course de fuite : 4,5 m/s. Personne âgée : 0,9 m/s. Porteuse de bassine sur la tête : 1,1 m/s, ne court jamais (elle pose la bassine et s'écarte).
- **Évitement** : un passant qui en rattrape un autre à moins de 1,2 m change de file s'il y a 2 m libres, sinon ralentit. Deux passants face à face s'écartent chacun de 0,4 m sur leur droite. Devant un obstacle fixe (étal, moto garée sur le trottoir, poteau), contournement par le côté libre ; si le trottoir est bouché, le passant descend sur la chaussée sur 6 m au plus, en regardant d'abord (même règle que la traversée).
- **Le joueur** : un passant s'écarte de 0,5 m devant Koffi qui marche ; si Koffi court et le touche, le passant est bousculé (recule de 0,6 m, dit une réplique de protestation, repart après 1 s) sans tomber. Une bousculade ne déclenche aucune recherche ; cinq en 30 s devant un policier à moins de 20 m : avertissement oral, puis 1 étoile à la suivante.
- **Pauses** : aux étals, vendeuses de rue, arrêts de minibus, bancs : un passant sur cinq s'arrête 5 à 40 s (regarde, achète, téléphone, s'assoit).
- **Nombre** : la densité se règle par quartier et par heure (voir « Routines selon l'heure »). Passants simulés complètement dans un rayon de 60 m autour du joueur ; de 60 à 120 m, déplacement simplifié (pas d'évitement, animation réduite à 10 images par seconde) ; au-delà, aucun. Plafond : 60 passants complets et 60 simplifiés (120 au marché, voir « Foules de marché »).
- Création et retrait toujours hors du champ de la caméra ou à plus de 80 m ; jamais d'apparition à moins de 25 m du joueur, même dans son dos.
- Ils ne marchent ni dans la lagune ni sur la plage mouillée ; sur la plage sèche, promeneurs libres (pas de files) à 1,0 m/s.
- Sous forte pluie : voir `jour_nuit_et_meteo.md` (ils courent s'abriter).
- Test : 20 passants lâchés 60 s sur le tronçon : aucun centre de passant sur la chaussée hors contournement et traversée ; aucune paire à moins de 0,5 m pendant plus de 1 s ; vitesses dans les trois classes ; un obstacle posé en travers d'un trottoir est contourné par tous en moins de 8 s ; aucune création à moins de 25 m du joueur sur 5 minutes simulées ; nombre total sous le plafond.

## Traversée de route
- **Où** : aux passages piétons peints (grands carrefours, devant les écoles et les marchés) ; dans les rues de quartier et les « vons », n'importe où (traversée libre).
- **Décision de traverser** (au bord, tourné vers la chaussée) : le passant regarde les deux sens ; il part si aucun véhicule n'atteindra sa trajectoire avant `largeur de chaussée / sa vitesse + 2 s` (pour 7 m à 1,5 m/s : 6,7 s). Sinon il attend, et réévalue toutes les 0,5 s. Après 12 s d'attente, sa marge tombe à +1 s (il « force » un peu, comme en vrai) ; après 25 s, il lève la main et s'engage si le premier véhicule est à plus de 15 m et roule à moins de 30 km/h.
- **Aux feux** (quand la circulation en aura, voir `circulation.md`) : traversée au feu rouge des véhicules ; 1 passant sur 6 traverse quand même si la voie est libre.
- **Pendant la traversée** : marche en ligne droite à sa vitesse +20 %. Si un véhicule arrive à moins de 8 m sur sa trajectoire : s'il a fait moins de la moitié, il recule ; sinon il court (3 m/s) jusqu'au bord. Sur un boulevard à terre-plein, il traverse en deux fois.
- **Les véhicules de la circulation** s'arrêtent toujours pour un piéton sur leur voie (règle déjà en place dans `trafic.gd`). Le conducteur arrêté plus de 6 s donne un petit coup de klaxon (une fois : décision 59).
- **Groupes** : aux passages piétons, les passants en attente partent ensemble (jusqu'à 6), ce qui évite un flux continu qui bloquerait la circulation. Entre deux groupes, 8 s au moins de voie libre pour les véhicules.
- **Enfants** (décision 48) : ils ne traversent pas. Leurs trajets domicile-école sont tracés sur un même côté de rue ; un adulte en gilet les fait attendre devant l'école (décor).
- **Embouteillage** : entre des véhicules à l'arrêt (moins de 5 km/h), les passants traversent en se faufilant, avec 0,5 m de marge.
- Traverser n'est jamais reproché au joueur : aucune infraction piétonne pour Koffi.
- Test : voie libre, départ en moins de 1 s ; voiture à 50 km/h à 40 m sur 7 m de chaussée : le passant attend ; il part quand elle est passée ; 100 traversées avec circulation à 50 km/h : aucun contact ; un véhicule de la circulation s'arrête à plus de 2 m d'un piéton engagé ; aucun enfant sur la chaussée en 10 minutes simulées à 7 h 30 ; groupe de 6 au plus.

## Réactions au danger
- Chaque passant a un état : `calme`, `inquiet`, `fuite`, `à terre`, `abrité`. Il ne peut pas être détruit : il n'a pas de points de vie.
- **Ce qui inquiète** (il s'arrête, regarde, recule de 2 m ; 3 à 6 s) : klaxon long à moins de 10 m ; véhicule à plus de 30 km/h à moins de 6 m ; bagarre à 10-20 m ; sirène de police à moins de 40 m ; Koffi qui court droit sur lui.
- **Ce qui fait fuir** (course à 4,5 m/s à l'opposé du danger, 8 à 15 s, puis marche inquiète 10 s, puis retour au calme et à sa routine) : bagarre à moins de 10 m ; véhicule sur le trottoir à moins de 12 m ; collision de véhicules à moins de 15 m ; coup de feu de la police (scènes d'histoire seulement, décision 75) à moins de 80 m ; objet lancé près de lui.
- **Esquive d'un véhicule** : si un véhicule doit le toucher dans moins de 1,2 s, le passant plonge de côté (1,5 m, perpendiculaire à la trajectoire, vers le bord le plus proche). Réussite : 100 % sous 30 km/h, 80 % de 30 à 60, 50 % au-delà (difficulté « Tranquille » : +20 points).
- **Renversé** (décision 4) : il tombe (0,5 s), reste à terre 2 s (sous 30 km/h) à 4 s (au-delà), se relève en se tenant le bras ou la hanche, s'éloigne en boitant 6 s puis fuit normalement. Projection limitée à 2 m, pas de sang. Il redevient un obstacle solide dès qu'il se relève ; à terre, les véhicules de la circulation s'arrêtent devant lui et celui du joueur est freiné à 5 km/h en passant (impossible de « rouler dessus » à pleine vitesse).
- **Frappé par Koffi** : voir `combat.md` (il tombe, se relève, s'enfuit).
- **Témoins** : tout passant en état `inquiet` ou `fuite` qui voit la cause est témoin. S'il y a un policier à moins de 50 m, la recherche est immédiate ; sinon un témoin sur trois « téléphone » (animation, 6 s) et une patrouille est envoyée (voir `police_et_niveau_de_recherche.md`). Bousculer ou effrayer le témoin interrompt l'appel une fois sur deux.
- **Les courageux** : 1 adulte sur 10 ne fuit pas une bagarre : il s'interpose en paroles (« Hé ! Laissez-le ! »), à 3 m, sans frapper. Devant un passant à terre, 1 sur 4 vient l'aider à se relever (il se relève alors en 1 s).
- **Les vendeuses** ne quittent pas leur étal : elles se baissent derrière (`abrité`) et crient. Les **enfants** s'écartent toujours les premiers (rayon d'inquiétude doublé), courent vers l'école ou un adulte, et ne peuvent être ni touchés ni bousculés : un véhicule ou un coup qui devrait en atteindre un est dévié ou annulé (zone de protection de 1 m, voir « Choix »).
- **Retour à la normale** : 20 s sans nouveau danger. La rue ne reste pas vide : les passants créés ensuite arrivent calmes.
- Répliques de réaction (liste de départ, 3 voix d'hommes et 3 de femmes) : « Hé ! Doucement ! », « Tu es fou ou quoi ? », « Kaï ! », « Regarde devant toi, hein ! », « On va appeler la police ! », « Ça va, madame ? », « Mon pied ! », « Chauffeur du dimanche ! », « Éééé ! Les gens de maintenant… ».
- Test : véhicule lancé à 20 km/h sur un passant : esquive dans 100 % des cas sur 50 essais ; à 80 km/h : touché dans 40 à 60 % des cas, toujours relevé en moins de 6 s, toujours présent dans la scène ensuite ; bagarre simulée : tous les passants à moins de 10 m passent en `fuite`, s'éloignent d'au moins 20 m, reviennent au calme en moins de 60 s ; un enfant placé sur la trajectoire d'une voiture n'est jamais touché ; avec un policier à 40 m, étoile immédiate.

## Conversations d'ambiance
- But : faire entendre la ville sans dialogue écrit par mission. Trois formes :
  1. **Échange à deux** : deux passants arrêtés face à face (ou une cliente et une vendeuse) disent 2 à 4 répliques.
  2. **Phrase au téléphone** : un passant seul, téléphone à l'oreille, dit 1 ou 2 phrases.
  3. **Interpellation** : une phrase lancée à Koffi quand il passe à moins de 3 m (vendeuse, apprenti de minibus, zémidjan au parc).
- **Déclenchement** : au plus une conversation audible toutes les 12 s, dans un rayon de 8 m autour du joueur à pied (5 m en véhicule, vitres ou casque obligent ; rien au-dessus de 30 km/h). Volume qui décroît avec la distance, inaudible à 15 m. Pas de sous-titres par défaut (option « sous-titrer l'ambiance » dans les menus, voir `dialogues.md`).
- Une même réplique n'est pas rejouée avant 10 minutes réelles ; une même conversation pas avant 20 minutes.
- **Quantité visée** pour la première version publique : 60 échanges à deux, 40 phrases de téléphone, 40 interpellations ; 8 voix (4 femmes, 4 hommes), générées (décision 108).
- **Thèmes**, choisis selon le lieu, l'heure, la météo et le chapitre : prix du marché, embouteillages, pluie et inondations, harmattan, coupure de courant, football de quartier (équipes inventées), famille, école, chantiers (chapitre 4), ville à l'arrêt (chapitre 3, sans nommer la maladie : décision 95), paiement mobile, zémidjans trop rapides.
- **Écho des actes du joueur** (2 à 5 minutes réelles après) : « Tu as vu le zém qui est tombé à Étoile Rouge ? », « Il paraît qu'on a arrêté quelqu'un à Ganhi. ». Dix phrases à trous (lieu, véhicule).
- Exemples, à reprendre tels quels :
  - Marché — « C'est combien, la tomate ? — 500 le tas. — 500 ? Tu veux que je cuisine l'argent ? — Prends à 400, c'est parce que c'est toi. »
  - Rue — « Tu as eu le courant chez toi hier ? — À 23 h seulement. J'ai repassé la chemise à la lampe torche. »
  - Téléphone — « Allô ? Je suis déjà en route… Oui, oui, je suis au carrefour. » (le passant est assis sur un banc).
  - Téléphone — « Maman, j'ai envoyé par KwabôPay. Regarde ton téléphone. Non, l'autre téléphone. »
  - Pluie — « Ça, c'est une pluie qui va emporter les sandales. — Les miennes sont déjà parties. »
  - Harmattan — « Mets la pommade sur les lèvres, tu ressembles à un poisson fumé. »
  - Interpellation (vendeuse) — « Grand frère, viens goûter ! Beignets chauds, 25 francs ! »
  - Interpellation (apprenti) — « Étoile, Étoile, Étoile ! Il reste une place ! » (il en reste six).
  - Interpellation (zémidjan au parc) — « Koffi ! Tu roules encore avec la moto de Romaric ? Elle tousse, hein. »
  - Chantier (chapitre 4) — « Ils ont encore cassé la route. — Ils disent que c'est pour la refaire. — Ils disaient ça aussi l'année passée. »
- Salutations fon autorisées dans l'ambiance : seulement celles de la liste de `dialogues.md`.
- Une conversation s'interrompt net si un des deux passe en `inquiet` ou `fuite`.
- Interdits : personne réelle, parti, marque réelle, religion tournée en ridicule, accent moqué (décisions 17, 25, 104) ; jurons légers seulement (112).
- Test : 10 minutes simulées à pied au marché : entre 20 et 50 conversations jouées, jamais deux à moins de 12 s, aucune répétition de réplique ; rien de joué au-dessus de 30 km/h ; conversation coupée quand un danger apparaît ; les fichiers de voix référencés existent tous.

## Foules de marché
- Lieux : halle et allées de Dantokpa, rues de Missèbo, marchés d'Akpakpa et de Ganhi. Heures pleines : 8 h-18 h (pic 10 h-13 h).
- **Densité visée** dans les allées : 1 personne pour 3 m² au pic (une allée de 4 m × 30 m = 40 personnes), 1 pour 8 m² le reste de la journée, 1 pour 40 m² après 19 h, personne après 21 h sauf gardiens et balayeuses.
- **Trois niveaux de détail**, pour tenir 300 silhouettes visibles :
  | Distance au joueur | Représentation | Plafond |
  |---|---|---|
  | 0-25 m | passant complet (évitement, réactions, voix) | 40 |
  | 25-60 m | passant simplifié (suit sa file, animation à 10 images par seconde, pas de voix) | 80 |
  | 60-150 m | silhouette groupée (instances sans squelette, glissement lent, 3 poses) | 180 |
- **Circulation dans les allées** : pas de files strictes ; chaque passant vise un étal, y reste 10 à 60 s, puis en vise un autre à 5-30 m ; 1 sur 4 repart avec un sachet noir à la main. Vitesse 0,8 à 1,2 m/s.
- **Personnages fixes** : vendeuses assises derrière leurs étals (une par étal ouvert, ne se déplacent pas), porteurs avec charrette à bras ou pousse-pousse (2 par allée principale ; ils demandent le passage : « Agoo ! », et la foule s'écarte de 1 m), vendeurs ambulants (plateau sur la tête), apprentis de minibus à l'entrée.
- **Koffi dans la foule** : sa vitesse est plafonnée à 3,5 m/s en marche et 6 m/s en course quand il y a plus de 6 passants à moins de 3 m ; les passants s'écartent d'eux-mêmes à la marche, sont bousculés à la course. C'est un outil de jeu : en poursuite à pied, la foule ralentit autant les poursuivants (voir `police_et_niveau_de_recherche.md`).
- **Véhicules** : les allées couvertes sont interdites à tout véhicule (bornes). Dans les rues de marché, la foule déborde sur la chaussée : la circulation y roule à 10 km/h ; une moto du joueur est plafonnée à 20 km/h par la densité (les passants s'écartent en protestant) ; une voiture avance à 8 km/h au plus. Forcer le passage au-dessus de ces vitesses renverse des passants : témoins nombreux, 1 étoile immédiate (il y a toujours un agent au marché en journée).
- **Panique** : un danger au marché fait fuir les passants dans un rayon de 15 m seulement (au lieu de 10 m, mais sans contagion au-delà) ; les allées se vident vers les sorties, pas vers les étals. Les étals ne sont jamais renversés par la foule.
- **Sons** : brouhaha continu dont le volume suit la densité (3 couches : clairsemé, animé, plein), cris de vente toutes les 5 à 10 s.
- Chapitre 3 : densité divisée par 4, un étal sur deux fermé. Chapitre 6 (place rénovée) : mêmes foules, allées plus larges.
- Test : au pic, entre 250 et 300 personnages visibles depuis l'entrée de Dantokpa et image au-dessus de 30 par seconde sur la machine de référence (voir le document « Performance ») ; plafonds par niveau jamais dépassés ; vitesse de Koffi plafonnée dans la foule ; moto à 20 km/h au plus dans une rue de marché pleine ; personne dans les allées à 22 h ; un porteur traverse une allée pleine en moins de 40 s.

## Routines selon l'heure
- La densité de chaque type de lieu suit ce tableau (100 = plafond du lieu). Entre deux tranches, passage progressif sur 30 minutes de jeu.

| Tranche | Rues de quartier | Boulevards et Ganhi | Marchés | Plage, Marina | Maquis |
|---|---|---|---|---|---|
| 5 h-6 h 30 | 20 (balayeuses, fidèles qui vont prier, vendeuses de bouillie) | 10 | 15 (installation des étals) | 5 (pêcheurs) | 0 |
| 6 h 30-9 h | 70 (enfants vers l'école, travailleurs) | 80 | 50 | 10 (sportifs) | 5 |
| 9 h-12 h | 40 | 70 | 100 | 15 | 10 |
| 12 h-15 h | 30 (sieste, ombre) | 50 | 80 | 10 | 70 (repas) |
| 15 h-17 h | 40 | 60 | 90 | 30 | 20 |
| 17 h-20 h | 80 (retour, enfants de 17 h à 18 h) | 90 | 50 (rangement à partir de 18 h) | 80 (promeneurs, footballeurs) | 60 |
| 20 h-23 h | 40 (devant les maisons, sur des bancs) | 30 | 5 | 50 | 100 |
| 23 h-5 h | 5 (gardiens assis, quelques noctambules) | 5 | 2 (gardiens) | 5 | 20 jusqu'à 1 h, puis 0 |

- **Enfants en uniforme kaki** : présents de 6 h 45 à 7 h 45, de 12 h à 12 h 30 et de 17 h à 17 h 45, du lundi au vendredi, sur les trottoirs à moins de 300 m d'une école, par groupes de 2 à 5. Aucun le week-end, pendant les vacances (juillet-septembre du calendrier du jeu) ni au chapitre 3.
- **Routines individuelles** : un passant créé reçoit un but (école, marché, bureau, maison, maquis, arrêt de minibus, lieu de culte) cohérent avec l'heure ; il marche vers ce but puis disparaît en y entrant (porte, cour) ou devient une silhouette fixe (assis). On ne simule pas de journée complète par passant.
- **Personnages à horaire fixe** : Maman Koffi à son étal de bouillie de 6 h à 10 h (décision 30) ; balayeuses 5 h-7 h ; vendeuses de pain 6 h-9 h et 17 h-20 h ; vendeurs de brochettes 18 h-23 h ; gardiens de nuit devant les boutiques 21 h-6 h (assis, lampe torche).
- **Jours** : semaine de 7 jours. Samedi : marchés à 100 dès 8 h, Ganhi à 40. Dimanche matin : rues calmes (30), passants en tenue de fête de 8 h à 11 h ; après-midi : plage à 100. Vendredi 13 h-14 h : passants en boubou autour des mosquées (décor, décision 18).
- **Météo** : forte pluie : toutes les densités × 0,2 et les passants restants sont abrités ; harmattan : × 0,9 le matin ; grosse chaleur de 13 h à 15 h : les passants marchent à l'ombre quand le trottoir en a.
- **Chapitres** : chapitre 3 : densités × 0,35 partout, × 0,25 au marché, personne après 21 h ; chapitre 4 : ouvriers en gilet autour des chantiers 7 h-17 h ; chapitre 6 : places rénovées à 100 le soir.
- Test : pour chaque tranche, en forçant l'heure, le nombre de passants dans une zone d'essai de chaque type est à ± 20 % de la valeur du tableau × plafond ; aucun enfant hors des trois créneaux ni un samedi ; Maman Koffi présente à 8 h, absente à 11 h ; passage 8 h 50-9 h 30 sans saut de plus de 15 % en une minute de jeu.

## Variété des tenues
- Un passant = une **silhouette** + une **tenue** + des **couleurs** + un **accessoire**, tirés à sa création par `tenue.gd` à partir d'une graine (la même graine redonne le même passant).
- **Silhouettes** (8) : femme mince, femme ronde, femme âgée, homme mince, homme fort, homme âgé, adolescent·e (lycéen, 15-18 ans), enfant (9-12 ans). Trois tailles par silhouette adulte (×0,95, ×1,0, ×1,05). Teintes de peau : 6 nuances de brun ; passants étrangers (décision 49) : 4 nuances de plus, seulement à Ganhi, à la Marina, à l'aéroport et sur la plage, 1 passant sur 20 dans ces lieux.
- **Tenues** (22) :
  | Femmes (10) | Hommes (9) | Jeunes (3) |
  |---|---|---|
  | pagne noué + chemisier | pantalon + chemise à manches courtes | uniforme kaki (enfant) |
  | ensemble en pagne (jupe longue + haut assorti) | jean + tee-shirt | uniforme kaki (lycéen) |
  | boubou ample | boubou trois pièces | short + maillot de foot |
  | robe droite en pagne | chemise en pagne + pantalon | |
  | jupe + tee-shirt | short + débardeur (ouvrier, porteur) | |
  | tailleur ou chemisier-pantalon (Ganhi) | costume ou chemise-cravate (Ganhi) | |
  | jean + haut | tenue de mécanicien (bleu taché) | |
  | tenue de sport | survêtement | |
  | vendeuse : pagne + foulard + tablier (décision 46) | chemise jaune numérotée (zémidjan, décision 43) | |
  | tenue de fête (dimanche, cérémonies) : bazin brodé | tenue de fête : bazin brodé | |
- **Coiffures et couvre-chefs** (12) : foulard noué (4 nouages), tresses, cheveux courts, perruque lisse, crâne rasé, casquette, bonnet brodé, chapeau de paille, casque de moto porté au bras.
- **Motifs de pagne** : 24 motifs inventés (décision 46 : aucun motif de marque réelle), chacun en 3 jeux de couleurs, soit 72 tissus, sur une seule planche de textures de 2 048 × 2 048.
- **Accessoires** (1 passant sur 2) : sachet noir, sac à main, sac à dos, bassine sur la tête (femmes, marchés), plateau de marchandises, bébé au dos (ne peut jamais être renversé : cette passante esquive toujours), téléphone à la main, parapluie (pluie), cache-nez (harmattan, et pour 9 passants sur 10 au chapitre 3), bidon jaune, régime de bananes.
- **Répartition par lieu** : Ganhi : 50 % de tenues de bureau ; marchés : 60 % de pagnes, 100 % de vendeuses derrière les étals ; plage : sport, shorts, étrangers ; quartiers : mélange ; têtes de ligne : chemises jaunes.
- **Évolution par chapitre** : plus de jeans et de téléphones tenus à la main à partir du chapitre 4 (1 passant sur 3 au lieu de 1 sur 6) ; écouteurs à partir du chapitre 5.
- **Règle anti-clones** : jamais deux passants identiques (même silhouette, même tenue, mêmes couleurs) à moins de 30 m l'un de l'autre ; à la création, on retire jusqu'à 5 fois.
- **Budget** : conforme à `docs/style_graphique.md` ; les 8 silhouettes partagent un squelette (un pour les adultes, un pour les enfants) et toutes les tenues tiennent sur 3 planches de textures.
- Nombre de combinaisons adultes : 6 silhouettes × 3 tailles × environ 9 tenues × 72 tissus ou 12 couleurs unies × 12 coiffures : plusieurs dizaines de milliers.
- Test : 1 000 tirages : au moins 50 % de femmes (± 3 points) ; aucun enfant hors uniforme kaki ou tenue de foot ; aucun uniforme kaki sur un adulte ; étrangers absents hors des quatre lieux ; aucune paire identique à moins de 30 m sur 200 passants placés ; la même graine redonne la même apparence ; chemise jaune seulement sur les conducteurs de zémidjan.

## Choix faits par Claude (à confirmer)
- Les enfants ne peuvent être ni touchés ni bousculés (zone de protection de 1 m qui dévie véhicules et coups) : application stricte des décisions 3 et 48.
- Un passant à terre freine le véhicule du joueur à 5 km/h : pas de « rouler dessus ».
- « Agoo ! » (demande de passage) ajouté à la liste des expressions à faire valider.
