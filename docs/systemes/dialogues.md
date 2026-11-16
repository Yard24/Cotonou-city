# Dialogues : fonctionnement attendu

Code proposé : `scripts/dialogue.gd` (lecture d'une conversation, sous-titres, choix, historique), `scripts/voix.gd` (lecture des fichiers de voix, priorités), données dans `dialogues/<mission ou lieu>.json`. Vérifications : `scripts/selftest_dialogue.gd`, avec une conversation d'essai de 6 répliques dont un choix, et un outil de contrôle des fichiers (`scripts/outils/verif_dialogues.gd`).

Cadre : français parlé de Cotonou, sous-titré (décision 105) ; expressions fon limitées aux salutations et exclamations, liste soumise à Bravo avant usage (106) ; Koffi parle beaucoup et commente quand il conduit (107) ; voix générées, une voix distincte par personnage principal (108) ; humour par les dialogues et les situations, jamais de moquerie sur une ethnie, une religion ou un accent (104) ; jurons légers seulement (112) ; français seulement à la sortie (117).

Une **réplique** = un identifiant, un personnage, un texte, un fichier de voix, une durée, et en option une humeur (neutre, content, fâché, inquiet, moqueur) et un geste. Format de l'identifiant : `<mission>_<personnage>_<numéro>` (par exemple `c1m3_romaric_012`), repris dans le nom du fichier `voix_romaric_c1m3_012.ogg` (voir `docs/conventions.md`).

## Sous-titres
- **Activés par défaut** (décision 105). Option dans les menus : activés / désactivés ; taille petite, moyenne, grande (28, 36, 46 pixels de haut pour un écran de 1 080 lignes) ; fond : aucun, bandeau à 50 %, bandeau à 80 % ; nom du personnage affiché ou non ; « sous-titrer l'ambiance » (conversations des passants et radio parlée), désactivé par défaut.
- **Place** : en bas, centrés, à 8 % du bord inférieur ; ils remontent au-dessus du texte d'aide (« E : monter ») s'il est affiché, et au-dessus des bandes noires en cinématique.
- **Forme** : 2 lignes au plus, 42 caractères par ligne au plus. Une réplique plus longue est coupée en plusieurs sous-titres, aux virgules ou aux points, jamais au milieu d'un groupe de mots. Texte blanc, contour noir de 2 pixels.
- **Nom du personnage** devant la première ligne, en couleur : « Romaric : ». Couleurs fixes : Koffi blanc (pas de nom affiché quand il parle seul), Romaric orange, Maman Koffi jaune clair, Tonton Gratien vert, Nan Akouavi violet clair, Le Doyen bleu clair, Monsieur Fortuné gris perle, Capitaine rouge brique, Expédit turquoise, Rachidath rose, Adjudant Barnabé bleu, Afi vert clair ; passants et inconnus : gris clair avec leur rôle (« Vendeuse : », « Agent : »). Toutes les couleurs ont un contraste d'au moins 7 pour 1 sur le bandeau.
- **Durée d'affichage** : celle du fichier de voix + 0,3 s. Sans voix : 1,2 s + 0,06 s par caractère, entre 1,5 et 7 s. Un sous-titre n'est jamais remplacé avant 1 s d'affichage.
- **Expressions fon** : en italique, suivies la première fois de leur sens entre crochets : « *Kwabô !* [Bienvenue !] ». Ensuite, sans traduction (option « toujours traduire » dans les menus).
- **Bruits utiles** entre crochets, seulement si l'option « sous-titres pour sourds et malentendants » est active : [sirène de police derrière], [le téléphone sonne], [klaxon].
- **Personnage hors champ** ou au téléphone : nom suivi de « (téléphone) » ou « (radio) ».
- **Priorités** quand plusieurs choses parlent : dialogue de mission > appel téléphonique > commentaire de Koffi > passants > radio. Un seul sous-titre à la fois ; la source moins prioritaire continue en son, sans texte.
- **Orthographe** : français correct à l'écrit, tournures locales gardées (« On dit quoi ? », « Tu as fait un peu ? », « C'est comment ? », « dêh », « hein » en fin de phrase). Pas d'écriture phonétique qui imiterait un accent (décision 104). Chiffres en chiffres, « FCFA » ou « francs » comme on le dit à l'oral.
- Test : réplique de 100 caractères coupée en 2 sous-titres d'au plus 2 lignes de 42 caractères, sans coupure dans un mot ; durée sans voix d'un texte de 50 caractères = 4,2 s ; première occurrence d'une expression fon avec traduction, la seconde sans ; pendant un dialogue de mission, une conversation de passants n'affiche aucun texte ; l'outil de contrôle signale toute réplique de plus de 168 caractères (2 sous-titres pleins) non découpée à la main.

## Choix de réponses
- Certains dialogues proposent **2 à 4 réponses**. Elles s'affichent en liste au-dessus des sous-titres, numérotées ; chacune fait 40 caractères au plus et dit l'intention, pas la phrase entière (« Refuser poliment », « Marchander », « Faire une blague »). Koffi prononce ensuite la phrase complète.
- **Touches** : 1, 2, 3, 4, ou flèches haut/bas + E ; manette : croix + A. Pendant le choix, le jeu continue autour (pas de pause) sauf dans les cinématiques, où tout attend.
- **Temps de réponse** : pas de limite par défaut. Certains choix sont marqués « pressés » (négociation, contrôle de police, marchandage) : une barre se vide en 8 s ; à la fin, la réponse par défaut de la fiche est prise (toujours la plus prudente, en général se taire ou accepter).
- **Étiquettes** devant une réponse :
  - [FCFA 500] : la réponse coûte ou propose de l'argent ; grisée si Koffi ne l'a pas ;
  - [Mentir] : Koffi est mauvais menteur (décision 10) : un mensonge réussit 1 fois sur 3 face à un inconnu, jamais face à Maman Koffi, Nan Akouavi ou Barnabé ; l'échec est toujours drôle, jamais bloquant ;
  - [Réputation 40] : exige un palier de réputation ; grisée et lisible sinon (le joueur voit ce qui lui manque) ;
  - [Fin] : quitte la conversation.
- **Conséquences**, toutes écrites dans la fiche : prix d'un service ; bagarre évitée ou déclenchée ; réputation ±1 à ±5 ; information obtenue (marqueur sur la carte) ; ton de la relation avec un personnage (compteur par personnage, de −10 à +10, qui choisit des variantes de répliques plus tard) ; objectif facultatif réussi. **Aucun choix ordinaire ne ferme une mission principale** : les deux fins du jeu dépendent du seul choix final du chapitre 6 (décision 98), présenté plein écran, sans chronomètre, avec confirmation.
- **Les deux boussoles** (décision 14) : dans les choix à portée morale, une réponse est celle qu'approuverait Maman Koffi ou Nan Akouavi ; elle n'est pas signalée, mais leurs répliques ultérieures y réagissent.
- **Déjà dit** : une réponse d'information déjà choisie apparaît grisée et se rejoue en version courte.
- **Relance** : si le joueur s'éloigne de plus de 6 m pendant un choix non pressé, le personnage dit « Hé, je te parle ! » ; à 12 m, la conversation s'interrompt et reprendra au même point (E).
- Chaque choix est noté dans l'historique (« Tu as choisi : Marchander »).
- **Règle d'écriture** : au plus 3 choix par mission principale ; pas de choix dont toutes les réponses mènent exactement à la même réplique (sinon, pas de choix).
- Test : conversation d'essai : touche 2 → la branche 2 est jouée et notée dans l'historique ; choix pressé sans réponse : réponse par défaut après 8 s ; réponse à 500 FCFA grisée avec 300 FCFA en poche, sélection impossible ; mensonge face à Barnabé : échec dans 100 % de 50 tirages ; l'outil de contrôle refuse une réponse de plus de 40 caractères, un choix à une seule réponse, et un choix sans réponse par défaut s'il est pressé.

## Lecture des voix
- Toutes les répliques sont **doublées par des voix générées** (décision 108) : une voix propre à chacun des 12 personnages principaux (Koffi, Romaric, Maman Koffi, Tonton Gratien, Nan Akouavi, Le Doyen, Monsieur Fortuné, Capitaine, Expédit, Rachidath, Adjudant Barnabé, Afi), plus le policier corrompu, plus 8 voix de passants (4 femmes, 4 hommes), 4 voix d'animateurs radio et 2 voix de publicité.
- **Fichiers** : `.ogg` mono, 44,1 kHz, volume normalisé à −18 LUFS, 0,1 s de silence au début et à la fin ; un fichier par réplique dans `assets/sons/voix/`.
- **Enchaînement** : les répliques d'une conversation se suivent avec 0,25 s de silence ; 0,1 s pour une interruption (drapeau `coupe`), où la réplique précédente est arrêtée en fondu de 0,1 s.
- **Passer** : Entrée coupe la réplique en cours (fondu 0,1 s) et lance la suivante.
- **Dans l'espace** : en jeu, la voix sort du personnage (son 3D, pleine puissance jusqu'à 4 m, inaudible à 25 m) ; celle de Koffi est toujours au centre ; en cinématique, toutes les voix sont au centre avec un léger décalage gauche/droite selon la place à l'image.
- **Filtres** : téléphone (bande 300-3 400 Hz, léger grésillement), radio (compression, voir `radio_en_voiture.md`), casque de moto (Koffi et son passager : aigus atténués de 3 dB, bruit de vent selon la vitesse), intérieur de voiture (extérieur atténué de 8 dB).
- **Mixage** : pendant une réplique de mission, la musique et la radio baissent de 8 dB (retour en 0,5 s après), le moteur de 4 dB.
- **Commentaires de Koffi** (décision 107) : en conduisant ou en marchant, il lâche une phrase sur ce qui se passe. Déclencheurs et listes : choc (12 phrases), embouteillage (10), pluie (8), harmattan (6), beau virage ou pointe de vitesse (8), sirène derrière lui (8), client à bord (20), passage devant un lieu connu (2 par lieu), argent gagné (8), argent perdu (8), faim (4), panne sèche (4), nuit (6). Au plus un commentaire toutes les 25 s, jamais pendant un dialogue ou un appel ; une même phrase pas avant 15 minutes réelles. Option des menus : fréquence « bavard » (25 s), « normal » (50 s), « discret » (120 s). Exemples : « Voilà, c'est pour ça que les gens prennent le zém. » (embouteillage) ; « Romaric va me tuer. Enfin, me parler pendant deux heures. C'est pareil. » (choc avec la moto prêtée) ; « La pluie de Cotonou, elle ne prévient pas, elle arrive. » (pluie).
- **Âge** (décision 8) : la voix de Koffi est la même du chapitre 1 au chapitre 6 ; seuls le débit et l'assurance changent dans l'écriture.
- **Réplique sans fichier** (voix pas encore générée) : le sous-titre s'affiche pour la durée calculée et le jeu note l'identifiant dans `user://voix_manquantes.txt` ; jamais de blocage.
- **Prononciation** : fiche de prononciation à fournir au générateur pour les noms de lieux et de personnes (Dantokpa, Missèbo, Fidjrossè, Akpakpa, Ganhi, Akouavi, Rachidath, kpayo, zémidjan) et les expressions fon ; une réplique mal prononcée est régénérée, pas gardée « pour l'accent ».
- **Volume** : curseur « Voix » séparé de « Musique » et « Bruitages ».
- Test : conversation d'essai de 6 répliques : chaque fichier est lu en entier, dans l'ordre, avec 0,25 s ± 0,05 d'écart ; Entrée passe à la suivante en moins de 0,2 s ; musique à −8 dB pendant la réplique ; pas plus d'un commentaire de Koffi par 25 s sur 10 minutes simulées de conduite avec chocs ; fichier manquant : sous-titre affiché, identifiant écrit dans le fichier de suivi ; l'outil de contrôle liste les répliques sans fichier et les fichiers sans réplique.

## Mouvement des lèvres simplifié
- Pas de synchronisation labiale par phonèmes : le style du jeu (voir `docs/style_graphique.md`) permet un mouvement simple, piloté par le **volume de la voix**.
- **Mâchoire** : un seul os (ou une forme) « bouche ouverte », de 0 à 1. À chaque image : `ouverture = volume lissé de la voix × gain`, plafonnée à 1 ; lissage : montée en 0,05 s, descente en 0,10 s ; en dessous d'un seuil (−40 dB), bouche fermée. Angle de la mâchoire à 1 : 14°.
- **Trois formes de bouche** pour éviter l'effet « marionnette » : fermée, mi-ouverte, ouverte-arrondie ; on alterne mi-ouverte et arrondie à chaque pic de volume (toutes les 0,12 à 0,25 s).
- **Précalcul** : l'enveloppe de volume de chaque fichier de voix est calculée à l'import (30 valeurs par seconde, fichier `.env` à côté du `.ogg`) : aucun calcul audio en jeu.
- **Regard et tête** : celui qui parle regarde son interlocuteur (rotation de la tête jusqu'à 60°, des yeux jusqu'à 25°) ; petit hochement à chaque début de phrase (2°) ; clignement toutes les 3 à 6 s (0,12 s).
- **Humeur** : chaque réplique peut porter une humeur qui règle les sourcils et les coins de la bouche (5 poses : neutre, content, fâché, inquiet, moqueur), tenue pendant la réplique, fondu de 0,2 s.
- **Gestes** : 6 gestes de conversation réutilisables (main ouverte, doigt levé, bras croisés, mains sur les hanches, haussement d'épaules, main sur le front), déclenchés par la fiche ou au hasard toutes les 4 à 8 s pour qui parle plus de 3 s.
- **Où cela s'applique** : personnages principaux et passants complets à moins de 12 m de la caméra. Au-delà, ou pour les passants simplifiés : pas de bouche, seulement un léger mouvement de tête. Casque de moto (visière) : rien ; on fait bouger la tête et les épaules.
- **Koffi de dos** en vue à la troisième personne : quand il parle, tête qui tourne un peu vers l'interlocuteur et geste de la main ; pas de bouche visible.
- **Téléphone** : Koffi porte la main à l'oreille ; à moto, il parle dans le casque (pas de main levée).
- Test : avec un fichier d'essai (0,5 s de son, 0,5 s de silence, 0,5 s de son) : ouverture supérieure à 0,5 pendant les sons, inférieure à 0,05 après 0,15 s de silence ; jamais plus de 1 ; passant à 15 m : os de la mâchoire immobile ; le fichier d'enveloppe existe pour chaque voix ; tête tournée vers l'interlocuteur à moins de 60°.

## Expressions fon élémentaires
- Règle (décision 106) : seulement des **salutations et exclamations**, jamais une phrase d'intrigue ; le joueur qui ne connaît pas le fon ne doit rien perdre. La liste ci-dessous est **la proposition à soumettre à Bravo** ; aucune expression n'entre dans une réplique avant son accord, et toute la liste doit être relue par une personne qui parle fon (orthographe, tons, usage). En attendant, les fiches portent le drapeau `fon_a_valider`.
- Orthographe : simplifiée pour l'écran (pas de caractères spéciaux ni de marques de ton), en italique.

| Expression (écran) | Sens affiché | Usage dans le jeu |
|---|---|---|
| *Kwabô* | Bienvenue | accueil dans une boutique, une maison ; retour de Koffi au chapitre 1 ; nom du paiement mobile fictif |
| *A fon ganji a ?* | Bien réveillé ? | salutation du matin (5 h-11 h), surtout Maman Koffi et les vendeuses |
| *Een, un fon ganji* | Oui, bien réveillé | réponse à la précédente |
| *Kudo zanzan* | Bonjour (le matin) | salutation de passants le matin |
| *Kudo gbada* | Bonsoir | salutation à partir de 18 h |
| *Kudo azon* | Bon travail | à quelqu'un qui travaille : entre zémidjans, à un mécanicien, à une vendeuse |
| *A do ganji a ?* | Ça va ? | salutation à toute heure |
| *A wanu* | Merci | après une course, un achat, un service |
| *A wanu kaka* | Merci beaucoup | après un pourboire, une aide |
| *E yi zaande* | À tout à l'heure | en se quittant |
| *O dabo* | Au revoir | en se quittant |
| *Agoo !* | Attention, laissez passer ! | porteurs au marché, Koffi qui se faufile |
| *Kaï !* | (exclamation de surprise) | choc, mauvaise nouvelle ; non traduit |
| *Éééé !* | (exclamation d'étonnement ou de reproche) | passants ; non traduit |
| *Tchié !* | (exclamation d'agacement) | embouteillage, prix trop haut ; non traduit |

- Mots d'usage courant déjà admis par les décisions et employés comme des noms communs français, sans italique ni traduction répétée : zémidjan (ou « zém »), kpayo, tokpa-tokpa, maquis. Ajout proposé : *kèkènon* (conducteur de zémidjan), utilisé comme interpellation (« Kèkènon ! »), à valider avec la liste.
- **Dosage** : au plus une expression fon par conversation de moins de 6 répliques, deux au-delà ; jamais deux à la suite ; Koffi en emploie moins au chapitre 1 (il revient de Lagos : Romaric le taquine là-dessus une fois) et davantage ensuite.
- **Qui les emploie** : surtout Maman Koffi, Nan Akouavi, le Doyen, les vendeuses et les zémidjans ; presque jamais Monsieur Fortuné (français soigné), ce qui le caractérise sans le dire.
- **Voix** : prononciation fournie au générateur par la fiche de prononciation ; un enregistrement de référence par expression est demandé à Bravo ou à un proche (15 fichiers courts).
- **Technique** : les expressions sont déclarées dans `dialogues/fon.json` (clé, texte d'écran, sens, drapeau `valide`). Une réplique y fait référence par `{fon:kwabo}` ; le moteur met l'italique, gère la traduction à la première occurrence, et l'outil de contrôle refuse toute clé absente ou non validée dans une version publique.
- Interdits : expression à sens religieux ou rituel, proverbe attribué à une ethnie, insulte, mot inventé « qui sonne fon ».
- Test : l'outil de contrôle compte les expressions par conversation et refuse le dépassement ; une clé inconnue fait échouer la vérification ; avec `valide = faux`, la construction « version publique » échoue et la construction d'essai affiche l'expression suivie de « (à valider) » ; première occurrence traduite, suivantes non.

## Historique
- Le joueur peut relire ce qui vient d'être dit : touche **U** en jeu (ou menu de pause → « Dialogues »). Le jeu se met en pause.
- **Contenu** : les 200 dernières répliques entendues (dialogues de mission, appels, messages vocaux, choix faits : « → Tu as choisi : Marchander »), dans l'ordre, de la plus récente en bas à la plus ancienne en haut ; nom du personnage en couleur, texte complet (non découpé en sous-titres), heure du jeu en marge, séparateur avec le titre de la mission ou « En ville ».
- **N'y figurent pas** : commentaires de Koffi, conversations de passants, radio (sauf les flash info liés à l'histoire, marqués « Radio »).
- **Réécouter** : E sur une réplique rejoue sa voix.
- **Défilement** : flèches (une réplique), Page précédente/suivante (dix), Début/Fin ; manette : stick et gâchettes.
- **Expressions fon** : toujours suivies de leur sens dans l'historique.
- **Durée de vie** : l'historique est gardé pour la séance en cours et **sauvegardé** dans la limite des 200 répliques (identifiants seulement, pas le texte : le texte est relu dans les fichiers de dialogue, ce qui permettra l'anglais plus tard, décision 117).
- **Rappel d'objectif** : en tête de l'historique, l'objectif en cours et la dernière consigne importante de la mission (réplique marquée `consigne` dans la fiche), pour qui reprend le jeu après une pause.
- **Journal de missions** : les scènes complètes des missions terminées se revoient depuis le journal (`moteur_de_missions.md`), pas depuis l'historique.
- Cas limites : réplique passée avec Entrée : elle figure quand même en entier ; conversation interrompue : les répliques non dites n'y figurent pas ; nouvelle partie : historique vide.
- Test : après la conversation d'essai : 6 répliques et 1 ligne de choix, dans l'ordre ; une 201e réplique chasse la plus ancienne ; E rejoue le bon fichier ; une réplique passée à 10 % de sa durée est présente en entier ; après sauvegarde et rechargement, l'historique est identique ; aucun commentaire de Koffi dedans.

## Choix faits par Claude (à confirmer)
- Liste de 15 expressions fon proposée, non utilisable avant validation par Bravo et relecture par un locuteur ; orthographe d'écran simplifiée.
- Lèvres pilotées par le volume de la voix, sans phonèmes.
- Touche U pour l'historique ; touches 1 à 4 pour les réponses.
- Aucun choix de dialogue ne ferme une mission principale ; seul le choix final du chapitre 6 décide de la fin.
