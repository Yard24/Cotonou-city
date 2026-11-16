# Service de zémidjan : fonctionnement attendu

Code : `scripts/zem.gd` (existe : six clients fixes, tarif, course simple ; à étendre), marchandage dans `scripts/marchandage.gd` (à créer, voir `economie.md`), réputation dans `scripts/zem_rep.gd` (à créer). Vérifications : `scripts/selftest_zem.gd` (à créer), sur une rue droite de 400 m sans circulation, avec un tirage aléatoire fixé (`seed(7)`).

Deux usages : Koffi **passager** d'un zémidjan (se déplacer sans véhicule) et Koffi **conducteur** (son premier métier, décisions 11 et 67). Rappels : chemise jaune numérotée (décision 43), casque pour le pilote et le passager (décision 52), tarif 100 FCFA + 2 FCFA par mètre à vol d'oiseau, arrondi à 50, borné de 100 à 1 000 FCFA (décision 64). Temps : 1 heure de jeu = 2 minutes réelles.

## Héler un zémidjan
- Touche **X** à pied (manette : croix directionnelle haut). Koffi lève le bras 1,5 s et lance « Zém ! ». Possible seulement debout, au sol, à moins de 15 m d'une chaussée.
- Le zémidjan libre le plus proche, dans un rayon de 60 m et sans passager, clignote, vient s'arrêter le long du trottoir à 2 m de Koffi. S'il n'y en a aucun, un zémidjan est créé hors du champ de la caméra, à 80-120 m, sur la voie qui mène vers le joueur. Délai garanti : 4 à 12 s en journée, 10 à 25 s entre 23 h et 5 h.
- Pendant l'attente, le texte du bas affiche « Un zém arrive… ». Un second appui sur X annule (le zémidjan repart).
- Arrivé, le conducteur salue (une phrase tirée d'une liste de 8, par exemple « On va où, grand frère ? »). **E** ouvre le choix de destination : liste des lieux déjà découverts (voir `carte_et_gps.md`), triée par distance, plus « Mon repère » si un repère personnel est posé et « Objectif de mission » s'il y en a un. Flèches haut/bas, E pour valider, Échap pour renoncer.
- Refus du service, avec le message correspondant :
  - niveau de recherche à 1 étoile ou plus : « Pas de zém : la police te cherche. » ;
  - destination à moins de 80 m : « C'est à côté, vas-y à pied. » ;
  - pendant une mission qui l'interdit (drapeau `zem_interdit`) ;
  - dans l'eau, dans un bâtiment, déjà dans un véhicule : X ne fait rien.
- Si Koffi s'éloigne de plus de 10 m du zémidjan arrêté ou n'appuie pas sur E en 15 s, le conducteur repart.
- Cas limite : Koffi hèle depuis un terre-plein ou une cour : le zémidjan s'arrête au point de chaussée le plus proche et attend ; le texte indique « Rejoins le zém ».
- Test : X sans chaussée à 15 m : rien. X sur un trottoir avec un zémidjan libre à 40 m : il est arrêté à moins de 3 m du joueur en moins de 12 s. Sans zémidjan à 60 m : un est créé à plus de 80 m et hors champ. Avec 1 étoile : refus et message. La liste ne contient aucun lieu non découvert ni de lieu à moins de 80 m.

## Négociation du prix
- Elle suit la règle commune du marchandage (`economie.md`, section « Marchandage ») : trois échanges au plus (décision 65).
- Prix juste `P` = tarif de la distance. Le conducteur annonce `P × 1,3` arrondi à 50 (au plus 1 300 FCFA, seule exception au plafond de 1 000, puisqu'elle se négocie). Son plancher secret vaut `P × 0,9` à `P × 1,1`, arrondi à 50, tiré à l'arrivée du zémidjan.
- Trois réponses à chaque échange : « D'accord » (touche 1), « Enlève un peu » (2 : −10 % du dernier prix annoncé), « C'est trop, divise » (3 : −25 %). Les montants proposés sont affichés avant de choisir.
- Modificateurs du plancher : nuit (22 h-5 h) +20 % ; forte pluie +20 % ; heures de pointe +10 % ; ils se cumulent, plafond +40 %.
- Conducteur vexé (offre sous 60 % de son plancher, ou troisième refus) : il repart, et Koffi ne peut plus héler pendant 20 s.
- Si Koffi n'a pas en poche (espèces + KwabôPay à partir du chapitre 2) le prix annoncé, les réponses qu'il ne peut pas payer sont grisées ; si même le plancher le plus bas possible (`P × 0,9`) dépasse sa bourse, le conducteur dit « Tu n'as pas l'argent, mon frère » et repart.
- Sans action en 12 s, la négociation est abandonnée (le zémidjan repart, sans pénalité).
- Test : pour 300 m, `P` = 700, annonce 900 ; « D'accord » fixe 900 ; avec le tirage fixé (plancher 700), « Enlève un peu » deux fois aboutit à un accord entre 700 et 800 ; « C'est trop » trois fois : le zémidjan part et X est refusé pendant 20 s ; avec 500 FCFA en poche, les réponses à plus de 500 sont grisées.

## Trajet en passager
- Accord conclu : Koffi monte derrière le conducteur (1,2 s), casqué. La caméra passe en vue extérieure moyenne, tournable librement.
- Le zémidjan suit l'itinéraire le plus court sur le réseau routier (même calcul que le GPS), à 45 km/h en ligne droite, 25 km/h dans les virages, et remonte les files par l'axe de la route à 18 km/h (décision 61). Il respecte les piétons. Il ne tombe jamais.
- Commandes du passager :
  - **Entrée maintenue 1 s** : « Passer le trajet » : fondu au noir de 1,5 s, arrivée immédiate ; l'horloge avance de **1 minute de jeu par 60 m de route** (2 km = 33 minutes de jeu). Interdit pendant un objectif chronométré.
  - **E** : « Dépose-moi ici » : le zémidjan s'arrête au prochain endroit possible (moins de 30 m), Koffi paie le prix convenu au prorata de la distance parcourue, arrondi à 50 au-dessus, 100 FCFA au moins.
  - **Maj** : « Accélère, chef » : 60 km/h au lieu de 45 pendant le reste du trajet, +100 FCFA sur le prix, dit une seule fois par trajet.
- Koffi commente le trajet (décision 107) : une réplique toutes les 20 à 40 s, tirée selon le quartier traversé et l'heure.
- Arrivée : arrêt à moins de 5 m du point choisi, côté trottoir ; Koffi descend à droite.
- Cas limites : route inondée impraticable (voir `jour_nuit_et_meteo.md`) : le conducteur prend un détour, et s'il n'y en a pas, dépose Koffi au bord de l'eau au prorata. Niveau de recherche gagné en route (impossible en passager, sauf mission) : le conducteur s'arrête et fait descendre Koffi sans payer. Appel entrant : il se prend normalement.
- Test : trajet de 400 m en ligne droite : arrivée en 30 à 45 s, à moins de 5 m du but, joueur à pied à droite de la moto ; « Passer le trajet » : arrivée en moins de 3 s et horloge avancée de 6 à 7 minutes de jeu ; « Dépose-moi ici » à mi-chemin : prix payé = moitié du prix convenu arrondie à 50 au-dessus ; « Accélère » : vitesse de 55 à 60 km/h et +100 FCFA ; aucune chute sur 50 trajets simulés avec circulation.

Note de calcul : la moto roule en moyenne à 10 m/s ; 60 m prennent donc 6 s réelles, soit 3 minutes de jeu au vrai rythme. On n'avance l'horloge que d'un tiers pour que « passer le trajet » ne fasse pas défiler les journées.

## Paiement
- Le paiement se fait **à l'arrivée**, automatiquement, au prix convenu (plus les 100 FCFA d'« Accélère »). Une ligne s'affiche 3 s : « Course : −600 FCFA ».
- Chapitre 1 : espèces seulement. À partir du chapitre 2 : si les espèces ne suffisent pas, le complément est pris sur KwabôPay (frais de 1 %, 10 FCFA au moins, voir `economie.md`), avec le son de notification.
- Pourboire : pendant les 3 s d'affichage, **E** ajoute 50 FCFA (une fois). Un pourboire donne +1 de réputation de quartier (voir le document « Groupes et réputation », autre agent) au plus une fois par jour de jeu.
- Koffi ne peut pas se retrouver sans de quoi payer : le prix a été vérifié à la négociation, et l'argent nécessaire est **réservé** (non dépensable ailleurs) jusqu'à l'arrivée.
- Si la course est interrompue par le jeu (mission qui démarre, évanouissement) : rien n'est payé.
- Test : argent avant − argent après = prix convenu exact ; avec 200 FCFA en espèces et 1 000 sur KwabôPay pour une course à 600 : espèces à 0, KwabôPay à 596 ; E pendant l'affichage retire 50 de plus, un second E ne retire rien.

## Travail comme zémidjan
Base existante : voir `conduite_moto.md`, section « Passager ». Ce qui s'ajoute :
- **Être en service** : sur une moto, sans passager, niveau de recherche à 0. Aucune touche à presser. La chemise jaune (obtenue à la mission « La place parmi les jaunes », chapitre 1) est exigée par les clients qui hèlent ; avant elle, seuls les six clients fixes du début proposent des courses.
- **Déroulement** : approche à moins de 30 m (le client lève le bras), arrêt à moins de 6 m et sous 4 km/h, annonce de la destination et du prix, E pour accepter (décision de Bravo), ou **marchandage** : touche 2 « Ajoute un peu » (+10 %), touche 3 « C'est loin, double presque » (+25 %), selon la règle commune inversée (le client a un plafond secret de `P × 1,0` à `P × 1,25`). Client vexé : il s'en va et aucun client ne hèle dans un rayon de 40 m pendant 30 s.
- **Satisfaction du client**, de 0 à 100, départ à 80, visible par une petite jauge sous le prix :
  - choc qui abîme la moto : −15 ; frôler un piéton à moins de 0,5 m à plus de 30 km/h : −5 ;
  - temps de référence = distance par la route / 8 m/s + 20 s ; chaque seconde au-delà : −1 ; arrivée avant 70 % du temps de référence : +10 ;
  - rouler plus de 3 s à plus de 80 km/h : −10 (une fois) ; sous la pluie le client est plus tendu : pénalités × 1,5.
- **Paiement à l'arrivée** (arrêt à moins de 7 m) : prix convenu ; satisfaction de 90 ou plus : pourboire de 50 FCFA (100 si le prix dépasse 600) ; satisfaction sous 40 : le client retire 100 FCFA (jamais sous 100 FCFA payés) et le dit.
- Chute : course perdue, pas de dédommagement ni d'amende (décision de Bravo), réputation −5.
- **Carburant** : la jauge baisse en travaillant (voir `garage.md`) ; panne sèche avec un client : il descend, paie la moitié au prorata, et s'en va.
- **Recette à Romaric** (chapitre 1 seulement, tant que la moto est prêtée) : 1 000 FCFA par jour de jeu travaillé (au moins une course), prélevés à 20 h ou au premier passage devant l'atelier ensuite. Non payé trois jours de suite : Romaric appelle, sans autre sanction (c'est un ami).
- **Revenu visé** : 8 à 12 courses par jour de jeu, soit 3 500 à 5 000 FCFA, proche de la recette réelle d'un conducteur.
- Test : client plafond 800 pour `P` = 700 : « Ajoute un peu » (750) accepté, « double presque » (900) puis encore : client parti ; trajet sans choc dans le temps : satisfaction ≥ 90 et pourboire de 50 ; deux chocs et 30 s de retard : satisfaction 20 et 100 FCFA retirés ; panne sèche : moitié du prorata ; sans chemise jaune, aucun client mobile ne lève le bras.

## Clients qui hèlent
- Les clients ne sont plus seulement aux six points fixes : n'importe quel passant adulte marchant sur un trottoir peut devenir client.
- **Tirage** : toutes les 4 s, si le joueur est en service et qu'il y a moins de 3 clients actifs, un passant situé à 30-120 m, dans un cône de 120° devant la moto, à moins de 4 m d'une chaussée, est converti avec la probabilité : 0,5 aux heures de pointe (7 h-9 h, 17 h-20 h), 0,3 en journée, 0,15 de 20 h à 23 h, 0,05 de 23 h à 5 h ; × 1,5 sous la pluie ; × 1,5 à moins de 150 m de Dantokpa, d'Étoile Rouge ou d'une tête de ligne de minibus.
- Le client s'arrête au bord du trottoir, se tourne vers la chaussée, lève le bras quand la moto est à moins de 30 m et lance « Zém ! » ou « Kèkènon ! » (voir `dialogues.md`). Point bleu sur la mini-carte.
- Il attend 45 s. Sans arrêt du joueur, un zémidjan de la circulation le prend (s'il y en a un à 40 m) ou il reprend sa marche.
- **Types de clients** (tirage pondéré) :
  | Type | Part | Particularité |
  |---|---|---|
  | Ordinaire | 55 % | rien |
  | Pressé | 15 % | prix +30 %, compte à rebours (distance par la route / 9 m/s + 15 s) ; en retard : prix normal |
  | Chargé (bassine, sac de riz, régime de bananes) | 15 % | +100 FCFA ; moto encore plus lourde (accélération −25 % au lieu de −15 %) |
  | Bavard | 10 % | parle pendant tout le trajet (répliques d'ambiance) ; pourboire certain si satisfaction ≥ 70 |
  | Mauvais payeur | 5 % | à l'arrivée, annonce 100 FCFA de moins ; un marchandage d'un seul échange permet de récupérer le prix |
- Destinations : un lieu à 250-2 000 m par la route, choisi selon l'heure (matin : marchés, écoles pour les parents, bureaux de Ganhi ; soir : quartiers d'habitation ; nuit : maquis).
- Jamais d'enfant client (décision 48). Au moins la moitié des clients sont des femmes (décision 47).
- Les zémidjans de la circulation prennent eux aussi des passagers (un sur trois roule avec un passager casqué).
- Cas limites : client converti puis hors de portée (plus de 200 m) : il redevient passant. Deux clients à moins de 6 m : le plus proche parle, l'autre attend. Niveau de recherche gagné : tous les clients baissent le bras.
- Test : sur 10 minutes simulées en journée, rue fréquentée : entre 5 et 20 clients créés, jamais plus de 3 à la fois, tous à moins de 4 m d'une chaussée et à plus de 30 m du joueur à la création ; aucun de nuit sur 2 minutes simulées dans une rue vide ; répartition des types à ± 10 points sur 500 tirages ; client non servi disparu ou reparti après 45 s.

## Réputation du conducteur
- Note de métier `rep_zem`, de 0 à 100, départ à 20 au retour de Lagos. Elle est distincte de la réputation de quartier. Affichée dans le téléphone (contact « Le Doyen ») et, 3 s, à chaque changement.
- Variations :
  | Événement | Effet |
  |---|---|
  | Course payée | +1 |
  | Satisfaction ≥ 90 | +1 de plus |
  | Client pressé livré à temps | +1 de plus |
  | Satisfaction < 40 | −2 |
  | Client déposé avant l'arrivée (E) | −3 |
  | Chute avec un client | −5 |
  | Renverser un passant en service | −4 |
  | Être arrêté par la police en chemise jaune | −3 |
- Pas plus de +12 par jour de jeu (empêche de monter à 100 en une soirée). Aucune baisse spontanée avec le temps.
- Paliers :
  | Note | Titre | Effet |
  |---|---|---|
  | 0-19 | « Inconnu » | 1 client sur 2 refuse de monter (« Je ne te connais pas ») |
  | 20-39 | « Nouveau » | fonctionnement normal |
  | 40-59 | « Connu au parc » | clients pressés et chargés disponibles ; plafond secret des clients +5 % |
  | 60-79 | « Bon zém » | courses longues (jusqu'à 3 000 m, donc 1 000 FCFA) ; pourboires doublés |
  | 80-100 | « Zém de confiance » | clients réguliers : jusqu'à 3 appels par jour de jeu pour une course réservée payée +50 % ; le Doyen confie les missions secondaires d'arbitrage |
- Les paliers 40 et 60 sont des conditions de missions du chapitre 1 (à fixer par l'agent chargé des missions).
- Sous 20 après le chapitre 1 : le Doyen convoque Koffi (appel), simple dialogue de remontrance ; la note remonte à 20.
- Test : 12 courses parfaites dans la journée : +12 exactement, la treizième ne rapporte rien ; chute : −5 ; bornes 0 et 100 jamais dépassées ; à 19, un client sur deux refuse sur 200 tirages (± 10 %) ; à 80, un appel de client régulier arrive dans les 24 h de jeu.

## Choix faits par Claude (à confirmer)
- Touche X pour héler ; « passer le trajet » avec Entrée maintenue.
- Prix annoncé à 130 % du tarif, donc jusqu'à 1 300 FCFA avant marchandage.
- Recette de 1 000 FCFA par jour à Romaric au chapitre 1.
- « Kèkènon » (conducteur de zémidjan, en fon) à faire valider avec la liste de `dialogues.md`.
