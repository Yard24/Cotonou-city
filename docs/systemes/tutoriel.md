# Tutoriel : fonctionnement attendu

Aujourd'hui : un texte d'aide fixe en bas de l'écran (`scripts/hud.gd`) liste toutes les touches d'un coup. Rien n'est guidé. Code prévu : `scripts/tuto.gd` (étapes, conseils, conditions), textes dans `data/textes/tutoriel.csv`. Vérifications prévues : `scripts/selftest_tuto.gd`.

Rappel des décisions : Koffi revient de Lagos sans argent et démarre conducteur de zémidjan sur la moto prêtée par Romaric (9, 11, 51) ; casque automatique (52) ; course de zémidjan : E devant le client pour accepter, 100 à 1 000 FCFA, marchandage en trois échanges (64, 65) ; dette envers Tonton Gratien (72) ; touches : flèches ou ZQSD, E monter, Espace sauter ou frein à main, Maj courir, C s'accroupir (113) ; trois difficultés (116) ; missions de 5 à 12 minutes avec points de contrôle (101) ; Afi apprend à Koffi le paiement mobile et les réseaux (41) ; KwabôPay à partir du chapitre 2 (66) ; humour par les dialogues (104).

## Principes
- **Pas de tutoriel séparé** : on apprend dans la première mission et dans les suivantes, par l'histoire. Le joueur n'est jamais arrêté plus de 3 secondes par un panneau.
- **Un conseil = une action** : une ligne en bas de l'écran, couleur `ffe27a` (couleur des conseils), avec la touche réellement configurée dans un petit cadre (« [Maj] Courir »). Le conseil disparaît dès que le joueur a fait l'action (réussie une fois), ou au bout de 12 secondes ; s'il n'a pas été réussi, il revient 20 secondes plus tard, 3 fois au plus.
- **Un seul conseil à la fois**, jamais pendant une réplique importante ni pendant une poursuite.
- **Jamais deux fois** : chaque conseil réussi est noté dans la sauvegarde. Une nouvelle partie les remet à zéro. Option « Conseils » dans les réglages : « Tous », « Seulement les nouveautés » (par défaut après le chapitre 1), « Aucun ».
- **Rappel** : la pause contient « Commandes » (toutes les touches, par situation : à pied, à moto, en voiture, sur l'eau, téléphone) et « Conseils déjà vus ». Le long texte d'aide actuel disparaît de l'écran de jeu et va là.
- **Clavier ou manette** : les touches affichées sont celles du dernier appareil utilisé.
- **Voix** : c'est un personnage qui explique, dans le ton (Romaric, Afi, le Doyen), et le conseil écrit ne fait que rappeler la touche. Koffi répond en râlant (« Romaric, je sais marcher, hein. J'étais à Lagos, pas sur la lune. »).
- **Échec impossible** pendant les étapes d'apprentissage du début : pas de chrono, pas de police, pas de dégât sérieux avant la fin de la première course.

## Déplacement
- **Où et quand** : tout début du jeu, après la cinématique d'ouverture (Koffi descend d'un minibus venu de la frontière, sac à l'épaule, gare routière près de Dantokpa, 2017, fin d'après-midi). Romaric l'attend à 60 m, devant un étal, et lui fait signe.
- **Étapes** (chacune validée par l'action, dans cet ordre) :
  1. **Regarder** : « Bouge la souris pour regarder autour de toi » — validé après 90° de rotation. (Sauté si la souris n'est pas utilisée dans les 6 secondes : le jeu fonctionne au clavier seul.)
  2. **Marcher** : « [flèches] ou [Z Q S D] : marcher » — un marqueur jaune au sol à 15 m ; validé en l'atteignant.
  3. **Courir** : Romaric crie « Dépêche-toi, la pâte va refroidir ! » — « [Maj] Courir » ; validé après 2 secondes de course.
  4. **Sauter et franchir** : un caniveau ouvert de 1 m de large puis un muret de 0,8 m barrent le chemin direct — « [Espace] Sauter », puis « [Espace] devant un muret : monter dessus ». Un chemin contourne les deux (20 m de plus) : rien n'est obligatoire.
  5. **S'accroupir** : une bâche d'étal tendue à 1,3 m — « [C] S'accroupir » pour passer dessous ; contournable aussi.
  6. **Interagir** : arrivé près de Romaric, « [E] Parler ». Courte scène de retrouvailles (25 secondes, passable). Puis Romaric tend un sachet d'eau : « [E] Boire » — la jauge de santé, volontairement à 70 au début (« le voyage »), monte de 25 ; un conseil désigne la jauge une fois (« Ta santé. Manger et boire la fait remonter. »).
  7. **S'asseoir** (facultatif) : un banc à côté — conseil seulement si le joueur passe à moins de 3 m.
- **Durée visée** : 60 à 90 secondes pour un joueur habitué, 3 minutes au plus pour un débutant.
- **Minicarte** : présentée à l'étape 2 par un seul conseil (« Le point jaune sur la carte, c'est là que tu vas. ») ; la grande carte attend le téléphone.
- **Nage, chute, bagarre** : pas ici. La nage est expliquée la première fois que Koffi a de l'eau jusqu'à la taille (« Koffi sait nager. [Maj] Nager plus vite. La jauge bleue, c'est ton souffle. ») ; la chute, à la première blessure ; la bagarre, dans la mission du chapitre 1 qui l'introduit.
- **Garde-fous** : si le joueur ne bouge pas pendant 20 secondes, Romaric relance (3 répliques différentes) ; s'il part à l'opposé de plus de 80 m, un rappel puis un mur doux (Koffi : « Non, Romaric est par là. ») — la zone libre est de 120 × 120 m pendant ces étapes ; s'il fait toutes les actions avant qu'on les demande, les conseils correspondants sont validés sans s'afficher.
- **Difficulté** : identique dans les trois.
- Test : en simulant les touches dans l'ordre, les 6 étapes se valident et la scène de Romaric se lance ; marcher sans jamais courir ne valide pas l'étape 3 et le conseil revient 3 fois puis s'efface ; contourner le muret n'empêche pas d'arriver à l'étape 6 ; courir avant qu'on le demande valide l'étape 3 sans afficher le conseil ; un conseil validé ne réapparaît pas après sauvegarde et rechargement ; avec « Conseils : Aucun », rien ne s'affiche mais les étapes s'enchaînent ; la santé passe de 70 à 95 après le sachet d'eau.

## Conduite
- **Où et quand** : juste après les retrouvailles. Romaric montre sa moto de zémidjan (jaune, cabossée, « Elle s'appelle Patience. Tu vas comprendre pourquoi. ») garée à 10 m, sur une rue de quartier calme, sans circulation pendant l'exercice.
- **Étapes à moto** :
  1. **Monter** : « [E] Monter sur la moto » — le casque se met tout seul (Koffi : « Même le casque, il est prêté ? »).
  2. **Accélérer** : « [Haut] Accélérer » — validé à 25 km/h.
  3. **Tourner** : un virage à droite puis un à gauche balisés par des pneus peints — « [Gauche] [Droite] Tourner. La moto penche : c'est normal. »
  4. **Freiner** : une ligne blanche devant un cabri qui traverse (figurant animal, il ne peut pas être touché : il s'écarte toujours) — « [Bas] Freiner » ; validé en s'arrêtant à moins de 4 m après la ligne.
  5. **Frein arrière** : un demi-tour dans une cour — « [Espace] Frein arrière : pour tourner serré ».
  6. **Klaxon** : deux collègues zems bouchent la rue en discutant — « [H] Klaxon ». Ils s'écartent en riant. Romaric : « Doucement avec ça, on n'est pas à Lagos ici. » (rappel de la décision 59).
  7. **Caméra** : « [V] Changer de vue » — présenté, pas obligatoire.
  8. **Descendre** : arrivée à l'atelier de Romaric — « [E] Descendre ».
- Trajet total : 450 m, 2 minutes. Romaric suit sur une seconde moto et commente.
- **Se faufiler** : expliqué plus tard, au premier embouteillage rencontré (« Les voitures sont bloquées, pas toi. Passe entre les files, doucement. »), puisqu'il n'y a pas de circulation dans l'exercice.
- **Chute** : si le joueur percute un mur pendant l'exercice, la chute est jouée normalement mais ne coûte que 5 points de santé ; Romaric : « C'est ma moto, hein ! » Le conseil « Une chute coûte de la santé et du temps » s'affiche une fois.
- **Carburant** : première leçon à la mission suivante — la jauge clignote, Romaric indique une vendeuse de kpayo (400 FCFA le litre en 2017) et une station officielle (530 FCFA) : « Le kpayo est moins cher, mais le moteur n'aime pas toujours. » Un seul conseil sur la jauge.
- **Voiture** : le premier volant vient plus tard dans le chapitre 1 (mission où Koffi conduit la voiture d'un client). Conseils affichés seulement pour ce qui diffère de la moto : « [Espace] Frein à main », « [Bas] à l'arrêt : reculer », « [L] Phares », « [J] [K] Clignotants ». 
- **Autres véhicules** : tricycle (« Chargé, il freine long. »), minibus (« Arrête-toi aux arrêts : [E] ouvrir la porte. »), camion (« Prends tes virages large. »), pirogue (« [Haut] Pagayer. Elle tourne même à l'arrêt. »), barque à moteur (« Pas de frein : lâche les gaz à temps. ») : un à deux conseils à la première montée, pas d'exercice.
- **Règles de la route** : on roule à droite (décision du 16 novembre) ; le conseil apparaît à la première prise de la voie de gauche pendant plus de 3 secondes face à un véhicule (« On roule à droite ! »). Feux rouges : conseil à la première fois où un agent est en vue.
- **Garde-fous** : pendant l'exercice, la moto ne peut pas quitter le parcours de plus de 60 m (rues fermées par des étals et un camion de livraison qui manœuvre) ; rester à l'arrêt 20 secondes fait relancer Romaric ; descendre de la moto en route est permis, le conseil « [E] Monter » revient.
- Test : en simulant les touches, les étapes 1 à 8 se valident dans l'ordre et l'objectif suivant apparaît ; rouler à 20 km/h ne valide pas l'étape 2 ; s'arrêter à 6 m après la ligne ne valide pas l'étape 4, qui se rejoue (le cabri retraverse) ; le cabri n'est jamais touché, quelle que soit la vitesse (essai à 60 km/h) ; une chute pendant l'exercice coûte 5 points ; pas de véhicule de circulation dans la zone pendant l'exercice ; le conseil « se faufiler » ne s'affiche qu'au premier embouteillage.

## Première mission
- **Titre** : « Le retour » (chapitre 1, mission 1). Durée visée : 8 à 10 minutes, tout compris (dont les deux apprentissages ci-dessus). Le scénario détaillé appartient au domaine du chapitre 1 ; ce document fixe ce que la mission doit **apprendre** et comment.
- **Déroulement** :
  1. Arrivée à la gare routière, retrouvailles avec Romaric (déplacement).
  2. La moto « Patience » jusqu'à l'atelier (conduite).
  3. À l'atelier : Romaric prête la moto et une chemise jaune numérotée « 2017 » (elle remplace le maillot vert quand Koffi travaille comme zem). Il explique l'argent en une phrase : Koffi a **0 FCFA** ; il doit une recette à Romaric (500 FCFA par jour de jeu pour la moto) et il apprendra bientôt ce qu'il doit à Tonton Gratien.
  4. **Première course** : une cliente lève le bras à 80 m (Tantie Rosine, qui tient un maquis). Conseil : « Arrête-toi près d'un client qui lève le bras ». Elle annonce « Dantokpa, côté tissus. 300 francs. » — « [E] Accepter la course ». Elle monte, met le casque passager. Une **colonne bleue** marque la destination à 600 m ; la minicarte trace le chemin.
  5. Trajet avec un vrai peu de circulation ; la cliente commente la conduite (4 répliques selon la douceur : « Tu conduis bien, mon fils », « Hé ! Mes œufs ! »). À l'arrivée : « +300 FCFA » en vert `8df59a`, premier argent du jeu.
  6. **Deuxième course, avec marchandage** : un client pressé propose 200 FCFA pour 900 m. Écran de marchandage expliqué en direct : « Il propose 200. Demande plus, mais pas trop : trois échanges, pas un de plus. » Le joueur choisit entre 250, 350 et 500 ; le client accepte 250 tout de suite, discute 350 (accord à 300), s'en va à 500 (un autre client arrive 10 secondes plus tard, sans marchandage). Dans tous les cas la mission continue.
  7. **Manger** : la santé a un peu baissé par le script (soleil) ; Romaric appelle : « Passe chez ta maman, elle t'attend. » Maman Koffi, devant la maison près de Dantokpa, sert la bouillie et les beignets (gratuits) : la santé remonte, courte scène d'émotion et de reproches (30 secondes).
  8. **Fin** : Koffi rend 500 FCFA de recette à Romaric (ou ce qu'il a, la mission n'échoue pas pour ça : Romaric note la différence). **Sauvegarde automatique** expliquée par une ligne : « Le jeu sauvegarde tout seul après chaque mission. » Écran de fin de mission : temps, argent gagné, pas de note.
- **Ce que le joueur sait à la fin** : se déplacer, conduire la moto, prendre un client, lire la minicarte et la colonne bleue, marchander, gagner et rendre de l'argent, se soigner en mangeant, où est sa maison.
- **Ce qu'on garde pour les missions 2 à 4** : le téléphone (voir plus bas), la dette de Tonton Gratien, l'essence, la police (premier contrôle par l'adjudant Barnabé, sans amende : un avertissement), la bagarre, la voiture.
- **Points de contrôle** (décision 101) : après l'arrivée à l'atelier, après la première course, après le repas. En cas d'évanouissement (improbable ici) ou d'abandon, on reprend au dernier.
- **Échecs possibles** : faire tomber la cliente (collision avec chute) → elle se relève, refuse de remonter, une autre cliente lève le bras 10 secondes plus tard (pas d'écran d'échec, pas de dédommagement, conformément à la décision du 16 novembre) ; abandonner la moto plus de 2 minutes ou à plus de 200 m → Romaric appelle, puis reprise au point de contrôle.
- **Liberté** : pendant la mission, la zone de jeu est limitée à Dantokpa et ses abords (800 × 600 m) par des rues en travaux et des camions arrêtés ; le monde s'ouvre à la fin de la mission 1.
- **Difficulté** : la question « Tranquille, Normal ou Corsé » est posée avant la cinématique d'ouverture, avec une phrase par choix ; modifiable à tout moment dans la pause.
- **Version publique gratuite** (décision 119) : cette mission est la porte d'entrée de la démonstration ; elle doit tenir debout seule.
- Test : la mission jouée automatiquement de bout en bout (touches simulées, chemin suivi) se termine sans intervention en moins de 12 minutes simulées ; l'argent vaut 0 au début, 300 après la première course, entre 500 et 650 avant de payer Romaric selon le marchandage, puis ce total moins 500 ; choisir 500 au marchandage fait partir le client et en amène un autre ; la santé remonte chez Maman Koffi sans rien payer ; une sauvegarde automatique existe à la fin ; les trois points de contrôle rechargent au bon endroit avec le bon argent ; faire tomber la cliente n'affiche pas d'écran d'échec et ne retire pas d'argent ; le joueur ne peut pas sortir de la zone de 800 × 600 m.

## Téléphone
- **Où et quand** : mission 2 du chapitre 1 (« Le numéro d'Afi »). Koffi a un vieux téléphone à touches rapporté de Lagos, écran fêlé. Afi, sa petite sœur lycéenne (16 ans en 2017, en uniforme kaki — elle n'est jamais dans une scène d'action, décision 48), lui met une puce d'un opérateur inventé (« Bénitel ») à la maison, et se moque gentiment : « Grand frère, même la grand-mère a mieux que ça. »
- **Ouvrir le téléphone** : touche T (ou Haut sur la croix de la manette). Le téléphone monte en bas à droite de l'écran, 0,3 seconde ; le jeu **ne se met pas en pause** (sauf en Tranquille, où il ralentit à 30 %). On ne peut pas l'ouvrir en nageant, en bagarre, ni pendant une chute. À moto ou en voiture, on peut répondre à un appel, pas naviguer dans les menus au-dessus de 20 km/h (Koffi : « Pas en roulant ! »).
- **Étapes guidées par Afi**, chacune validée par l'action :
  1. « [T] Sortir le téléphone ».
  2. **Répondre** : Romaric appelle exprès — sonnerie, « [E] Décrocher » (« [Échap] Refuser » est montré mais Afi dit : « Réponds, c'est impoli. »). On apprend que les missions arrivent souvent par un appel.
  3. **Contacts** : « [Haut] [Bas] choisir, [E] ouvrir » — appeler Afi elle-même, qui décroche à deux mètres de lui (« Allô ? Oui, je te vois. »). Les contacts de départ : Maman, Afi, Romaric.
  4. **Messages** : un message de Tonton Gratien arrive (« Neveu. Passe me voir à Missèbo. On doit parler chiffres. ») — ouvrir le message ajoute un **marqueur de mission** sur la carte. Leçon : lire un message peut lancer une mission.
  5. **Carte** : ouvrir la grande carte depuis le téléphone (ou touche M directement) ; déplacer, zoomer, « [E] Poser un repère » — le trajet s'affiche sur la minicarte. Validé en posant un repère sur Missèbo.
  6. **Ranger** : « [T] ou [Échap] ».
- Durée : 2 minutes. Chaque étape a une réplique d'Afi et une réponse de Koffi.
- **Le téléphone grandit avec l'histoire** (décisions 41 et 66), et chaque nouveauté a sa mini-leçon de 20 à 40 secondes, toujours par Afi :
  - chapitre 1 : appels, messages, contacts, carte, « Carnet » (objets à collecter), réglage de la sonnerie ;
  - chapitre 2 (2018) : premier téléphone tactile d'occasion (20 000 FCFA chez un revendeur de Missèbo, imposé par une mission) ; **KwabôPay** — Afi fait recevoir puis envoyer 500 FCFA à Koffi (« Tu vois ? Plus besoin de chercher la monnaie. ») ; appareil photo ;
  - chapitre 3 (2020) : commandes de livraison par messages, groupes de discussion des livreurs ;
  - chapitre 4 (2021) : application « Koffi Transport » (gérer ses motos et conducteurs, recettes) ; réseau social inventé « Palabre » (réputation, annonces) ;
  - chapitre 5 (2023) : achat de billets, suivi des camions sur la carte ;
  - chapitre 6 : rien de nouveau à apprendre.
- **Batterie et crédit** : pas de gestion de batterie ni de crédit d'appel (ce serait une corvée) ; seule exception écrite : une mission où le téléphone est déchargé.
- **Appels manqués** : un appel de mission non décroché revient 1 minute plus tard, puis devient un message avec marqueur ; on ne perd jamais une mission pour un appel manqué.
- **Sécurité** : aucun numéro réel, aucune adresse réelle ; les numéros affichés ont un format inventé à 8 chiffres commençant par 00.
- **Garde-fous** : si le joueur ne sort pas le téléphone après 20 secondes, Afi insiste ; s'il range le téléphone en plein milieu, la leçon reprend à l'étape en cours quand il le ressort ; refuser l'appel de Romaric à l'étape 2 → Romaric rappelle 5 secondes plus tard, vexé (« Tu me refuses, moi ? »).
- Test : T ouvre et ferme le téléphone ; les 6 étapes se valident dans l'ordre avec les touches simulées ; ouvrir le message de Tonton Gratien crée le marqueur de mission à Missèbo ; poser un repère trace un chemin sur la minicarte ; le téléphone ne s'ouvre pas en nageant ; à 40 km/h, le menu refuse la navigation mais un appel peut être décroché ; au chapitre 1, l'application KwabôPay n'existe pas, au chapitre 2 elle apparaît après la leçon ; un appel de mission ignoré deux fois devient un message avec marqueur.
