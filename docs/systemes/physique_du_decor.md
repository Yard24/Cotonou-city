# Physique du décor : fonctionnement attendu

Déjà dans le jeu : murs, murets, caisses et étals du marché sont des obstacles fixes (`scripts/relief.gd`, `scripts/decor.gd`) ; on peut monter sur les étals. Rien ne se renverse encore. Code prévu : `scripts/renversable.gd` (objets qui tombent), `scripts/etal.gd`, `scripts/cloture.gd`, `scripts/lampadaire.gd`. Vérifications prévues : `scripts/selftest_decor.gd`.

Rappel des décisions : dégâts visibles, **pas d'explosion** ni d'incendie (57) ; passants jamais tués (4) ; barème de choc des véhicules : rien sous 18 km/h perdus d'un coup ; lieux de culte respectés (18) ; marques inventées (25) ; budget : étal et mobilier de rue 300 triangles, petit objet 150 (style graphique).

## Règles communes
- Trois familles : **fixe** (ne bouge jamais : bâtiments, murs, arbres, piliers), **renversable** (tient debout, tombe au choc), **cassable** (se défait en morceaux préparés à l'avance).
- Un objet renversable est **endormi** : tant que rien ne le touche, il n'a pas de physique active (aucun coût). Un choc suffisant le réveille : il devient un corps physique, tombe, glisse, puis se rendort après **4 secondes** d'immobilité.
- **Seuil de réveil** : chaque objet a une force minimale, donnée ici en vitesse de choc pour une voiture (une moto, plus légère, doit aller 1,5 fois plus vite ; Koffi à pied ne renverse que les objets de moins de 15 kg, en courant).
- **Limite** : 40 objets actifs en même temps au niveau « Bas », 80 en « Moyen », 150 au-delà. Au-dessus, les plus anciens et les plus éloignés sont figés là où ils sont.
- **Remise en place** : un objet renversé reste à terre tant que le joueur est à moins de 150 m ou le regarde. Ensuite, il est remis à sa place d'origine après **2 minutes réelles** (les gens ont rangé). Les objets cassés sont remplacés au **jour de jeu suivant**.
- **Dégâts au véhicule** : un objet renversable abîme peu (0 à 5 points) et ralentit selon sa masse ; un objet fixe applique le barème habituel.
- **Passants** : un objet renversé ne blesse pas un passant ; s'il tombe vers lui, il sursaute et s'écarte (2,5 secondes de fuite). Les objets ne tombent jamais sur un enfant (les abords des écoles n'ont que du mobilier fixe).
- **Son** : chaque matière a son bruit (tôle, bois, plastique, carton), entendu des adversaires à 40 m (voir perception).

## Objets renversables

| Objet | Masse | Seuil (voiture) | Effet sur le véhicule | Particularité |
|---|---|---|---|---|
| Carton, cageot vide | 2 kg | tout contact | aucun | Koffi les renverse en marchant |
| Chaise et table en plastique | 3 et 8 kg | tout contact | aucun | se glissent sous les roues 1 s (bruit) |
| Bidon jaune de 25 litres, vide | 2 kg | tout contact | aucun | roule ; vu partout |
| Bidon jaune plein (eau, huile) | 25 kg | 8 km/h | −5 km/h | se renverse et fait une flaque (voir ci-dessous) |
| Poubelle, demi-fût | 15 kg | 8 km/h | −5 km/h | répand 6 déchets légers |
| Pile de pneus (4) | 40 kg | 15 km/h | −10 km/h | les pneus roulent jusqu'à 12 m |
| Parasol de vendeuse | 6 kg | 5 km/h | aucun | s'envole de 2 m si la météo est à l'orage |
| Panneau-chevalet de boutique | 5 kg | tout contact | aucun | — |
| Cône et barrière de chantier | 3 et 12 kg | 5 km/h | aucun | chapitre 4 surtout |
| Panneau de signalisation (poteau fin) | 20 kg | 30 km/h | −15 km/h, 3 points de dégâts | se plie à la base, ne se détache pas |
| Vélo, moto garée | 15 et 110 kg | 10 et 25 km/h | −5 et −20 km/h | la moto tombe sur le côté ; son propriétaire proteste s'il est là |
| Brouette, pousse-pousse chargé | 30 à 120 kg | 15 km/h | −15 km/h | verse son chargement (sacs) |
| Sac de riz ou de ciment de 50 kg | 50 kg | 20 km/h | −15 km/h | le sac de ciment crevé fait un nuage gris de 3 s |
| Présentoir de bouteilles de kpayo | 20 kg | 8 km/h | aucun | voir ci-dessous |
| Poteau de bois d'un auvent | 25 kg | 35 km/h | −20 km/h, 5 points | l'auvent s'affaisse d'un côté, sans tomber sur personne |

- **Kpayo** : les bouteilles et bonbonnes d'essence de contrebande se renversent et font une flaque sombre de 2 m (glissante 20 secondes : adhérence −40 %). **Elles ne prennent jamais feu et n'explosent jamais** (décision 57), même sous un choc violent ou près d'un moteur qui fume. Le vendeur réclame 1 500 FCFA par présentoir renversé (voir dédommagement des étals) ; refuser coûte 3 de réputation dans le quartier.
- **Flaques** (eau, huile, kpayo) : disque de 1,5 à 2 m, 20 secondes ; adhérence −40 % pour tous les véhicules (distance de freinage plus longue, virage plus large). Personne ne tombe de moto à cause d'une flaque : on ne tombe pas de moto sans collision (décision du 16 novembre).
- **À pied** : Koffi pousse en marchant les objets de moins de 15 kg (ils glissent devant lui) et bute contre les autres. Plus tard : ramasser et lancer un cageot, tirer une brouette.
- **Utilité en jeu** : dans une poursuite, renverser des pneus ou une brouette derrière soi ralentit les poursuivants (ils perdent la même vitesse que le joueur aurait perdue) ; les adversaires en fuite font pareil (1 objet toutes les 10 secondes).
- **Objets jamais renversables** : tout ce qui se trouve dans l'enceinte ou devant l'entrée d'un lieu de culte, d'une école, d'un centre de santé ; les marmites sur le feu des maquis (fixes, pour ne blesser personne) ; les bouteilles de gaz (fixes).
- Cas limites : objet poussé dans l'eau → il flotte 10 secondes puis disparaît ; objet coincé sous un véhicule → il est écarté sur le côté au bout de 1 seconde ; objet tombé hors de la carte ou sous le sol → remis à sa place d'origine tout de suite.
- Test : une voiture à 30 km/h renverse une pile de pneus (elle perd environ 10 km/h, 0 point de dégâts) et pas un panneau de signalisation à 25 km/h ; une moto à 20 km/h ne renverse pas la pile de pneus (seuil 22,5 km/h), à 25 km/h si ; Koffi en marchant déplace un carton, pas un sac de riz ; 4 secondes après le choc, l'objet est rendormi ; 2 minutes plus tard, joueur à plus de 150 m, il est revenu à sa place ; 60 objets renversés au niveau « Bas » → 40 actifs au plus ; un présentoir de kpayo renversé ne produit ni flamme ni explosion, seulement une flaque.

## Étals de marché
- Déjà là : les étals du marché Dantokpa (table de bois `8b5a2b`, toit de tôle ou parasol), fixes, sur lesquels on peut monter. À faire : les rendre vivants.
- **Types** :
  - **table simple** (1,8 × 0,8 m, 0,8 m de haut) avec marchandise posée : tomates, piments, oignons en tas, poisson fumé, pagnes pliés, chaussures, quincaillerie ;
  - **étal couvert** (2 × 1,5 m, 4 poteaux, toit de tôle à 2,2 m) ;
  - **bassine au sol** sur un petit tabouret, parasol ;
  - **étal roulant** (charrette à bras) ;
  - **natte au sol** (friperie, 2 × 3 m).
- **Choc d'un véhicule** :
  - en dessous de 10 km/h : l'étal tremble, 2 ou 3 articles roulent, la vendeuse crie ; pas de dégât ;
  - de 10 à 30 km/h : la table bascule, la marchandise se répand (12 à 20 petits objets très légers : tomates qui roulent, pagnes qui volent), le véhicule perd 10 km/h ;
  - au-dessus de 30 km/h : la table casse en 3 morceaux préparés, le toit de tôle tombe à plat (jamais sur quelqu'un), le véhicule perd 20 km/h et prend 3 points de dégâts ;
  - les 4 poteaux d'un étal couvert sont fixes jusqu'à 35 km/h.
- **La vendeuse** : elle s'écarte toujours à temps (pas de côté de 2 m dès qu'un véhicule arrive vers elle à moins de 2 secondes ; décision 4 : elle peut tomber assise, se relève, n'est jamais blessée gravement). Puis elle se fâche (6 répliques par type de marchandise : « Mes tomates ! Tu vas payer ça aujourd'hui même ! »).
- **Dédommagement** : pendant 30 secondes, E près de la vendeuse propose « Payer les dégâts ». Montants (2017) : bassine ou natte 500 FCFA ; table simple 1 500 FCFA ; étal couvert 3 000 FCFA ; table cassée +2 000 FCFA.
  - Payé : la perte de réputation du quartier passe de −3 à −1, et la vendeuse revend à Koffi normalement.
  - Pas payé : −3 dans le quartier, −2 chez les Dames du marché, et cette vendeuse refuse de servir Koffi pendant 3 jours de jeu. Si un policier est à moins de 50 m : 1 étoile.
  - Trois étals renversés en moins de 2 minutes réelles : 1 étoile de toute façon (« trouble au marché »).
- **Monter dessus** (existe) : marcher sur une table garnie écrase la marchandise — même dédommagement qu'un choc léger (500 FCFA) ; les tables vides (après 19 h) ne coûtent rien.
- **Horaires** : marchandise présente de 7 h à 19 h ; le soir, tables vides et bâchées, quelques étals de nuit éclairés à la lampe ; chapitre 3 : un étal sur trois seulement.
- **Allées** : 3 m de large au marché ; les véhicules n'y entrent pas (bornes fixes aux entrées ; une moto y est poussée à la main, voir « Groupes et réputation », territoires). Les étals renversables par un véhicule sont donc surtout ceux du bord des rues.
- **Pluie** : les vendeuses tirent des bâches en 10 secondes ; les nattes au sol sont repliées.
- **Remise en état** : un étal renversé est redressé au bout de 2 minutes réelles hors de vue ; un étal cassé revient au jour de jeu suivant.
- Cas limites : étal poussé par un autre véhicule que celui du joueur (circulation) → cela n'arrive pas, la circulation les évite toujours ; le joueur bousculé contre un étal par un adversaire → pas de dédommagement dû ; étal renversé pendant une poursuite imposée par une mission → dédommagement réclamé à la fin de la mission, plafonné à 5 000 FCFA.
- Test : à 8 km/h, l'étal reste debout ; à 20 km/h, il bascule, la voiture perd entre 8 et 12 km/h, entre 12 et 20 articles sont créés ; à 40 km/h, la table est en 3 morceaux et la voiture a 3 points de dégâts ; la vendeuse est à plus de 1,5 m du point de choc dans les trois cas et n'a pas été touchée ; payer 1 500 FCFA limite la perte de réputation à 1 ; sans payer, la vente est refusée pendant 3 jours de jeu ; 3 étals en 2 minutes donnent 1 étoile.

## Clôtures

| Type | Hauteur | Comportement à pied | Comportement face à un véhicule |
|---|---|---|---|
| Mur de parpaings (cours, concessions) | 2 à 2,5 m | infranchissable, sauf par une caisse ou un véhicule garé contre lui | fixe, barème de choc habituel |
| Mur bas, muret (existe) | 0,5 à 1,5 m | franchissement avec Espace | fixe |
| Tôle ondulée sur cadre de bois (chantiers, terrains vagues) | 2 m | infranchissable ; certaines ont une tôle décrochée (passage accroupi de 0,8 m de large, marqué par une tôle de travers) | à partir de 25 km/h en voiture, un panneau de 2 m se couche (cassable) ; −15 km/h, 4 points de dégâts ; une moto ne passe jamais |
| Palissade de bambou ou de branches de palmier (plage, maquis, village lacustre) | 1,6 m | franchissement impossible (trop fragile pour grimper), mais on voit au travers | cède à partir de 15 km/h ; −8 km/h, 1 point |
| Grillage sur poteaux (terrains de sport, écoles) | 2 m | on voit au travers ; infranchissable | fixe devant les écoles ; ailleurs cède à 35 km/h ; −20 km/h, 5 points |
| Grille en fer forgé (banque, administrations, belles villas de Ganhi) | 2,2 m | infranchissable | fixe |
| Clôture de sécurité (port, aéroport, entrepôts du Transit) | 2,5 m, barbelé au sommet | infranchissable ; plafond invisible au-dessus | fixe, toujours |
| Barrière de bois basse (enclos, jardins) | 1 m | franchissement avec Espace | cède à 10 km/h ; −5 km/h |
| Haie taillée | 1,2 m | franchissement avec Espace, ralentit | on passe au travers ; −10 km/h |
| Barrière levante (parkings, port, péage) | bras à 1 m | on passe dessous accroupi | cède à 30 km/h (le bras se casse) : 1 étoile, 5 points |
| Portail de concession en tôle | 2 m | E pour ouvrir s'il n'est pas verrouillé (1 s) | fermé : fixe ; ouvert : on passe |

- **Portails et portes** : trois états — ouvert, fermé, verrouillé. Les portails des lieux de mission s'ouvrent par l'histoire ; ceux des propriétés de Koffi s'ouvrent tout seuls à son approche en véhicule (à 8 m, en 1,5 seconde).
- **Lieux protégés** : les clôtures des écoles, lieux de culte, centres de santé, commissariats et de l'aéroport sont toujours fixes ; rien ne permet d'y faire entrer un véhicule en force.
- **Propriété privée** : franchir la clôture d'une concession habitée fait sortir quelqu'un (« Hé ! Tu cherches quoi ici ? ») ; rester plus de 15 secondes : −1 de réputation ; chez le Transit : voir « Comportement des adversaires ».
- **Clôture cassée** : le panneau couché reste un obstacle bas (10 cm) sur lequel on roule ; réparé au jour de jeu suivant. Casser une clôture devant témoin : −1 de réputation ; devant un policier à moins de 50 m : 1 étoile.
- **Chantiers du chapitre 4** (décision 91) : de longues palissades de tôle bleue apparaissent sur les boulevards en travaux ; elles sont **fixes** (ce sont elles qui ferment les rues) et portent des panneaux « Travaux — déviation » inventés.
- **Les adversaires et la police** respectent les mêmes règles : aucun ne traverse une clôture fixe ; les fuyards à pied sautent les barrières basses en 0,6 seconde.
- Cas limites : véhicule arrêté à cheval sur une clôture couchée → il repart normalement ; clôture cédée par la moitié d'une voiture (choc en biais sous le seuil) → elle ne cède pas, glissement le long ; Koffi coincé entre un véhicule et une clôture fixe → il est poussé le long, jamais écrasé (santé perdue selon le choc).
- Test : une voiture à 20 km/h contre une tôle de chantier s'arrête, à 30 km/h le panneau se couche et elle perd entre 12 et 18 km/h ; une moto à 60 km/h ne passe pas la tôle ; la clôture de l'aéroport ne cède pas à 120 km/h ; Koffi franchit une barrière de bois de 1 m avec Espace mais pas un grillage de 2 m ; il passe accroupi par une tôle décrochée ; une barrière levante cassée donne 1 étoile ; le portail d'une propriété de Koffi est ouvert quand il arrive à 8 m.

## Lampadaires
- **Modèles** : lampadaire de boulevard (mât d'acier de 9 m, une ou deux crosses) tous les 30 m sur les boulevards et les ponts ; lampadaire solaire (mât de 6 m, panneau au sommet), surtout à partir du chapitre 4 sur les voies neuves ; poteau électrique en bois ou en béton (8 m) avec fils, dans les rues de quartier, portant parfois une ampoule ; projecteurs des places et du port (mâts de 15 m).
- **Allumage** : avec le cycle jour-nuit (décision 89), ils s'allument à 18 h 45 et s'éteignent à 6 h 30, par vagues d'une rue à l'autre sur 10 secondes (pas tous d'un coup). Lumière chaude `ffdcaa` sur les anciens, blanche sur les solaires. Halo au sol de 12 m de rayon ; 1 lampadaire sur 12 est en panne et 1 sur 20 clignote (fixés au tirage de la carte, pas au hasard à chaque nuit).
- **Coupures de courant** : aux chapitres 1 à 3, un quartier perd son éclairage public environ une nuit sur cinq, pendant 1 à 3 heures de jeu (les lampadaires solaires restent allumés ; les boutiques sortent des lampes ; on entend des groupes électrogènes). Aux chapitres 5 et 6, une nuit sur vingt. La radio parlée l'annonce.
- **Coût graphique** : au niveau « Bas », les lampadaires n'éclairent pas vraiment : globe lumineux et disque clair peint au sol ; « Moyen » : vraie lumière pour les 8 plus proches, sans ombre ; « Élevé » : 16, ombres pour les 4 plus proches ; « Ultra » : 32, ombres pour les 8 plus proches (voir « Performance », ombres et éclairage).
- **Choc d'un véhicule** :
  - en dessous de 40 km/h : le mât est fixe, barème de choc habituel ; il vibre et la lampe clignote 2 secondes ;
  - de 40 à 70 km/h (voiture) : le mât de boulevard **penche** de 15° et reste penché, la lampe s'éteint ; le véhicule est arrêté net (dégâts habituels d'un choc de face) ;
  - au-dessus de 70 km/h (voiture) ou 50 km/h (camion, minibus) : le mât **se couche** lentement (1,5 seconde), dans le sens du choc, et devient un obstacle bas en travers ; il ne tombe jamais sur un passant ni sur un autre véhicule (s'il y en a un dans l'axe, il reste penché à 30°). Étincelles brèves à la base, **pas d'incendie**.
  - Une moto ne fait jamais tomber un mât : choc habituel, chute du pilote.
  - Les poteaux électriques à fils, les mâts de 15 m et tous les lampadaires des ponts sont toujours fixes (pas de fil qui tombe sur la chaussée).
- **Conséquences** : un mât abattu éteint ce lampadaire et ses deux voisins jusqu'au jour de jeu suivant ; « dégradation de bien public » : 1 étoile si un policier est à moins de 80 m ou si c'est le 2e de la journée ; amende de 5 000 FCFA en cas d'arrestation avec ce motif.
- **La nuit et les adversaires** : sous un lampadaire allumé, Koffi est vu de plus loin (30 m au lieu de 15, voir perception) ; un quartier en coupure aide à se cacher.
- **Affiches et objets** : certains mâts portent une affiche ou une banderole de fausse publicité (marques inventées) ; aucune affiche électorale ni politique (décision 17).
- **Grimper** : on ne grimpe pas aux mâts.
- Cas limites : mât abattu sur la voie → la circulation le contourne ou attend, il est retiré au bout de 2 minutes réelles hors de vue (souche fermée par un cône jusqu'au lendemain) ; choc en reculant → mêmes seuils ; deux mâts à la suite → le second est testé avec la vitesse restante.
- Test : à 12 h, aucun lampadaire allumé ; à 19 h, tous sauf ceux en panne (1 sur 12) ; une voiture à 35 km/h ne déplace pas le mât ; à 55 km/h, il penche de 15° et s'éteint ; à 90 km/h, il se couche, deux voisins s'éteignent ; une moto à 100 km/h ne le fait pas tomber ; un mât de pont à 120 km/h reste fixe ; avec un passant placé dans l'axe de chute, le mât reste penché ; au niveau « Bas », aucune vraie source de lumière n'est créée pour les lampadaires ; pendant une coupure, seuls les solaires sont allumés.
