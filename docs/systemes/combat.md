# Combat : fonctionnement attendu

Code proposé : `scripts/combat.gd` (coups, garde, esquive, objets tenus), `scripts/adversaire.gd` (voir aussi le document « Comportement des adversaires », autre agent). Vérifications : `scripts/selftest_combat.gd`, sur une dalle vide de 20 × 20 m, avec un adversaire d'essai immobile puis un adversaire actif, tirage fixé.

Cadre (à respecter à la lettre) : **aucune arme à feu** pour le joueur ni pour les adversaires (décision 3) ; combat **à mains nues, plus objets ramassés** — bâton, planche — ni couteau ni machette (78) ; les adversaires battus restent assis, sonnés, ils ne meurent pas (79) ; les passants ne peuvent pas être tués (4) ; pas de sang détaillé, aucune violence sur des enfants (3) ; aucune mission n'oblige à faire du mal à un innocent (102) ; Koffi préfère négocier que se battre (10) : presque toute bagarre de l'histoire peut être évitée ou écourtée par la parole ou la fuite.

Les tâches « visée », « armes à feu » et « mise à couvert » ne concernent plus le joueur (voir « Conséquences pour le plan » dans `docs/decisions.md`). Leurs sections ci-dessous disent ce qui les remplace.

Touches (clavier) : **F** frapper (ou clic gauche), **G** garde (ou clic droit, maintenue), **Espace** pendant la garde : esquive, **Tab** changer de cible, **E** ramasser un objet, **R** le lancer ou le lâcher. Manette : X frapper, gâchette gauche garde, A esquive, stick droit cible, Y ramasser, B lancer.

## Coups de poing
- **Coup simple** : F. Portée 1,3 m, arc de 90° devant Koffi. Durée 0,35 s (0,12 s d'élan, 0,08 s actif, 0,15 s de retour). Dégâts 8.
- **Enchaînement** : trois F à moins de 0,5 s d'intervalle : gauche (8), droite (8), crochet (14, repousse de 1 m et fait vaciller 0,8 s). Total 30 en 1,2 s. Rater le rythme recommence au premier coup.
- **Coup appuyé** : F maintenu 0,6 s puis relâché : coup de pied frontal, portée 1,6 m, dégâts 18, repousse de 2 m, fait tomber un adversaire qui vacille. Koffi est vulnérable pendant la charge (il n'est pas en garde).
- **En courant** : F pendant une course de plus de 1 s : coup d'épaule, dégâts 10, fait tomber un adversaire léger ; Koffi s'arrête 0,5 s après.
- **Assistance** : s'il y a un adversaire dans un cône de 60° à moins de 3 m, Koffi se tourne vers lui et avance jusqu'à 1 m pour porter le coup. Sans cible, le coup part dans le vide (aucun effet).
- **Adversaires** (points de résistance) : petite frappe 40 ; homme de main 70 ; costaud 110 ; Capitaine (décision 35), scènes d'histoire : 200, avec des phases écrites. À zéro : l'adversaire s'assoit par terre, sonné, se tient la tête (décision 79) ; il y reste 30 s puis s'en va en boitant, ou reste assis jusqu'à la fin de la mission si elle le demande. On ne peut plus le frapper (les coups ne partent pas : Koffi dit « Il a son compte. »).
- **Effets** : bruit mat, petite secousse de caméra (0,1 s), l'adversaire touché recule de 0,3 m et ne peut pas attaquer pendant 0,25 s. Pas de sang, pas de marque.
- **Rythme des adversaires** : un seul attaque à la fois quand ils sont 2 ou 3 (les autres tournent à 2,5 m) ; deux à la fois à partir de 4. Leur coup : 0,5 s d'élan bien visible (bras armé), 10 points de dégâts (homme de main), 15 (costaud). Difficulté : dégâts reçus × 0,6 en « Tranquille », × 1,4 en « Corsé ».
- **Sur un passant** : il tombe au premier coup (aucun point de résistance), reste 2 s à terre, se relève et s'enfuit ; 1 étoile s'il y a un témoin (voir `police_et_niveau_de_recherche.md`). Un second coup sur un passant à terre est impossible. Les enfants ne peuvent pas être visés ni touchés (voir `pietons.md`).
- **Sur un policier** : il encaisse (80 points de résistance), +2 étoiles ; sonné, il est relevé par ses collègues après 10 s.
- Interdits de frappe : en nageant, accroupi, en véhicule, dans les bâtiments marqués « calmes » (logements, banque, lieux de culte, étal de Maman Koffi) : la touche F y fait un geste de la main (salut).
- Test : un coup sur l'adversaire d'essai (70) : reste 62 ; enchaînement : reste 40 après 1,2 s et recul d'au moins 0,8 m ; coup appuyé : −18 et recul d'au moins 1,5 m ; coup hors portée (2 m) : aucun dégât ; adversaire à zéro : état `sonné`, toujours présent, insensible aux coups suivants ; passant frappé : à terre puis en fuite, toujours présent après 10 s ; F dans un bâtiment calme : aucun dégât.

## Esquive
- **Garde** : G maintenue. Koffi lève les avant-bras, marche à 2,5 m/s, reste tourné vers sa cible. En garde, un coup de face (arc de 120°) ne fait que 30 % de ses dégâts ; un coup dans le dos fait 100 %. Une attaque à l'objet (bâton) traverse à 60 %.
- **Esquive** : Espace pendant la garde, avec une direction (gauche, droite, arrière) : pas chassé de 2 m en 0,35 s. Koffi est intouchable pendant les 0,25 premières secondes. Sans direction : recul. Temps de recharge 0,6 s (pas d'esquives en rafale).
- **Esquive parfaite** : déclenchée dans les 0,2 s qui précèdent l'impact d'un coup adverse : l'adversaire frappe dans le vide et vacille 1 s ; le prochain coup de Koffi dans cette seconde fait double dégâts. Un court ralenti (0,3 s à 50 % de vitesse) le signale.
- **Parade** : G pressée dans les 0,15 s avant l'impact : le coup ne fait aucun dégât et l'adversaire est repoussé de 0,5 m. Plus difficile que l'esquive, sans bonus de dégâts.
- **Signal** : chaque attaque adverse est annoncée par un élan de 0,5 s et un éclat blanc bref au poing (0,4 s en « Corsé », 0,7 s en « Tranquille »). Les attaques au bâton sont annoncées 0,7 s et ne peuvent pas être parées à mains nues (esquive seulement).
- **Saisies** (costauds, policiers) : annoncées par les deux bras ouverts ; la garde n'y fait rien, seule l'esquive marche. Saisi par un costaud : marteler F (6 appuis en 2 s) pour se dégager, sinon 15 points de dégâts. Saisi par un policier : arrestation.
- **Fuir** : sortir de la garde et courir. Les adversaires ordinaires poursuivent sur 60 m ou 15 s puis abandonnent en criant ; ils ne suivent pas dans une foule de marché ni devant un policier.
- **Se relever** : jeté à terre (coup appuyé d'un costaud), Koffi se relève en 1,2 s ; Espace pendant la chute : roulade, relevé en 0,6 s.
- Hors combat (pas de cible à 6 m), G ne fait rien et Espace reste le saut.
- Test : coup de 10 reçu en garde de face : 3 points perdus ; dans le dos : 10 ; esquive déclenchée 0,1 s avant l'impact : 0 dégât, adversaire `vacille`, coup suivant à 16 ; esquive 0,5 s trop tôt : touché ; deux esquives à 0,3 s d'intervalle : la seconde ne part pas ; saisie : garde sans effet, esquive efficace ; adversaire distancé de 60 m : il abandonne.

## Armes de mêlée
- « Arme » veut dire ici **objet ramassé** (décision 78). Liste fermée :

| Objet | Où | Dégâts | Portée | Cadence | Solidité (coups portés) | Particularité |
|---|---|---|---|---|---|---|
| Bâton (manche, branche) | chantiers, marchés, cours | 16 | 1,8 m | 0,5 s | 12 | enchaînement de 2 coups |
| Planche | chantiers, entrepôts, port | 22 | 1,7 m | 0,8 s | 6 | repousse de 1,5 m ; se casse en deux à la fin |
| Balai | devant les boutiques | 10 | 2,0 m | 0,45 s | 8 | tient à distance (l'adversaire touché ne peut pas avancer pendant 0,5 s) |
| Couvercle de marmite | maquis | 6 | 1,0 m | 0,4 s | 10 | garde à 10 % de dégâts au lieu de 30 % |
| Bidon vide (20 L) | stations de kpayo, port | 8 | lancé seulement | — | 1 | lancé : fait vaciller 1 s |
| Seau d'eau | marchés, lavage | 0 | lancé, 4 m | — | 1 | aveugle l'adversaire 2 s (il frappe au hasard) |
| Sandale | toujours disponible (maintenir R 1 s sans objet) | 3 | lancée, 10 m | 2 s | — | détourne l'attention : l'adversaire touché se tourne vers Koffi, vexé ; clin d'œil comique, une fois toutes les 10 s |

- **Ramasser** : E à moins de 1,5 m d'un objet marqué (contour clair quand on est en combat ou à 3 m). Un seul objet à la fois, tenu à la main droite. Koffi court normalement avec, ne peut pas grimper, nager ni conduire en le tenant : monter en véhicule ou sauter à l'eau le fait lâcher.
- **Lancer** : R : lance l'objet tenu vers la cible verrouillée (voir « Visée »), portée 8 m, dégâts = moitié des dégâts de frappe (5 au moins), l'objet tombe au sol et peut être repris s'il n'est pas cassé. R sans cible : pose l'objet.
- **Usure** : à la fin de sa solidité, l'objet casse (bruit sec, il disparaît après 5 s). Parer avec un objet l'use d'un cran.
- **Adversaires armés** : à partir du chapitre 2, certains hommes de main portent un bâton (dégâts 18, annonce 0,7 s). Un adversaire touché par un coup appuyé lâche son bâton : on peut le ramasser. Ils ne portent jamais de lame ni d'arme à feu.
- **Objets interdits** : couteaux, machettes, bouteilles cassées, outils tranchants, pierres lancées à la tête : aucun n'existe comme objet de combat, même dans le décor des marchés (les couteaux d'étal sont du décor fixe).
- **Sur un passant** : frapper un passant avec un objet = 2 étoiles s'il y a un témoin ; il tombe et se relève comme d'habitude.
- **Police** : un agent qui voit Koffi tenir un bâton ou une planche en pleine rue hors combat lui dit de le poser (sommation, 5 s) ; refus : 1 étoile. L'objet est confisqué à l'arrestation.
- Les objets ne se rangent pas, ne se gardent pas d'une mission à l'autre et ne sont pas sauvegardés.
- Test : bâton : 16 par coup, cassé au 13e ; planche : 22 et recul d'au moins 1,2 m, cassée au 7e ; couvercle : coup de 10 en garde = 1 point ; seau lancé : adversaire `aveuglé` 2 s ; lancer d'un bâton à 6 m : 8 points et objet au sol ; montée en véhicule : objet lâché ; aucun objet de la liste interdite n'est ramassable (recherche par nom dans la scène).

## Visée
- Pas de visée d'arme à feu : la tâche d'origine ne s'applique plus. Ce qui en tient lieu est le **verrouillage de cible** pour le corps à corps et le lancer.
- **Verrouillage automatique** : en entrant en combat (un adversaire hostile à moins de 6 m, ou premier coup porté), la cible est l'adversaire le plus proche du centre de l'écran. Un anneau discret s'affiche à ses pieds (blanc ; orange quand il prépare une attaque).
- **Changer de cible** : Tab (suivant, dans le sens des aiguilles d'une montre) ou stick droit. Maintenir Tab 0,5 s : plus de verrouillage (déplacement libre).
- Verrouillé, Koffi tourne autour de sa cible : gauche/droite deviennent des pas de côté ; la caméra se place derrière lui, cible et Koffi dans l'image, et recule jusqu'à 8 m pour garder à l'écran jusqu'à 4 adversaires.
- **Avertissement hors champ** : un adversaire qui attaque hors de l'écran est signalé par une flèche orange au bord de l'écran, 0,5 s avant l'impact.
- **Lancer** : la trajectoire est automatique vers la cible verrouillée (arc simple) ; précision 100 % jusqu'à 5 m, 70 % à 8 m, impossible au-delà. Sans verrouillage, on lance droit devant soi.
- Le verrouillage ne se pose jamais sur un passant, un enfant, un allié ni un adversaire déjà sonné. Sur un policier, seulement s'il est en train de saisir Koffi.
- Fin du combat (plus d'adversaire debout à 15 m, ou fuite réussie) : verrouillage retiré, caméra normale en 0,5 s.
- Test : deux adversaires à 2 m et 4 m : le plus proche du centre est verrouillé ; Tab passe à l'autre ; passant placé au milieu : jamais verrouillé ; adversaire sonné : verrouillage transféré au suivant ; 20 lancers à 4 m : 20 touchés ; à 8 m : entre 10 et 18 ; à 10 m : lancer refusé.

## Armes à feu
- **Il n'y en a pas dans le jeu jouable** (décision 3). Ni Koffi, ni ses alliés, ni Capitaine, ni aucun adversaire n'en porte, n'en ramasse, n'en achète ou n'en parle comme d'un moyen à sa portée. Aucune boutique, aucun menu, aucune touche, aucune munition.
- **Seule la police en porte** (étui fermé à la ceinture, modèle simplifié, jamais sorti en jeu libre) et « ne tire que dans des scènes d'histoire écrites à l'avance » (décision 75). Règles de ces scènes :
  - elles sont des cinématiques ou des passages très encadrés (voir `moteur_de_missions.md`) ; le joueur ne peut ni être touché par un tir aléatoire ni provoquer le tir par son comportement ;
  - tir de sommation en l'air ou dans un pneu : jamais sur une personne à l'image ; pas de blessé par balle montré ;
  - deux scènes au plus dans tout le jeu (proposition : chapitre 4, arrestation du policier corrompu par Barnabé ; chapitre 5 ou 6, interception des hommes de Capitaine), à confirmer par l'agent chargé de l'histoire ;
  - le son du coup de feu fait fuir les passants dans un rayon de 80 m (`pietons.md`).
- Un policier sonné ou arrêté dans une scène ne lâche pas son arme ; elle n'est pas un objet ramassable et n'a pas de collision propre.
- Conséquences pour le reste du jeu : pas d'impacts de balles dans le décor, pas de vitres brisées par tir, pas de gilet pare-balles, pas de réticule, pas de statistique de précision.
- Les jouets (pistolet à eau d'un étal) restent du décor non ramassable, pour éviter toute confusion à l'image.
- Test (automatique, à lancer sur tout le projet) : aucune action d'entrée nommée « tirer », « viser » ou « recharger » ; aucun objet ramassable dont la catégorie est `arme_a_feu` ; en jeu libre à 5 étoiles pendant 10 minutes simulées, aucun événement `tir` émis ; l'événement `tir` ne peut être émis que par un script de cinématique (vérifier l'appelant).

## Mise à couvert
- Pas de couverture contre des tirs : la tâche d'origine ne s'applique plus. Ce qui en tient lieu est **se cacher** : de la police pendant une recherche, des hommes de Capitaine pendant les missions de filature et d'infiltration (entrepôts du port).
- **S'accroupir** (C, voir `joueur_a_pied.md`) derrière un obstacle d'au moins 1,0 m de haut (muret, caisse, voiture, étal) : si l'obstacle coupe la ligne entre les yeux de l'observateur (1,6 m) et la tête de Koffi accroupi (1,1 m), il n'est pas vu. Portée de vue de l'observateur divisée par 2 envers un Koffi accroupi, même à découvert.
- **Se coller** : accroupi à moins de 0,6 m d'un obstacle, Koffi s'y adosse tout seul (pas de touche) ; gauche/droite le font glisser le long ; au bord, maintenir la direction 0,3 s le fait **jeter un œil** (la caméra se décale de 0,8 m, Koffi reste caché) ; relâcher le remet à l'abri.
- **Cachettes marquées** (petite icône d'œil barré quand on est à 3 m, pendant une recherche ou une mission discrète) : entrée de cour, dessous d'escalier, étal bâché, cabine de camion ouverte, grande jarre vide (comique, une seule dans le jeu, à Dantokpa). E pour y entrer (0,8 s), E ou une direction pour sortir. Dedans : invisible, sauf si un observateur a vu Koffi entrer (ligne de vue dans les 2 s précédentes) ou fouille cette cachette.
- **Jauge d'attention** : au-dessus de chaque garde ou agent qui peut voir Koffi : elle se remplit en 1,5 s à 10 m, 3 s à 25 m, 0,5 s à moins de 4 m ; deux fois plus lentement de nuit hors éclairage, sous forte pluie ou dans l'harmattan. Pleine : repéré. Elle se vide en 3 s hors de vue.
- **Bruit** : courir s'entend à 12 m, marcher à 5 m, accroupi à 1,5 m ; sous la pluie, tout est divisé par 2. Lancer un objet (R) fait un bruit à l'endroit de la chute : le garde va voir (8 s), ce qui libère le passage.
- **Dans la foule** : voir `police_et_niveau_de_recherche.md`, « Fin de recherche ».
- Les adversaires, eux, ne se mettent pas à couvert (ils n'ont rien à craindre à distance) ; ils peuvent se cacher pour une embuscade écrite par une mission.
- Test : garde à 15 m de jour, Koffi debout à découvert : repéré en moins de 3 s ; accroupi derrière une caisse de 1,2 m : jamais repéré en 30 s ; debout derrière la même caisse : repéré ; « jeter un œil » : non repéré ; dans une cachette sans avoir été vu : non trouvé si le garde ne la fouille pas ; entré sous ses yeux : trouvé ; objet lancé à 8 m : le garde quitte son poste au moins 6 s.

## Santé et protection
- **Santé de Koffi** : 100 points, mêmes règles qu'ailleurs (`joueur_a_pied.md`) : la santé remonte seule de 1,5 point par seconde après 10 s sans blessure ; en combat (adversaire hostile à 15 m), cette remontée est suspendue.
- **Sources de dégâts en combat** : coup d'homme de main 10, de costaud 15, bâton 18, saisie 15, matraque de police 10 ; multipliés par la difficulté (0,6 / 1 / 1,4).
- **Pas de gilet ni d'armure** (sans armes à feu, ils n'ont pas lieu d'être). La « protection » est faite de trois choses concrètes :
  1. **La garde** : −70 % de face (voir « Esquive »).
  2. **Le casque de moto** (décision 52) : porté d'office à moto ; si Koffi le garde à pied (il le garde pendant 30 s après être descendu, ou tant qu'il reste à moins de 15 m de sa moto), −20 % sur tous les coups et aucun vacillement sur le premier coup reçu.
  3. **La forme du jour** : un repas dans un maquis ou chez une vendeuse (décision 81) donne « bien mangé » pendant 2 heures de jeu : santé maximale 120 (les 20 points en plus ne se régénèrent pas seuls). Détails et prix dans le document « Nourriture et santé » (autre agent).
- **Se soigner en combat** : impossible de manger ou de s'asseoir tant qu'un adversaire hostile est à moins de 15 m. Le sachet d'eau (+25) reste possible si l'étal est à portée (c'est voulu : fuir jusqu'à la vendeuse est une tactique, et drôle).
- **Vaciller** : un coup de 15 ou plus, ou trois coups reçus en 2 s, fait vaciller Koffi 0,6 s (pas d'attaque possible). Jamais deux vacillements en moins de 3 s (pas de « matraquage » sans issue).
- **Santé basse** : sous 30, l'écran se désature légèrement et la respiration de Koffi s'entend ; les adversaires de petite envergure se mettent à le provoquer au lieu d'attaquer une fois sur deux (ouverture pour fuir ou parler).
- **À zéro** (décision 80) : Koffi s'effondre, les adversaires s'en vont en riant (ils ne le frappent plus), réveil au centre de santé le plus proche, soins : 10 % de l'argent, 2 000 FCFA au plus, rien s'il n'a rien. En mission : échec et reprise au dernier point de contrôle, santé à 60 au moins, sans frais (voir `moteur_de_missions.md`).
- **Alliés** (Romaric dans certaines bagarres) : 100 points ; à zéro ils s'assoient, sonnés, et se relèvent à la fin du combat. Les coups de Koffi ne les touchent pas.
- **Affichage** : jauge de santé habituelle ; au-dessus de l'adversaire verrouillé, une barre fine de résistance, visible seulement en combat.
- **Se rendre ou parler** : dans une bagarre de rue ordinaire, si Koffi baisse sa garde et s'éloigne de 6 m, un choix « On se calme » peut apparaître (E) : 50 % de chances de finir la bagarre contre des petites frappes, 0 % contre des hommes de Capitaine.
- Test : coup de 10 : santé 90 ; en garde : 97 ; avec casque et garde : 97,6 arrondi à 98 ; « bien mangé » : maximum 120 puis retour à 100 après 2 h de jeu ; pas de régénération pendant un combat, reprise 10 s après ; vacillement après un coup de 15, pas de second avant 3 s ; à zéro en jeu libre : réveil au centre de santé, frais conformes ; à zéro en mission : reprise au point de contrôle avec au moins 60.

## Réaction des passants
- Complète `pietons.md`, section « Réactions au danger », pour le cas précis d'une bagarre.
- **Cercles** autour de la bagarre :
  - moins de 10 m : fuite (4,5 m/s, à l'opposé), cris ;
  - 10 à 20 m : inquiets, ils reculent jusqu'à 20 m ;
  - 20 à 30 m : **badauds** : 1 passant sur 3 s'arrête pour regarder, à distance, et commente (« Hé ! Hé ! Regardez ça ! », « Séparez-les ! », « Qui a commencé ? ») ; 1 badaud sur 4 sort son téléphone pour filmer à partir du chapitre 4 ; la vidéo peut ressortir sur le réseau social fictif (`telephone_du_joueur.md`).
  - au-delà : rien.
- Jamais plus de 8 badauds ; ils se tiennent en arc de cercle et laissent toujours une sortie de 4 m (la foule ne doit jamais enfermer le joueur).
- **Qui Koffi affronte** change tout :
  - contre des **hommes de main** (adversaires de mission) : les passants ne prennent pas parti contre Koffi ; aucun témoin n'appelle la police pendant les 30 premières secondes ; ensuite 1 sur 3 téléphone ;
  - Koffi frappe un **passant** : indignation immédiate ; tous les témoins comptent ; les « courageux » (1 sur 10) s'interposent ; 1 étoile s'il y a un policier à 50 m ou après l'appel d'un témoin (6 s) ; 2 étoiles avec un objet ;
  - Koffi se **défend** (il n'a pas porté le premier coup) : les passants le disent (« C'est l'autre qui a commencé ! ») ; s'il est arrêté quand même, l'amende est réduite de 50 %.
- **Vendeuses** : abritées derrière leur étal ; si un combattant tombe sur un étal, les fruits roulent (effet visuel, l'étal n'est pas détruit), la vendeuse réclame 500 FCFA de dégâts à Koffi après le combat (payer : +1 de réputation de quartier ; refuser : −2).
- **Enfants** : ils sont retirés de la scène (ils courent hors du rayon de 30 m, vers l'école ou un adulte) avant tout le monde ; jamais badauds.
- **Quartier** : dans le quartier de Koffi (Dantokpa), si sa réputation de quartier est bonne, 2 passants connus peuvent venir s'interposer en sa faveur : les petites frappes s'en vont (fin de bagarre).
- **Après** : les badauds se dispersent en 10 s ; un passant sur cinq commente en passant près de Koffi pendant 2 minutes réelles (« C'est toi le boxeur ? ») ; écho possible à la radio parlée si la bagarre a mené à une arrestation.
- **Adversaires sonnés** : des passants les aident à s'asseoir à l'ombre après 15 s (animation simple) : on montre que personne n'est gravement blessé.
- Test : bagarre simulée au centre d'une rue de 20 passants : aucun passant à moins de 10 m après 5 s ; 0 à 8 badauds entre 20 et 30 m ; un couloir de sortie d'au moins 4 m existe toujours (lancer de rayons sur 360°) ; contre des hommes de main : aucun appel avant 30 s ; contre un passant, témoin présent : étoile en moins de 8 s ; aucun enfant à moins de 30 m après 5 s ; badauds dispersés 10 s après la fin.

## Choix faits par Claude (à confirmer)
- Touches F (frapper), G (garde), Tab (cible), R (lancer).
- « Visée » = verrouillage de cible ; « armes à feu » = règle d'absence, plus encadrement des deux scènes de police ; « mise à couvert » = se cacher.
- La sandale lancée, objet toujours disponible, comme touche comique sans gravité.
- Pas d'armure ; le casque de moto gardé à pied et le repas servent de protection.
