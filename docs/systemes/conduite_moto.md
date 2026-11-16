# Conduite moto : fonctionnement attendu

Code : `scripts/moto.gd` (conduite, équilibre, chute ; la moto reprend de `scripts/car.gd` les chocs, les dégâts et le klaxon), chute du pilote dans `scripts/main.gd` et `scripts/player.gd`, caméra dans `scripts/vue.gd`. Vérifications : `scripts/selftest_moto.gd` (lancé par le test automatique), sur la plage, moto seule. Passager et courses de zémidjan : `scripts/zem.gd` ; passage entre les voitures : `scripts/trafic.gd` et `scripts/moto.gd` ; vérifications de ces deux points : `scripts/selftest_moto_ville.gd`.

Conduite « arcade », comme la voiture : simple au clavier, pas une simulation. Les chiffres sont des réglages de départ, à ajuster après essai.

La moto est le premier véhicule du joueur (décision 51) : celle que Romaric prête à Koffi est garée à côté du point de départ, et la mission 1 demande de monter dessus. Deux autres motos sont garées en ville (marché Dantokpa, boulevard de la Marina). Les motos de la circulation ont leur conducteur : on ne peut pas encore les emprunter.

## Monter et descendre
- E près d'une moto garée : Koffi monte dessus, casqué (décision 52), en maillot vert. E de nouveau, à moins de 22 km/h : il descend à gauche de la moto.
- Une moto sans pilote repose sur sa béquille, penchée de 8°.
- À l'arrêt, le pilote pose le pied gauche par terre.

## Accélération
- Haut (flèche ou Z) : accélérer. La moto est vive au démarrage (18 m/s²) et de moins en moins à mesure qu'elle prend de la vitesse : 50 km/h en 1 seconde, vitesse maximale 94 km/h atteinte en 3 secondes environ. Elle est donc moins rapide qu'une voiture (122 km/h).
- Aucune touche : frein moteur, 3 m/s².
- Pas de marche arrière au moteur : Bas à l'arrêt fait reculer en poussant avec les pieds, à 5 km/h au plus. Le guidon agit alors à l'envers, comme sur une vraie moto.
- Moteur très abîmé (dégâts à 80 ou plus) : 56 km/h au plus.
- Plus tard : bruit du moteur, roue arrière qui patine sur le sable et sous la pluie, motos plus ou moins puissantes.
- Test : 50 km/h après 1 s, 94 km/h au plus, 76 m en 4 s ; la deuxième seconde ajoute moins de vitesse que la première ; 17 m/s après 1 s de frein moteur depuis 20 m/s ; recul plafonné à 5 km/h.

## Freinage
- Bas en roulant : les deux freins, 20 m/s². De 90 km/h à l'arrêt en 1,25 s sur 15 m environ. La moto freine moins fort qu'une voiture (30 m/s²).
- Espace seul : frein arrière, deux fois moins fort (31 m pour s'arrêter depuis 90 km/h). En virage, la roue arrière glisse et le virage se resserre : c'est l'équivalent du frein à main de la voiture.
- Bas + Espace : freinage d'urgence, 26 m/s² (12 m depuis 90 km/h).
- Freiner l'emporte sur l'accélérateur. Une fois arrêtée, la moto ne part pas en arrière d'un coup. En ligne droite, freiner ne fait ni tourner ni pencher. La fourche plonge un peu (effet visuel).
- Plus tard : feu stop visible, blocage de la roue avant sous la pluie, traces de pneu.
- Test : arrêt depuis 90 km/h en 1,25 s sur 15,4 m ; 31 m au frein arrière seul ; 11,8 m avec les deux ; accélérateur + frein arrière : la moto ralentit ; virage de 81° sur 7,3 m au frein arrière au lieu de 46° sur 9,5 m.

## Équilibre et inclinaison
- Gauche/droite : la moto se couche vers l'intérieur du virage, jusqu'à 38°, et c'est cet angle qui la fait tourner. La mise sur l'angle prend un quart de seconde environ : la moto ne change pas de direction d'un coup.
- Plus on roule vite, plus le virage est large : en 1 seconde elle tourne de 120° à 29 km/h, 65° à 54 km/h, 38° à 94 km/h. En ville elle est plus agile qu'une voiture ; à pleine vitesse il faut freiner avant le virage.
- Guidon relâché : elle se redresse seule en moins d'une seconde et repart tout droit.
- Au pas (moins de 20 km/h) : on tourne surtout au guidon, presque sans pencher. À l'arrêt, elle ne pivote pas et ne penche pas.
- Gauche et droite sont parfaitement symétriques. Les roues penchent avec la moto.
- On ne tombe jamais tout seul en penchant ou en freinant en virage : seule une collision fait tomber (voir plus bas). Choix fait pour que la moto reste agréable au clavier.
- Les motos de la circulation penchent aussi dans leurs virages (28° environ).
- Plus tard : dérapage sur le sable et sous la pluie, roue avant levée, passager qui déplace le poids.
- Test : 38° d'angle atteints et jamais dépassés ; symétrie gauche/droite ; moins de 60 % de l'angle après 0,1 s ; redressée après 1 s ; rien à l'arrêt ; angles tournés décroissants avec la vitesse ; direction inversée en reculant ; moto de la circulation penchée dans son virage puis redressée.

## Chute du pilote
- Un choc qui fait perdre 25 km/h ou plus d'un coup (mur de face, voiture percutée) fait tomber le pilote. Frôler un mur en biais ou toucher un obstacle à faible vitesse ne fait pas tomber.
- Le pilote se retrouve par terre à côté de la moto, sans pouvoir agir pendant 2 secondes, puis il se relève seul. La moto est couchée sur le côté et elle est abîmée (mêmes dégâts qu'une voiture, sans tôle pliée ; fumée à partir de 50).
- Santé perdue : 2,5 points par m/s perdu au-delà de 4 m/s. Un mur à 72 km/h coûte 40 points, à pleine vitesse 55. À moto on n'a pas de carrosserie : on se fait mal plus tôt qu'en voiture.
- Une chute ne fait jamais perdre connaissance (décision 53) : il reste toujours au moins 5 points de santé. À 5 points, tomber ne coûte plus que du temps.
- Pour repartir : E une fois près de la moto pour la relever, E une seconde fois pour remonter. Si elle est face à un mur, reculer avec les pieds (Bas) en braquant.
- Une moto garée percutée par un véhicule se couche aussi ; on la relève de la même façon.
- Plus tard : le pilote glisse sur la route dans le sens de la marche, chute quand une voiture percute la moto, cri et commentaire de Koffi, réparation au garage.
- Test : petit choc et mur frôlé sans chute ; mur de face à 72 km/h : chute, 40 points perdus, pilote à moins de 1,5 m de la moto, aucune action possible pendant 1 s, relevé après 2,5 s ; moto relevée puis remontée avec E, elle repart ; avec 12 points de santé une grosse chute laisse 5 points, sans évanouissement.

## Caméra moto
- V fait défiler quatre vues, comme en voiture, mais plus proches et plus basses : 5,5 m, 7,5 m (au départ) et 10,5 m derrière la moto, puis la vue du guidon, à hauteur des yeux du pilote.
- La caméra penche du même côté que la moto dans les virages, mais moins qu'elle : 20 % de l'angle en vue extérieure (8° au plus), 50 % en vue du guidon (19° au plus). Moto droite, caméra droite.
- La vue du guidon suit la moto sans retard. On n'y voit pas encore le guidon ni les mains.
- En voiture et à pied, rien ne change.
- Plus tard : guidon et compteur visibles en vue du guidon, caméra qui recule un peu avec la vitesse, regard vers l'arrière.
- Test : trois distances croissantes, toutes plus courtes et plus basses qu'en voiture ; moto penchée de 34° : caméra penchée du même côté, moins que la moto, et davantage en vue du guidon qu'en vue extérieure ; vue du guidon entre 1,5 et 2 m de haut, regard droit devant, qui suit la moto ; 11 m en voiture et 6,5 m à pied inchangés.

## Passager à l'arrière
C'est la première forme du métier de zémidjan (décisions 11, 64 et 67) : une course simple, sans marchandage pour l'instant.
- Six clients attendent au bord de la route : place de l'Amazone, marché Dantokpa, boulevard de la Marina, grand carrefour de l'Est, avenue de l'Ouest, bout de la grande avenue. Ils apparaissent en petits points bleus sur la mini-carte.
- Quand le joueur approche à moto, sans passager, à moins de 30 m, le client se tourne vers lui et lève le bras. Si la moto s'arrête (moins de 4 km/h) à moins de 6 m de lui, il annonce sa destination (un des cinq autres points) et son prix, affichés en bas de l'écran. À pied ou en voiture, il ne se passe rien. Un seul client à la fois.
- **E pour accepter la course** (décision de Bravo du 16 novembre) : le client monte à l'arrière. Pour refuser, il suffit de repartir. Devant un client qui propose sa course, E n'est donc pas « descendre de la moto » : il faut s'éloigner de quelques mètres pour descendre.
- Une colonne bleue marque l'arrivée, avec un rond bleu sur la mini-carte ; la colonne jaune de la mission reste affichée.
- Prix : 100 FCFA de prise en charge plus 2 FCFA par mètre à vol d'oiseau, arrondi à 50 FCFA, entre 100 et 1 000 FCFA (décision 64). Dans la ville actuelle, les courses vont de 250 à 700 FCFA.
- Paiement à l'arrivée : la moto doit s'arrêter à moins de 7 m du point d'arrivée. Le client descend sur le trottoir, paie, reste quelques secondes puis s'en va. Trente secondes plus tard, un client attend de nouveau à son point de départ.
- Avec un passager la moto est plus lourde : 15 % d'accélération en moins (44 km/h après 1 seconde au lieu de 50), 10 % de freinage en moins (16,5 m au lieu de 14,6 m depuis 90 km/h), et elle se couche un peu moins vite dans les virages. La vitesse maximale ne change pas.
- Le passager est assis derrière le pilote, casqué comme lui (décision 52), avec la chemise du client.
- E avec un client à bord : le client descend sur place et la course n'est pas payée. E une seconde fois : le pilote descend.
- Chute avec un client : il tombe lui aussi, reste 2 secondes par terre, se relève et repart à pied (décision 4). La course est perdue, sans dédommagement ni amende (décision de Bravo) : le seul coût est la santé du pilote et le temps perdu. Le client ne perd pas de santé visible et la police ne réagit pas encore.
- Si la moto s'arrête à l'arrivée à côté d'un autre client qui attend, celui-ci propose aussitôt sa course : on peut enchaîner.
- Plus tard : marchandage en trois échanges (décision 65), pourboire ou client mécontent selon la conduite, clients qui hèlent depuis n'importe quel trottoir, paiement KwabôPay au chapitre 2, passager sur les motos de la circulation, voix du client.
- Test : six clients à leur place ; tarif de 100, 300 et 1 000 FCFA pour 0, 100 et 5 000 m ; personne ne monte à pied, en voiture ni sur une moto qui roule ; bras levé à l'approche ; à l'arrêt le client propose sans monter ; la proposition tombe si la moto repart ; E fait monter le client sans faire descendre le pilote ; prix égal au tarif de la distance ; pas de second client ; moto chargée plus lente à accélérer, à freiner et à se coucher ; pas de paiement en roulant, paiement exact à l'arrêt ; le client s'en va puis un autre revient ; E dépose sans payer ; chute : client par terre puis debout, course perdue, 20 points de santé en moins pour le pilote.

## Passage entre les voitures
Décision 61 : les motos se faufilent, les voitures restent bloquées.
- La moto du joueur fait 0,8 m de large, une voiture 2 m : la moto passe dans un espace de 1,4 m entre deux voitures sans rien toucher, là où une voiture reste coincée. Dans un espace plus étroit que la moto, elle bute et s'arrête (sans chute à faible vitesse).
- Les voitures de la circulation ne s'arrêtent plus pour une moto qui roule à côté d'elles, dans le couloir : seule une moto droit devant (à moins de 1,65 m de leur axe) les arrête. Avant, une moto qui les doublait de près les faisait piler. Une voiture à la même place les arrête toujours.
- Les motos de la circulation remontent les files : derrière une voiture arrêtée ou très lente (moins de 11 km/h), la moto déboîte de 1,9 m vers l'axe de la route (à gauche de la file, puisqu'on roule à droite), longe la file à 18 km/h au plus, puis se rabat et reprend sa vitesse. Les voitures, elles, attendent derrière.
- Une moto ne double pas une autre moto, ni une voiture qui roule normalement, et s'arrête toujours devant un piéton.
- Toute la circulation roule à droite de la chaussée, comme au Bénin (décision de Bravo du 16 novembre), et tourne dans le même sens autour de la place de l'Amazone. Les voitures garées n'ont pas été retournées.
- Tant qu'il n'y a ni feux ni embouteillages, les files n'existent que lorsque quelque chose bloque une voie (le joueur arrêté en voiture, par exemple).
- Plus tard : couloir entre deux files de même sens quand les routes auront plusieurs voies, rétroviseur accroché si on passe trop vite, coups de klaxon des motos, embouteillages aux heures de pointe (décision 60).
- Test : passage du joueur à 1,4 m sans dégât ni chute ; arrêt derrière un espace de 0,4 m ; une voiture ne passe pas à 1,4 m ; une voiture de la circulation s'arrête pour la moto du joueur droit devant, pas pour la moto à 1,9 m de côté, et s'arrête pour une voiture à 1,9 m de côté ; une moto de la circulation dépasse une voiture arrêtée en moins de 10 s, à 1,9 m d'elle, côté axe de la route, à 18 km/h au plus, puis reprend sa voie et sa vitesse ; la voiture qui suit s'arrête 6,6 m derrière et y reste ; les 27 véhicules de la circulation sont à droite de l'axe de leur route.

## Pas encore fait
- Marchandage du prix de la course (décision 65).
- Phare, feu stop et clignotants de la moto (les touches L, J, K n'ont pas d'effet visible à moto).
- Manette (décision 114), à faire maintenant que la conduite moto existe.
