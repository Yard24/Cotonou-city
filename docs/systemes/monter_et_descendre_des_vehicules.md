# Monter et descendre des véhicules : fonctionnement attendu

Code : `scripts/embarquement.gd` (portières, côtés, verrouillage, place libre, saut en marche, emprunt) ; `scripts/main.gd` garde la touche E et `mount()` (le héros est assis dans le véhicule). Vérifications : `scripts/selftest_embarquement.gd`, lancé à la fin du test automatique, sur la plage et dans la circulation.

Une seule touche : **E**. E ne sert qu'à monter et descendre (les courses de zémidjan s'acceptent avec M). On roule à droite : le volant, donc la portière du conducteur, est à gauche. Les chiffres sont des réglages de départ, à ajuster après essai.

## Entrée côté conducteur
- E à moins de 4,8 m d'un véhicule : Koffi monte dans le plus proche. S'il se tient du côté gauche du véhicule (ou juste derrière), il passe par la portière du conducteur.
- La portière s'ouvre et se referme (0,7 s) ; la voiture ne démarre pas avant. Les feux, le klaxon et la caméra répondent tout de suite.
- Moto : pas de portière, pas de côté, pas d'attente. Une moto couchée se relève d'abord (premier E), on remonte ensuite (second E).
- Évanoui, par terre ou dans l'eau, on ne monte pas.
- Plus tard : Koffi marche jusqu'à la portière et s'assoit (animation du personnage), bruit de portière.
- Test : E à gauche fait monter côté conducteur ; accélérateur enfoncé, la voiture ne bouge qu'après 0,7 s ; la moto se monte d'un coup, des deux côtés.

## Entrée côté passager
- Si Koffi se tient du côté droit, il monte par la portière du passager et se glisse jusqu'au volant : 1,5 s avant de pouvoir démarrer, au lieu de 0,7 s. Un message le dit. C'est donc possible partout, mais plus lent : utile quand on arrive par la droite, pénalisant quand on est pressé.
- Portière choisie bloquée (mur, véhicule collé à moins de 0,7 m de la caisse) : il passe par l'autre. Les deux bloquées : il reste dehors, « Pas la place d'ouvrir une portière ».
- Une fois au volant, il redescend côté conducteur comme d'habitude.
- Plus tard : monter comme simple passager (taxi, voiture d'un personnage), choisir sa place dans un minibus.
- Test : E à droite : portière droite, 1,5 s d'attente, au moins 0,5 s de plus que côté conducteur ; portière du conducteur contre le mur du bord du monde : entrée par la droite ; mur d'un côté et voiture collée de l'autre : refus.

## Sortie (et place libre à la descente)
- E à moins de 22 km/h : le véhicule s'arrête et Koffi descend. Au-dessus : saut en marche (plus bas).
- Il descend là où il y a la place, dans cet ordre : à gauche (2,4 m de l'axe d'une voiture, 1,2 m d'une moto), à droite, derrière (3,4 m ; 1,9 m pour une moto), devant.
- Un endroit est libre si Koffi y tient debout : pas dans la mer, pas dans un autre véhicule, pas dans un mur ni un objet du décor, et rien entre le véhicule et lui (muret, mur mince).
- Aucune place : il reste à bord, « Pas la place de descendre ici : avance un peu ».
- Sortie obligée (chute à moto, évanouissement au volant) : il est posé à l'endroit libre et accessible le plus proche, jusqu'à 7 m.
- La portière du côté où il sort s'ouvre et se referme.
- Plus tard : sortie par le toit ou la fenêtre d'un véhicule retourné, sortie à la nage d'un véhicule tombé à l'eau.
- Test : sans obstacle, à gauche ; mur à gauche, à droite ; mur et voiture, derrière ; puis devant ; coincé partout, il reste à bord avec le message ; sortie obligée à un endroit libre, du bon côté du mur ; moto longée par une voiture : descente de l'autre côté ; mer, mur et emplacement d'un véhicule reconnus comme pris.

## Saut en marche
- E au-dessus de 22 km/h (en marche avant comme en marche arrière) : Koffi saute. Il roule par terre 2 secondes sans pouvoir agir, puis se relève seul.
- Santé perdue : 5 points, plus 2 par m/s au-dessus de 22 km/h. 23 points à 54 km/h, 61 à pleine vitesse en voiture. Comme pour une chute à moto (décision 53), on ne s'évanouit jamais pour ça : il reste toujours 5 points.
- Le véhicule continue tout droit sur sa lancée et s'arrête seul (9 m depuis 54 km/h). Il peut percuter quelque chose et s'abîmer. La portière reste ouverte tant qu'il roule, puis se referme.
- Moto : elle se couche et glisse ; il faudra la relever. Avec un client à bord, on ne saute pas : « arrête-toi d'abord ».
- Pas de place pour atterrir : il reste à bord.
- Plus tard : Koffi glisse dans le sens de la marche, passants qui s'écartent, réaction de la police, véhicule lâché qui tourne ou qui dévale une pente.
- Test : à 18 km/h descente normale sans blessure ; à 54 km/h 23 points perdus, 2 s par terre, la voiture garde sa vitesse puis s'arrête seule après 9 m, portière ouverte puis refermée, sans dégât ; 8 points de santé à 108 km/h : il en reste 5, sans évanouissement ; marche arrière ; moto couchée qui glisse 9 m ; refus avec un client.

## Emprunt d'un véhicule occupé
- Les voitures de la circulation ont un conducteur (pas encore visible). E près de l'une d'elles **arrêtée ou presque** (moins de 11 km/h) : Koffi prend le volant, la voiture quitte la circulation et devient un véhicule du joueur (« Voiture empruntée ! »).
- Tant qu'elle roule, on n'ouvre pas la portière : il faut l'arrêter en se mettant devant (la circulation s'arrête devant le héros).
- Décision 54 : le premier emprunt passe ; **dès le deuxième, c'est un signalement** qui déclenchera une recherche. Le compte existe (`signalements`) ; la police qui s'en servira n'est pas encore faite, la règle « à moins de 50 m d'un policier » non plus.
- Remonter dans une voiture déjà empruntée n'est pas un nouvel emprunt.
- Les motos de la circulation ne se prennent pas (leur pilote est dessus). Un conducteur sur trois a verrouillé ses portières (plus bas).
- Plus tard : conducteur visible qui proteste et descend, passagers, alarme, propriétaire qui poursuit.
- Test : refus à 43 km/h ; la voiture s'arrête devant le héros ; arrêtée, E : elle sort de la circulation, entre dans les véhicules du joueur et se conduit ; 1 emprunt = 0 signalement, 2 emprunts = 1 signalement ; remonter ne compte pas ; moto de la circulation refusée.

## Verrouillage des portes
- Deux des cinq voitures garées sont fermées à clé (la grise près du boulevard de la Marina, la verte de l'avenue de l'Ouest). La rouge du départ est ouverte.
- Dans la circulation, un conducteur sur trois a verrouillé ses portières ; jamais les taxis (ils prennent des clients). Choix fixe, sans hasard : la ville reste la même d'un lancement à l'autre.
- E sur une voiture fermée : la poignée résiste (la portière bouge de 3°), un message (« Portière fermée à clé » ou « Le conducteur a verrouillé ses portières »), on reste dehors. Les deux côtés sont fermés.
- Les motos n'ont pas de portière : jamais fermées.
- Pas de vitre cassée ni de serrure forcée pour l'instant.
- Plus tard : clé des véhicules achetés, antivol des motos, verrouiller son propre véhicule, forcer une portière (avec signalement).
- Test : les voitures fermées sont celles prévues ; aucune moto ni aucun taxi verrouillé ; refus des deux côtés avec message et poignée qui résiste ; la même voiture déverrouillée s'ouvre ; voiture verrouillée de la circulation non empruntée et toujours dans la circulation.

## Animation des portes
- Chaque voiture a deux portières avant (panneau et vitre), articulées à l'avant, créées la première fois qu'on s'en sert.
- Ouverture progressive en 0,25 s jusqu'à 63°, vers l'extérieur ; fermeture en 0,25 s. Montée : 0,7 s en tout. Descente : 0,7 s. Porte fermée à clé : 3° pendant 0,35 s.
- C'est la portière du côté utilisé qui bouge, l'autre reste fermée. Elle fait partie de la caisse : elle penche et roule avec la voiture.
- Après un saut en marche, elle reste ouverte tant que la voiture roule.
- Plus tard : portières arrière, coffre et capot, portière arrachée par un choc, bruitages.
- Test : ouverture croissante image après image, 63° atteints et jamais dépassés, 0° à la fin ; le bord de la portière s'écarte à plus de 1,7 m de l'axe, du bon côté ; l'autre portière ne bouge pas ; même chose à la descente ; la portière suit la voiture.

## Véhicules garés
- Voitures et motos garées sont tournées dans le sens de la voie qu'elles longent (on roule à droite). Les cinq voitures et la moto de Romaric étaient à contresens : corrigé.
- Test : les 8 véhicules garés ont le cap de leur voie.
