# Garage : fonctionnement attendu

Code proposé : `scripts/garage.gd` (rangement des véhicules, réparation, peinture, améliorations), `scripts/carburant.gd` (jauge, stations, kpayo), `scripts/salissure.gd`. Les dégâts existent déjà dans `scripts/car.gd` (compteur de 0 à 100). Vérifications : `scripts/selftest_garage.gd`, avec une moto et une voiture d'essai, tirage fixé.

Cadre : véhicules du jeu : moto, tricycle de livraison, voiture, taxi, minibus, camionnette, camion, pirogue à moteur (décision 55) ; dégâts visibles, pas d'explosion (57) ; carburant : jauge simple, stations officielles chères, kpayo moins cher mais risqué pour le moteur (58) ; Romaric est mécanicien moto (28) ; Tonton Gratien vend des pièces à Missèbo (31) ; garage parmi les propriétés achetables (69) ; on garde ses véhicules après une arrestation (76). Prix en FCFA de la période P1 (2017) ; autres périodes : coefficient de `economie.md` (1,05 ; 1,10 ; 1,20 ; 1,35 ; 1,40), sauf le carburant qui a sa table.

Trois sortes de lieux : **l'atelier de Romaric** (Missèbo ; motos et tricycles ; dès le début), **les garages de quartier** (5 en ville : toutes réparations, peinture ; noms inventés : « Garage La Confiance », « Garage Dieu Merci Auto »…), **le garage personnel** de Koffi (propriété, chapitre 3).

## Garage personnel
- **Avant d'en avoir un** : Koffi a des **places de stationnement** : 1 devant chez Maman Koffi (moto seulement), 1 devant la chambre de Dantokpa. Un véhicule à lui laissé ailleurs y est ramené au bout de 24 h de jeu (« un petit du quartier l'a ramené », 200 FCFA) ou reste retrouvable par son icône sur la carte.
- **Le garage** (Missèbo, 600 000 FCFA au chapitre 3, voir `proprietes.md`) : cour murée de 14 × 10 m, portail coulissant de 4 m, auvent en tôle de 8 × 5 m avec fosse et établi, pièce de rangement. **6 emplacements** au sol (2 sous l'auvent) : chacun accepte une moto, un tricycle, une voiture, un taxi ou une camionnette ; minibus et camion occupent 2 emplacements. Extension au chapitre 5 (300 000 FCFA) : 10 emplacements. La maison de Fidjrossè a 2 emplacements, l'entrepôt 4 (camions).
- **Ranger** : entrer par le portail (il s'ouvre à 6 m devant un véhicule de Koffi) et s'arrêter sur un emplacement libre (marquage au sol) : « Véhicule rangé », sauvegardé avec son état, sa couleur, ses améliorations, son niveau de carburant. Garage plein : message, et proposition de vendre ou de sortir un véhicule.
- **Véhicules empruntés** : un véhicule pris à quelqu'un ne peut pas être rangé (« Celui-là n'est pas à toi. ») : le portail reste fermé. On ne devient propriétaire qu'en achetant (ou par une mission).
- **Sortir** : E sur un véhicule rangé, comme sur un véhicule garé. **Faire livrer** : depuis le téléphone (contact « Romaric Mécano » → « Amène-moi… »), un véhicule rangé est amené à Koffi en 2 à 4 minutes réelles pour 1 000 FCFA (moto) à 3 000 FCFA (voiture) ; pas pendant une mission ni une recherche.
- **Véhicule perdu** : détruit (100 points de dégâts), tombé à l'eau, abandonné loin : il est **récupérable** au garage 12 h de jeu plus tard contre le remorquage (2 000 FCFA moto, 5 000 voiture, 15 000 camion) et dans l'état où il était. Un véhicule possédé n'est jamais perdu pour de bon.
- **Dans son garage**, Koffi répare lui-même ou avec l'apprenti (voir « Réparation ») à **−30 %**, peint et améliore sans attendre les horaires d'ouverture ; pas de carburant sur place, sauf 2 bidons de 5 L en réserve.
- **L'apprenti** (un jeune du quartier, engagé d'office) : il garde la cour, salue, donne l'état des véhicules (« La jaune fume un peu, patron. »).
- **Activité** : le garage répare aussi pour le quartier : c'est son revenu (15 000 FCFA par jour de jeu, `proprietes.md`).
- Interdit d'entrée en cours de recherche si un policier voit Koffi entrer (voir « Peinture »).
- Test : véhicule possédé rangé puis restauré à l'identique après sauvegarde et rechargement (dégâts, couleur, carburant, améliorations) ; 7e véhicule refusé ; camion = 2 emplacements ; véhicule emprunté : portail fermé ; véhicule à 100 points de dégâts : présent au garage 12 h de jeu plus tard contre 5 000 FCFA ; livraison : véhicule à moins de 15 m du joueur en moins de 4 minutes.

## Réparation
- **Où** : atelier de Romaric (motos, tricycles ; 7 h-19 h, et de nuit en le réveillant : +50 %), garages de quartier (tout ; 7 h 30-18 h 30, fermés le dimanche), garage personnel (toujours), dépannage par téléphone (+20 %, sur place).
- **Comment** : arrêter le véhicule sur la dalle marquée (clé plate au sol), moteur tournant ou non ; le texte du bas annonce : « E : réparer — 4 200 FCFA ». E : fondu de 1 s, bruits d'outils, le véhicule ressort à 0 point de dégâts, pièces remises en place (phares, pare-chocs), fumée arrêtée, pneus regonflés. L'horloge avance de 1 minute de jeu par point réparé (30 points = 30 minutes de jeu).
- **Prix** = points de dégâts × tarif du véhicule :

| Véhicule | FCFA par point | De 100 à 0 |
|---|---|---|
| Moto | 100 | 10 000 |
| Tricycle | 150 | 15 000 |
| Pirogue à moteur (à l'embarcadère) | 200 | 20 000 |
| Voiture, taxi | 300 | 30 000 |
| Camionnette, minibus | 400 | 40 000 |
| Camion | 600 | 60 000 |
- Minimum 500 FCFA ; arrondi à 50 au-dessus. **Réductions** : Romaric : −50 % sur la moto qu'il a prêtée, au chapitre 1 (« c'est ma moto que tu casses ») ; garage personnel : −30 % ; pièces achetées chez Tonton Gratien et apportées (« lot de pièces », 3 000 FCFA, 1 par réparation) : −20 % ; les réductions s'ajoutent, plafond −60 %.
- **Réparation partielle** : si l'argent manque, le mécanicien propose de réparer « pour ce que tu as » (par tranches de 10 points) ; en dessous du minimum : refus.
- **Pneus crevés** (herse) : 6 000 FCFA le pneu de moto, 20 000 celui de voiture, en plus.
- **Moteur encrassé au kpayo** (voir « Carburant ») : nettoyage : 5 000 FCFA moto, 15 000 voiture.
- **Rafistolage de bord de route** : Koffi peut, capot ouvert (E à l'avant du véhicule arrêté, 8 s d'animation), ramener un véhicule de 80-100 à **79** points, une fois par panne : de quoi rejoindre un garage (la fumée noire devient blanche). Gratuit ; impossible pendant une recherche à 2 étoiles et plus.
- **Véhicule à 100** : il ne roule plus. Choix : rafistolage (s'il n'a pas déjà servi), dépannage par téléphone (Romaric vient : réparation à +20 %, ou remorquage au garage), ou l'abandonner (récupérable, voir plus haut).
- **Pendant une mission** : réparer est permis si la fiche ne l'interdit pas ; le chronomètre ne s'arrête pas.
- **Pendant une recherche** : les garages de quartier refusent à 1 étoile et plus (« Je ne veux pas d'histoires. ») ; Romaric accepte à 1 étoile.
- Romaric parle pendant toute la réparation (décision 28) : 30 répliques, selon les dégâts et le chapitre.
- Test : moto à 42 points chez un garagiste : 4 200 FCFA, 0 point après, horloge +42 minutes ; même moto prêtée chez Romaric au chapitre 1 : 2 100 ; garage personnel avec lot de pièces : −50 % ; avec 1 500 FCFA : réparation partielle de 10 points proposée (1 000) ; voiture à 100 : immobile, rafistolage → 79, second rafistolage refusé ; refus avec 1 étoile chez un garagiste.

## Peinture
- **Où** : garages de quartier avec l'enseigne au pot de peinture (3 sur 5) et garage personnel (cabine sous l'auvent). Pas chez Romaric.
- **Choix** : écran avec le véhicule qui tourne ; **16 couleurs** en nuancier (blanc, ivoire, gris clair, gris anthracite, noir, rouge, bordeaux, orange, jaune, vert clair, vert bouteille, bleu ciel, bleu roi, bleu nuit, marron, violet), finition mate ou brillante ; pour les voitures : bande latérale d'une seconde couleur (option) ; pour les motos : réservoir et garde-boue. Flèches pour parcourir, E valider, Échap annuler.
- **Prix** : moto 5 000 ; tricycle 8 000 ; voiture 25 000 ; camionnette et minibus 35 000 ; camion 60 000 ; bande ou seconde couleur : +20 %. Durée : fondu, horloge +2 heures de jeu.
- **Couleurs réservées** : jaune à bande verte = taxi (décision 44) : seulement avec la licence de taxi (achat du taxi) ; blanc à bande bleu nuit avec rampe = police : impossible. Peindre un taxi d'une autre couleur lui retire son statut (les clients ne le hèlent plus) ; on peut le repeindre en taxi gratuitement une fois.
- **Inscriptions** (minibus, camions, tricycles) : une devise peinte à l'arrière, à choisir parmi 24 écrites pour le jeu (« La patience est un chemin », « Qui sait l'avenir ? », « On ne se presse pas pour tomber », « Maman a dit »…) : 3 000 FCFA. Pas de saisie libre ; pas de devise religieuse (décision 18).
- **Logo de l'entreprise** (chapitre 5) : le nom de l'entreprise de Koffi peint sur les portières de ses véhicules : gratuit au garage personnel ; +5 % de revenus des livraisons faites avec un véhicule marqué.
- **Fin d'une recherche** (voir `police_et_niveau_de_recherche.md`) : repeindre d'une couleur **différente** met fin à une recherche de 1 à 3 étoiles, à condition d'être entré dans le garage sans être vu d'un policier (aucune ligne de vue dans les 5 s précédentes) ; le garagiste de quartier demande alors le double (« Je n'ai rien vu, mais ça coûte. ») ; refusé à 4 et 5 étoiles. Dans le garage personnel : prix normal. Le véhicule cesse d'être « signalé ».
- La peinture neuve remet la salissure à zéro et efface les rayures ; elle ne répare pas la tôle (un véhicule à plus de 25 points garde ses bosses, repeintes).
- Les motos confiées aux conducteurs peuvent toutes prendre la couleur de l'entreprise en une fois (5 000 par moto).
- Test : voiture rouge repeinte en bleu roi : 25 000 FCFA, couleur changée sur le modèle et restaurée après rechargement, horloge +2 h ; même couleur choisie pendant une recherche : pas de fin de recherche ; couleur différente à 2 étoiles sans être vu : niveau 0 et prix doublé chez un garagiste ; à 4 étoiles : refus ; taxi jaune et vert refusé sans licence ; devise hors liste impossible.

## Améliorations
- **Où** : garage personnel (toutes), atelier de Romaric (motos : niveaux 1 et 2), garages de quartier (niveau 1). Les pièces viennent de la boutique de Tonton Gratien : à partir du chapitre 2, il faut y **commander** la pièce (prête au jour de jeu suivant) ; avoir remboursé sa dette donne −10 %.
- **Familles et effets** (trois niveaux, à acheter dans l'ordre ; les pourcentages s'appliquent aux réglages des documents de conduite) :

| Famille | Niveau 1 | Niveau 2 | Niveau 3 |
|---|---|---|---|
| Moteur | accélération +8 % | +15 %, vitesse maximale +5 % | +22 %, vitesse maximale +10 % |
| Freins | distance de freinage −10 % | −18 % | −25 % |
| Pneus | adhérence sous la pluie et sur la terre : moitié de la pénalité | pénalité divisée par 3 | plus de pénalité sous averse ; résistent une fois à une herse |
| Suspension, châssis | dégâts reçus −10 % | −20 % | −30 % ; marchandise fragile −30 % de casse |
| Réservoir | +25 % de capacité | +50 % | +100 % |
| Filtre et carburation | risque du kpayo divisé par 2 | divisé par 4 | plus de risque |
- **Équipements** (un seul niveau) : porte-bagages renforcé (moto : 3 colis au lieu de 2) ; caisse arrière (moto : marchandise à l'abri de la pluie) ; bâche (tricycle, camionnette) ; phare longue portée (+50 % de portée) ; klaxon à deux tons (plaisir seulement) ; poste radio de guidon (moto, chapitre 2) ; galerie de toit (voiture, taxi : +2 colis ou bagages) ; antivol (le véhicule n'est jamais « ramené par un petit du quartier » : il reste où on l'a laissé).
- **Prix P1** : moto : 8 000 / 20 000 / 45 000 par famille ; voiture et taxi : × 3 ; camionnette et minibus : × 4 ; camion : × 6 ; tricycle : × 1,5 ; pirogue : moteur et réservoir seulement, × 2. Équipements : 3 000 à 15 000 (moto), 10 000 à 40 000 (voiture).
- **Limites** : la moto la plus améliorée reste moins rapide qu'une voiture de série (103 km/h contre 122) ; aucune amélioration ne rend un véhicule indestructible ; pas de nitro, pas de blindage, pas d'armement (décisions 2 et 3).
- **Aspect** : chaque niveau de moteur change un détail visible (pot d'échappement), les pneus ont un dessin différent, la suspension relève la caisse de 3 cm ; le son du moteur gagne en grave au niveau 3.
- **Pose** : 1 heure de jeu par niveau ; impossible pendant une coupure de courant au garage personnel (sauf groupe électrogène).
- **Flotte** : une moto confiée avec filtre niveau 1 et pneus niveau 1 tombe en panne deux fois moins souvent (`economie.md`).
- Les améliorations sont attachées au véhicule, sauvegardées, et comptent pour 50 % de leur prix à la revente.
- Test : moto de série : 50 km/h après 1 s ; moteur niveau 1 : 54 ; niveau 3 : 61 et 103 km/h au plus ; freins niveau 3 : arrêt depuis 90 km/h en 11,6 m ± 0,5 au lieu de 15,4 ; réservoir niveau 2 : 12 L au lieu de 8 ; niveau 2 refusé sans le niveau 1 ; prix voiture = 3 × prix moto ; pièce non commandée au chapitre 2 : pose refusée.

## Carburant et stations-service
- **Jauge simple** (décision 58) : arc sous le compteur de vitesse, de plein à vide ; orange sous 25 %, rouge clignotant sous 10 % avec une réplique de Koffi. Les véhicules de la circulation n'ont pas de jauge ; un véhicule emprunté a entre 30 et 90 % de son réservoir.
- **Réservoirs et consommation** (réglages de jeu : la ville est condensée, on consomme plus vite qu'en vrai pour que le plein compte) :

| Véhicule | Réservoir | Distance par litre | Autonomie | Carburant |
|---|---|---|---|---|
| Moto | 8 L | 2,5 km | 20 km | essence |
| Tricycle | 12 L | 1,8 km | 22 km | essence |
| Voiture, taxi | 30 L | 1,5 km | 45 km | essence |
| Camionnette, minibus | 45 L | 1,0 km | 45 km | gazole |
| Camion | 120 L | 0,5 km | 60 km | gazole |
| Pirogue | voir « Navigation sur l'eau » | | | essence |
- Consommation +30 % au-dessus de 80 % de la vitesse maximale, +20 % à pleine charge ; au ralenti à l'arrêt : rien. Une journée de zémidjan (10 courses) consomme environ 1 L (500 FCFA).
- **Prix du litre** :

| Période | Station officielle | Kpayo |
|---|---|---|
| P1 (2017) | 530 | 400 |
| P2 (2018-2019) | 560 | 400 |
| P3 (2020) | 520 | 375 |
| P4 (2021-2022) | 600 | 450 |
| P5 (2023-2024) | 700 | 600 |
| P6 (2025-2026) | 700 | 550 |
- Gazole : prix de la station +25 FCFA ; pas de gazole au kpayo avant le chapitre 4.
- **Stations officielles** (marque inventée « Pétro-Golfe », auvent rouge et blanc) : 6 en ville, sur les boulevards, ouvertes 24 h sur 24 ; KwabôPay accepté dès le chapitre 2. S'arrêter à moins de 2,5 m d'une pompe, moteur coupé d'office : « E : le plein — 3 180 FCFA » ou flèches pour choisir 1 000, 2 000, 5 000 FCFA ou le plein. Remplissage : 2 L par seconde, on peut relâcher avant la fin. Pompiste en combinaison ; petite boutique (eau, Fizi). Pas de vente pendant une coupure de courant (quartier) ni à 2 étoiles et plus.
- **Vendeuses de kpayo** (décision 5 : c'est un des trafics du jeu, montré comme un commerce de rue) : étals en bois avec bouteilles et bonbonnes de verre remplies d'essence jaune, entonnoir à filtre de tissu ; environ 30 en ville, dans les rues de quartier, 6 h-22 h ; espèces seulement ; vente **au litre** (bouteille de 1 L) ou à la bonbonne de 5 L ; pas de marchandage au litre, un échange possible à partir de 10 L. La vendeuse verse elle-même : 1 L par seconde.
- **Risque du kpayo** : chaque litre a une « qualité » tirée par étal et par jour de jeu : bonne (70 % des étals), moyenne (22 %), mauvaise (8 %). La part de mauvaise essence dans le réservoir fait monter un compteur d'**encrassement** (0 à 100) : +0 par litre bon, +2 moyen, +6 mauvais (réservoir de moto ; proportionnel à la taille du réservoir pour les autres). Effets : à 30 : le moteur tousse (ratés sonores, accélération −10 %) ; à 60 : calages au ralenti (1 démarrage sur 4 échoue : il faut rappuyer), accélération −20 %, fumée grise ; à 100 : panne, comme un véhicule à 100 points de dégâts côté moteur. L'encrassement baisse de 1 par litre d'essence de station brûlé ; nettoyage au garage : remise à zéro (voir « Réparation »). Une vendeuse fidélisée (5 achats) prévient : « Celle d'aujourd'hui n'est pas bonne, prends peu. »
- Le kpayo ne s'enflamme jamais et n'explose jamais dans le jeu (décision 57, et `physique_du_decor.md`).
- **Police** : acheter du kpayo n'est pas poursuivi ; transporter plus de 4 bidons (missions de contrebande) l'est (`moteur_de_missions.md`).
- **Panne sèche** : le moteur coupe, le véhicule roule sur son élan. Solutions : pousser (E maintenu derrière, 1 m/s ; une moto se pousse à 2 m/s) ; aller à pied remplir un **bidon de 5 L** (500 FCFA le bidon vide, une fois) ; appeler Romaric (livraison de 5 L : prix du kpayo + 1 000 FCFA) ; un vendeur ambulant de kpayo passe à moto après 3 minutes réelles si Koffi reste près du véhicule (prix double). On n'est jamais bloqué.
- **Histoire** : au chapitre 5, la hausse brutale du kpayo (table) est commentée par la radio et les passants ; au chapitre 3, files aux stations (3 à 6 véhicules, 20 s d'attente).
- Test : moto, réservoir plein : panne sèche après 20 km ± 1 à 40 km/h ; plein de 6 L en P1 à la station : 3 180 FCFA en 3 s ; même plein au kpayo : 2 400 ; 8 L de mauvaise qualité : encrassement 48, ratés présents, accélération −10 % ; 20 L de station brûlés ensuite : encrassement 28 ; nettoyage : 0 ; station fermée pendant une coupure ; panne sèche : vendeur ambulant présent après 3 minutes ; aucun événement « feu » ou « explosion » après un choc sur un étal de kpayo.

## Lavage
- **Salissure** : compteur de 0 (propre) à 100 par véhicule possédé ou conduit. Elle monte de : +1 par km sur goudron sec ; +4 par km sur terre (« vons ») ; +8 par km sur terre mouillée ; +10 par traversée de zone inondée ; +3 par jour de jeu garé dehors (× 3 sous harmattan : +9) ; rien dans un garage. La pluie retire 10 points par heure de jeu aux véhicules dehors (jusqu'à 30 au plus bas : la pluie ne lave pas tout).
- **Aspect** : à partir de 30, voile de poussière ocre sur le bas de caisse ; 60 : projections de boue jusqu'aux vitres, plaque peu lisible ; 90 : couleur à peine visible, quelqu'un a écrit « LAVE-MOI » du doigt sur la vitre arrière (voitures).
- **Où laver** :
  - **laveurs de rue** : 8 emplacements (bord de lagune, carrefours, près des stations), 7 h-18 h : des jeunes avec seaux et éponges ; s'arrêter sur la dalle, E. Moto 200 FCFA, tricycle 300, voiture 500, camionnette et minibus 1 000, camion 1 500 ; durée : 20 s réelles, animées (Koffi descend, discute ; passable avec Entrée) ; résultat : salissure 0 ;
  - **station de lavage** d'une station Pétro-Golfe (2 en ville, 24 h sur 24) : jet haute pression, +50 % du prix, 5 s ;
  - **soi-même** au garage personnel ou devant son logement : gratuit, 30 s réelles, E maintenu (seau et éponge), salissure ramenée à 10.
- **À quoi ça sert** (effets mesurés, modestes mais réels) :
  - clients : taxi à plus de 60 de salissure : 1 client sur 3 refuse de monter ; zémidjan à plus de 80 : pourboires supprimés ; véhicule à moins de 20 : +5 de satisfaction de départ ;
  - contrôles routiers : plaque illisible (salissure 60 et plus) : arrêt systématique et 500 FCFA de contravention ;
  - revente : −5 % au-dessus de 60 ;
  - recherche : un lavage ne change rien au niveau de recherche (ce n'est pas une peinture) ;
  - missions : certaines exigent un véhicule propre (conduire Nan Akouavi à une cérémonie) ;
  - Kpôlè : une photo de véhicule propre et repeint plaît davantage (`telephone_du_joueur.md`).
- Les laveurs ont 12 répliques ; un pourboire de 100 FCFA (E pendant la fin du lavage) : +1 de réputation de quartier, une fois par jour de jeu.
- Le lavage ne répare rien et n'efface ni bosses ni rayures.
- Véhicules de la circulation : salissure tirée entre 0 et 70 à leur création, selon le quartier et la météo des derniers jours.
- Test : 10 km de terre sèche : salissure +40 ; 3 jours garé sous harmattan : +27 ; 3 jours au garage : +0 ; pluie de 2 heures de jeu sur un véhicule à 80 : 60 ; à 20 : reste 20 (plancher de 30 non franchi vers le bas : inchangé) ; laveur de rue : 500 FCFA pour une voiture et salissure 0 ; lavage maison : 10 ; taxi à 65 : refus de 25 à 40 % des clients sur 200 tirages ; contrôle routier à 60 : contravention de 500.

## Choix faits par Claude (à confirmer)
- Un véhicule possédé n'est jamais perdu : remorquage payant et retour au garage.
- Rafistolage de bord de route (100 → 79 points) pour ne jamais rester bloqué.
- Consommations de jeu plus fortes que la réalité ; prix du litre proches des prix réels, accordés au tutoriel (530 et 400 FCFA en 2017).
- Kpayo : risque par « qualité du jour » de l'étal et compteur d'encrassement, jamais de feu.
- Station inventée « Pétro-Golfe ».
