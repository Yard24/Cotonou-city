# Avion et voyages : fonctionnement attendu

Rien n'est encore codé. Code prévu : `scripts/voyage.gd` (billets, trajets, changement de ville), `scripts/cine_vol.gd` (cinématique de vol), `scripts/ville.gd` (chargement d'une ville). Vérifications prévues : `scripts/selftest_voyage.gd`.

Rappel des décisions : pas d'avion ni d'hélicoptère pilotable ; **l'avion fait l'aller-retour Cotonou-Parakou comme voyage rapide** (56) ; autres villes plus tard, réduites : Porto-Novo, Ouidah, Abomey, Parakou (87) ; la route du Nord du chapitre 5 est un long trajet en camion avec étapes, pas une carte libre (88) ; compagnies, hôtels et marques inventés (25) ; monuments simplifiés, sans inscription réelle (26) ; l'aéroport est le 7e quartier construit (84).

Choix de Claude : la compagnie fictive s'appelle « Ailes du Borgou » (avion blanc à dérive orange) ; les cars sont ceux de « Trans-Nokoué Voyages » ; l'avion n'est ouvert qu'après la première arrivée à Parakou par la route (chapitre 5), pour que le long trajet en camion garde son sens.

## Aéroport de Cotonou
- Emplacement : à l'ouest de la carte, entre Ganhi et Fidjrossè, le long de la route de la plage. Emprise dans le jeu : 900 × 350 m (piste de 800 × 40 m orientée est-ouest, parallèle à la mer, tarmac de 200 × 120 m, aérogare de 90 × 30 m sur 2 niveaux, parking de 80 places, rond-point d'accès).
- Ce que voit le joueur dehors : la clôture grillagée de 2,5 m tout autour (infranchissable, voir « Physique du décor »), le parking, la file de taxis jaunes à bande verte (10 places), le coin des zémidjans à l'extérieur de la barrière (ils n'entrent pas sur le parking), des vendeuses de cartes de téléphone et d'eau, des familles qui attendent. Un avion décolle ou atterrit toutes les 20 minutes réelles (vers l'ouest le plus souvent), audible à 800 m.
- **Parking** : barrière automatique. 200 FCFA l'entrée en moto, 500 FCFA en voiture (2023), payés à la sortie au guichet (arrêt de 2 secondes). Un véhicule du joueur garé là y reste pendant son voyage, sans frais de plus.
- **Aérogare** (intérieur visitable, décision 92) : hall de 60 × 20 m, 9 m sous plafond ; 2 comptoirs « Ailes du Borgou », 4 comptoirs d'autres compagnies inventées (fermés, décor), un tableau des vols (4 lignes qui défilent : Parakou et trois destinations de décor, « Niamey », « Lomé », « Abidjan », jamais jouables), une buvette (jus 500 FCFA, sandwich 1 500 FCFA : l'aéroport est cher), 30 sièges, des toilettes (porte fermée), le contrôle de sécurité (portique, tapis), la salle d'embarquement vitrée avec vue sur le tarmac.
- **Zones interdites** : tarmac, piste, tours et hangars. Portes verrouillées ; un agent en bleu nuit devant chaque accès (« C'est réservé au personnel. »). Insister (3 tentatives) : 1 étoile. Il n'existe aucun moyen de monter dans un avion autrement que par l'embarquement.
- **Métiers** : c'est le meilleur point de prise en charge pour le taxi (courses longues, 1 500 à 3 000 FCFA) ; à zémidjan, on prend les clients à l'extérieur de la barrière.
- **Ouverture** : le quartier est construit et visitable dès qu'il est modélisé, mais les comptoirs n'ouvrent qu'au chapitre 5 (avant : « Pas de vol pour l'intérieur du pays en ce moment. »). Horaires des comptoirs : 5 h-20 h.
- **La ville change** (décision 91) : façade ancienne aux chapitres 1 à 3, palissades de chantier au chapitre 4, façade vitrée et auvent neufs aux chapitres 5 et 6.
- **Police** : arriver à l'aéroport avec 2 étoiles ou plus : barrière fermée, agents à l'entrée ; pas d'embarquement avec 1 étoile ou plus.
- Cas limites : l'avion ne peut pas être touché, ni la piste atteinte, même en sautant d'un toit (plafond invisible au-dessus de la clôture) ; véhicule abandonné devant le hall plus de 2 minutes : déplacé à la fourrière du parking, 1 000 FCFA.
- Test : le héros ne peut atteindre aucun point de la piste ni du tarmac (essai sur 50 points de départ autour de la clôture) ; avant le chapitre 5, E au comptoir affiche le message de fermeture ; la barrière prélève 200 FCFA à la sortie en moto ; à 21 h les comptoirs sont fermés ; 3 tentatives sur une porte interdite donnent 1 étoile.

## Achat de billet
- Où : comptoir « Ailes du Borgou » (E devant l'hôtesse), ou par le téléphone à partir du chapitre 5 (application de voyage, paiement KwabôPay), ou au petit aérodrome de Parakou pour le retour.
- **Vols** : Cotonou → Parakou à 7 h, 12 h et 17 h ; Parakou → Cotonou à 9 h, 14 h et 19 h. Chaque jour de jeu. 48 places ; le vol n'est jamais complet pour le joueur.

| Billet | Prix 2023 | Prix 2025 |
|---|---|---|
| Aller simple | 38 000 FCFA | 42 000 FCFA |
| Aller-retour (retour libre pendant 30 jours de jeu) | 68 000 FCFA | 75 000 FCFA |
| Changement d'horaire | 3 000 FCFA | 3 000 FCFA |
| Bagage de plus de 20 kg (colis de livraison) | 500 FCFA le kilo | 500 FCFA le kilo |

- Écran d'achat : destination (une seule), aller simple ou aller-retour, heure du vol parmi ceux qui restent aujourd'hui et demain, prix, mode de paiement (espèces au comptoir, KwabôPay partout). Confirmation : le billet apparaît dans le téléphone (« Vol AB 204 — Cotonou-Parakou — 12 h 00 — Embarquement 11 h 40 »).
- **Embarquement** : ouvert de 40 minutes de jeu avant le vol jusqu'à 10 minutes de jeu avant (soit de 80 à 20 secondes réelles avant le départ : c'est court, donc le comptoir propose aussi **« Attendre le vol »**, qui fait avancer l'horloge jusqu'à l'embarquement). Le joueur passe le portique à pied (E), puis la cinématique démarre.
- **Vol manqué** : billet reporté une fois sans frais sur le vol suivant ; ensuite 3 000 FCFA.
- **Remboursement** : avant l'embarquement, 80 % du prix, au comptoir seulement.
- **Ce qu'on emporte** : la tenue, le téléphone, l'argent, l'inventaire de poche, un colis de 20 kg. Les véhicules restent à Cotonou ; à Parakou, Koffi retrouve les véhicules qu'il y a laissés ou achetés (un garage par ville). Les bâtons et planches ramassés sont laissés au portique (« Ça, ça reste ici. »).
- **Refus de vente** : niveau de recherche de 1 étoile ou plus ; mission en cours qui interdit de quitter la ville ; argent insuffisant (l'hôtesse indique le prix du car : 8 000 FCFA) ; chapitre inférieur à 5 ; Parakou jamais atteinte par la route.
- **Faux papiers** : ce trafic existe dans des missions écrites seulement (décision 5) ; au comptoir, aucun papier n'est demandé au joueur.
- Cas limites : achat à 19 h 30 → billet pour le lendemain 7 h ; deux billets pour le même vol → refusé ; billet retour acheté à Cotonou et jamais utilisé → expire après 30 jours de jeu, sans remboursement, avec un rappel dans le téléphone 3 jours avant.
- Test : avec 38 000 FCFA au chapitre 5, l'aller simple est vendu et l'argent tombe à 0 ; avec 37 999 FCFA, refus ; avec 1 étoile, refus ; « Attendre le vol » place l'horloge à 11 h 40 pour le vol de 12 h ; un billet non utilisé est reporté gratuitement une fois, puis coûte 3 000 FCFA ; remboursement avant embarquement = 30 400 FCFA.

## Cinématique de vol
- L'avion n'est jamais piloté (décision 56) : le vol est une courte séquence, **28 secondes** au premier voyage, **12 secondes** ensuite, et on peut la passer en maintenant E 1 seconde dès le deuxième voyage (le premier est obligatoire, il sert de découverte).
- Avion : bimoteur à hélices de 48 places, ailes hautes, blanc à dérive orange, sans marque réelle ; 9 000 triangles (catégorie « bus, camion » relevée).
- Plans (version longue) :
  1. 0-4 s — Koffi traverse le tarmac à pied dans la file des passagers et monte la passerelle arrière ; caméra basse, à 12 m, côté gauche.
  2. 4-9 s — Roulage et décollage vers l'ouest ; caméra fixe en bout de piste, l'avion passe au-dessus (bruit qui enfle puis s'éloigne).
  3. 9-15 s — Vue par le hublot, place 9A : l'aile, l'hélice, Cotonou en dessous — la plage, la lagune et ses trois ponts, le lac et le village lacustre. La carte du jeu est affichée en version très simplifiée (niveau de détail le plus bas, brume couleur sable). Koffi commente (5 répliques tirées au sort, la première fixe : « Hé ! C'est comme ça que les oiseaux nous voient ? »).
  4. 15-21 s — Carte du pays stylisée, en aplats : un trait orange avance de Cotonou à Parakou (environ 320 km à vol d'oiseau), avec les noms des étapes de la route du Nord déjà visitées. L'horloge du jeu défile dans un coin.
  5. 21-28 s — Descente au-dessus d'une savane arborée plus sèche et plus rouge, atterrissage à Parakou ; fondu.
- Version courte : plans 2, 4 et 5 raccourcis à 4 secondes chacun.
- **Temps de jeu** : le vol dure 1 heure de jeu (départ 12 h, arrivée 13 h). Par comparaison, le car prend 7 heures de jeu et le camion du chapitre 5 une journée avec étapes.
- **Pendant la séquence** : aucune commande sauf passer ; la sauvegarde automatique se fait à l'arrivée ; la ville d'arrivée se charge derrière les plans 3 à 5 (voir « Chargement des villes ») — si le chargement n'est pas fini, le plan 4 (la carte) est prolongé, sans écran figé.
- **Radio et téléphone** : coupés pendant le vol ; les messages reçus arrivent d'un coup à l'atterrissage.
- **Météo** : par harmattan, la vue du hublot est voilée ; par orage, léger tremblement de caméra (3 cm) et une réplique inquiète. Aucun incident de vol, jamais.
- **Retour** : mêmes plans en sens inverse, arrivée par la mer ; plan du hublot au coucher du soleil pour le vol de 19 h.
- Sous-titres toujours affichés (décision 105).
- Test : la séquence complète dure 28 s ± 0,5 s au premier vol et 12 s ± 0,5 s ensuite ; maintenir E au premier vol ne la passe pas, au deuxième si ; à la fin, le héros est à Parakou, l'horloge a avancé de 1 heure de jeu, la sauvegarde automatique a été écrite ; un chargement artificiellement ralenti de 10 secondes prolonge le plan 4 sans image figée de plus de 0,5 s.

## Arrivée à Parakou
- Parakou, grande ville du nord, est réduite comme les autres (décision 87) : **1,5 × 1,2 km**, ouverte au chapitre 5. Ambiance différente de Cotonou : air plus sec, terre plus rouge, arbres de savane (karités, nérés, manguiers), moins de circulation, beaucoup de camions, des motos-taxis en chemise d'une autre couleur que le jaune de Cotonou (verte et jaune, choix de Claude, à confirmer). Aucun parti, aucune enseigne réelle.
- Lieux prévus : l'aérodrome (piste de 600 m, aérogare d'un seul niveau de 30 × 12 m, parking de terre), le grand marché central (simplifié), la gare routière et le **parc à camions** (fin de la route du Nord), la base de Koffi (« Dépôt Koffi Transport — Parakou », achetable au chapitre 5 : entrepôt et garage), un maquis (« Maquis Le Karité » : igname pilée 700 FCFA, fromage peul grillé 500 FCFA, +40 et +25 de santé), l'hôpital de zone, un commissariat, une station-service, un hôtel inventé (« Hôtel Les Routiers », 6 000 FCFA la nuit : point de sauvegarde tant que le dépôt n'est pas acheté), 2 quartiers d'habitation, la voie ferrée désaffectée et sa gare (décor).
- **Sortie de l'avion** : fondu, Koffi est debout devant l'aérogare, sac à l'épaule, il est 13 h (pour le vol de 12 h). Sauvegarde automatique. Message : « Parakou — le Nord ». À la première arrivée, courte scène de 15 secondes : un contact (chauffeur de son dépôt, ou un zémidjan si le dépôt n'est pas acheté) l'attend avec une pancarte mal orthographiée (« KOFI »).
- **Se déplacer** : motos-taxis devant l'aérodrome (course vers le centre 300 FCFA, 2023) ; si le joueur possède un véhicule à Parakou, il est garé sur le parking ; sinon location d'une moto à l'aérodrome, 2 500 FCFA le jour de jeu, caution 20 000 FCFA.
- **Ce qui est propre à chaque ville** : véhicules présents, propriétés, réputation par quartier (Parakou compte 3 quartiers : centre, marché, parc à camions), niveau de recherche (remis à zéro à l'arrivée : la police de Parakou ne connaît pas les affaires de Cotonou), commerces. **Ce qui suit Koffi** : argent, KwabôPay et banque, téléphone, tenue, inventaire de poche, santé, statistiques, missions.
- **Recettes** : les motos confiées à Cotonou continuent de rapporter pendant l'absence (décision 68) ; les versements arrivent par KwabôPay.
- **Appels** : les proches appellent normalement ; les missions qui demandent d'être à Cotonou affichent « à Cotonou » et un raccourci vers l'achat du billet retour.
- **Climat** : pas de mer, pas de lagune ; saison sèche plus marquée (harmattan fort de décembre à février : visibilité 200 m, tenue poussiéreuse deux fois plus vite) ; pluies de mai à septembre seulement.
- Cas limites : arrivée de nuit (vol de 17 h : arrivée 18 h) → les loueurs sont encore là jusqu'à 20 h ; évanouissement à Parakou → réveil à l'hôpital de zone de Parakou, jamais à Cotonou ; si le joueur n'a plus de quoi payer ni l'avion ni le car (moins de 8 000 FCFA), le chauffeur du dépôt ou un camionneur ami le ramène gratuitement (« Monte, on descend sur Cotonou ce soir. ») : trajet de 9 heures de jeu en fondu — on ne peut jamais rester bloqué.
- Test : après le vol, le héros est à la position d'arrivée de l'aérodrome, à 13 h, étoiles à 0, argent inchangé hors billet ; les véhicules de Cotonou ne sont pas présents ; l'inventaire de poche est identique ; s'évanouir à Parakou réveille à l'hôpital de Parakou ; avec 0 FCFA, l'option de retour gratuit apparaît et ramène à Cotonou.

## Trajet routier entre villes
- Trois façons de changer de ville par la route.
- **1. Le car** (voyage rapide bon marché) — gares routières : Étoile Rouge à Cotonou, gare de chaque ville. Compagnie inventée « Trans-Nokoué Voyages », cars blancs et verts de 50 places. Guichet (E), billet, départ toutes les 2 heures de jeu de 6 h à 18 h. Le trajet est un fondu de 6 secondes avec une carte stylisée (la séquence de l'avion, plan 4, sans avion).

| Destination depuis Cotonou | Distance réelle par la route | Prix du car (2023) | Durée en temps de jeu | Ouverture |
|---|---|---|---|---|
| Porto-Novo | environ 35 km | 1 000 FCFA | 1 h | chapitre 4 |
| Ouidah | environ 40 km | 1 000 FCFA | 1 h | chapitre 4 |
| Abomey | environ 135 km | 3 500 FCFA | 3 h | chapitre 5 |
| Parakou | environ 415 km | 8 000 FCFA | 7 h | chapitre 5, après la première arrivée en camion |

- **2. Conduire soi-même sur un tronçon court** (Porto-Novo, Ouidah) : aux sorties de Cotonou (sortie est après Akpakpa, sortie ouest après Fidjrossè) commence un **couloir de route** de 2,5 km jouables : route à 2 voies, villages, postes de péage et de contrôle, vendeuses au bord de la route, camions à doubler. Durée 2 à 3 minutes à 80-100 km/h. Au bout, panneau « Porto-Novo 1 km », fondu de 2 secondes, et on entre en roulant dans la ville d'arrivée, avec son véhicule. Faire demi-tour dans le couloir ramène à la ville de départ.
  - Péage : moto exemptée, voiture 300 FCFA, camionnette 500 FCFA, camion 1 000 FCFA (2023). Passer sans payer : 1 étoile.
  - Contrôle de police au milieu du couloir 1 fois sur 3 : arrêt de 5 secondes, papiers du véhicule (toujours en règle pour un véhicule possédé ; un véhicule emprunté = 2 étoiles). Certains agents acceptent un « petit geste », règles de la décision 77.
  - Carburant : le trajet consomme comme 12 km de ville ; une station au milieu du couloir.
- **3. La route du Nord en camion** (décision 88) : c'est la suite de missions du chapitre 5, avec **6 étapes** — Cotonou, Bohicon, Dassa, Savè, Tchaourou, Parakou. Entre deux étapes : un tronçon jouable de 3 à 4 km (4 à 6 minutes en camion à 60-70 km/h), puis une halte (parc à camions, maquis, mécanicien, point de contrôle = point de sauvegarde). Le détail des événements (sabotages de Capitaine, pannes, contrôles) appartient aux missions du chapitre 5. Une fois la route faite une première fois, on peut la refaire librement en camion pour des livraisons longues (paie 25 000 à 60 000 FCFA selon la charge), ou sauter d'une halte à la suivante en dormant dans la cabine.
- **Abomey** : accessible par le car, ou comme détour à l'étape de Bohicon (couloir de 2 km).
- **Règles communes** : pas de départ avec 1 étoile ou plus ; l'horloge avance de la durée indiquée ; sauvegarde automatique à l'arrivée ; un passager ou un client en cours de course interdit de quitter la ville ; les recettes et les commandes en cours (tailleur) continuent de courir.
- **Sécurité routière et ton** : sur les couloirs, les accidents suivent les règles habituelles (dégâts, pas d'explosion) ; les autres usagers ne meurent jamais ; pas de coupeurs de route armés (décision 3) — les embûches sont des pannes, des contrôles, des troupeaux qui traversent, des camions en panne sur la chaussée et les hommes de Capitaine à mains nues ou en véhicule.
- Cas limites : panne d'essence dans un couloir → un vendeur de kpayo passe à moto au bout de 30 secondes (prix double) ; camion abandonné entre deux étapes → retrouvé à la dernière halte contre 5 000 FCFA de remorquage ; arriver au bout du couloir à pied → message « C'est loin à pied, Koffi. » et mur invisible.
- Test : le car pour Ouidah retire 1 000 FCFA, avance l'horloge de 1 heure et place le héros à la gare d'Ouidah ; le car pour Parakou est refusé avant l'arrivée en camion ; franchir le bout du couloir en voiture → même voiture, mêmes dégâts et même carburant moins la consommation, dans la ville d'arrivée ; péage non payé → 1 étoile ; demi-tour → retour à Cotonou ; avec 1 étoile le guichet refuse.

## Chargement des villes
- **Une seule ville en mémoire à la fois.** Chaque ville est une scène séparée découpée en zones carrées de 250 m (comme Cotonou, tâche T0030) ; les couloirs de route et les haltes du Nord sont de petites scènes de 1 à 2 zones de large.
- **Tailles visées** : Cotonou 6 × 4 km (384 zones) ; Parakou 1,5 × 1,2 km (30 zones) ; Porto-Novo 1,2 × 1 km (20 zones) ; Ouidah 1 × 1 km (16 zones, dont la plage et la route qui y mène) ; Abomey 1 × 0,8 km (12 zones) ; un couloir de route 2,5 × 0,5 km (20 zones étroites).
- **Déroulement d'un changement de ville** :
  1. fondu au noir ou cinématique (0,5 s) ; le jeu est en pause, les commandes coupées ;
  2. sauvegarde de l'état de la ville quittée : position et état des véhicules possédés, propriétés, réputation, objets ramassés, heure — dans la sauvegarde, section `villes.<nom>` ;
  3. libération de la ville quittée (zones, passants, circulation) ;
  4. chargement en arrière-plan de la ville d'arrivée : d'abord la zone d'arrivée et ses 8 voisines (9 zones), puis le reste au fil du jeu (chargement progressif habituel) ;
  5. remise en place de l'état sauvegardé de cette ville, de la circulation et des passants autour du point d'arrivée ;
  6. sauvegarde automatique, puis fin du fondu.
- **Durées visées** : 4 secondes au plus sur le PC de référence au niveau « Moyen », 8 secondes au niveau « Bas » sur disque dur lent. Pendant ce temps : la carte stylisée du trajet (jamais un écran figé), une barre de progression fine, et une astuce ou une image de carte postale débloquée.
- **Mémoire** : après libération, la mémoire utilisée revient à moins de 110 % de ce qu'elle était avant le premier chargement de cette ville (pas de fuite) ; budget visé pour une ville chargée autour du joueur : 1,5 Go au niveau « Bas », 3 Go en « Ultra ».
- **Ce qui continue pendant l'absence** : l'horloge commune à tout le jeu ; les recettes quotidiennes ; les délais (tailleur, location) ; les événements d'histoire datés. Ce qui est figé : la circulation, les passants, la météo de la ville quittée (recalculée au retour d'après la date).
- **Points d'arrivée** : chaque ville en déclare un par moyen de transport (`arrivee_avion`, `arrivee_car`, `arrivee_route_est`…) ; un point d'arrivée est toujours dégagé : la circulation ne peut pas apparaître à moins de 20 m pendant les 5 premières secondes.
- **Échec de chargement** (fichier manquant ou abîmé) : retour à la ville de départ, billet remboursé, message clair (« Le voyage n'a pas pu se faire. Rien n'est perdu. ») et ligne dans le journal d'erreurs (voir « Outils de développement », rapport de plantage).
- **Version publique du chapitre 1** (décision 119) : aucune autre ville ; les gares et l'aéroport affichent leurs messages de fermeture.
- Cas limites : quitter le jeu pendant un changement de ville → au retour, la sauvegarde automatique d'avant le départ est proposée ; changement de ville pendant un appel → l'appel est repoussé à l'arrivée ; changement de niveau graphique pendant le chargement → appliqué à la fin.
- Test : aller-retour Cotonou-Parakou répété 10 fois : aucune erreur, mémoire stable à ±10 %, durée de chaque chargement sous 4 s (machine de test, niveau « Moyen ») ; une moto laissée à Cotonou est retrouvée au même endroit avec les mêmes dégâts ; aucune zone de Cotonou n'est en mémoire à Parakou ; un fichier de ville renommé provoque le retour à Cotonou avec remboursement ; aucun véhicule de circulation à moins de 20 m du point d'arrivée pendant 5 secondes.
