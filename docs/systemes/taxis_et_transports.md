# Taxis et transports : fonctionnement attendu

Code proposé : `scripts/transport.gd` (lignes, arrêts, montée et descente du joueur), `scripts/taxi.gd` (métier de taxi), circulation dans `scripts/trafic.gd`. Vérifications : `scripts/selftest_transport.gd`, sur une ligne d'essai de 1 200 m avec 3 arrêts, tirage fixé.

Transports en commun du jeu : zémidjan (voir `service_de_zemidjan.md`), taxi-ville, minibus « tokpa-tokpa », autocar. Koffi peut en être passager ; il peut conduire le taxi et le minibus comme métier (décision 67). Temps : 1 heure de jeu = 2 minutes réelles.

## Taxi-ville
- Voiture jaune à bande verte (décision 44), lanterne « TAXI » sur le toit, 4 places passagers. Une voiture sur douze de la circulation est un taxi ; un sur deux roule avec 1 à 3 passagers.
- **Héler** : X maintenu 0,6 s à pied (X bref = zémidjan). Le taxi libre le plus proche dans un rayon de 80 m vient s'arrêter à 3 m ; sinon un taxi est créé hors champ à 100-150 m. Délai : 6 à 20 s le jour, 15 à 40 s entre 23 h et 5 h. Mêmes refus que pour le zémidjan (niveau de recherche, destination à moins de 80 m, mission).
- E près de la portière arrière droite : choix de la destination (même liste que le zémidjan), puis choix de la formule :
  - **Place** (taxi partagé) : prix fixe par zone (voir « Tarifs »), pas de marchandage. Le taxi peut s'arrêter jusqu'à 2 fois pour prendre ou déposer d'autres passagers (10 s par arrêt) et ne fait pas de détour de plus de 150 m. Disponible seulement si la destination est à moins de 150 m d'un boulevard ou d'une avenue.
  - **Course privée** (« dépôt ») : trajet direct jusqu'au point choisi, prix à la distance, marchandage en trois échanges (prix annoncé à 130 %).
- Trajet : vue extérieure, taxi à 50 km/h au plus, bloqué dans les embouteillages (décision 61 : c'est le défaut du taxi face au zémidjan). Mêmes commandes qu'en zémidjan : Entrée maintenue pour passer le trajet (horloge +1 minute de jeu par 50 m), E pour descendre avant (prorata en course privée, prix plein en place).
- La radio du taxi joue une station au hasard ; le joueur peut en changer (voir `radio_en_voiture.md`).
- Sous forte pluie, le taxi est l'abri : aucun malus, alors que le zémidjan majore de 20 %.
- Emprunter un taxi occupé suit la règle commune (décision 54) ; les passagers descendent et s'enfuient.
- Test : X maintenu fait venir un taxi et non un zémidjan ; place Dantokpa-Ganhi au prix de zone exact ; course privée de 1 000 m au chapitre 1 : 3 300 ramené au plafond de 3 000, annoncé 3 900 avant marchandage ; deux arrêts intermédiaires au plus ; détour mesuré inférieur à 150 m ; dans un embouteillage simulé le taxi met au moins 2 fois plus de temps qu'un zémidjan.

## Minibus tokpa-tokpa
- Minibus de 14 places, carrosserie de couleur libre (blanc, bleu clair, beige), nom de ligne peint sur une planchette derrière le pare-brise. Un apprenti se tient à la porte latérale et crie la destination (« Tokpa, Tokpa, Tokpa ! », « Étoile, Étoile ! »).
- **Trois lignes**, toutes au départ de Dantokpa (« tokpa-tokpa » : du marché… au marché) :
  | Ligne | Parcours | Longueur de jeu | Fréquence |
  |---|---|---|---|
  | A | Dantokpa – Missèbo – Ganhi – Marina – Place de l'Amazone | 2,4 km | un départ toutes les 4 minutes réelles |
  | B | Dantokpa – Étoile Rouge – aéroport – Fidjrossè | 4,2 km | toutes les 5 minutes réelles |
  | C | Dantokpa – pont – Akpakpa | 2,6 km | toutes les 4 minutes réelles |
- Service de 5 h 30 à 22 h. Aux heures de pointe, fréquence doublée et minibus pleins (voir ci-dessous).
- Le minibus roule à 40 km/h au plus, s'arrête à chaque arrêt marqué (8 à 15 s) et **à la demande** : un passant ou le joueur qui lève le bras (X) à moins de 20 m de sa route le fait s'arrêter s'il a de la place.
- **Monter** : E à la porte latérale quand le minibus est arrêté. Koffi paie à l'apprenti en montant (prix fixe, voir « Tarifs »). Il choisit son arrêt de descente dans la liste des arrêts restants ; il peut aussi appuyer sur E en route (« Apprenti, je descends ! ») : arrêt au prochain endroit possible, dans les 40 m.
- **Plein** : aux heures de pointe, un minibus sur trois arrive plein ; l'apprenti fait signe que non, le minibus ne s'arrête pas. Il faut attendre le suivant.
- À l'intérieur : vue extérieure par défaut ; touche V : vue par la fenêtre. Ambiance sonore : conversations de passagers (voir `pietons.md`), radio du chauffeur.
- Passer le trajet : Entrée maintenue, horloge +1 minute de jeu par 40 m (le minibus est lent : c'est le transport le moins cher).
- Le minibus sert à découvrir la carte : chaque arrêt desservi pendant qu'on est à bord est ajouté aux lieux découverts.
- Cas limites : minibus bloqué par une inondation : terminus anticipé, tous les passagers descendent, pas de remboursement. Niveau de recherche gagné à bord : le chauffeur s'arrête et l'apprenti fait descendre Koffi.
- Test : les trois lignes passent par tous leurs arrêts dans l'ordre ; arrêt à la demande à moins de 20 m de la route, pas à 30 m ; prix débité à la montée ; descente à l'arrêt choisi, à moins de 6 m du poteau ; hors service à 23 h (aucun minibus créé) ; un minibus plein ne s'arrête pas.

## Bus
- La décision 55 ne prévoit pas d'autobus pilotable. Le « bus » du jeu est l'**autocar interurbain** d'une compagnie inventée, « Atlantique Voyages » (livrée blanche et orange, 12 m × 2,5 m, 50 places). Il n'est jamais conduit par le joueur.
- **Gare routière** : à Étoile Rouge, une cour avec 3 quais, un guichet (bâtiment où l'on n'entre pas : on parle au guichetier par la fenêtre), une salle d'attente ouverte, des vendeuses d'eau et de pain.
- **Rôle en ville** : décor vivant. Un autocar entre ou sort de la gare toutes les 6 minutes réelles (6 h-20 h), suit la route la plus large vers la sortie nord ou la route de l'ouest, à 45 km/h, sans arrêt. Il est prioritaire de fait : la circulation s'écarte.
- **Rôle de voyage** : quand les autres villes existeront (décision 87 : Porto-Novo, Ouidah, Abomey), l'autocar est le voyage rapide par la route. E au guichet, choix de la ville, paiement, fondu au noir, arrivée à la gare de la ville. Durées (horloge du jeu) et prix : voir « Tarifs ». Parakou se fait en avion (décision 56) ou, au chapitre 5, en camion (décision 88) ; l'autocar ne la dessert pas pour ne pas faire doublon.
- Tant que les villes n'existent pas, le guichetier répond « Les routes sont en travaux, repasse plus tard » et rien n'est vendu.
- Pas de voyage avec un niveau de recherche, ni pendant une mission (sauf mission qui le demande).
- Le véhicule que Koffi a laissé près de la gare est rangé à son garage ou, s'il n'en a pas, retrouvé à la gare au retour.
- Test : un autocar toutes les 6 minutes réelles ± 30 s entre 6 h et 20 h, aucun la nuit ; il ne s'arrête qu'en gare ; le guichet refuse avec 1 étoile ; avec une ville débloquée, le voyage débite le prix exact, avance l'horloge de la durée prévue et place Koffi à la gare d'arrivée.

## Arrêts
- **Arrêt de minibus** : un poteau avec une planchette de couleur (A rouge, B bleu, C vert), parfois un banc et un abri en tôle (un arrêt sur trois). Zone d'arrêt de 12 m le long du trottoir, où la circulation ne se gare pas.
- Arrêts par ligne (nom affiché en montant et sur la carte) :
  - A : Dantokpa (tête), Missèbo, Ganhi-Marché, Ganhi-Banques, Marina, Place de l'Amazone (tête).
  - B : Dantokpa, Saint-Michel, Étoile Rouge, Cadjèhoun, Aéroport, Fidjrossè-Plage (tête).
  - C : Dantokpa, Pont (rive ouest), Pont (rive est), Akpakpa-Marché, Akpakpa-Dépôt (tête).
- Écart entre deux arrêts : 350 à 700 m.
- **Tête de ligne** : 2 à 4 minibus garés en file, moteur arrêté ; le premier part quand il est plein ou à l'heure de départ. Les apprentis rabattent les clients. On y trouve une vendeuse d'eau et un parc de zémidjans (4 à 8 motos garées, conducteurs assis dessus).
- **Station de taxis** : 3 emplacements marqués à Ganhi-Banques, à l'aéroport et à Place de l'Amazone ; il y a toujours au moins un taxi libre de 6 h à 22 h (pas besoin de héler).
- **Parc de zémidjans** : aux têtes de ligne, devant Dantokpa, à Étoile Rouge ; zémidjan immédiat.
- **Passants aux arrêts** : 0 à 6 personnes attendent selon l'heure (6 aux heures de pointe) ; elles montent dans le minibus qui s'arrête, autant qu'il a de places.
- Sur les cartes : icône « minibus » de la couleur de la ligne (voir `carte_et_gps.md`). Un arrêt apparaît dès qu'on passe à moins de 40 m.
- Chapitre 4 (chantiers, décision 91) : l'arrêt Étoile Rouge est déplacé de 80 m (palissades) ; au chapitre 6, les arrêts des boulevards rénovés ont tous un abri neuf.
- Test : 17 arrêts créés, chacun à moins de 3 m d'un trottoir et hors carrefour (plus de 15 m) ; aucune voiture garée dans les zones d'arrêt ; nombre de passants en attente conforme à l'heure ; une station de taxis n'est jamais vide en journée.

## Tarifs
Prix de jeu, proches des prix réels de chaque période (décision 63). Tous multiples de 50.

| Transport | Chapitres 1-3 (2017-2020) | Chapitres 4-6 (2021-2026) |
|---|---|---|
| Zémidjan | 100 + 2 FCFA/m, de 100 à 1 000 | identique (décision 64) |
| Minibus, par trajet, quelle que soit la distance sur la ligne | 150 | 200 |
| Taxi, place partagée, même zone | 200 | 300 |
| Taxi, place partagée, zone voisine | 300 | 400 |
| Taxi, place partagée, deux zones ou plus | 500 | 600 |
| Taxi, course privée | 300 + 3 FCFA/m, arrondi à 100, de 500 à 3 000 | 400 + 3 FCFA/m, de 600 à 3 500 |
| Taxi depuis l'aéroport (privée seulement) | minimum 2 000 | minimum 2 500 |
| Autocar Porto-Novo (1 h 30 de jeu) | 1 000 | 1 200 |
| Autocar Ouidah (1 h 30 de jeu) | 1 000 | 1 200 |
| Autocar Abomey (4 h de jeu) | 3 000 | 3 500 |

- Zones du taxi partagé : Centre (Ganhi, Marina, Place de l'Amazone, port), Marché (Dantokpa, Missèbo), Ouest (Étoile Rouge, aéroport, Fidjrossè), Est (Akpakpa).
- Majoration de nuit (22 h-5 h) : +50 % sur le taxi, arrondi à 50. Pas de majoration sur le minibus (il ne roule pas).
- Chapitre 3 (ville à l'arrêt, décision 95) : minibus limités à 7 passagers et prix à 250 FCFA ; taxis partagés à 2 passagers et +100 FCFA par place.
- Chapitre 2 : la hausse provoquée par Monsieur Fortuné (décision 94) s'applique aux livraisons, pas aux transports de personnes.
- Paiement : espèces ; KwabôPay accepté par les taxis à partir du chapitre 4, par l'autocar dès le chapitre 2, jamais par les minibus.
- Koffi sans argent : il ne monte pas (« Mon frère, ici on paie d'abord »).
- Test : table de 12 cas (transport, chapitre, distance, heure) comparée aux prix calculés ; tous les prix sont multiples de 50 ; course privée de 100 m = 600 → 600 ; de 2 000 m = 6 300 → 3 000 ; de nuit 3 000 → 4 500.

## Travail comme taxi
- Disponible au chapitre 2, après la mission où Koffi obtient son permis. Deux façons :
  - **Taxi loué** à la station de Ganhi-Banques : E sur un taxi marqué « à louer », 3 000 FCFA de versement par jour de jeu au propriétaire (prélevé au retour du taxi, avant 22 h ; en retard : 1 000 FCFA de pénalité et taxi refusé le lendemain).
  - **Taxi à soi** : acheté chez le vendeur de voitures à partir du chapitre 4 (voir `economie.md`).
- En service : au volant d'un taxi, sans niveau de recherche. La lanterne s'allume (touche **N** pour se mettre hors service et l'éteindre).
- **Clients** : mêmes règles d'apparition que pour le zémidjan (`service_de_zemidjan.md`, « Clients qui hèlent »), mais ils hèlent en disant « Taxi ! » et ne réagissent qu'à un taxi. Arrêt à moins de 6 m, sous 4 km/h.
- **Course privée** (40 % des clients) : un client ou un groupe de 2 à 4, une destination, prix selon le tarif, marchandage possible. Tant que la course dure, on ne prend personne d'autre.
- **Place partagée** (60 %) : le client annonce sa zone (« Akpakpa ! »). On peut prendre jusqu'à 4 clients ; chacun a sa destination, marquée d'une colonne numérotée 1 à 4, et paie le prix de place à sa descente. Un client à bord depuis plus de `distance directe / 6 m/s + 60 s` s'impatiente ; 30 s de plus et il descend sans payer au premier arrêt.
- **Satisfaction** (course privée) : comme en zémidjan, avec en plus : −10 par passage dans une rue inondée profonde, +5 si la radio joue (n'importe quelle station).
- **Dégâts** : au-delà de 50 points de dégâts, les clients refusent de monter (« Ta voiture-là fume ! ») ; il faut réparer (`garage.md`).
- Bagages : les clients de l'aéroport et de la gare routière ont des valises ; ouverture du coffre automatique, 4 s de plus à la montée et à la descente, +200 FCFA.
- **Revenu visé** : 12 000 à 18 000 FCFA par jour de jeu avant versement et carburant, soit environ 7 000 à 10 000 nets, le double du zémidjan.
- **Chauffeur de minibus** (même décision 67), résumé : à partir du chapitre 3, E sur un minibus en tête de ligne ; on suit la ligne dans l'ordre des arrêts (colonnes de couleur), l'apprenti encaisse ; recette = 150 ou 200 FCFA par passager monté, dont 40 % pour le chauffeur ; un tour complet rapporte 1 500 à 3 000 FCFA au joueur ; sauter un arrêt où quelqu'un attend : −200 FCFA ; arriver en tête de ligne avec plus de 3 minutes réelles de retard sur l'horaire : part du chauffeur ramenée à 30 %.
- Cas limites : niveau de recherche gagné avec des clients : ils crient, et descendent dès que le taxi passe sous 10 km/h, sans payer. Taxi loué abandonné : retrouvé à la station le lendemain, versement et pénalité dus.
- Test : lanterne allumée seulement en service ; 4 clients partagés au plus, le cinquième ne monte pas ; chacun paie le prix de sa zone à sa descente ; client retenu trop longtemps : parti sans payer ; versement de 3 000 débité au retour du taxi ; clients refusés à 51 points de dégâts ; tour de ligne A complet avec 20 passagers à 150 FCFA : 1 200 FCFA pour le joueur.

## Choix faits par Claude (à confirmer)
- Le « bus » est un autocar interurbain non pilotable (compagnie inventée « Atlantique Voyages »), puisque la décision 55 ne liste pas d'autobus. C'est un neuvième modèle de véhicule à prévoir, hors liste des véhicules pilotables.
- Trois lignes de minibus au départ de Dantokpa ; noms d'arrêts tirés de vrais quartiers (décision 24).
- Touche N : lanterne de taxi (hors service).
