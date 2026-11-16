# Conduite moto : fonctionnement attendu

Code : `scripts/moto.gd` (conduite, équilibre, chute ; la moto reprend de `scripts/car.gd` les chocs, les dégâts et le klaxon), chute du pilote dans `scripts/main.gd` et `scripts/player.gd`, caméra dans `scripts/vue.gd`. Vérifications : `scripts/selftest_moto.gd` (lancé par le test automatique), sur la plage, moto seule.

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

## Pas encore fait
- Passager à l'arrière (courses de zémidjan) et passage entre les voitures : prochaines tâches du plan.
- Phare, feu stop et clignotants de la moto (les touches L, J, K n'ont pas d'effet visible à moto).
- Manette (décision 114), à faire maintenant que la conduite moto existe.
