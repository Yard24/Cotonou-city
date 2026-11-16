# Activités annexes : fonctionnement attendu

Rien n'est encore codé. Code prévu : un fichier par activité (`scripts/foot.gd`, `scripts/course_moto.gd`, `scripts/peche.gd`, `scripts/livraison.gd`, `scripts/awale.gd`, `scripts/sport.gd`, `scripts/collecte.gd`). Vérifications prévues : `scripts/selftest_activites.gd`.

Rappel des décisions : **pas de jeux d'argent ni de paris** (70) : aucune activité ne demande de mise, on ne gagne que des primes fixes, des objets ou de la réputation ; enfants jamais impliqués dans une action (48) : tous les joueurs de foot et d'awalé sont des adultes ; missions secondaires prévues : courses de motos sur la plage, livraisons chronométrées, objets perdus (103) ; pas de marque réelle (25).

Règles communes : une activité se lance en marchant dans un cercle jaune (`f5c400`, 2 m de rayon) et en appuyant sur E ; un panneau annonce le nom, la récompense et le record. Échap ouvre « Recommencer / Abandonner ». Aucune activité n'est disponible avec 1 étoile de recherche ou plus, ni pendant une mission. Chaque activité enregistre son meilleur résultat (voir « Statistiques et succès »).

## Football de rue
- Ce que voit le joueur : des terrains de sable ou de terre rouge de 30 × 18 m, buts faits de deux pneus ou de petits buts en fer de 2 m de large sur 1 m de haut (« petits poteaux », sans gardien). Terrains : plage de Fidjrossè, terrain vague d'Akpakpa, cour derrière Dantokpa. Des adultes y jouent de 16 h à 19 h ; hors de ces heures, le terrain est vide et l'activité indisponible (sauf la plage, aussi de 7 h à 9 h).
- Format : **4 contre 4**, sans gardien, match de **3 minutes** ou premier à **3 buts**. Koffi joue avec 3 coéquipiers dirigés par le jeu. Vue : caméra haute, 14 m derrière le terrain côté long, qui suit le ballon.
- Commandes : directions pour courir (7 m/s avec le ballon, 8 m/s sans), Maj pour un sprint de 3 secondes (9,5 m/s, puis 5 secondes de récupération), **E : passe** vers le coéquipier le plus proche de la direction tenue (ballon à 14 m/s), **Espace : tir** — maintenir jusqu'à 1 seconde pour doser (12 à 24 m/s), **C : tacle debout** (à moins de 1,5 m du porteur ; réussi si on est face à lui ou de côté, raté de dos = faute).
- Ballon : sphère de 22 cm, rebond 0,6 sur la terre, 0,35 sur le sable ; il ralentit plus vite sur le sable (frottement double). Sorti du terrain : remise au pied pour l'adversaire, à l'endroit de la sortie.
- Fautes : tacle de dos = coup franc à l'adversaire ; 3 fautes de Koffi = il sort 20 secondes (son équipe joue à 3). Pas de carton, pas de bagarre.
- Adversaires : 3 niveaux — « Les Anciens du quartier » (lents, bonnes passes), « Les Zems FC » (rapides, tirent de loin), « Les Dockers » (physiques, taclent beaucoup). Leur vitesse est 85 %, 95 % ou 105 % de celle de Koffi.
- Récompense : aucune mise, aucun pari. Victoire : +3 de réputation dans le quartier (1 fois par jour de jeu et par terrain), et un sachet d'eau offert. Première victoire contre chaque équipe : un maillot (haut, allure 1) aux couleurs de l'équipe battue. Défaite ou nul : rien n'est perdu.
- Cas limites : nul à la fin du temps → « but en or » pendant 60 secondes, puis match nul ; grosse pluie → pas de match (terrain inondé) ; le ballon ne peut pas quitter la zone (filets invisibles à 5 m derrière les lignes) ; Koffi quitte le terrain de plus de 8 m → abandon après un avertissement de 3 secondes.
- Test : un tir maintenu 1 seconde part à 24 m/s ; un ballon envoyé droit dans le but vide compte 1 but et replace les joueurs au centre ; 3 buts terminent le match ; un tacle de dos donne une faute ; la 3e faute sort Koffi 20 secondes ; une victoire ajoute 3 de réputation, une seconde le même jour 0.

## Courses de motos
- Sur la plage (décision 103) et, plus tard, sur des pistes en terre. Organisées par Romaric et ses amis mécaniciens : départ signalé par deux fanions verts et un attroupement de 8 à 12 spectateurs derrière une corde. Disponibles de 16 h à 19 h (plage peu fréquentée) ; jamais sur la route ouverte.
- **Pas de pari, pas de droit d'entrée.** Prime fixe remise par l'organisateur (« c'est le garage qui offre »).
- 4 parcours :

| Parcours | Lieu | Longueur | Tours | Temps or / argent / bronze |
|---|---|---|---|---|
| La ligne droite des cocotiers | Fidjrossè | 800 m aller-retour autour d'un fût | 1 | 0:52 / 0:58 / 1:06 |
| Le slalom des pirogues | Fidjrossè | 1 100 m entre des pirogues tirées sur le sable | 2 | 2:20 / 2:35 / 2:55 |
| La boucle de la Marina | plage de la Marina | 1 400 m | 2 | 2:50 / 3:10 / 3:35 |
| La piste rouge (chapitre 3 et suivants) | terrain vague d'Akpakpa, terre et bosses | 900 m | 3 | 2:40 / 3:00 / 3:25 |

- Déroulement : 5 concurrents + Koffi, sur une ligne ; décompte « 3, 2, 1, Allez ! » ; portes à franchir (deux fanions espacés de 8 m, la suivante en surbrillance) ; position, tour et chrono affichés en haut. Porte manquée : il faut y revenir, sinon le tour ne compte pas (flèche rouge).
- Sable : adhérence réduite (accélération −25 %, distance de freinage +40 %), vitesse maximale −10 % ; sable mouillé près de l'eau : comme la terre ferme, mais l'eau à plus de 20 cm de profondeur freine fort (−50 %).
- Moto : celle sur laquelle le joueur arrive. Les concurrents roulent sur une moto équivalente (même vitesse maximale à ±3 %), pour que la moto achetée ne décide pas tout. 3 niveaux de concurrents selon le parcours.
- Chute (collision seulement, comme ailleurs) : Koffi se relève en 3 secondes à côté de sa moto, santé perdue selon les règles moto ; la course continue. Les concurrents chutent aussi et se relèvent.
- Primes (2017) : 1re place 1 500 FCFA, 2e 700, 3e 300 ; une seule prime par jour de jeu et par parcours (ensuite : course « pour le plaisir », chrono enregistré). Médailles au chrono, indépendantes du classement. Les 4 médailles d'or débloquent chez Romaric un échappement « course » (accélération +5 %).
- Sécurité des passants : les baigneurs sont derrière la corde ; aucun enfant sur la zone ; un passant bousculé arrête la course (abandon) et coûte 2 de réputation.
- Cas limites : sortir de plus de 40 m du tracé → compte à rebours de 5 secondes puis abandon ; moto à 80 de dégâts ou plus → l'organisateur refuse le départ (« Répare d'abord ça. ») ; plus d'essence → abandon ; marée : le tracé est fixe, il n'y a pas de marée.
- Test : franchir toutes les portes dans l'ordre termine la course et enregistre le temps ; sauter une porte ne valide pas le tour ; arriver 1er donne 1 500 FCFA la première fois et 0 la seconde le même jour ; sur le sable, 0 à 60 km/h prend 25 % de temps en plus que sur le bitume ; à 80 de dégâts le départ est refusé.

## Pêche en lagune
- À partir du chapitre 2, avec la pirogue (décision 86). On pêche depuis une pirogue arrêtée sur la lagune ou le lac Nokoué, ou depuis les berges et pontons marqués d'un piquet à ruban bleu (6 points : berge de Dantokpa, sous l'ancien pont côté Akpakpa, embouchure, 3 au village lacustre).
- Matériel, vendu à l'embarcadère de Dantokpa (« Tout pour la Pêche ») : ligne à main 500 FCFA ; canne en bambou 2 000 FCFA (zone de touche plus large de 30 %) ; épervier (filet lancé) 8 000 FCFA, depuis la pirogue seulement ; boîte de 20 appâts 200 FCFA.
- **Ligne** : E lance (1 appât). Attente de 4 à 15 secondes (plus courte à l'aube 5 h-8 h et au crépuscule 17 h-19 h : 3 à 8 secondes). Le bouchon plonge, bruit bref : il faut appuyer sur E dans la fenêtre (0,8 s ; 1,0 s avec la canne). Puis remontée : une jauge de tension oscille ; maintenir E la fait monter, relâcher la fait descendre ; rester dans la zone verte 3 à 8 secondes selon le poisson. Dans le rouge 1,5 seconde : le fil casse (appât perdu) ; trop bas 2 secondes : le poisson se décroche.
- **Épervier** : Espace maintenu pour doser le lancer (cercle au sol de 3 m de rayon, à 2 à 8 m de la pirogue) ; prise de 0 à 6 petits poissons selon le lieu et l'heure ; 20 secondes pour ramener et vider ; pas de gros poisson.

| Prise | Où | Poids | Prix au kilo (2017) | Fréquence |
|---|---|---|---|---|
| Tilapia | partout | 0,2 à 0,8 kg | 1 200 | 45 % |
| Mulet | embouchure, lagune | 0,3 à 1 kg | 1 000 | 20 % |
| Poisson-chat (silure) | lac, près des herbes | 0,5 à 3 kg | 1 500 | 15 % |
| Crabe de lagune | berges | 0,2 kg | 1 500 | 10 % |
| Crevettes (épervier seulement) | lac, de nuit | 0,1 à 0,5 kg | 2 500 | — |
| Capitaine (gros) | embouchure, aube | 2 à 6 kg | 2 500 | 4 % |
| Objet (vieille sandale, pneu, bidon) | partout | — | 0 | 6 % |

- Panier : 10 kg dans la pirogue, 4 kg à pied. Vente aux mareyeuses de l'embarcadère de Dantokpa ou du village lacustre (prix −10 % au village, mais pas de trajet), de 6 h à 19 h. Le poisson doit être vendu dans la journée de jeu : le lendemain, il vaut moitié prix ; après 2 jours, il est jeté. Maman Koffi accepte un poisson par jour (+1 repas gratuit le soir).
- Acadjas : les enclos de branchages des pêcheurs du lac (voir « lac Nokoué ») sont **privés** ; y pêcher fait accourir le propriétaire en pirogue, −5 de réputation au village lacustre, prise confisquée.
- Gain visé : 1 500 à 4 000 FCFA par demi-journée de jeu, moins qu'un métier, pour le plaisir.
- Cas limites : pas d'appât → message et rappel du point de vente ; panier plein → on doit relâcher ou vendre ; pluie forte → attente doublée ; pirogue en mouvement (plus de 0,5 m/s) → lancer refusé ; nuit → seulement crevettes à l'épervier et poisson-chat.
- Test : avec un générateur de hasard fixé, un lancer donne une touche entre 4 et 15 secondes ; appuyer hors fenêtre perd l'appât ; tenir la jauge dans le vert 5 secondes ramène un tilapia du poids tiré ; 2 kg de tilapia se vendent 2 400 FCFA à Dantokpa et 2 160 au village ; le 11e kilo est refusé dans la pirogue ; pêcher dans un acadja retire 5 de réputation et vide la prise.

## Livraison de marchandises
- C'est l'activité libre de livraison, différente des missions d'histoire de Nan Akouavi. Disponible dès le chapitre 1 à moto (petits colis), puis en tricycle (chapitre 2), camionnette (chapitre 4).
- Points de départ : tableau noir « Livraisons du jour » à l'entrepôt de Dantokpa, au dépôt de Missèbo, au port (chapitre 2) et, plus tard, depuis le téléphone (application de Koffi, chapitre 4). 3 à 5 offres affichées, renouvelées toutes les 6 heures de jeu : marchandise, destination, distance par la route, délai, paie.
- **Capacité** : moto 1 colis (20 kg, sanglé à l'arrière ; pas de passager en même temps) ; tricycle 6 colis ou 300 kg ; camionnette 12 colis ou 1 000 kg. Chargement : E devant le tas, 2 secondes par colis ; déchargement pareil dans le cercle d'arrivée.
- **Paie** (2017) : 200 FCFA + 1,5 FCFA par mètre de route + 100 FCFA par colis au-delà du premier, arrondi à 50 FCFA. Exemple : 1 colis à 1 200 m = 2 000 FCFA ; 6 colis à 2 000 m = 3 700 FCFA.
- **Délai** : distance ÷ 7 m/s + 30 secondes par colis, en temps réel ; ×1,5 aux heures de pointe (décision 60). Chrono en haut de l'écran, vert puis rouge dans les 20 dernières secondes.
  - Dans le délai : paie complète ; avec plus de 25 % de temps restant : prime de 15 %.
  - Retard : −2 % par seconde de retard, plancher 40 % de la paie.
- **État de la marchandise** : jauge de 100 %. Elle baisse sur les chocs (mêmes seuils que les dégâts du véhicule : rien sous 18 km/h perdus d'un coup, puis 1 % par km/h au-delà), sur les chutes à moto (−25 %) et, pour les marchandises fragiles, sur les freinages au frein à main (−3 %). Paie multipliée par l'état ; sous 30 %, le client refuse le colis (0 FCFA, −2 de réputation chez le donneur d'ordre).
- **Types** : courant (cartons, sacs de riz) ; **fragile** (œufs, verrerie, téléviseur : paie +40 %, jauge deux fois plus sensible) ; **frais** (poisson, glace : paie +30 %, délai ×0,75) ; **encombrant** (matelas, planches sur le tricycle : vitesse maximale −15 %, dépasse de 1 m à l'arrière).
- **Tournée** : à partir de 3 colis, plusieurs adresses ; le joueur choisit l'ordre, le délai est commun. La carte montre toutes les adresses.
- Aucune marchandise interdite dans cette activité (les trafics — kpayo, marchandises du port, faux papiers — n'existent que dans les missions écrites, décision 5).
- Barrages et contrôles : avec une cargaison en règle, un contrôle de police fait perdre 8 secondes (l'agent regarde le bon de livraison), rien d'autre.
- Cas limites : véhicule abandonné avec le chargement plus de 2 minutes réelles ou à plus de 150 m → livraison annulée, marchandise perdue, −3 de réputation chez le donneur d'ordre ; véhicule immobilisé (panne d'essence) → on peut appeler Romaric (dépannage payant) sans annuler ; recherche de 2 étoiles pendant la livraison → le client n'ouvre pas tant que les étoiles sont là ; changement de véhicule impossible en cours de livraison sauf du tricycle vers la camionnette (transbordement colis par colis).
- Test : la paie calculée pour 1 colis à 1 200 m vaut 2 000 FCFA ; livrer avec 30 % du temps restant paie 2 300 ; 10 secondes de retard paient 1 600 ; un choc à 40 km/h perdus retire 22 % d'état ; un colis à 25 % est refusé ; la moto refuse un second colis ; s'éloigner de 150 m du véhicule chargé annule la livraison.

## Awalé
- Version à 2 rangées de 6 cases, 4 graines par case au départ (48 graines), la plus répandue. On y joue contre des adultes assis à l'ombre : devant l'atelier de Romaric, sous le grand arbre de la cour de Dantokpa, à la buvette de la plage, devant la boutique de Tonton Gratien. De 10 h à 22 h.
- **Aucune mise, aucun pari** (décision 70) : on joue pour l'honneur. Koffi ne propose jamais d'argent et les adversaires non plus.
- Vue : caméra à la verticale du plateau de bois (60 cm de long), les graines sont des billes grises ; le nombre de graines s'affiche sur la case survolée. Gauche/droite pour choisir une de ses 6 cases, E pour jouer, Échap pour abandonner (compte comme une défaite).
- Règles :
  - on prend toutes les graines d'une de ses cases et on les sème une à une dans les cases suivantes, dans le sens inverse des aiguilles d'une montre ; avec 12 graines ou plus, on saute la case de départ ;
  - si la dernière graine tombe chez l'adversaire et porte la case à **2 ou 3** graines, on les capture, ainsi que celles des cases précédentes de l'adversaire tant qu'elles comptent 2 ou 3 ;
  - un coup qui capturerait **toutes** les graines de l'adversaire est joué mais ne capture rien ;
  - si l'adversaire n'a plus de graines, on doit jouer un coup qui lui en donne ; si c'est impossible, le joueur ramasse les graines restantes de son camp et la partie s'arrête ;
  - victoire à **25 graines** capturées ; 24 partout = nul ; après 100 coups sans capture, chacun ramasse son camp et on compte.
- Semis animé : 0,15 seconde par graine (maintenir E : instantané). Temps de réflexion libre pour le joueur ; l'adversaire joue en 1 à 3 secondes.
- Adversaires : 4 niveaux — débutant (coup au hasard parmi ceux qui ne donnent rien), habitué (prend dès qu'il peut), fort (calcule 3 coups à l'avance), « Le Doyen » (5 coups à l'avance, à partir du chapitre 2, devant le siège des zémidjans). Chacun a 6 répliques de victoire et 6 de défaite, taquines, sans moquerie.
- Récompenses : première victoire contre chaque adversaire : +5 de réputation dans son quartier ; battre le Doyen : un plateau d'awalé sculpté à poser dans le logement et le succès correspondant. Ensuite, rien que la statistique.
- Aide : au premier lancement, 5 écrans expliquent les règles sur un vrai plateau ; une option « montrer les prises possibles » (activée en Tranquille) entoure en vert les cases qui capturent.
- Cas limites : case vide non sélectionnable ; coup interdit (laisser l'adversaire sans graine alors qu'on peut lui en donner) refusé avec un message ; quitter pendant le semis attend la fin du semis.
- Test : depuis la position de départ, jouer la 3e case donne les nombres attendus dans chaque case ; une position préparée où la dernière graine fait 3 puis 2 en arrière capture 5 graines ; un coup qui prendrait tout ne capture rien ; un semis de 12 graines saute la case d'origine ; 25 graines terminent la partie ; aucun échange d'argent n'a lieu (argent identique avant et après).

## Salle de sport
- Lieux : « Muscu Akpakpa Fitness » (salle couverte, tôle et ventilateurs, haltères en ciment coulé dans des boîtes), et la **plage de Fidjrossè** au petit matin (barres fixes, groupe qui court, gratuit de 6 h à 8 h). Salle ouverte de 6 h à 21 h. Entrée 300 FCFA la séance (2017), abonnement 4 000 FCFA pour 30 jours de jeu.
- Une **séance** = 3 exercices au choix parmi 5, environ 2 minutes réelles en tout ; elle fait passer 1 heure de jeu.
  - Développé couché : appuyer en rythme sur Haut quand le repère passe dans la zone (12 répétitions, zone de 0,25 s).
  - Corde à sauter : Espace en rythme, 30 secondes, le rythme accélère.
  - Sac de frappe : enchaîner E (direct) et C (crochet) selon les flèches affichées, 30 secondes.
  - Tractions (plage) : alterner Gauche/Droite, 10 répétitions.
  - Course sur le sable (plage) : 400 m chronométrés, à pied.
- Chaque exercice donne 0 à 3 étoiles ; une séance rapporte 1 à 9 points à l'une des trois qualités :
  - **Force** (couché, tractions) : dégâts des coups de poing +2 % par niveau ;
  - **Souffle** (corde, course) : endurance de course et de nage +4 % par niveau ;
  - **Technique** (sac) : fenêtre d'esquive en bagarre +3 % par niveau.
- Niveaux 0 à 10 par qualité ; il faut 10 points pour le niveau 1, puis 5 de plus à chaque niveau (15, 20…). **Une seule séance utile par jour de jeu** : la deuxième ne rapporte rien (« Le corps a besoin de repos. »).
- Sans entraînement pendant 15 jours de jeu, une qualité perd 1 niveau, jamais en dessous de 3 une fois ce niveau atteint. La corpulence de Koffi ne change pas à l'écran (décision 50).
- **Entraîneur** : « Coach Hervé », ancien boxeur, apprend 3 enchaînements de bagarre à mains nues (500 FCFA la leçon, aux niveaux de Technique 2, 5 et 8). Combats d'entraînement avec gants et casque, en 2 reprises d'une minute, sans mise ni pari, sans blessure (la santé ne descend pas sous 30).
- Effets immédiats : séance terminée = état « en forme » 10 minutes réelles (remontée de santé jusqu'à 70 au lieu de 50). Faire une séance avec moins de 30 de santé est refusé.
- Cas limites : arriver à 20 h 30 → une séance commencée se termine ; abonnement expiré → retour au tarif à la séance ; rater toutes les répétitions → 0 étoile, 1 point quand même.
- Test : 12 appuis dans la zone donnent 3 étoiles ; une séance à 9 points puis une seconde le même jour → 9 points seulement ; 10 points font passer la Force au niveau 1 et les dégâts du poing de 6 à 6,12 ; 15 jours simulés sans séance font perdre 1 niveau, mais pas en dessous de 3 ; séance refusée à 25 de santé.

## Objets cachés à collecter
- Quatre collections, visibles dans le téléphone (application « Carnet ») avec un compteur par quartier. Rien n'est perdu si on en manque un ; aucun n'est dans un lieu de culte (décision 18) ni dans un lieu qui disparaît entre deux chapitres.

| Collection | Nombre | Aspect | Où | Récompense par objet |
|---|---|---|---|---|
| Capsules dorées de « Zito » | 60 | capsule brillante qui tourne, 25 cm, halo doré, tintement audible à 15 m | toits accessibles, ruelles, dessous des ponts, bout des pontons | 200 FCFA |
| Vieilles plaques de zémidjan | 20 | plaque jaune numérotée clouée sur un mur ou un arbre | une par zone de la carte, en hauteur (à atteindre par franchissement) | 500 FCFA, +1 de réputation chez les zémidjans |
| Cassettes de la radio rétro | 16 | boîtier orange posé sur un rebord | maquis, garages, intérieurs | débloque un morceau sur la station zouk et rétro |
| Cartes postales de Cotonou | 12 | point de vue marqué par un trépied ; E prend la « photo » | toit de la halle de Dantokpa, les trois ponts, la plage, l'aéroport, le village lacustre… | une image de chargement + 1 000 FCFA |

- Paliers : 15 capsules → casquette dorée ; 30 → la minicarte signale les capsules à moins de 40 m ; 60 → tenue « Zito » complète et peinture dorée pour une moto. 20 plaques → la moto de collection « Zem d'or » au garage de Romaric. 16 cassettes → émission spéciale sur la radio. 12 cartes postales → filtre « carte postale » du mode photo.
- Les **objets perdus** des passants (décision 103) sont des missions secondaires, décrites ailleurs ; ils ne comptent pas dans ces collections.
- Répartition par chapitre : 60 % accessibles dès que le quartier est ouvert ; le reste dans les quartiers et lieux ouverts plus tard (port, aéroport, village lacustre, Parakou : 4 capsules et 1 carte postale). Un objet reste ramassable jusqu'à la fin du jeu.
- Chaque objet a un identifiant fixe (`capsule_017`) et une position écrite dans `data/collecte.json` ; l'état ramassé est sauvegardé. Ramassage : marcher dessus (capsules) ou E (plaques, cassettes, cartes postales). Un court son et « Capsule 17/60 — Dantokpa 3/8 » pendant 3 secondes.
- Aide en fin de partie : après le dernier chapitre, Afi vend pour 5 000 FCFA par quartier une « carte au trésor » qui affiche les objets restants du quartier.
- Cas limites : ramassage possible à pied seulement (pas depuis un véhicule) ; pendant une mission, on peut ramasser et le ramassage est gardé même si la mission échoue ; aucun objet à plus de 12 m de chute sans chemin de descente.
- Test : le fichier contient exactement 60, 20, 16 et 12 identifiants uniques, chacun placé sur une position atteignable (au-dessus du sol, hors bâtiment plein, hors de l'eau profonde) ; marcher sur une capsule ajoute 200 FCFA, incrémente le compteur et la fait disparaître ; elle ne réapparaît pas après sauvegarde et rechargement ; à 30 capsules la minicarte affiche celles à moins de 40 m ; en voiture, rouler sur une capsule ne la ramasse pas.
