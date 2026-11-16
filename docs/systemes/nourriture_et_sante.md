# Nourriture et santé : fonctionnement attendu

Déjà dans le jeu (`scripts/player.gd`, `scripts/interaction.gd`) : 100 points de santé, jauge verte/jaune/rouge, sachet d'eau fraîche à 100 FCFA (+25), banc, remontée lente, évanouissement et réveil place de l'Amazone. Ce document décrit la suite. Code prévu : `scripts/repas.gd` (manger, faim, effets), `scripts/soins.gd` (centre de santé, pharmacie). Vérifications prévues : `scripts/selftest_repas.gd`.

Rappel des décisions : manger dans les maquis et chez les vendeuses rend de la santé (81) ; santé à zéro = réveil au centre de santé, soins payants (80), 10 % de l'argent, 2 000 FCFA au plus, rien si on n'a rien ; pas de sang détaillé (3) ; aucun personnage ne meurt (42) ; pas de drogue (5) ; commerces inventés (25).

## Maquis et restaurants
- Ce que voit le joueur : des maquis (toit de tôle ou paillote, tables en plastique, marmites à l'arrière, radio allumée) et quelques restaurants fermés avec climatisation. On y entre ; ils font partie de la trentaine d'intérieurs (décision 92).
- Lieux prévus (noms inventés) :
  - « Maquis Chez Tantie Rosine » — Dantokpa, ouvert 6 h-22 h ;
  - « Maquis Le Carrefour » — Étoile Rouge, 10 h-1 h ;
  - « Maquis La Lagune » — Akpakpa, au bord de l'eau, 11 h-23 h, poisson ;
  - « Maquis Fidjrossè Plage » — sur le sable, 11 h-1 h ;
  - « Restaurant Le Baobab Bleu » — Ganhi, 12 h-15 h et 19 h-23 h, allure 3 exigée (voir vêtements) ;
  - « Restaurant La Marina » — boulevard de la Marina, 12 h-23 h, à partir du chapitre 4.
- E à une table libre : Koffi s'assoit, la carte s'affiche (4 à 6 plats, photo en aplat, prix, santé rendue). Haut/bas pour choisir, E pour commander, Échap pour partir sans payer (rien n'a été servi).
- Le repas : la serveuse apporte le plat en 3 secondes, Koffi mange en 6 secondes (animation main-bouche, on mange la pâte à la main droite), puis paie. Maintenir E passe l'animation (1 seconde).

| Plat | Prix 2017 | Santé | Bonus |
|---|---|---|---|
| Pâte de maïs, sauce tomate et poisson frit | 500 | +45 | rassasié 6 min |
| Pâte rouge (amiwo) et poulet | 1 000 | +60 | rassasié 8 min |
| Igname pilée, sauce arachide | 800 | +55 | rassasié 8 min, endurance |
| Akassa et poisson braisé | 700 | +50 | rassasié 6 min |
| Riz au gras et poulet | 800 | +55 | rassasié 6 min |
| Haricots et farine de manioc (atassi-gari) | 300 | +35 | rassasié 4 min |
| Brochettes de bœuf (3) | 500 | +30 | — |
| Jus de bissap, de baobab ou de gingembre | 200 | +10 | — |
| Boisson gazeuse inventée « Zito » | 300 | +10 | — |
| Menu du jour au restaurant de Ganhi | 4 500 | +100 | rassasié 12 min, endurance |

- Les durées sont en minutes réelles. Prix +4 % par année de jeu, arrondis à 50 FCFA.
- Pas d'alcool commandable par le joueur (jeu « à partir de 12 ans ») : des bouteilles sont visibles sur les tables voisines, rien de plus.
- Le premier repas de chaque journée de jeu chez Tantie Rosine est offert tant que la réputation à Dantokpa dépasse 60.
- Paiement en espèces, ou KwabôPay à partir du chapitre 2. Pas assez d'argent : les plats trop chers sont grisés ; on ne peut pas partir sans payer.
- Les maquis sont un lieu de rencontre : certaines missions commencent à une table (marqueur sur la chaise), et les voisins de table lâchent des rumeurs (une phrase tirée au sort parmi 40, liée au chapitre).
- Cas limites : santé pleine et déjà rassasié → la serveuse sert quand même, mais un message prévient avant de payer (« Tu n'as pas faim. Commander quand même ? ») ; recherche de 2 étoiles ou plus → refus de servir, les clients regardent vers la porte ; toutes les tables prises (heures de pointe 12 h-14 h : 80 % d'occupation) → Koffi peut prendre à emporter au comptoir, même effet, sans animation de table ; fermé → porte close, panneau avec les horaires.
- Chapitre 3 : salles fermées, vente à emporter seulement par un guichet, de 10 h à 16 h.
- Test : avec 500 FCFA et 40 de santé, la pâte au poisson laisse 0 FCFA et 85 de santé ; l'état « rassasié » dure 360 secondes ; avec 200 FCFA seul le jus est sélectionnable ; à 2 étoiles la carte ne s'ouvre pas ; à 23 h le maquis de Dantokpa est fermé.

## Vendeuses de rue
- Ce que voit le joueur : des vendeuses assises derrière une bassine ou un petit étal, ou marchant avec un plateau sur la tête, en pagne et foulard (décision 46). On achète debout, sans entrer nulle part : E à moins de 2,6 m, une petite liste de 1 à 3 articles, E pour acheter. Koffi mange en marchant (2 secondes, sans arrêter le joueur).
- **Maman Koffi** vend bouillie et beignets devant la maison, près de Dantokpa, de 6 h à 10 h (décision 30) : c'est gratuit pour Koffi une fois par matin (« Mange d'abord, tu parleras après. »), +30 de santé.

| Article | Où et quand | Prix 2017 | Santé |
|---|---|---|---|
| Sachet d'eau fraîche (existe déjà) | partout, toute la journée | 100 | +25 |
| Sachet d'eau simple (non glacée) | vendeuses ambulantes aux carrefours | 25 | +8 |
| Bouillie de maïs | matin, 6 h-10 h | 100 | +20 |
| Beignets de haricot (5) | matin et fin d'après-midi | 100 | +15 |
| Beignets sucrés (4) | matin | 100 | +15 |
| Pain et omelette | matin, kiosques | 250 | +30 |
| Arachides grillées (cornet) | toute la journée | 50 | +5 |
| Banane plantain grillée | après-midi | 100 | +12 |
| Igname frite et piment | 16 h-21 h | 200 | +20 |
| Maïs grillé ou bouilli | juin à septembre seulement | 100 | +12 |
| Ananas en tranches | toute la journée, plage | 100 | +10 |
| Noix de coco fraîche | plage de Fidjrossè | 200 | +20 |
| Poisson frit et piment | bord de lagune, 11 h-20 h | 300 | +25 |
| Brochettes au bord de la route | 18 h-minuit | 100 pièce | +10 |

- Les ambulantes suivent un circuit de 200 à 400 m et s'arrêtent 20 secondes à chaque carrefour. Aux feux rouges, elles longent les files : en moto ou en voiture à l'arrêt, E achète sans descendre (eau et arachides seulement).
- Stock : chaque vendeuse a 20 portions par jour de jeu. Stock vide : bassine vide, « C'est fini pour aujourd'hui. » Sous la pluie, les étals fixes sont bâchés (vente possible), les ambulantes s'abritent (pas de vente).
- **Fidélité** : au 5e achat chez la même vendeuse fixe, elle reconnaît Koffi (salut par son prénom) et ajoute un beignet ou un fruit « cadeau » (+5 de santé) à chaque achat suivant.
- Pas de marchandage pour la nourriture de rue (prix trop petits).
- Billets : si le joueur n'a que des billets virtuels, aucune gestion de monnaie — le prix exact est toujours débité.
- Cas limites : bousculer une vendeuse ou renverser son étal avec un véhicule fait tomber sa marchandise ; elle crie, refuse de vendre à Koffi pendant un jour de jeu, et la réputation du quartier baisse de 3 (voir « Physique du décor », étals de marché, pour le dédommagement). Elle ne peut pas être blessée gravement (décision 4).
- Test : acheter un cornet d'arachides à 50 FCFA rend 5 points ; le 21e achat de la journée est refusé ; à 11 h la bouillie n'est plus proposée ; à moto arrêtée au feu, E achète un sachet d'eau sans descendre ; 5e achat → drapeau « cliente fidèle », 6e achat → +5 de santé en plus.

## Effets sur la santé
- **Santé** : 0 à 100. Règles déjà en place conservées : remontée seule de 1,5 point/s après 10 s sans blessure, **mais seulement jusqu'à 50** désormais (choix de Claude : sinon manger ne sert à rien) ; au-dessus de 50, il faut manger, boire, se reposer ou se faire soigner. Banc : 6 points/s jusqu'à 70.
- **Rassasié** (icône de bol à côté de la jauge, avec minuterie) : après un vrai plat. Pendant ce temps :
  - la santé remonte seule jusqu'à 100 au lieu de 50 ;
  - la course à pied ne fatigue pas (quand la jauge d'endurance existera).
- **Endurance** (bonus de certains plats) : +10 % de vitesse de nage et de course pendant la durée de « rassasié ».
- **Trop manger** : un 3e plat en moins de 10 minutes réelles ne rend rien et rend Koffi « lourd » 2 minutes (course à 8 m/s au lieu de 10, réplique : « J'ai trop mangé… doucement. »). Les boissons et petits articles de rue ne comptent pas.
- **Faim** : il n'y a pas de jauge de faim qui punit. Après 2 jours de jeu sans aucun repas, Koffi le dit (« Mon ventre fait la grève. ») et la remontée automatique s'arrête à 30 au lieu de 50, jusqu'au prochain repas. Rien de plus : on ne s'évanouit jamais de faim.
- **Soif et chaleur** : entre 12 h et 15 h par temps de soleil, courir plus de 60 secondes d'affilée sans boire fait trembler légèrement l'image et ralentit la course à 8 m/s jusqu'à ce qu'on boive ou qu'on passe 10 secondes à l'ombre. Ne retire pas de santé.
- **Kpayo et nourriture** : aucun aliment ne rend malade par hasard (pas de punition aléatoire sur la nourriture).
- **Sources de dégâts** (rappel et valeurs de départ) : chute (11 points par mètre au-delà de 3 m), choc en véhicule (20 à 48), chute de moto (10 à 35 selon la vitesse), coup de poing reçu (6), coup de bâton reçu (12), percuté par un véhicule à pied (15 à 40), épuisement dans l'eau (voir « Navigation sur l'eau », noyade).
- **Signes à l'écran** : sous 30, bord de l'écran légèrement rouge, souffle court, Koffi boite (marche à 4,5 m/s, course à 8 m/s) ; sous 15, battement de cœur sourd. Pas de sang (décision 3) : des pansements apparaissent sur le modèle sous 30 et disparaissent au-dessus de 60.
- **Difficulté** (décision 116) : dégâts reçus ×0,6 en Tranquille, ×1 en Normal, ×1,4 en Corsé ; santé rendue par la nourriture identique dans les trois.
- Test : sans repas, la santé remonte de 20 à 50 puis s'arrête ; après un plat, elle monte jusqu'à 100 ; 3 plats en 5 minutes → le 3e rend 0 et la course tombe à 8 m/s pendant 120 s ; à 25 de santé la vitesse de marche est 4,5 m/s ; en Tranquille un coup de poing coûte 3,6 points (arrondi à 4).

## Hôpital et réanimation
- **Évanouissement** (santé à zéro) : Koffi tombe assis puis allongé, l'image passe au gris en 1 seconde, le son s'étouffe. Fondu au noir de 2,5 secondes, carton « Quelques heures plus tard… ». Personne ne meurt jamais, Koffi compris.
- **Réveil** : sur un lit du **centre de santé le plus proche** à vol d'oiseau (aujourd'hui : place de l'Amazone, en attendant). Centres prévus, tous inventés :
  - « Centre de santé de la Lagune » — Dantokpa ;
  - « Clinique Bon Secours de Ganhi » — Ganhi ;
  - « Centre de santé d'Akpakpa » ;
  - « Dispensaire de Fidjrossè » ;
  - « Hôpital de zone de Parakou » (chapitre 5) ;
  - sur la route du Nord : l'infirmerie de l'étape la plus proche.
- Au réveil : santé à 100, 3 heures de jeu ont passé (6 minutes réelles de l'horloge, pas d'attente pour le joueur), niveau de recherche remis à zéro seulement s'il était de 1 étoile (au-delà, voir ci-dessous).
- **Facture** : 10 % de l'argent de poche, 2 000 FCFA au plus, 0 s'il n'a rien (règle déjà validée). L'argent sur KwabôPay et à la banque n'est pas compté. L'infirmière la lit : « Soins et pansements : 1 250 francs. Et faites attention à vous. »
- Ce qu'on garde : véhicules possédés, objets, tenue, argent restant. Le véhicule utilisé au moment de l'évanouissement est rangé devant le centre de santé s'il appartient à Koffi (dégâts conservés) ; un véhicule emprunté reste où il est.
- **Évanoui pendant une mission** : la mission échoue et propose « Reprendre au dernier point de contrôle » (pas de facture, pas de passage au centre de santé) ou « Abandonner » (réveil au centre de santé, facture normale).
- **Évanoui avec 2 étoiles ou plus** : réveil au centre de santé avec un agent au pied du lit ; on applique l'arrestation (amende de la police + facture des soins, retour devant le commissariat, décision 76).
- **Se faire soigner debout** : entrer dans un centre de santé et parler à l'accueil (E) : soins complets pour 15 FCFA par point manquant, 1 500 FCFA au plus (2017) ; durée 5 secondes. Ouvert jour et nuit.
- **Pharmacie** (croix verte, « Pharmacie de l'Étoile », « Pharmacie du Marché », « Pharmacie des Trois Palmiers » — noms de fantaisie) : ouverte 8 h-22 h, une pharmacie de garde la nuit (tirée au sort chaque jour de jeu, indiquée sur la carte).
  - Pansements : 300 FCFA, +20 de santé, 3 dans l'inventaire au plus, utilisables n'importe où (touche à définir dans l'inventaire, 2 secondes, à l'arrêt).
  - Trousse de secours : 1 500 FCFA, +60, 1 au plus.
  - Aucun médicament n'est nommé, aucun effet « dopant ».
- **Proches** : après un 3e évanouissement dans le même chapitre, Maman Koffi appelle au réveil (réplique tirée parmi 5 : « On m'a dit que tu étais encore à l'hôpital. Koffi, tu veux me tuer ? »). Sans effet sur le jeu.
- **Les autres personnages** : un passant ou un adversaire à terre se relève seul après 6 à 20 secondes (décisions 4 et 79). Aucune ambulance jouable ; une ambulance blanche à bande orange (inventée) peut passer dans la circulation, sirène brève, et les véhicules s'écartent.
- Chapitre 3 : file d'attente visible devant les centres de santé, entrée avec cache-nez ; les prix et les règles ne changent pas.
- Test : santé à 0 avec 8 000 FCFA → réveil au centre le plus proche, 7 200 FCFA, santé 100, horloge avancée de 3 heures de jeu ; avec 50 000 FCFA → 48 000 ; avec 0 → 0 ; évanoui en mission → choix proposé, reprise sans facture ; soins à l'accueil avec 60 de santé → 600 FCFA ; 4e pansement refusé à l'achat ; à 2 étoiles, réveil suivi de l'amende et position devant le commissariat.
