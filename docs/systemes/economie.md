# Économie : fonctionnement attendu

Code : aujourd'hui une variable `money` dans `scripts/main.gd`. Cible proposée : `scripts/argent.gd` (portefeuille, KwabôPay, dette, journal des mouvements), `scripts/prix.gd` (table des prix par chapitre), `scripts/boutique.gd` (interface d'achat), `scripts/marchandage.gd`. Vérifications : `scripts/selftest_economie.gd`, sans décor : opérations sur le portefeuille et tables de prix, tirage fixé.

Cadre : tout en FCFA, prix proches de la réalité de chaque année (décision 63) ; marchandage en trois échanges au plus (65) ; paiement mobile fictif « KwabôPay » à partir du chapitre 2 (66) ; métiers jouables (67) ; motos confiées à des conducteurs (68) ; propriétés (69) ; pas de jeux d'argent ni de paris (70) ; pas d'achat en argent réel (71) ; dette envers Tonton Gratien aux chapitres 1 et 2 (72) ; commerces, banques et marques inventés (25). Unité de code : entier de FCFA (`docs/conventions.md`). Temps : 1 jour de jeu = 48 minutes réelles.

Périodes de prix : P1 = chapitre 1 (2017) ; P2 = chapitre 2 (2018-2019) ; P3 = chapitre 3 (2020) ; P4 = chapitre 4 (2021-2022) ; P5 = chapitre 5 (2023-2024) ; P6 = chapitre 6 (2025-2026). Coefficient général des prix : 1,00 ; 1,05 ; 1,10 ; 1,20 ; 1,35 ; 1,40.

## Argent en FCFA
- **Affichage** : en haut à droite, « 12 500 FCFA », espace entre les milliers, jamais de décimale. Un gain s'affiche 2 s en vert sous le total (« +600 »), une dépense en orange (« −100 »), puis le total défile jusqu'à sa nouvelle valeur en 0,5 s.
- **Plus petite somme** : 25 FCFA (le beignet). Tous les prix sont multiples de 25 ; les prix de 500 et plus sont multiples de 50 ; au-delà de 10 000, multiples de 500.
- **Trois poches** :
  1. **Espèces** : dès le début. C'est le nombre affiché. Plafond : 9 999 975 (affichage sur 7 chiffres).
  2. **KwabôPay** : à partir du chapitre 2 (voir plus bas) ; affiché sous les espèces avec un petit téléphone.
  3. **Compte en banque** (banque inventée « Banque du Golfe », bâtiment visitable à Ganhi, décision 92) : à partir du chapitre 4. Dépôts et retraits au guichet (lundi-vendredi 8 h-16 h, samedi 8 h-12 h) sans frais ; pas d'intérêts ; obligatoire pour tout achat de plus de 2 000 000 FCFA (propriétés, camions). Pas de carte, pas de distributeur : c'est voulu, cela garde un rôle aux espèces et à KwabôPay.
- **Ce que risque chaque poche** : l'évanouissement coûte 10 % des espèces + KwabôPay, 2 000 FCFA au plus (décisions du 16 novembre) ; l'amende de police se calcule sur espèces + KwabôPay (`police_et_niveau_de_recherche.md`) ; le compte en banque n'est jamais touché par les deux. Pas de vol à la tire sur Koffi.
- **Jamais négatif** : aucune opération ne fait passer une poche sous zéro ; un achat impossible est refusé avec la raison (« Il te manque 350 FCFA. »). La seule dette du jeu est celle de Tonton Gratien.
- **Dette envers Tonton Gratien** (décision 72), montants proposés à l'agent chargé de l'histoire : chapitre 1 : 40 000 FCFA (le billet de retour de Lagos et les premiers jours), à rembourser avant la fin du chapitre (décision 93) ; chapitre 2 : 150 000 FCFA (premier tricycle de livraison). Intérêts : 10 % du restant dû tous les 7 jours de jeu, arrondis à 50 (« prête avec intérêts », décision 31). Remboursement à sa boutique de Missèbo, par tranches de 1 000 FCFA au moins, ou par KwabôPay. Une échéance manquée ne déclenche ni violence ni saisie : un appel de l'oncle, puis de Maman Koffi (c'est pire). La dette est affichée dans le journal de missions.
- **Journal des mouvements** : les 50 dernières opérations (date du jeu, libellé, montant, poche), visibles dans l'application KwabôPay du téléphone à partir du chapitre 2 ; avant, dans le carnet de Koffi (menu de pause).
- **Triche et arrondis** : tout calcul de prix arrondit au multiple autorisé le plus proche, au-dessus pour ce que Koffi paie, en dessous pour ce qu'il reçoit ; le test vérifie qu'aucun aller-retour achat-revente ne rapporte.
- **Départ** : 0 FCFA (décision 11). **Repères de richesse visés** en fin de chapitre : 20 000 ; 150 000 ; 500 000 ; 2 500 000 ; 8 000 000 ; 20 000 000 et plus.
- Test : achat de 100 avec 50 : refus et message ; gain de 600 : total exact et affichage « +600 » ; aucune poche négative après 10 000 opérations au hasard ; intérêts de la dette : 40 000 → 44 000 après 7 jours de jeu, 0 si la dette est soldée ; dépôt en banque refusé un dimanche et au chapitre 3 ; tous les prix de `prix.gd` respectent les multiples.

## Boutiques
- **Types de commerces** (tous à nom inventé, décision 25) et où l'on entre :

| Type | Exemples de noms | Où | Heures | On y entre ? |
|---|---|---|---|---|
| Étal ou vendeuse de rue | « Chez Tantie Florence », parasols bleus | partout | 6 h-20 h | non (E devant l'étal) |
| Maquis | « Maquis La Détente », « Chez Da Rose » | tous les quartiers | 11 h-1 h | oui |
| Boutique de quartier | « Alimentation La Grâce » | quartiers | 7 h-22 h | comptoir sur la rue |
| Boutique de vêtements | « Prêt-à-porter Élégance Plus », couturier « Maître Aimé » | Ganhi, Dantokpa | 9 h-19 h | oui |
| Pièces détachées | boutique de Tonton Gratien, Missèbo | Missèbo | 8 h-18 h | oui |
| Vendeur de motos | « Motos du Littoral » | Étoile Rouge | 8 h-18 h | cour ouverte |
| Parc de véhicules d'occasion | « Parc Auto du Port » | près du port | 8 h-18 h | cour ouverte |
| Téléphonie | kiosque « Zékôm » (opérateur inventé) | partout | 7 h-21 h | non |
| Salon de coiffure | « Coiffure Bon Garçon » | Dantokpa, Akpakpa | 8 h-20 h | oui |
| Station-service et kpayo | voir `garage.md` | axes | 24 h / 6 h-22 h | non |
| Quincaillerie | « Quincaillerie Sèmèvo » | Akpakpa | 8 h-18 h | oui |

- Fermé le dimanche : vêtements, pièces détachées, véhicules, quincaillerie, banque. Chapitre 3 : tout ferme à 19 h, maquis en vente à emporter seulement.
- **Entrer en contact** : E devant le vendeur ou le comptoir (2,6 m). Salutation (une réplique), puis la **fiche de boutique** s'ouvre : liste à gauche (nom, prix, petite image), détail à droite (effet, « tu en as 2 »), argent disponible en haut. Flèches, E acheter, 2 marchander quand c'est permis, Échap sortir. Le jeu n'est pas en pause, mais Koffi est immobile et intouchable par la circulation (il est hors chaussée).
- **Achat** : débit immédiat (espèces d'abord, puis KwabôPay si la boutique l'accepte : pastille « KwabôPay accepté »), son de pièces, une réplique du vendeur une fois sur trois. Ce qui se consomme (repas, eau) l'est tout de suite ; ce qui se garde va dans l'inventaire (10 emplacements : pièces, bidon, cadeaux de mission) ou au logement (tenues).
- **Stock** : illimité pour les consommables ; les véhicules d'occasion sont 3 à 5 par parc, renouvelés tous les 3 jours de jeu, chacun avec son état (dégâts de 10 à 40, prix en conséquence) ; tenues : une par modèle.
- **Revente** : seulement les véhicules (au parc d'occasion : 50 % du prix d'achat neuf, moins 0,5 % par point de dégâts, jamais sous 20 %) et les pièces détachées (chez Tonton Gratien : 40 %). Pas de revente de nourriture ni de tenues.
- **Réputation** : dans le quartier où Koffi est bien vu (voir « Groupes et réputation »), −5 % à −10 % d'office ; où il est mal vu, pas de marchandage possible.
- **Le vendeur connaît Koffi** : après 5 achats dans la même boutique, salutation personnalisée et premier échange de marchandage plus favorable (voir « Marchandage »).
- **Pendant une recherche** (1 étoile et plus) : le vendeur refuse de servir.
- **Vendeurs absents** : hors horaires, rideau baissé ou étal bâché ; E affiche les horaires.
- Pas de jeux d'argent, de loterie ni de pari dans aucune boutique (décision 70) ; pas de publicité réelle ni d'achat en argent réel (71).
- Test : boutique fermée à 23 h avec affichage des horaires ; achat débité une seule fois ; KwabôPay refusé là où il n'est pas accepté ; revente d'une moto neuve payée 400 000 avec 20 points de dégâts : 160 000 ; achat puis revente immédiate : perte d'au moins 50 % ; refus de vente avec 1 étoile.

## Prix des biens
- Table de référence en **P1 (2017)**. Pour les autres périodes : prix × coefficient de la période (1,05 ; 1,10 ; 1,20 ; 1,35 ; 1,40), arrondi au multiple autorisé — sauf les lignes marquées « fixe » et le carburant (table propre dans `garage.md`).

| Bien | Prix P1 (FCFA) | Effet ou remarque |
|---|---|---|
| Beignet | 25 | +3 santé |
| Sachet d'eau fraîche | 100 (prix du jeu actuel, fixe en P1-P3 ; 150 ensuite) | +25 santé |
| Bouillie + beignets chez Maman Koffi | 0 pour Koffi (une fois par matin) | +30 santé, une réplique |
| Pain et omelette | 300 | +30 santé |
| Riz sauce dans un maquis | 500 | +50 santé, « bien mangé » |
| Pâte et poisson dans un maquis | 800 | +70 santé, « bien mangé » |
| Poulet braisé (le soir) | 1 500 | santé pleine, « bien mangé » |
| Boisson sucrée (marque inventée « Fizi ») | 300 | +15 santé |
| Crédit téléphone | 200 / 500 / 1 000 | voir `telephone_du_joueur.md` |
| Coupe de cheveux | 500 | apparence (décision 50 : la coiffure oui, le visage non) |
| Tee-shirt, maillot | 1 500 à 3 000 | tenue |
| Chemise en pagne sur mesure | 6 000 | tenue ; prête le lendemain |
| Costume | 45 000 | tenue (chapitres 4 et après) |
| Sandales / chaussures fermées | 1 000 / 8 000 | tenue |
| Casque de moto neuf | 6 000 | remplace le casque abîmé (apparence) |
| Carte de conducteur de zémidjan (chapitre 1) | 2 000, fixe | exigée aux contrôles |
| Bidon de 5 L (vide) | 500 | pour transporter de l'essence |
| Pneu de moto / de voiture | 6 000 / 20 000 | réparation après une herse |
| Téléphone neuf (chapitre 4) | 60 000, fixe | appareil photo meilleur, réseau social |
| Moto d'occasion | 180 000 | dégâts de 10 à 40 à l'achat |
| Moto neuve | 400 000 | |
| Tricycle de livraison (occasion / neuf) | 500 000 / 900 000 | |
| Voiture d'occasion | 1 500 000 | |
| Taxi (voiture d'occasion + peinture + licence) | 1 800 000 | |
| Pirogue à moteur | 600 000 | chapitre 2 et après |
| Minibus d'occasion | 3 500 000 | |
| Camionnette d'occasion | 4 000 000 | |
| Camion d'occasion | 9 000 000 | chapitre 5 |

- Détail des repas et de leurs effets : document « Nourriture et santé » (autre agent) ; en cas d'écart, ce document-là fait foi pour les effets, celui-ci pour les prix.
- **Achat de véhicules** : à partir du chapitre 4 (décision 96), sauf la pirogue (chapitre 2) et le tricycle (chapitre 2, par la dette de Tonton Gratien).
- **Variations** :
  - **marché** : au marché, les prix affichés sont à 115 % et se marchandent ; dans les boutiques à prix fixe (alimentation, téléphonie, station), pas de marchandage ;
  - **heure** : après 18 h, les vendeuses de rue bradent ce qui reste : −20 % sur la nourriture ;
  - **pluie** : parapluie (1 500) vendu par des ambulants qui n'apparaissent que sous la pluie, à 2 000 ;
  - **chapitre 2** (décision 94) : Monsieur Fortuné fait monter le coût du transport : les vivres au marché prennent +10 % de plus pendant le chapitre, et les passants en parlent ;
  - **chapitre 3** : +15 % de plus sur les vivres, pénurie certains jours (un produit sur cinq indisponible, tiré chaque jour de jeu) ;
  - **chapitre 6** : stabilité.
- Les prix sont lus dans une seule table (`prix.gd`) : aucune boutique n'écrit un prix en dur.
- Test : pour 10 biens × 6 périodes, prix = table × coefficient arrondi au bon multiple ; riz sauce P1 = 500, P4 = 600, P5 = 700 (675 arrondi au-dessus), P6 = 700 ; prix du marché affiché = 115 % ; après 18 h, beignets et repas de rue à −20 % ; aucun prix nul ou négatif hors la bouillie de Maman Koffi.

## Revenus des activités
- Objectif d'équilibre : un métier doit rapporter, net de carburant et de versement, **plus que le précédent** et moins qu'une mission principale du même chapitre par heure réelle.

| Activité (décision 67 et 103) | Disponible | Recette brute par jour de jeu bien travaillé | Charges | Net visé |
|---|---|---|---|---|
| Zémidjan | chapitre 1 | 3 500 à 5 000 | recette de Romaric 1 000 (chapitre 1), essence 500 | 2 500 à 4 000 |
| Livraisons à moto (2 colis) | chapitre 1, fin | 6 000 à 9 000 | essence 600 | 5 500 à 8 500 |
| Coiffeur (salon « Bon Garçon ») | chapitre 1 | 300 à 700 par client, 8 clients par séance | aucune | 2 500 à 5 000 par séance de 4 h de jeu |
| Taxi | chapitre 2 | 12 000 à 18 000 | versement 3 000, essence 4 000 | 7 000 à 10 000 |
| Livraisons en tricycle (10 colis) | chapitre 2 | 15 000 à 25 000 | essence 2 000 | 13 000 à 23 000 |
| Chauffeur de minibus | chapitre 3 | 6 tours × 1 500 à 3 000 | aucune (véhicule du patron) | 9 000 à 18 000 |
| Livraisons en camionnette | chapitre 4 | 40 000 à 70 000 | essence 8 000 | 32 000 à 62 000 |
| Camionneur (trajets du port, route du Nord) | chapitre 5 | 80 000 à 150 000 par voyage | gazole 20 000 | 60 000 à 130 000 |
| Dépannage, objets perdus, courses sur la plage | selon missions | 500 à 20 000 par activité | — | — |

- Détail de chaque métier dans son document (« Service de zémidjan », « Taxis et transports », « Moteur de missions » pour les livraisons, « Activités annexes » pour le coiffeur et les autres, autre agent).
- **Motos confiées à des conducteurs** (décision 68), à partir du chapitre 4 :
  - Koffi achète une moto et la confie à un conducteur au parc du Doyen (E sur le Doyen → « Confier une moto ») ; 20 motos au plus.
  - **Recette** : 8 000 FCFA par moto et par jour de jeu (réglage de jeu : une journée de jeu de 48 minutes vaut ici quatre jours de recette réelle à 2 000 FCFA), versée dans une **caisse** chez le Doyen, ou par KwabôPay si Koffi le choisit (frais de 1 %).
  - **Aléas**, tirés chaque jour de jeu par moto : 80 % journée normale ; 10 % panne (pas de recette, réparation de 2 000 à 8 000 à payer pour qu'elle reparte) ; 7 % petite journée (moitié) ; 3 % conducteur indélicat (rien, et il faut lui parler : mission courte de dialogue ou remplacement).
  - **Usure** : chaque moto confiée prend 1 point de dégâts par jour ; au-dessus de 60, panne 2 fois plus fréquente ; révision au garage de Koffi à prix coûtant.
  - Une moto améliorée (voir `garage.md`) tombe moins en panne (5 % au lieu de 10 %).
  - Plus tard, même principe pour tricycles (15 000 par jour), taxis (20 000) et camions (60 000), chapitres 5 et 6.
- **Revenus des propriétés** : voir `proprietes.md` (garage 15 000, boutique 40 000, entrepôt 110 000 par jour de jeu).
- **Règle commune aux revenus passifs** : ils courent avec le **temps joué éveillé** : dormir, attendre ou passer un trajet n'en ajoute pas (sinon dormir en boucle rendrait riche). Une caisse non relevée se remplit jusqu'à 3 jours de recette, puis s'arrête.
- **Dépenses courantes qui équilibrent** : carburant, réparations, repas, amendes, intérêts de la dette, entretien de la flotte ; à partir du chapitre 4, **patente** : 5 % des revenus passifs, prélevés d'office à la caisse et affichés (« Patente : −400 »). C'est l'administration, pas un parti (décision 17).
- Pas de salaire versé pour ne rien faire, pas de gain au hasard (décision 70).
- Test : simulation d'une journée type de chaque métier (script d'entrées) : net dans la fourchette du tableau ; 10 motos confiées sur 100 jours simulés : recette moyenne entre 6 500 et 7 500 par moto et par jour, pannes entre 8 et 12 % ; dormir 3 fois de suite : caisse inchangée ; caisse plafonnée à 3 jours ; patente = 5 % exactement.

## Achat de propriétés
- Cinq types (décision 69). La procédure dans le monde (panneau, visite, clés) est décrite dans `proprietes.md` ; ici, l'argent.

| Propriété | Lieu | Disponible | Prix (FCFA) | Rapporte par jour de jeu |
|---|---|---|---|---|
| Chambre | Dantokpa, cour commune derrière le marché | chapitre 2 | 150 000 | rien (logement) |
| Garage | Missèbo, à côté de l'atelier de Romaric | chapitre 3 | 600 000 | 15 000 |
| Boutique | Dantokpa, allée des tissus | chapitre 4 | 1 500 000 | 40 000 |
| Entrepôt | Akpakpa, zone du port | chapitre 5 | 4 000 000 | 110 000 |
| Maison | Fidjrossè, deuxième rue derrière la plage | chapitre 5, fin | 9 000 000 | rien (logement) |

- Ces prix ne suivent pas le coefficient général : ils sont fixés par l'histoire. Avant la chambre, Koffi loge gratuitement chez Maman Koffi.
- **Paiement** : comptant, en une fois. Jusqu'à 2 000 000 : espèces et KwabôPay ; au-delà : par le compte en banque (il faut être passé déposer l'argent à la « Banque du Golfe »). Frais d'acte : 5 % du prix, payés au même moment au guichet de la mairie d'arrondissement (décor) : c'est le total, frais compris, que le panneau affiche (157 500 pour la chambre).
- **Crédit** : pas de crédit bancaire. Une seule exception écrite par l'histoire : au chapitre 4, Nan Akouavi peut avancer la moitié de la boutique (750 000), remboursée par retenue de 50 % des revenus de la boutique jusqu'à extinction, sans intérêts (elle n'est pas Tonton Gratien).
- **Marchandage** : un seul échange possible avec le vendeur, gain au mieux de 5 % (voir « Marchandage ») ; les frais d'acte ne se marchandent pas.
- **Conditions** : chapitre atteint ; mission de présentation réussie ; aucune dette en retard envers Tonton Gratien ; niveau de recherche à 0.
- **Revente** : impossible (les propriétés servent de points de sauvegarde et de conditions de missions) ; un achat est définitif et confirmé par un écran « Acheter la boutique pour 1 575 000 FCFA ? ».
- **Charges** : aucune charge récurrente autre que la patente de 5 % sur les revenus.
- **Fin « vendre »** du chapitre 6 (décision 98) : la vente de l'entreprise est un événement d'histoire, pas une revente de propriétés par ce système.
- Test : achat refusé avec 157 499 FCFA et accepté avec 157 500 pour la chambre ; achat de l'entrepôt refusé si l'argent est en espèces et accepté s'il est en banque ; propriété marquée « à toi » et argent débité une seule fois ; revenus qui commencent au jour de jeu suivant ; avance de Nan Akouavi : 50 % des revenus retenus jusqu'à 750 000 exactement.

## Paiement mobile fictif
- **« KwabôPay »** (décision 66) : service inventé de l'opérateur inventé « Zékôm ». Couleurs : orange et vert foncé ; logo : une main ouverte stylisée. Aucun rapport de nom ni de logo avec un service réel.
- **Arrivée** : chapitre 2, mission où Afi installe le compte sur le téléphone de Koffi (décision 41) ; cette mission sert de tutoriel. Avant, l'application n'existe pas dans le téléphone.
- **Ce qu'on fait avec** (application du téléphone, voir `telephone_du_joueur.md`) :
  - **Recevoir** : clients (1 client de zémidjan ou de taxi sur 4 propose de payer ainsi au chapitre 2, 1 sur 2 à partir du chapitre 4), paiements de missions, recettes de la flotte ; sans frais pour celui qui reçoit.
  - **Payer** en boutique, là où la pastille « KwabôPay accepté » est affichée (grandes boutiques dès le chapitre 2, maquis et taxis au chapitre 4, presque partout au chapitre 6 ; jamais les vendeuses de beignets ni les minibus) ; frais : 1 % du montant, 10 FCFA au moins, arrondis à 5.
  - **Envoyer** à un contact (Maman Koffi, Afi, Romaric, Tonton Gratien pour la dette) : frais de 1 %, plafonnés à 2 000 FCFA.
  - **Déposer / retirer** des espèces dans un kiosque « Zékôm » (7 h-21 h) : dépôt gratuit ; retrait : 2 % de frais, 50 FCFA au moins.
- **Plafonds** : solde de 2 000 000 FCFA ; 500 000 par opération. Au-delà : la banque.
- **Conditions** : il faut du **réseau** (absent sur la lagune loin des rives, dans les entrepôts fermés du port et pendant certaines missions) et un téléphone chargé ; pendant une coupure de courant de quartier, les kiosques ferment mais les paiements passent. Sans réseau : « Pas de réseau. Paie en espèces. ».
- **Ordre de débit** : en boutique, espèces d'abord ; le joueur peut inverser dans les options de l'application (« Payer d'abord par KwabôPay »).
- **Sécurité** : l'argent sur KwabôPay est touché par les frais d'évanouissement et les amendes comme les espèces. Une mission du chapitre 2 met en scène une **arnaque par message** (« Vous avez reçu 50 000 FCFA par erreur, merci de renvoyer… ») : choix de dialogue ; Afi explique la règle : on ne renvoie rien, on ne donne jamais son code. Ensuite, de faux messages arrivent parfois (1 tous les 5 jours de jeu) ; y répondre fait perdre 1 000 à 5 000 FCFA la première fois seulement (leçon), puis Koffi refuse tout seul avec une réplique.
- **Code secret** : jamais demandé au joueur (pas de saisie) ; Koffi le tape à l'écran en 1 s d'animation.
- **Notifications** : son propre (deux notes montantes), bandeau « KwabôPay : +600 FCFA de 97 •• •• 12 ».
- **Histoire** : au chapitre 3, KwabôPay devient le moyen normal de payer (ville à l'arrêt) : frais supprimés pendant ce chapitre.
- Test : paiement de 600 : frais 10 (1 % = 6, minimum 10) ; de 25 000 : frais 250 ; envoi de 300 000 : frais 2 000 (plafond) ; retrait de 1 000 : frais 50 ; dépôt portant le solde au-dessus de 2 000 000 : refusé ; sans réseau : paiement refusé avec le message ; application absente au chapitre 1 ; second faux message : aucune perte.

## Marchandage
- Petit jeu rapide, **trois échanges au plus** (décision 65). Il sert pour : courses de zémidjan et de taxi (dans les deux sens), achats au marché, véhicules d'occasion, livraisons négociées, propriétés (un seul échange).
- **Ce qu'on voit** : un bandeau en bas : à gauche le vendeur et son **prix annoncé**, à droite trois réponses numérotées avec leur montant, au centre trois petits jetons (les échanges restants) et le visage du vendeur (content, neutre, agacé). Barre de temps de 8 s par échange (réponse par défaut : accepter).
- **Données d'une négociation** (Koffi acheteur) : prix juste `P` ; prix annoncé `A` = `P × 1,3` (marché : `P × 1,15` ; véhicules : `P × 1,1`) ; **plancher secret** `S`, tiré entre `P × 0,9` et `P × 1,1` ; **patience** 3.
- **Réponses** à chaque échange :
  1. « D'accord » : achat au dernier prix du vendeur.
  2. « Enlève un peu » : Koffi propose le dernier prix du vendeur −10 %.
  3. « C'est trop » : Koffi propose le dernier prix du vendeur −25 %.
- **Réaction du vendeur** à une offre `O` :
  - `O ≥ S` : accord à `O`. Fin.
  - `S × 0,6 ≤ O < S` : contre-proposition = milieu entre son dernier prix et `S`, arrondi au multiple autorisé au-dessus ; un jeton en moins ; visage neutre, puis agacé au troisième.
  - `O < S × 0,6` : il est vexé : fin de la négociation. Le prix redevient `A`, à prendre ou à laisser ; au marché, la vendeuse ne marchandera plus avec Koffi avant le lendemain ; un conducteur s'en va.
  - Au troisième échange sans accord : « Dernier prix » = sa dernière contre-proposition, à prendre (1) ou à laisser (Échap).
- **Lecture du jeu** : « Enlève un peu » réussit presque toujours à gratter 10 à 20 % ; « C'est trop » peut gagner plus en un coup mais vexe si le vendeur était déjà près de son plancher. Le visage donne l'indice : content = loin du plancher, agacé = tout près.
- **Koffi vendeur** (courses, livraisons) : mêmes règles en miroir : le client annonce `P`, a un **plafond secret** entre `P × 1,0` et `P × 1,25` ; réponses « D'accord », « Ajoute un peu » (+10 %), « C'est loin, double presque » (+25 %) ; offre au-dessus de `plafond × 1,4` : client vexé.
- **Ce qui déplace le plancher** (ou le plafond, en miroir), cumulable, borné à ±20 % :
  - client fidèle (5 achats ici) : −5 % ; bonne réputation de quartier : −5 % ; mauvaise : +10 % et un seul échange ;
  - tenue : en costume au marché : +10 % (« lui, il a l'argent ») ; en chemise jaune de zémidjan : 0 ;
  - fin de journée au marché (après 18 h) : −10 % ;
  - pluie ou nuit pour un transport : +20 % ;
  - difficulté : « Tranquille » −5 %, « Corsé » +5 %.
- **Phrases** : chaque réponse a 6 variantes dites par Koffi et 6 réactions par type de vendeur (vendeuse de marché, conducteur, vendeur de véhicules), par exemple : « À ce prix-là, tu me livres avec ? » ; « Ajoute un peu, mon frère, l'essence n'est pas l'eau. » ; « Mon fils, c'est le prix d'achat que tu me donnes là. » ; « Prends, c'est parce que c'est toi. » ; « Va voir ailleurs et reviens me dire. ». Jamais de moquerie sur l'origine ou l'accent (décision 104).
- **Sans marchandage** : option des menus « marchandage automatique » : le jeu applique d'office le résultat moyen (`P × 1,1` à l'achat), sans bandeau ; pour qui veut jouer vite.
- Le marchandage ne porte jamais sur une amende officielle (ce serait de la corruption : voir `police_et_niveau_de_recherche.md`).
- Tirage : le plancher est tiré à l'ouverture de la négociation avec le générateur du jeu ; fermer et rouvrir la même négociation dans la même minute de jeu redonne le même plancher (pas de relance gratuite).
- Test (avec `P` = 1 000, `A` = 1 300, `S` forcé à 1 000) : « D'accord » : 1 300 ; « Enlève un peu » : offre 1 170 ≥ 1 000 → accord à 1 200 (arrondi à 50 au-dessus) ; `S` forcé à 1 100, « C'est trop » : offre 975, entre 660 et 1 100 → contre-proposition 1 200, puis « Enlève un peu » : 1 080 < 1 100 → contre-proposition 1 150, puis troisième échange : « Dernier prix 1 150 » ; `S` = 1 100 et offre forcée à 600 : vexé, prix 1 300 ; jamais plus de 3 échanges sur 1 000 négociations au hasard ; prix final toujours entre `S × 1,0` et `A` ; même plancher à la réouverture.

## Choix faits par Claude (à confirmer)
- Trois poches (espèces, KwabôPay, banque à partir du chapitre 4) ; pas de carte ni de distributeur.
- Prix des véhicules proches des prix réels ; prix des propriétés et recette des motos confiées (8 000 par jour de jeu) réglés pour le rythme du jeu, la journée ne durant que 48 minutes.
- Les revenus passifs courent avec le temps joué éveillé, pas pendant le sommeil.
- Montants de la dette (40 000 puis 150 000, 10 % par semaine de jeu) proposés à l'agent chargé de l'histoire.
- Noms inventés : Zékôm, Banque du Golfe, Fizi, Motos du Littoral, Parc Auto du Port.
