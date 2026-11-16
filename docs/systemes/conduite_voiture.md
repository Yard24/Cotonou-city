# Conduite voiture : fonctionnement attendu

Code : `scripts/car.gd`. Vérifications : `scripts/selftest_voiture.gd` (lancé par le test automatique), sur la plage, voiture seule.

Conduite « arcade » : simple à prendre en main au clavier, pas une simulation. Les chiffres sont des réglages de départ, à ajuster après essai.

## Accélération et freinage
- Haut (flèche ou Z) : accélérer, 16 m/s² ; la voiture atteint 100 km/h en 2 secondes environ. Vitesse maximale 122 km/h (34 m/s).
- Bas (flèche ou S) en roulant : freiner, 30 m/s² ; de 100 km/h à l'arrêt en 1 seconde environ, sur 13 m environ.
- Aucune touche : la voiture ralentit doucement (4 m/s²).
- Le compteur en bas à droite affiche la vitesse en km/h.
- Plus tard : boîte de vitesses automatique audible (bruit du moteur), adhérence réduite sous la pluie et sur le sable, vitesse maximale différente selon le véhicule.
- Test : 4 secondes d'accélération font parcourir plus de 20 m (mesuré : 85 m, 122 km/h).

## Direction
- Gauche/droite : tourner. La voiture ne pivote pas à l'arrêt ; le volant prend tout son effet à partir de 25 km/h.
- Plus on roule vite, moins elle tourne (à pleine vitesse, 45 % de braquage en moins) : pas de tête-à-queue involontaire sur les boulevards.
- Gauche et droite sont parfaitement symétriques.
- Plus tard : roues avant qui pivotent à l'écran, dérapage sur le sable et sous la pluie.
- Test : en 0,5 s, environ 48° à 36 km/h et 34° à 108 km/h ; rien à l'arrêt ; même angle à gauche et à droite.

## Frein à main
- Espace en voiture. Freinage très fort : de 72 km/h à l'arrêt en 1 seconde, sur moins de 5 m.
- Il resserre le virage : la voiture tourne presque autant, sur une distance deux fois plus courte. Sert aux demi-tours et aux virages serrés.
- Il n'y a pas encore de dérapage de l'arrière : la voiture ne glisse pas de côté.
- Plus tard : dérapage contrôlé, traces de pneus, crissement.
- Test : vitesse inférieure à 5 km/h après 1 seconde ; virage de 42° sur 2,3 m au lieu de 47° sur 5,3 m sans frein à main.

## Marche arrière
- Bas à l'arrêt : reculer, jusqu'à 36 km/h.
- En reculant, la direction agit comme sur une vraie voiture : touche gauche, l'arrière part vers la gauche.
- Haut pendant qu'on recule : freinage fort, puis la voiture repart en avant.
- Plus tard : feux de recul blancs, caméra qui regarde vers l'arrière.
- Test : plafond de 36 km/h atteint, plus de 12 m parcourus en 3 secondes en ligne droite, direction inversée, reprise en avant en moins d'une demi-seconde.

## Suspension
- La carrosserie bouge sur ses ressorts, les roues restent au sol : le nez se lève à l'accélération (4° environ), plonge au freinage (5°), la caisse penche vers l'extérieur des virages (jusqu'à 5°).
- Un ressort amorti ramène la voiture à plat, avec un léger rebond. Jamais plus de 8°.
- Un choc tasse la voiture sur ses roues un court instant.
- C'est un effet visuel : il ne change pas la tenue de route. Il s'applique aussi aux voitures de la circulation (elles plongent quand elles freinent derrière un obstacle).
- Les motos ne sont pas concernées : leur inclinaison viendra avec la conduite moto.
- Plus tard : dos-d'âne, nids-de-poule et trottoirs qui secouent la voiture (quand le sol aura du relief pour les véhicules).
- Test : sens et ampleur du tangage et du roulis, angle maximal en maltraitant la voiture, retour à plat à l'arrêt, roues indépendantes de la carrosserie.

## Collisions
- La voiture ne traverse ni les murs, ni les bâtiments, ni les autres véhicules. Le bord de plage l'arrête : elle ne va pas dans la mer.
- De face : arrêt net. On peut toujours se dégager en marche arrière.
- En biais : la voiture glisse le long de l'obstacle en perdant peu de vitesse.
- Contre un autre véhicule : il ne bouge pas (les véhicules ne se poussent pas encore) ; les deux sont abîmés.
- Les passants ne sont pas encore des obstacles : les piétons renversés (ils tombent et se relèvent, décision 4) viendront avec le lot « passants ».
- Plus tard : véhicules et petits objets poussés par le choc, bruit de tôle, secousse de caméra, santé perdue par le conducteur dans un gros choc.
- Test : choc de face contre un mur (arrêt avant le mur, dégagement en marche arrière), contre une voiture arrêtée (arrêt derrière elle, elle ne bouge pas), mur pris en biais (la voiture continue, sans dégât).

## Dégâts visibles
- Chaque véhicule a un compteur de dégâts de 0 (neuf) à 100. Un choc compte selon la vitesse perdue d'un coup : rien en dessous de 18 km/h ; un mur de face à 70 km/h coûte environ 37 points, à pleine vitesse 75 points. Frotter un mur en biais ne coûte presque rien.
- Le véhicule percuté est abîmé aussi (70 % du choc).
- Ce qu'on voit, selon le côté touché :
  - à partir de 25 : tôle froissée — capot plié et un phare cassé (choc avant), coffre plié et un feu cassé (choc arrière) ;
  - à partir de 50 : pare-chocs qui pend, second phare cassé, fumée claire au-dessus du moteur ;
  - à partir de 80 : fumée noire et épaisse, vitesse plafonnée à 73 km/h.
- Un message prévient le conducteur à chaque stade.
- **Jamais d'explosion ni d'incendie** (décision 57) : même à 100, la voiture roule encore, au ralenti.
- Les dégâts restent sur le véhicule tant qu'il n'est pas réparé. La réparation existe dans le code (`repair()`), mais aucun garage ne la propose encore.
- Plus tard : réparation payante au garage, vitres fêlées, portière qui bâille, bruit du moteur abîmé, dégâts des motos (aujourd'hui : fumée seulement).
- Test : petit contact sans effet ; mur de face : capot plié, un phare, pas de fumée ; choc en reculant : coffre plié ; stade 2 : fumée claire ; stade 3 : fumée noire, vitesse plafonnée, la voiture roule toujours ; réparation : tout redevient neuf.
