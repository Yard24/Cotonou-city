# Vêtements et apparence : fonctionnement attendu

Rien n'est encore codé. Code prévu : `scripts/tenue.gd` (ce que porte Koffi, garde-robe), `scripts/boutique.gd` (écran d'achat commun à toutes les boutiques). Vérifications prévues : `scripts/selftest_tenue.gd`.

Rappel des décisions : on change la tenue, jamais le visage ni la corpulence (50) ; maillot vert, jean et sandales au chapitre 1, tenue qui s'améliore à chaque chapitre (27) ; commerces et motifs inventés (25, 46) ; pas de nudité (5) ; prix en FCFA proches de l'année jouée (63).

## Règles communes
- Koffi porte 6 emplacements : **haut**, **bas**, **chaussures**, **coiffure**, **couvre-chef**, **accessoires** (3 au plus : lunettes, montre, sac ou chaîne). Une **tenue complète** (boubou, bomba, costume) occupe haut + bas d'un coup.
- Un emplacement haut, bas ou chaussures n'est jamais vide : retirer une pièce remet la pièce de base du chapitre (maillot vert, jean, sandales).
- Tout ce qui est acheté va dans la **garde-robe**, accessible dans chaque logement du héros (touche E devant l'armoire). Changer de tenue y est gratuit et immédiat (fondu de 0,4 s).
- Le casque de moto se met tout seul par-dessus (décision 52) : il cache le couvre-chef et la coiffure tant qu'on est sur la moto.
- Chaque pièce a une **note d'allure** de 0 à 3. L'allure de Koffi est la somme haut + bas + chaussures (0 à 9 ; une tenue complète compte double). Effets, volontairement petits :
  - allure 0 à 2 : le vigile de la banque et celui de l'entreprise de prestations de services refusent l'entrée (« Chef, pas comme ça ici. ») ;
  - allure 6 et plus : +5 % sur les pourboires de taxi et de livraison à Ganhi et à la Marina ; première offre du marchandage 10 % plus haute partout (on le prend pour quelqu'un qui a les moyens).
- Tenue sale : après une chute à moto, une bagarre ou une nage, la tenue reste poussiéreuse ou mouillée 3 minutes réelles (teinte plus terne, −1 d'allure). Se changer au logement l'efface tout de suite.
- Vieillissement (décision 8) : le visage et la barbe de base changent aux chapitres 3 et 5 ; les vêtements achetés restent les mêmes.
- Prix : le tableau donne le prix de 2017. Il augmente de 4 % par année de jeu, arrondi à 50 FCFA.
- Test : la somme d'allure se calcule bien ; retirer le haut remet le maillot vert ; la garde-robe contient exactement les pièces achetées après sauvegarde et rechargement ; allure 2, la porte de la banque reste fermée ; allure 3, elle s'ouvre.

## Boutiques de tissus
- Ce que voit le joueur : des boutiques étroites aux murs couverts de pagnes pliés, à Dantokpa (6 boutiques dans l'allée des tissus, dont celle de Nan Akouavi, « Chez Nan Akouavi — Tissus en gros ») et à Missèbo (2 boutiques). Ouvertes de 8 h à 19 h, fermées le dimanche après-midi.
- E devant le comptoir ouvre l'écran d'achat : Koffi est face à la vendeuse, les pagnes défilent à gauche/droite, l'aperçu se drape sur un mannequin en bois.
- On y achète du **tissu**, pas un vêtement : il faut ensuite le porter au tailleur. Le tissu se vend à la **pièce de 6 yards** (une tenue complète) ou à la **demi-pièce de 3 yards** (une chemise ou un pantalon).
- 24 motifs inventés, en 4 gammes. Aucun motif ni nom de marque réel ; les noms sont de fantaisie (« Œil de la lagune », « Trois calebasses », « Route de Ganhi », « Pluie de juin »…).

| Gamme | Motifs | Demi-pièce | Pièce | Allure donnée à la tenue |
|---|---|---|---|---|
| Fancy imprimé | 10 | 2 500 | 4 500 | 1 |
| Pagne de qualité | 8 | 6 000 | 11 000 | 2 |
| Bazin teint | 4 | 9 000 | 17 000 | 3 |
| Tissé (bandes) | 2 | 12 000 | 22 000 | 3 |

- **Marchandage** (décision 65) : trois échanges au plus. La vendeuse annonce le prix du tableau + 20 % ; le joueur choisit « Accepter », « Proposer moins » (curseur de −5 à −40 %) ou « S'en aller ». Elle accepte toute offre au-dessus de son prix plancher (prix du tableau −10 %), contre-propose entre les deux, et se vexe en dessous de −40 % (boutique fermée à Koffi pendant 1 heure de jeu). Chez Nan Akouavi on ne marchande pas : prix du tableau, −15 % quand la réputation à Dantokpa atteint 50.
- Paiement en espèces ; par KwabôPay à partir du chapitre 2 (décision 66), sans frais.
- Le tissu acheté apparaît dans l'inventaire (« 1 pièce — Trois calebasses »). On peut porter 4 coupons au plus ; au-delà la vendeuse refuse (« Tu vas les porter comment ? »).
- Cas limites : argent insuffisant → l'option « Accepter » est grisée, la vendeuse propose la demi-pièce ; boutique fermée → panneau « Fermé, revenez à 8 h » ; recherche de 2 étoiles ou plus → la vendeuse refuse de servir tant que la police cherche Koffi.
- Chapitre 3 (ville à l'arrêt) : 2 boutiques sur 8 ouvertes, de 9 h à 15 h, et un motif en moins par gamme (rupture de stock).
- Test : avec 4 500 FCFA, achat d'une pièce de fancy au prix accepté, argent à 0, coupon dans l'inventaire ; une offre à −45 % ferme la boutique 1 heure de jeu (2 minutes réelles) ; un 5e coupon est refusé ; à 20 h l'écran d'achat ne s'ouvre pas.

## Tailleur
- Ce que voit le joueur : un atelier ouvert sur la rue, deux machines à pédale, des tenues suspendues. 3 ateliers : « Couture La Patience » (Dantokpa), « Maître Sourou Couture » (Étoile Rouge), « Élégance du Littoral » (Ganhi, plus cher, à partir du chapitre 4). Ouverts de 8 h à 20 h.
- E devant le tailleur : on choisit un **coupon** de l'inventaire, puis un **modèle**, puis une **couleur de fil et de broderie** (6 choix). Le mannequin montre le résultat avant de payer.

| Modèle | Tissu nécessaire | Façon (2017) | Délai |
|---|---|---|---|
| Chemise manches courtes | demi-pièce | 2 000 | 1 jour de jeu |
| Chemise manches longues | demi-pièce | 2 500 | 1 jour |
| Pantalon | demi-pièce | 2 500 | 1 jour |
| Ensemble chemise-pantalon | pièce | 4 000 | 1 jour |
| Bomba (tunique et pantalon) | pièce | 5 000 | 2 jours |
| Boubou trois pièces brodé | pièce de bazin ou de tissé | 12 000 | 3 jours |
| Costume deux pièces (Ganhi seulement, tissu uni vendu sur place 25 000) | — | 35 000 | 3 jours |

- Paiement : moitié à la commande (avance), moitié au retrait. Un ticket apparaît dans le téléphone (« Bomba — prête jeudi 10 h »). 1 jour de jeu = 48 minutes réelles (décision 89) ; une nuit de sommeil au logement fait avancer le délai.
- **Service express** : +50 % sur la façon, prêt en 3 heures de jeu (6 minutes réelles).
- Le tailleur est humain : 1 commande sur 6, tirée au sort à la commande, a **un jour de retard** (« Ah patron, il y a eu coupure… »). Jamais de retard en service express ni pendant une mission qui demande la tenue.
- Au retrait, la tenue va dans la garde-robe et Koffi peut l'enfiler sur place (cabine : rideau, fondu de 0,4 s).
- **Retouches** : 500 FCFA pour changer la couleur de broderie d'une tenue déjà faite, sur-le-champ.
- 3 commandes en cours au plus par atelier. Une commande non retirée est gardée sans limite de temps.
- Cas limites : pas de coupon → le tailleur renvoie vers l'allée des tissus et l'indique sur la carte ; argent insuffisant pour le solde → la tenue reste à l'atelier ; coupon trop petit pour le modèle → modèle grisé avec la mention « il faut une pièce entière ».
- Test : commander une chemise retire la demi-pièce de l'inventaire et 1 000 FCFA ; avant le délai, le retrait est refusé ; après 48 minutes simulées, le retrait prend 1 000 FCFA et ajoute la chemise à la garde-robe avec le bon motif ; l'express coûte 3 000 FCFA au total et est prêt en 6 minutes ; une 4e commande est refusée.

## Tenues traditionnelles
- Elles sont de trois origines : cousues chez le tailleur (bomba, boubou), offertes par l'histoire, ou louées pour une cérémonie.
- Liste :
  - **Bomba** : tunique ample à col brodé et pantalon du même tissu. Allure 2 à 3 selon le tissu.
  - **Boubou trois pièces** (grand boubou, tunique, pantalon) en bazin ou tissé, brodé au col. Allure 3 (compte 6).
  - **Tenue de fête en pagne noué à l'épaule** avec chemise blanche dessous (pas de torse nu, décision 5). Allure 3.
  - **Tenue assortie de cérémonie** (« uniforme ») : le même pagne que la famille pour un mariage ou un baptême ; donnée par Maman Koffi dans une mission du chapitre 2.
  - **Bonnet brodé** assorti (couvre-chef), 1 500 à 4 000 FCFA chez le tailleur.
- Effets :
  - en tenue traditionnelle complète, les salutations des passants âgés et des vendeuses changent (« Tu es bien mis aujourd'hui ! ») ; +2 de réputation par jour de jeu dans le quartier où Koffi passe au moins 10 minutes réelles, 1 fois par jour ;
  - certaines scènes l'exigent (fête de famille, invitation chez Nan Akouavi, cérémonie de fin du chapitre 6) : l'objectif affiche « Mets une tenue de cérémonie » et la porte reste fermée sinon ;
  - conduire une moto en grand boubou est possible mais Koffi s'en plaint (réplique : « Le boubou dans la chaîne, c'est comme ça qu'on finit à pied… ») ; aucun malus de conduite.
- **Location** : « Élégance du Littoral » loue un boubou pour 3 000 FCFA la journée, caution 10 000 FCFA rendue au retour. Rendu sale : 2 000 FCFA retenus. Non rendu après 2 jours de jeu : caution perdue, la tenue reste dans la garde-robe.
- Respect (décisions 18 et 104) : aucune tenue de culte ou de dignitaire religieux n'est achetable ni portable ; les tenues traditionnelles ne servent jamais de déguisement comique.
- Test : boubou porté → allure 6 ; la porte de la scène de cérémonie s'ouvre en bomba et reste fermée en maillot ; le bonus de réputation n'est donné qu'une fois par jour de jeu ; location rendue propre → 10 000 rendus, rendue après une chute → 8 000.

## Coiffure
- Choix de Claude : la décision 50 interdit de changer le visage et la corpulence ; les cheveux et la barbe, eux, se changent, comme une tenue.
- Lieux : salons de coiffure pour hommes — « Salon Le Dégradé » (Dantokpa), « Chez Parfait Coiffure » (Étoile Rouge), « Coupe Prestige » (Ganhi, à partir du chapitre 2) — et coiffeurs ambulants sous un arbre (tabouret, miroir accroché, tondeuse sur batterie) à Akpakpa et Fidjrossè. De 8 h à 21 h.
- E devant le fauteuil : Koffi s'assoit, la caméra passe face au miroir, les coupes défilent à gauche/droite avec leur prix.

| Coupe | Prix 2017 (ambulant / salon / Ganhi) |
|---|---|
| Rasé court | 200 / 300 / 1 000 |
| Dégradé bas | 300 / 500 / 1 500 |
| Dégradé haut avec trait | — / 700 / 2 000 |
| Afro court | 300 / 500 / 1 500 |
| Afro moyen (il faut 10 jours de jeu sans coupe) | — / 800 / 2 000 |
| Petites vanilles | — / 2 000 / 4 000 |
| Tresses plaquées | — / 2 500 / 5 000 |

- Barbe : rasé, moustache fine, bouc, barbe courte (à partir du chapitre 3), barbe pleine taillée (à partir du chapitre 5). 200 à 1 000 FCFA.
- La coupe dure 4 secondes à l'écran (bruit de tondeuse, fondu), puis Koffi se regarde et commente.
- Les cheveux **repoussent** : après 10 jours de jeu, un rasé devient afro court ; un dégradé perd son trait après 5 jours. Les tresses tiennent 15 jours puis reviennent à l'afro court.
- La coiffure ne change pas l'allure. Une coupe fraîche (moins de 2 jours de jeu) donne un commentaire des proches et rien d'autre.
- Lien avec le métier de coiffeur (décision 67) : les mêmes salons servent au métier jouable, décrit dans le système « Économie » ; ici le joueur est client.
- Cas limites : une coupe déjà portée est grisée ; pas assez d'argent → le coiffeur propose le rasé court ; l'ambulant ne travaille pas sous la pluie (tabouret vide, bâche tirée).
- Test : choisir « dégradé bas » au salon retire 500 FCFA et change le modèle de cheveux ; 10 jours simulés plus tard, le rasé est devenu afro court ; l'ambulant est absent quand la météo est « grosse pluie » ; la barbe pleine est absente de la liste avant le chapitre 5.

## Accessoires
- Vendus par les marchands ambulants (étal à roulettes ou présentoir porté sur la tête), dans les boutiques de Ganhi (« Galerie Marina Mode », « Optique Soleil d'Or ») et sur l'esplanade de la plage de Fidjrossè.

| Accessoire | Emplacement | Prix 2017 | Effet |
|---|---|---|---|
| Lunettes de soleil de rue (4 modèles) | accessoire | 1 000 | aucun |
| Lunettes de marque inventée « Lagoon » (3 modèles, Ganhi) | accessoire | 15 000 | +1 d'allure |
| Montre en plastique | accessoire | 1 500 | l'heure s'affiche à côté de la minicarte sans sortir le téléphone |
| Montre en métal « Tempo » | accessoire | 25 000 | même effet, +1 d'allure |
| Casquette (6 couleurs) | couvre-chef | 1 000 | aucun |
| Chapeau de paille | couvre-chef | 800 | aucun |
| Bonnet brodé | couvre-chef | 1 500 à 4 000 | va avec les tenues traditionnelles |
| Sacoche en bandoulière | accessoire | 3 000 | 2 emplacements d'inventaire en plus (6 coupons de tissu au lieu de 4, 2 petits colis de plus) |
| Sac à dos | accessoire | 6 000 | 4 emplacements d'inventaire en plus ; ne se cumule pas avec la sacoche |
| Chaîne fine dorée | accessoire | 5 000 | aucun |
| Sandales en cuir / baskets / souliers de ville | chaussures | 2 500 / 8 000 / 18 000 | allure 1 / 2 / 3 |
| Cache-nez en tissu (chapitre 3 seulement, offert par Maman Koffi) | accessoire | 0 | demandé à l'entrée des bâtiments pendant le chapitre 3 |

- L'allure gagnée par les accessoires est plafonnée à +2.
- Marchandage chez les ambulants (trois échanges, mêmes règles que les tissus) ; prix fixes à Ganhi.
- Les lunettes de soleil réduisent légèrement l'éblouissement de midi (bloom divisé par deux) aux niveaux « Élevé » et « Ultra » ; aucun effet sur le jeu.
- En bagarre, lunettes et couvre-chef tombent au premier coup reçu : ils restent au sol 60 secondes, E les ramasse ; sinon ils reviennent dans la garde-robe (rien n'est jamais perdu).
- Aucune arme, aucun bijou religieux, aucun insigne d'administration ou de police n'est vendu.
- Cas limites : 4e accessoire → le jeu demande lequel remplacer ; sacoche retirée alors que l'inventaire dépasse → retrait refusé tant que l'inventaire n'est pas allégé.
- Test : la montre affiche l'heure sur l'écran de jeu ; la sacoche porte l'inventaire de 4 à 6 coupons ; retirer la sacoche avec 6 coupons est refusé ; après un coup reçu, les lunettes sont au sol puis de retour dans la garde-robe 60 secondes plus tard ; allure des accessoires plafonnée à 2.
