# Joueur à pied : fonctionnement attendu

Code : `scripts/player.gd`. Vérifications : `scripts/selftest.gd`.

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
- Plus tard : élan plus long en courant, dégâts de chute, bruit d'atterrissage.
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
