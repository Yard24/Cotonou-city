# Radio en voiture : fonctionnement attendu

Code proposé : `scripts/radio.gd` (stations, grille, lecture, changement), `scripts/radio_info.gd` (flash info selon les actes du joueur), données dans `radio/stations.json`, sons dans `assets/sons/musique/` et `assets/sons/voix/`. Vérifications : `scripts/selftest_radio.gd`, avec des fichiers d'essai de 10 s, tirage fixé.

Cadre : 4 stations fictives : moderne, traditionnelle, zouk et rétro, parlée (décision 109) ; musique entièrement générée ou composée pour le jeu, aucun morceau existant, aucun artiste réel cité (110) ; la radio parlée diffuse de fausses publicités et des infos sur ce que le joueur vient de faire (111) ; aucune marque, aucun parti, aucune personne réelle (17, 25) ; jurons légers (112) ; humour sans moquerie (104). Noms de fichiers : `musique_radio_<station>_<numéro>.ogg` (`docs/conventions.md`).

## Stations
| N° | Nom et fréquence fictive | Genre | Contenu | Slogan (jingle chanté) |
|---|---|---|---|---|
| 1 | **Marina FM** — 98.2 | moderne | afro-pop, rap et électro d'ici, voix jeunes | « Marina FM, le son qui roule ! » |
| 2 | **Radio Tam-Tam** — 91.5 | traditionnelle | percussions, rythmes et chants d'inspiration locale, fanfares, chœurs | « Tam-Tam, la voix des anciens, l'oreille des jeunes. » |
| 3 | **Doux Souvenirs** — 104.7 | zouk et rétro | zouk, rumba, slows et variété des années 70 à 90, guitares claires | « Doux Souvenirs… comme avant, mais ce soir. » |
| 4 | **Cotonou Parole** — 89.0 | parlée | infos, débats de société, courrier des auditeurs, publicités, sport de quartier | « Cotonou Parole : on dit, on écoute, on dit encore. » |
- **Quantité visée** (première version publique : la moitié) : stations 1 à 3 : 14 morceaux chacune, de 2 min 30 à 3 min 30, soit environ 40 minutes par station ; station 4 : 45 minutes d'émissions en blocs de 3 à 6 minutes, plus les flash info. Par station : 8 jingles (3 à 6 s), 20 interventions d'animateur, 10 publicités partagées entre toutes.
- **Paroles** : en français et en onomatopées, écrites pour le jeu ; quelques salutations fon de la liste validée (`dialogues.md`) ; aucun texte religieux ou rituel détourné sur Radio Tam-Tam (décision 18) : rythmes et chants de fête, de travail, de marché.
- **Grille** : chaque station est une **boucle simulée dans le temps** : même à l'arrêt du moteur, la station « continue » ; en la reprenant, on tombe au milieu de ce qui passerait (position = temps de jeu écoulé modulo la durée de la boucle). Ordre de la boucle : tiré au début de chaque jour de jeu, sans deux morceaux consécutifs identiques d'un jour à l'autre. Schéma : jingle, 2 morceaux, animateur, 1 morceau, publicité, animateur… ; sur la station 4 : émission, publicité, flash info au début de chaque heure de jeu.
- **Selon l'heure** : Marina FM plus calme de 0 h à 5 h ; Radio Tam-Tam : émission « Le réveil du marché » de 5 h à 8 h ; Doux Souvenirs : « Dédicaces » de 20 h à 23 h ; Cotonou Parole : « Le Grand Matin » (6 h-9 h), « Midi Maquis » (12 h-14 h), « Embouteillage Club » (17 h-20 h, infos circulation vraies : ponts chargés, rues inondées), « La nuit porte conseil » (22 h-1 h).
- **Selon le chapitre** : 4 morceaux nouveaux par station débloqués à chaque chapitre (la musique vieillit avec la ville) ; chapitre 3 : messages de prudence sur toutes les stations, sans nommer la maladie (décision 95).
- **Où on l'entend** : dans tout véhicule à cabine (voiture, taxi, minibus, camionnette, camion) dès que le moteur tourne ; à moto : non au chapitre 1 ; à partir du chapitre 2, un petit poste accroché au guidon peut s'acheter (5 000 FCFA, son nasillard) ; pirogue : non. Aussi comme décor sonore : maquis, boutiques, taxis de la circulation (même boucle, même instant : en passant devant un maquis réglé sur Marina FM, on entend le même morceau que dans sa voiture).
- Format : `.ogg` stéréo, 44,1 kHz, −16 LUFS ; lecture en flux, un seul fichier décodé à la fois.
- Test : 4 stations chargées avec nom et fréquence ; position de lecture après 100 s de jeu moteur coupé = position initiale + 100 s (modulo la boucle) ; deux sources réglées sur la même station jouent le même fichier à moins de 0,1 s d'écart ; aucun fichier référencé manquant ; flash info au début de chaque heure de jeu sur la station 4 ; aucune radio à moto au chapitre 1.

## Changement de station
- **Touches** : **R** : station suivante ; **Maj + R** : précédente ; maintenir R 0,6 s : éteindre ou rallumer. Manette : croix gauche et droite. Ordre : éteinte → 1 → 2 → 3 → 4 → éteinte. Molette de la souris : permis aussi.
- **Passage** : 0,25 s de souffle et de grésillement, puis la nouvelle station en fondu de 0,3 s, prise là où en est sa boucle. Jamais de coupure nette.
- **Affichage** : bandeau en haut au centre pendant 3 s : nom, fréquence, titre du morceau et nom du groupe fictif, ou nom de l'émission. Style sobre (pas de roue de sélection).
- **Mémoire** : la station choisie est gardée par véhicule possédé et sauvegardée ; un véhicule emprunté est réglé sur la station de son propriétaire, tirée à sa création (taxis : 4 fois sur 10 Cotonou Parole ; minibus : Radio Tam-Tam ou Doux Souvenirs ; camions : Doux Souvenirs).
- **Démarrage** : en montant, la radio s'allume après 1 s (0,5 s de fondu). En descendant, on l'entend étouffée depuis l'extérieur jusqu'à 8 m tant que le moteur tourne ; elle se coupe à l'arrêt du moteur.
- **Volume** : curseur « Radio » dans les menus ; baisse automatique de 8 dB pendant les dialogues et les appels (`dialogues.md`) ; coupée pendant les cinématiques.
- **Coupée d'office** : pendant une poursuite écrite qui a sa propre musique ; pendant les missions de filature à pied ; quand la sirène de police est à moins de 15 m, la radio n'est pas coupée mais couverte.
- **Passagers** : un client de taxi peut demander une station (« Chauffeur, mets-nous Doux Souvenirs. ») : la mettre dans les 10 s : +5 de satisfaction ; refuser : rien.
- **Koffi réagit** (décision 107) : une fois sur six, à un changement de station ou à un début de morceau (« Ça, c'est la chanson de mon retour de Lagos. Ne me demandez pas pourquoi. »). Il chantonne faux sur Doux Souvenirs (4 extraits).
- **Dégâts** : au-delà de 80 points de dégâts, la radio grésille (parasites toutes les 5 à 10 s) ; à 100, elle se tait.
- **Réception** : sur la route du Nord (chapitre 5), les stations de Cotonou se brouillent après la première étape ; une cinquième station de décor, uniquement là, peut être ajoutée plus tard (hors des 4 décidées).
- Test : R cinq fois ramène à « éteinte » ; Maj + R inverse l'ordre ; la station 2 reprise après un détour par la 3 est à la position attendue (temps écoulé) ; bandeau affiché 3 s avec le bon titre ; station restaurée après sauvegarde ; volume à −8 dB pendant un dialogue ; à 85 points de dégâts : parasites.

## Animateurs fictifs
- Un animateur principal par station, une voix générée distincte pour chacun (décision 108), plus deux voix secondaires sur la station parlée. Aucun n'imite une personne réelle.

| Station | Animateur | Caractère | Tics de langage |
|---|---|---|---|
| Marina FM | **DJ Séna** (jeune femme) | énergique, taquine, parle par-dessus les intros | « On monte le son ! », donne l'heure toujours fausse de cinq minutes |
| Radio Tam-Tam | **Dah Bonou** (homme âgé) | lent, malicieux, conteur | commence par « Autrefois… » puis parle d'hier ; proverbes de son cru |
| Doux Souvenirs | **Tantie Clarisse** (femme mûre) | chaleureuse, romantique, lit les dédicaces | « Mes chéris… », soupire avant chaque slow |
| Cotonou Parole | **Monsieur Hospice** (présentateur) et **Mireille** (chroniqueuse) | lui pompeux et sérieux, elle vive et terre à terre ; ils se chamaillent poliment | lui : « Précisons-le d'emblée… » ; elle : « Bon. Concrètement ? » |
| Cotonou Parole | **L'auditeur Pascal** (voix au téléphone, récurrente) | appelle sur tous les sujets, n'a jamais la bonne émission | « Allô ? Je suis à l'antenne ? » |
- **Interventions** : 8 à 20 s entre deux morceaux ; 20 par animateur, dont : 6 neutres (titre, heure, salutations), 4 selon l'heure, 4 selon la météo (« Il pleut sur Cotonou, rangez les beignets. »), 3 par chapitre, 3 dédicaces ou courrier.
- **Liens avec le monde** : la météo et l'heure annoncées sont celles du jeu ; « Embouteillage Club » cite les vrais points chargés de la simulation ; à partir du chapitre 2, on entend parler du prix du transport qui monte (décision 94), au chapitre 4 des chantiers, au chapitre 5 des enquêtes de Rachidath (elle est invitée de Mireille), sans jamais prendre parti pour une formation politique : il n'y en a pas (décision 17).
- **Koffi à l'antenne** : au chapitre 4 ou 5, une mission secondaire le fait passer dans « Midi Maquis » (choix de dialogue) ; ensuite Mireille le cite parfois (« le jeune transporteur de Dantokpa »).
- **Dédicaces** (Doux Souvenirs) : 12 dédicaces écrites, dont 3 qui visent le joueur après certains événements (de Maman Koffi après le remboursement de la dette ; d'Afi ; de Romaric « pour mon ami qui me doit encore un rétroviseur »).
- **Débats de société** (Cotonou Parole), 10 sujets sans danger : faut-il klaxonner ? le casque ; marchander ou pas ; la pluie et les caniveaux ; téléphone à table ; le prix du pain ; les zémidjans et les piétons ; l'harmattan et la toux ; les chantiers ; l'argent mobile.
- **Écriture** : drôle par le caractère, jamais par la moquerie d'un accent ou d'une origine (104) ; pas de sujet religieux ; jurons légers ; chaque intervention tient en 45 mots au plus.
- Une même intervention ne repasse pas avant 3 jours de jeu ; celles qui dépendent de la météo ou de l'heure ne passent que si la condition est vraie.
- Test : 6 voix distinctes référencées ; intervention « pluie » jamais jouée par temps clair sur 20 jours simulés ; heure annoncée par DJ Séna = heure du jeu + 5 minutes ; aucune répétition avant 3 jours de jeu ; l'outil de contrôle des textes refuse plus de 45 mots et tout nom de la liste des noms interdits (marques, personnes réelles : liste tenue dans `radio/interdits.txt`).

## Publicités fictives
- 30 publicités de 12 à 25 s, toutes pour des **marques et commerces inventés** du jeu (décision 25), que le joueur peut croiser en ville : la radio sert aussi de guide. Voix : 2 voix de publicité + les animateurs. Chacune a son petit air chanté.
- **Liste de départ** (20 des 30 ; texte résumé) :

| Annonceur inventé | Idée et accroche |
|---|---|
| KwabôPay | « Envoyez l'argent sans envoyer le cousin. KwabôPay : c'est arrivé avant vous. » (à partir du chapitre 2) |
| Zékôm (opérateur) | « Zékôm : le réseau qui capte… presque partout. » |
| Fizi (boisson) | « Fizi ! Ça pique, ça réveille, ça pique encore. » |
| Motos du Littoral | « Elle démarre au premier coup. Le deuxième, c'est pour le plaisir. » |
| Parc Auto du Port | « Voitures d'occasion presque neuves, vendeurs presque sincères. » |
| Banque du Golfe | « Votre argent dort chez nous. Nous, on veille. » (à partir du chapitre 4) |
| Atlantique Voyages (autocars) | « Départ à l'heure. Arrivée… à l'arrivée. » |
| Maquis La Détente | « Le poisson est d'aujourd'hui, la sauce est de toujours. » |
| Savon « Clarté » | « Clarté lave le linge, la vaisselle, et la conscience du mari qui rentre tard. » |
| Pommade « Douceur d'Harmattan » | diffusée seulement en décembre-janvier : « Vos lèvres vous diront merci. Si elles peuvent encore. » |
| Bouillon « Maman Cube-Cube » | « Une pincée, et les voisins arrivent. » |
| Lait concentré « Bonne Vache » | « Dans la bouillie, dans le café, dans la cuillère quand personne ne regarde. » |
| Élégance Plus (prêt-à-porter) | « Entrez comme vous êtes. Sortez comme vous voulez. » |
| Coiffure Bon Garçon | « La coupe qui fait dire à ta mère : enfin ! » |
| Quincaillerie Sèmèvo | « Du clou au ciment : on a tout, sauf la monnaie. » |
| Lampes solaires « Soleil de Nuit » | diffusée surtout les soirs de coupure : « Quand le courant part, vous restez. » (à partir du chapitre 4) |
| École de conduite « Volant d'Or » | « Chez nous, le klaxon est en option. » |
| Pneus « Tient-la-Route » | « Sous la pluie, il y a ceux qui freinent et ceux qui prient. » |
| Eau « Fraîcheur du Mono » | « L'eau qui a du goût : aucun. » |
| Message de la mairie | « Le caniveau n'est pas une poubelle. » ; « Le casque : pour le pilote et pour le passager. » ; messages de la douane et de la police (numéro vert inventé) |
- **Pas de publicité** pour l'alcool, le tabac, les jeux d'argent (décision 70), les médicaments miracles ; aucun message politique ; aucune vraie publicité (71).
- **Fréquence** : une publicité toutes les 6 à 9 minutes réelles sur les stations musicales, toutes les 4 à 6 minutes sur Cotonou Parole ; jamais deux fois la même en 30 minutes réelles.
- **Liens avec le jeu** : entendre la publicité d'un commerce pas encore découvert l'ajoute à la carte une fois sur trois (« j'ai entendu parler de… ») ; promotions vraies : quand la radio annonce « −10 % chez Élégance Plus jusqu'à ce soir » (1 jour de jeu sur 6), la boutique applique la remise jusqu'à sa fermeture.
- **Histoire** : au chapitre 2 apparaissent les publicités lisses de l'entreprise de transit de Monsieur Fortuné (« Fortuné Transit : votre marchandise, notre affaire. ») ; au chapitre 5, la publicité de l'entreprise de Koffi (nom choisi par le joueur parmi 4 à la création de l'entreprise) : Koffi l'entend et commente ; dans la fin « vendre », elle est remplacée par celle du repreneur.
- Test : 30 publicités référencées, durées entre 12 et 25 s ; KwabôPay jamais diffusée au chapitre 1, Banque du Golfe jamais avant le chapitre 4, « Douceur d'Harmattan » jamais hors décembre-janvier ; intervalle entre deux publicités dans les fourchettes sur 2 heures simulées ; promotion annoncée : prix réellement à −10 % dans la boutique ce jour-là ; aucun mot de `radio/interdits.txt`.

## Flash info lié à l'histoire
- Sur **Cotonou Parole**, au début de chaque heure de jeu (toutes les 2 minutes réelles), un flash de 15 à 30 s lu par Monsieur Hospice : jingle, 1 à 3 brèves, « C'était Cotonou Parole. ». Les autres stations ont un flash plus court (une brève, 8 s) toutes les 3 heures de jeu.
- **Trois sortes de brèves**, par priorité :
  1. **Histoire** : écrites pour chaque mission principale (1 ou 2 par mission, environ 80 en tout), diffusées dans les 2 flashs qui suivent la mission ; elles racontent l'événement vu de l'extérieur, souvent à côté de la vérité (ressort comique : le joueur sait ce qui s'est vraiment passé). Exemple, chapitre 2 : « Les prix du transport de marchandises ont encore augmenté ce mois-ci. Les commerçantes de Dantokpa s'interrogent. Un transitaire bien connu parle, je cite, des lois du marché. »
  2. **Actes du joueur** (décision 111) : phrases à trous remplies par le jeu (lieu, véhicule, heure, nombre). File d'attente de 5 événements ; un événement est diffusé au flash suivant s'il a moins de 6 heures de jeu.
  3. **Vie de la ville** : météo vraie, coupures de courant (annoncées avec une heure de retard), embouteillages, chantiers, football de quartier (équipes inventées), prix du marché. 60 brèves à trous, pour qu'il y ait toujours quelque chose.
- **Événements du joueur suivis** et modèle de phrase (3 variantes chacune) :

| Événement | Seuil | Exemple |
|---|---|---|
| Poursuite | 3 étoiles ou plus atteintes | « Course-poursuite cet après-midi du côté de {quartier}. Le fuyard, sur {véhicule}, court toujours. » ou « …a été interpellé. » |
| Arrestation | toute arrestation à 2 étoiles et plus | « Un jeune homme a passé un moment au commissariat de {quartier}. Il en est ressorti, nous dit-on, plus léger de quelques billets. » |
| Agent sanctionné | après un « petit geste » accepté | « Un agent du contrôle de {quartier} a été suspendu pour indélicatesse. La hiérarchie rappelle qu'une amende se paie contre reçu. » (obligatoire, décision 19) |
| Passants renversés | 3 en 5 minutes réelles | « Plusieurs piétons bousculés à {quartier}. Plus de peur que de mal. La police recherche {véhicule}. » |
| Accident spectaculaire | choc de plus de 60 points de dégâts | « Tôle froissée sur {rue}. Le conducteur est reparti à pied, dit-on, en parlant tout seul. » |
| Record de livraison ou de course | médaille d'or | « Un livreur a traversé la ville en {durée}. Nos auditeurs demandent : par où ? » |
| Journée de zémidjan exemplaire | 12 courses sans choc | « Courrier des auditeurs : une dame remercie le zém numéro {numéro}, qui roule, je cite, comme quelqu'un qui a une mère. » |
| Achat de propriété | chaque achat | « Du nouveau à {quartier} : {type de propriété} a trouvé preneur. » |
| Mât d'éclairage abattu, étal renversé | — | « Dégâts matériels à {quartier}. La mairie rappelle que les lampadaires ne traversent pas. » |
| Rue inondée traversée en calant | — | brève de circulation |
- **Koffi n'est jamais nommé** avant le chapitre 5 (« un jeune homme », « un zémidjan au maillot vert », selon sa tenue réelle) ; ensuite « un transporteur de la place », puis son prénom dans les brèves d'histoire du chapitre 6.
- **Vérité** : les brèves sur les actes du joueur disent toujours vrai sur le lieu et l'issue (arrêté ou non) ; pas de brève inventant une victime : « plus de peur que de mal » (décision 4).
- **Koffi réagit** s'il écoute (une fois sur deux) : « C'est moi, ça ? Non. Si. Bon. » ; Maman Koffi peut appeler 1 à 3 minutes réelles après une brève d'arrestation.
- **Écoute manquée** : les brèves d'histoire non entendues (radio éteinte, autre station) sont rediffusées une fois au flash suivant entendu, puis archivées dans l'historique des dialogues sous « Radio ».
- **Les deux fins** (décision 98, 99) : dernier flash du jeu différent selon le choix ; dans les deux, Monsieur Fortuné devant la justice.
- Écriture : 40 mots au plus par brève ; ton de journal sérieux, drôle par le décalage ; aucune personne réelle, aucun parti ; l'administration (douane, mairie, police) seule représente le pouvoir (décision 17).
- Test : mission d'essai réussie : sa brève passe dans l'un des 2 flashs suivants sur la station 4 ; arrestation à 3 étoiles à Ganhi : brève avec « Ganhi » et « interpellé » ; « petit geste » accepté : brève de sanction mise en file et diffusée dans les 48 h de jeu ; événement vieux de 7 heures de jeu : non diffusé ; file limitée à 5 ; sans événement : 1 à 3 brèves de vie de la ville, météo conforme à la simulation ; aucune brève de plus de 40 mots.

## Choix faits par Claude (à confirmer)
- Noms des stations (Marina FM, Radio Tam-Tam, Doux Souvenirs, Cotonou Parole) et des animateurs, tous inventés.
- Stations en boucle simulée dans le temps : le même morceau au même instant dans la voiture et dans les maquis.
- Touche R pour changer de station ; pas de radio à moto au chapitre 1, petit poste en option ensuite.
- Les brèves ne nomment pas Koffi avant le chapitre 5.
