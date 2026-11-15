# Joueur à pied : fonctionnement attendu

Code : `scripts/player.gd` (héros), `scripts/relief.gd` (mer, ponton, murets, caisses), `scripts/interaction.gd` (objets). Vérifications : `scripts/selftest.gd`.

## Marche
- Haut/bas (flèches ou Z/S) : avancer, reculer. Gauche/droite : pivoter sur place ou en marchant (2,8 rad/s).
- Vitesse 5,5 m/s en avant, 60 % de cette vitesse en reculant.
- Le héros glisse le long des murs et des objets au lieu de rester bloqué.
- Bras et jambes se balancent pendant le déplacement et s'arrêtent à l'arrêt.
- Test : 2 secondes d'appui sur « avancer » font parcourir plus de 3 m.

## Course
- Maintenir Maj : 10 m/s. Relâcher : retour immédiat à la marche.
- On ne court pas accroupi.
- Plus tard : endurance (jauge qui se vide), essoufflement, bousculade des passants.
- Test : 1 seconde de course en ligne droite sur la plage fait parcourir entre 8 et 11 m.

## Saut
- Espace, à pied seulement (en voiture, Espace reste le frein à main).
- Hauteur d'environ 1,1 m, durée d'environ 0,7 s ; on garde le contrôle de la direction en l'air.
- Un seul saut : impossible de ressauter avant d'avoir touché le sol ou un objet.
- Le héros peut retomber sur un objet bas (étal de marché, muret) et marcher dessus ; il retombe en quittant le bord.
- Impossible de sauter accroupi.
- En l'air, jambes écartées et bras levés.
- Devant un obstacle bas, Espace sert à monter dessus (voir « Franchissement de muret »).
- Plus tard : élan plus long en courant, bruit d'atterrissage.
- Test : le héros décolle, ne peut pas faire de double saut, monte entre 0,9 et 1,6 m, puis revient exactement au sol.

## Position accroupie
- Maintenir C (ou Ctrl) : le héros se baisse, relâcher : il se relève.
- Vitesse 2,5 m/s. Hauteur de collision 1,20 m au lieu de 1,90 m : il passera sous les obstacles bas.
- On ne peut s'accroupir qu'au sol.
- Monter en voiture ou en descendre remet le héros debout.
- Plus tard : refuser de se relever sous un plafond bas, discrétion (les passants et la police repèrent moins vite), mise à couvert.
- Test : accroupi, le héros parcourt entre 1,8 et 3,2 m en 1 seconde, sa capsule mesure 1,20 m, il ne peut pas sauter ; touche relâchée, il retrouve 1,90 m.

## Caméra à la troisième personne
- Placée 6,5 m derrière le héros et 3 m au-dessus de ses pieds ; elle vise un point à 1,6 m de haut (la tête).
- Elle suit en douceur : la position rattrape en un quart de seconde environ, la visée plus vite, pour que le héros reste au centre.
- Elle suit aussi la hauteur du héros (saut, objet sur lequel il est monté).
- En voiture elle recule à 11 m et monte à 4,6 m.
- Plus tard : rotation libre à la souris ou au stick droit, recul automatique quand un mur s'interpose, champ de vision qui s'élargit en course.
- Test : après un déplacement, la caméra est entre 4 et 9 m du héros, derrière lui, et son axe passe à moins de 10° de sa tête.

## Nage
- La mer commence au sud de la plage. Le fond descend en pente douce (30 cm par mètre) jusqu'à 3,7 m de profondeur.
- Moins de 40 cm d'eau : marche normale. Au-delà : marche ralentie (60 % de la vitesse de marche, pas de course).
- À partir de 1,15 m d'eau, le héros nage : il flotte, le corps allongé à la surface, bras en crawl.
- Vitesse 2,5 m/s ; en maintenant Maj : 3,6 m/s.
- En nageant : pas de saut, pas de position accroupie, impossible de monter en voiture.
- Tomber ou plonger dans l'eau profonde ne blesse pas, quelle que soit la hauteur.
- La baignade s'arrête à la ligne de bouées orange, à environ 70 m du rivage (mur invisible). Les voitures, elles, restent bloquées en haut de la plage.
- Un ponton (boulevard de la Marina, à l'ouest) permet de plonger : on y monte depuis la plage avec Espace.
- Plus tard : souffle et plongée sous l'eau, vagues et courant, noyade, pirogues, éclaboussures et bruit de l'eau.
- Test : en marchant vers le large le héros finit par flotter à 1,15 m sous la surface, ne peut pas sauter, parcourt entre 2 et 3 m en 1 seconde, le corps allongé ; il ressort de l'eau en faisant demi-tour ; un plongeon de plus de 6 m ne lui enlève aucune santé. Une voiture lancée vers la mer s'arrête avant l'eau.

## Chute et dégâts
- Le héros a 100 points de santé, affichés par une jauge sous l'argent (verte, jaune sous 60, rouge sous 30).
- La hauteur d'une chute se mesure du point le plus haut atteint jusqu'au point d'arrivée.
- Jusqu'à 3 m : aucune blessure. Au-delà : 11 points par mètre supplémentaire (8 m = 55 points ; 12,1 m et plus = évanouissement).
- Santé à zéro : le héros s'évanouit, s'allonge 2,5 secondes, puis se réveille place de l'Amazone avec toute sa santé. Il ne perd pas d'argent pour l'instant.
- La santé remonte seule (1,5 point par seconde) après 10 secondes sans blessure ; 6 points par seconde assis sur un banc ; +25 d'un coup avec un sachet d'eau fraîche.
- Plus tard : chocs avec les véhicules, coups, cri et bruit de chute, écran qui rougit, frais de clinique au réveil, réveil au centre de santé le plus proche.
- Test : chute de 2,5 m sans perte ; chute de 8 m, il reste environ 45 points et la jauge suit ; chute de 14 m, évanouissement puis réveil place de l'Amazone avec 100 points ; la santé remonte seule après 10 s.

## Franchissement de muret
- Face à un obstacle dont le dessus est entre 0,30 m et 1,50 m plus haut que ses pieds, à moins d'un mètre, Espace fait monter le héros dessus au lieu de sauter (0,45 s : il se hisse, puis avance).
- Il faut la place de tenir debout sur l'obstacle ; sinon, ou si l'obstacle est trop haut (mur, voiture), Espace reste un saut normal.
- Sur un muret mince, il suffit de continuer d'avancer pour redescendre de l'autre côté : le muret est franchi.
- On peut enchaîner : les caisses empilées contre la halle du marché Dantokpa (côté nord) montent par marches de 1,33 m jusqu'au toit, à 8 m.
- Pas de franchissement accroupi, en nageant ou en l'air.
- Murets présents : le long du boulevard de la Marina, entre la route et la plage (ouvertures en face des rues et du ponton). Les étals du marché se montent de la même façon.
- Plus tard : s'accrocher à un rebord pendant un saut, passer un muret en courant sans s'arrêter, animation propre.
- Test : devant le muret de la Marina, Espace déclenche la montée, le héros passe par le dessus (1 m) et se retrouve au sol de l'autre côté ; devant le mur de la halle, Espace donne un saut normal ; les 6 caisses mènent au toit, à 8 m.

## Interaction avec les objets
- Touche E, à moins de 2,6 m d'un objet. Si une voiture est plus proche que l'objet, E fait monter en voiture. Le texte du bas de l'écran annonce l'action : « E : s'asseoir ».
- Étal d'eau fraîche (parasol bleu, place de l'Amazone et plage) : 100 FCFA, rend 25 points de santé. Pas de vente si la santé est pleine ou si l'argent manque ; la vendeuse le dit.
- Banc (place de l'Amazone, plage, entrée du marché) : le héros s'assoit et récupère plus vite ; une touche de direction ou Espace le relève.
- Panneau d'information (place de l'Amazone, ponton, halle du marché) : son texte s'affiche 8 secondes en bas de l'écran.
- Plus tard : ramasser et porter un objet, portes, pousser une caisse, parler aux passants, acheter à manger aux étals du marché.
- Test : sans objet à portée, E ne fait rien ; l'eau n'est pas vendue avec 50 FCFA ; avec 500 FCFA il en reste 400 et la santé gagne 25 ; le panneau affiche son texte ; le héros s'assoit, sa santé remonte, une touche de direction le relève.
