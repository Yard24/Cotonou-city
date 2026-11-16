# Groupes et réputation : fonctionnement attendu

Rien n'est encore codé. Code prévu : `scripts/reputation.gd` (valeurs, paliers, effets), `scripts/groupe.gd` (groupes, zones, alliances). Vérifications prévues : `scripts/selftest_reputation.gd`.

Rappel des décisions : comédie d'action réaliste (2) ; **aucune arme à feu** (3) ; passants jamais tués (4) ; trafics du jeu : kpayo, marchandises du port, faux papiers (5) ; **aucun parti, aucun élu, aucune élection** — le pouvoir, c'est l'administration : douane, mairie, police (17) ; corruption d'individus seulement, toujours réprimée (19) ; pas de moquerie sur une ethnie, une religion ou un accent (104) ; adversaires battus assis et sonnés (79).

Conséquence, choix de Claude : il n'y a **pas de « gangs »** au sens des jeux du genre. Les groupes sont des **corps de métier et des réseaux d'affaires**, sans appartenance ethnique, religieuse ni politique. Leurs conflits portent sur le travail, les prix et les places ; ils se règlent par la négociation, la concurrence, la combine et, au pire, la bousculade à mains nues.

## Groupes fictifs
- Huit groupes. Chacun a un nom, une couleur de repère sur la carte, un chef, un lieu, une tenue qui le rend reconnaissable, et ce qu'il apporte à Koffi.

| Groupe | Chef | Siège | Tenue ou signe | Ce qu'ils font |
|---|---|---|---|---|
| **Les Zems** (conducteurs de zémidjan) | Le Doyen | abri sous le grand arbre, Étoile Rouge | chemise jaune numérotée (décision 43) | parcs de stationnement, courses, entraide ; arbitrage du Doyen |
| **Les Dames du marché** | Nan Akouavi | allée des tissus, Dantokpa | pagne et foulard | commerce de gros, crédit, livraisons |
| **Les Mécanos de Missèbo** | Tonton Gratien (pièces), Romaric (atelier) | rue des pièces détachées, Missèbo | bleu de travail taché | réparation, pièces, prêts avec intérêts |
| **Les Gens de l'eau** (pêcheurs et piroguiers) | le chef des pêcheurs, « Vieux Sèna » | village lacustre | chapeau de paille large | pêche, passage, pirogues |
| **Les Routiers** (camionneurs) | « Tantie Gasoil », patronne d'un parc à camions | parc à camions du port, puis Parakou | serviette autour du cou | transport lourd, route du Nord |
| **Le Transit** (transitaires du port) | Monsieur Fortuné ; Expédit en est membre | immeuble « Fortuné Transit & Logistique », Ganhi | chemise blanche, badge | dédouanement, entrepôts, prix du transport |
| **Les Gros Bras** (hommes de main de Fortuné) | Capitaine | entrepôt du port | polo gris, lunettes noires | intimidation, sabotage — jamais d'arme à feu |
| **L'Administration** (police, douane, mairie) | Adjudant Barnabé pour la police | commissariat central, Ganhi | bleu nuit, écusson fictif (décision 45) | contrôles, amendes, autorisations |

- **Relation de Koffi avec chaque groupe** : une valeur de **−100 à +100**, 0 au départ (sauf Zems +10 grâce à Romaric, Mécanos +10, Transit 0, Gros Bras −10, Administration 0). Cinq paliers : hostile (−100 à −50), méfiant (−49 à −10), neutre (−9 à +19), ami (+20 à +59), frère (+60 à +100).
- **Ce qui fait bouger la valeur** : missions (de ±5 à ±20, écrit dans chaque mission) ; travailler pour le groupe (course de zem réussie +0,2 chez les Zems, livraison à l'heure +1 chez le donneur d'ordre) ; nuire à un membre (bousculer −2, frapper −5, abîmer son véhicule ou son étal −3) ; rendre service dans la rue (dépanner un zem en panne +3) ; rembourser Tonton Gratien à l'heure (+5 chez les Mécanos).
- **Effets par palier**, exemples :
  - Zems — ami : les collègues préviennent des barrages (icône sur la carte à 300 m) ; frère : n'importe quel zem prend Koffi gratuitement et un zem proche gêne « par hasard » le véhicule qui le poursuit, 1 fois par poursuite ; hostile : plus de clients aux parcs, le Doyen convoque Koffi.
  - Dames du marché — ami : −10 % dans les boutiques de Dantokpa ; frère : crédit jusqu'à 50 000 FCFA sans intérêt ; hostile : étals fermés à Koffi.
  - Mécanos — ami : réparations −15 % ; frère : dépannage gratuit une fois par jour de jeu.
  - Gens de l'eau — ami : pirogues prêtées gratuitement ; frère : repêchage sans passer par le centre de santé (réveil sur la berge avec 30 de santé, sans facture).
  - Routiers — ami : livraisons longues mieux payées (+10 %) ; frère : place garantie dans les parcs à camions.
  - Transit — monte et descend avec l'histoire ; un bon niveau donne des dédouanements plus rapides, jusqu'à la trahison d'Expédit (chapitre 4).
  - Gros Bras — toujours négatif ; plus c'est bas, plus ils surveillent Koffi (voir « Comportement des adversaires »).
  - Administration — n'est pas une « faction » qu'on achète : la valeur traduit le casier de Koffi. Haute : contrôles plus courts (3 secondes au lieu de 8), amendes à tarif normal ; basse : contrôles plus fréquents (×2), fouille du chargement. Proposer de l'argent ne fait jamais monter cette valeur (décisions 19 et 77).
- **Affichage** : dans le téléphone, application « Contacts », un écran par groupe : le chef, la jauge, le palier, les trois derniers événements (« +3 — tu as dépanné un collègue à Akpakpa »).
- **Membres dans la rue** : un passant sur six appartient visiblement à un groupe (tenue). Leurs salutations changent selon le palier (4 répliques par palier et par groupe).
- Ce qu'on ne fait jamais : rejoindre les Gros Bras ; affronter l'Administration en tant que groupe ; faire disparaître un groupe. Aucun groupe n'a de drapeau, de signe de la main, ni de « couleurs » à porter.
- Cas limites : valeur bornée à −100 et +100 ; un événement de mission peut verrouiller un palier (les Zems ne tombent pas sous « neutre » avant la fin du chapitre 1, pour ne pas bloquer le métier de départ) ; les gains de petites actions sont plafonnés à +5 par jour de jeu et par groupe (pas de moulin à réputation).
- Test : au départ, les valeurs sont celles de la liste ; dépanner un zem ajoute 3 ; 30 courses réussies le même jour n'ajoutent pas plus de 5 ; frapper un mécano retire 5 chez les Mécanos et rien ailleurs ; à +20 chez les Mécanos, une réparation de 2 000 FCFA coûte 1 700 ; les Zems ne descendent pas sous −9 pendant le chapitre 1 ; les valeurs sont identiques après sauvegarde et rechargement.

## Réputation par quartier
- En plus des groupes, chaque quartier a une **réputation de Koffi auprès des habitants**, de **−100 à +100**, 0 au départ sauf Dantokpa +15 (c'est son quartier d'enfance, décision 9). Quartiers : Ganhi, Marina, Dantokpa, Missèbo, Étoile Rouge, Akpakpa, le port, Fidjrossè, l'aéroport, le village lacustre ; plus tard les quartiers des autres villes.
- **Ce qui la fait monter** : mission secondaire rendue à un habitant (+3 à +8) ; objet perdu rapporté (+4) ; course de zem ou livraison réussie qui se termine dans le quartier (+0,2, plafonné à +3 par jour de jeu) ; acheter chez les vendeuses (+0,1 par achat, plafonné à +1 par jour) ; victoire au foot ou à l'awalé (voir activités) ; tenue traditionnelle (voir vêtements) ; aider une personne signalée par une icône bleue (pousser une voiture en panne, porter un sac : +2).
- **Ce qui la fait baisser** : bousculer un passant à pied (−1), le renverser avec un véhicule (−4), renverser un étal (−3, ramené à −1 si on dédommage), bagarre devant témoins (−2 si Koffi frappe le premier, 0 s'il se défend), rouler sur le trottoir à plus de 20 km/h (−1 par passant qui doit s'écarter), klaxonner sans arrêt plus de 5 secondes devant un lieu de culte, une école ou un centre de santé (−1), arrestation dans le quartier (−3).
- **Oubli** : chaque jour de jeu, une réputation négative remonte de 1 vers 0 (les gens oublient) ; une réputation positive ne redescend pas toute seule.
- **Paliers et effets** :

| Palier | Valeur | Effets |
|---|---|---|
| Indésirable | −100 à −50 | les vendeuses refusent de servir ; les passants s'écartent à 6 m ; un témoin appelle la police à la moindre bousculade ; pas de clients de zem dans le quartier |
| Mal vu | −49 à −10 | prix +10 % ; marchandage plus dur (plancher relevé de 10 %) ; un client de zem sur deux refuse la course |
| Inconnu | −9 à +19 | rien |
| Connu | +20 à +59 | les passants saluent ; marchandage plus facile (plancher abaissé de 5 %) ; les témoins n'appellent plus la police pour une simple bousculade |
| Enfant du quartier | +60 à +100 | prix −10 % ; un repas offert par jour ; après une poursuite, les habitants indiquent une fausse direction aux hommes de Capitaine (ils perdent la trace 5 secondes plus tôt) — jamais à la police |

- La réputation de quartier **n'agit pas sur la police** (un agent droit reste droit) : elle agit sur les habitants, les prix, les clients et les témoins.
- **Affichage** : sur la grande carte, un petit visage par quartier (5 expressions) ; en entrant dans un quartier, son nom s'affiche 3 secondes avec le palier s'il a changé depuis la dernière visite. Les variations s'affichent en petit au-dessus de la minicarte (« Dantokpa +2 »), groupées sur 2 secondes.
- **Radio parlée** (décision 111) : au-dessus de +60 ou en dessous de −50 dans un quartier, la station parlée glisse une phrase (« Les commerçantes de Dantokpa saluent un jeune livreur toujours ponctuel… » ou « À Akpakpa, on se plaint d'un chauffard à moto… »).
- Cas limites : une action à la frontière de deux quartiers compte pour celui où se trouve Koffi ; pendant une mission écrite, les pertes dues à des événements imposés ne sont pas comptées ; en difficulté Tranquille, les pertes sont divisées par deux.
- Test : renverser un étal à Dantokpa fait passer de 15 à 12, dédommager remonte à 14 ; à −50, l'achat chez une vendeuse est refusé ; à +60, un article à 1 000 FCFA coûte 900 ; 20 achats le même jour n'ajoutent que 1 ; une valeur de −30 vaut −20 dix jours de jeu plus tard ; une valeur de +30 est inchangée dix jours plus tard.

## Territoires
- Choix de Claude : pas de guerre de territoires ni de quartiers « à prendre » par la force. Un « territoire » est une **zone d'activité** : un endroit où un groupe travaille et a ses habitudes. La carte en compte une quarantaine.
- **Types de zones** :
  - **Parcs de zémidjans** (14) : un coin de carrefour avec 4 à 8 places. Chaque parc a ses habitués. Koffi peut y attendre des clients (un client toutes les 20 à 40 secondes au lieu de 60 à 120 ailleurs) si le parc l'accepte : chapitre 1, le parc de Dantokpa seulement ; les autres s'ouvrent par mission secondaire, par le palier « ami » chez les Zems, ou par une cotisation au parc de 500 FCFA par semaine de jeu.
  - **Allées du marché** (6, Dantokpa) : tissus, vivres, quincaillerie, friperie, poisson, tontines. Les Dames du marché y font la loi : on n'y roule pas (moto poussée à la main à 2 m/s), on n'y court pas aux heures d'affluence sans faire baisser la réputation.
  - **Rues de mécanos** (4, Missèbo et Akpakpa).
  - **Embarcadères et eaux de pêche** (6).
  - **Parcs à camions** (3 : port, sortie nord, Parakou).
  - **Zones du Transit** (5 : entrepôts du port, quais, immeuble de Ganhi) : privées, clôturées, gardées par les Gros Bras. Y entrer sans raison : avertissement, puis expulsion (voir « Comportement des adversaires »).
  - **Zones de l'Administration** : commissariats, douane, mairie, aéroport — règles de la police.
- **Ce que voit le joueur** : pas de frontières peintes dans le monde. Sur la grande carte, un filtre « Activités » colore légèrement les zones à la couleur du groupe ; en y entrant, le nom de la zone s'affiche 3 secondes (« Parc des zems de l'Étoile Rouge — chez le Doyen »).
- **Présence de Koffi Transport** : à partir du chapitre 2, Koffi gagne des **points d'attache** — pas des territoires, des emplacements de travail : une place de moto dans un parc, un quai d'entrepôt, un garage. Chaque point d'attache donne une recette ou un service (une moto confiée à un conducteur rapporte 1 500 FCFA par jour de jeu en 2018, décision 68). On les obtient par achat, par location (cotisation), ou par mission.
- **La pression de Fortuné** : au fil des chapitres, le Transit **rachète ou fait fermer** des zones : un parc de zems transformé en parking payant « Fortuné Parking » (chapitre 2), une rue de mécanos menacée d'expulsion (chapitre 4), des quais réservés (chapitre 4), un parc à camions sous contrat exclusif (chapitre 5). La carte le montre : la zone prend la couleur grise du Transit, les habitués ont disparu, des palissades ou une barrière apparaissent.
- **Reprendre une zone** : jamais par la bagarre seule. Trois moyens, selon la zone : une mission (prouver une irrégularité à la mairie avec Rachidath, trouver l'acte de propriété, organiser une pétition des commerçantes — pas de vote, pas d'élu : une lettre collective portée à l'administration), un rachat (prix affiché), ou un service rendu au groupe d'origine. Une zone reprise retrouve ses habitués en un jour de jeu.
- **Indicateur** : « Zones libres : 31/40 » dans le téléphone ; il sert au pourcentage de progression et pèse sur la fin (dans la fin « garder », les zones libres sont rendues à leurs groupes ; dans la fin « vendre », l'acheteur les garde).
- Cas limites : une zone fermée par l'histoire ne peut pas être reprise avant la mission prévue (prix non affiché, « Pas encore ») ; Koffi ne peut pas être expulsé d'un parc où il paie sa cotisation à jour ; cotisation impayée 2 semaines de jeu : place perdue, sans autre sanction.
- Test : au chapitre 1, seul le parc de Dantokpa donne des clients au rythme rapide ; payer 500 FCFA ouvre un second parc pour 7 jours de jeu, puis il se referme ; au chapitre 2, la zone rachetée passe au Transit et le compteur baisse de 1 ; terminer la mission de reprise remonte le compteur et fait réapparaître les habitués ; entrer à moto dans une allée du marché plafonne la vitesse à 2 m/s.

## Alliances
- **Entre groupes** : une table fixe la relation de départ et son évolution par chapitre. Trois états : **alliés** (s'entraident, se répètent ce que fait Koffi), **neutres**, **rivaux** (se gênent, se font concurrence).

| | Zems | Dames | Mécanos | Gens de l'eau | Routiers | Transit | Gros Bras |
|---|---|---|---|---|---|---|---|
| Zems | — | alliés | alliés | neutres | neutres | rivaux (dès ch. 2) | rivaux |
| Dames | | — | neutres | alliés | neutres | rivaux (dès ch. 2) | rivaux |
| Mécanos | | | — | neutres | alliés | neutres puis rivaux (ch. 4) | rivaux |
| Gens de l'eau | | | | — | neutres | neutres | neutres |
| Routiers | | | | | — | alliés puis rivaux (ch. 5) | rivaux (ch. 5) |
| Transit | | | | | | — | alliés |

- L'Administration n'est l'alliée de personne. Individuellement : Barnabé est droit ; le second policier, corrompu, rend service au Transit jusqu'à son arrestation au chapitre 4 (décision 39).
- **Contagion** : une variation de relation chez un groupe se répercute à **25 % chez ses alliés** et à **−25 % chez ses rivaux** (arrondi à l'entier, pas de répercussion en dessous de 4 points). Aider les Dames du marché de +8 donne +2 chez les Zems et les Gens de l'eau, −2 au Transit.
- **Alliance de Koffi avec un groupe** : au palier « frère » (+60), une mission d'alliance se débloque ; la réussir scelle l'alliance. Koffi peut alors **demander un coup de main** par téléphone, 1 fois par jour de jeu et par groupe allié :
  - Zems : 4 motos jaunes arrivent en 20 secondes et font écran 30 secondes entre Koffi et ses poursuivants (hommes de Capitaine seulement ; face à la police, ils refusent : « Nous, on ne se mêle pas de ça. ») ;
  - Dames du marché : une cachette pour une marchandise ou pour Koffi (les Gros Bras perdent sa trace tout de suite s'il entre dans l'allée des tissus) ;
  - Mécanos : dépannage sur place en 60 secondes, où que soit le véhicule ;
  - Gens de l'eau : une pirogue ou une barque l'attend à l'embarcadère le plus proche ;
  - Routiers : un camion barre une rue 20 secondes, ou transporte gratuitement un véhicule de Koffi d'une ville à l'autre.
- **Ce que coûte une alliance** : le groupe allié appelle à son tour (une demande par semaine de jeu environ : livraison urgente, remplacer un conducteur malade, pêcher un moteur tombé à l'eau). Refuser ou ignorer 48 heures de jeu : −5. Trois refus de suite : alliance suspendue jusqu'à un service rendu.
- **Alliances incompatibles** : aucune entre les six groupes de métier. Seule règle : accepter un contrat du Transit après le chapitre 2 (mieux payé de 30 %) coûte −4 chez les Zems et les Dames à chaque fois ; au chapitre 4, après la trahison d'Expédit, ces contrats disparaissent.
- **Le « front » du chapitre 5-6** : le nombre d'alliances scellées (0 à 5) compte pour la fin. Avec 3 alliances ou plus, la dernière mission propose le plan « tout le monde s'y met » (blocage pacifique des quais par les camions, les pirogues et les zems, pendant que Rachidath publie son enquête) ; avec moins, Koffi agit presque seul, et la mission est plus dure. Dans les deux cas, Monsieur Fortuné finit devant la justice (décision 99).
- **Rupture** : frapper un chef de groupe est impossible (ils ne sont pas attaquables) ; tomber sous +20 chez un allié suspend l'alliance ; elle reprend en repassant +40.
- Cas limites : la contagion ne s'applique pas aux variations écrites dans les missions principales (elles donnent leurs valeurs exactes) ; un coup de main demandé hors de la ville du groupe est refusé (« On n'est pas à Parakou, nous. ») sauf pour les Routiers ; pendant une mission qui l'interdit, le bouton est grisé.
- Test : +8 chez les Dames donne +2 aux Zems, +2 aux Gens de l'eau, −2 au Transit ; +3 ne se répercute pas ; à +60 la mission d'alliance apparaît ; alliance scellée → le coup de main des Zems fait apparaître 4 motos en moins de 20 secondes, une seule fois par jour ; demandé pendant une poursuite de police, il est refusé ; trois refus de service suspendent l'alliance ; la table des relations change bien aux chapitres 2, 4 et 5.
