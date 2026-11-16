# Mission 3.8 — Le don de Monsieur Fortuné

Tâches couvertes : T3844 (synopsis), T3845 (objectifs et échecs), T3846 (dialogues), T3847 (expressions fon). Rédigé le 16 novembre 2026.

- **Type :** infiltration sans arme, à pied, de jour (INF), avec une partenaire à guider.
- **Date dans l'histoire :** un samedi de septembre 2020, de 10 h à 10 h 45. Plein soleil.
- **Durée visée :** 10 minutes.
- **Disponible :** après 3.7, créneau 9 h-10 h 30. Déclencheur : appel de Rachidath (« Je vous avais dit que je rappellerais »), marqueur à l'Étoile Rouge.
- **Véhicule :** moto de Romaric pour le trajet Étoile Rouge → Akpakpa (sans épreuve) ; tout le reste à pied.
- **Récompense :** 15 000 FCFA (« guide et chauffeur », payés par « Le Fanal »).
- **Identifiants des répliques :** `c3m8_<personnage>_<numéro>`.

Ce qui la distingue de la 3.7 : voir le tableau en tête de `mission_3_07.md` (ici : à pied, de jour, un seul bâtiment, des gardes à pied, une partenaire, pas de police).

## Lieux
**Place de l'Étoile Rouge.** Estrade de 8 × 4 m sur le terre-plein nord, banderole blanche « Les Établissements Fortuné aux côtés des familles », cent sacs de riz empilés en pyramide (le nom « Fortuné » imprimé sur chaque sac), trois caméras, une soixantaine de personnes espacées. Koffi et Rachidath regardent depuis le trottoir d'en face, à 50 m.

**Entrepôt d'Akpakpa (quartier PK3), le même qu'en 3.5.** Plan pour le niveau :
| Zone | Dimensions | Contenu |
|---|---|---|
| Cour | 60 × 25 m, mur de 3 m | Portail coulissant gris (côté rue), guérite, deux tricycles blancs garés, tas de palettes, groupe électrogène |
| Brèche | Côté terrain vague, derrière le manguier | Le mur s'est effondré sur 1,5 m ; il reste un muret de 1 m, franchissable d'un saut |
| Hangar | 40 × 25 m, 8 m de haut | Travées de sacs empilés (couloirs de 2 m), quai de chargement avec un poste de radio |
| Bureau | À l'étage, 5 × 4 m, escalier métallique de 14 marches | Porte fermée à clé, fenêtre sur le hangar, armoire à classeurs, quatre bordereaux à trouver (bureau, armoire, corbeille de courrier, tableau mural) |
| Guérite | 2 × 2 m | Tableau à clés ; la clé du bureau porte une étiquette rouge |

**Gardes (six Crampons, maillots de football dépareillés, aucun n'est armé) :**
| N° | Poste | Comportement |
|---|---|---|
| 1 et 2 | Portail, côté rue | Fixes, regardent la rue ; n'entrent pas |
| 3 | Guérite | Écoute la cérémonie sur son téléphone ; sort boire au robinet de la cour toutes les 50 s pendant 15 s |
| 4 | Cour | Ronde de 70 s autour des tricycles et des palettes |
| 5 | Quai de chargement | Assis près du poste de radio, dos au hangar |
| 6 | Hangar | Ronde de 90 s dans les travées ; monte l'escalier du bureau une fois (événement écrit, étape 8) |

## Personnages présents
Koffi, Rachidath, Monsieur Fortuné (sur l'estrade puis voix à la radio), Capitaine (au pied de l'estrade), six Crampons, l'animateur de la cérémonie (voix).

## Synopsis
Septembre 2020. Le sac de riz est toujours à 28 000 FCFA, et Monsieur Fortuné a décidé d'être généreux.
Devant trois caméras, à l'Étoile Rouge, il offre cent sacs « aux familles éprouvées », son nom imprimé sur chacun.
Rachidath a fait le calcul : cent sacs donnés, plus de neuf mille gardés. Il lui manque la preuve écrite.
La cérémonie est sa chance : Capitaine et ses meilleurs hommes surveillent l'estrade, l'entrepôt d'Akpakpa n'a plus que six gardes.
Koffi l'y conduit, et cette fois ils entrent, à pied, par une brèche du mur.
Dans le hangar, la radio retransmet le discours : tant que Fortuné parle, personne n'attend de visite.
Koffi ouvre la route, détourne les gardes avec un caillou sur une tôle ou un poste de radio poussé à fond.
Rachidath avance de cachette en cachette à son signal, et c'est elle qui tient l'appareil.
Il faut la clé du bureau, pendue dans la guérite, puis quatre bordereaux à photographier.
Les papiers disent ce que les sacs disaient déjà : 9 240 sacs entrés en juillet, aucun sorti.
Un garde monte l'escalier ; Koffi fait tomber une pile de palettes dans la cour pour le rappeler en bas.
Ils ressortent par la brèche pendant les applaudissements. Personne n'a été touché.
Le lundi suivant, « Le Fanal » titre « Le riz qui dort », et Fortuné apprend le nom d'une journaliste.

## Règles de la mission
- **Horloge :** le discours. Une barre « Discours de M. Fortuné » se vide en 7 min réelles à partir de l'entrée par la brèche (Tranquille 8 min 30, Corsé 6 min). À la fin, Capitaine et quatre hommes rentrent : échec si Koffi et Rachidath sont encore dans l'enceinte.
- **Perception des gardes :** règles de `comportement_des_adversaires.md` (cône de 110°, 30 m de jour, accroupi : repérage deux fois plus lent, « ? » puis « ! »).
- **Diversions :**
  - **Caillou** (touche de lancer, portée 25 m, cailloux à ramasser dans la cour, 3 au plus sur soi) : le garde le plus proche du bruit, à moins de 15 m du point de chute, va voir pendant 15 s.
  - **Poste de radio du quai** (E dans le dos du garde n° 5, quand le n° 6 est loin) : volume à fond ; les gardes n° 5 et n° 6 n'entendent plus les pas pendant 60 s.
  - **Pile de palettes** (E, une seule fois, depuis la fenêtre du bureau au bout d'une corde de bâche) : fracas dans la cour, les gardes n° 4 et n° 6 y vont pendant 25 s.
- **Rachidath :** elle reste accroupie à sa cachette. « Signal » (touche de sifflement bas) : elle rejoint la cachette suivante en vue de Koffi (course de 10 m/s, 8 cachettes balisées). Elle ne part pas si un garde regarde dans sa direction (elle répond « Pas maintenant »).
- **Être vu :** un garde en « ! » rouge sur Koffi : Koffi a 20 s pour rompre la ligne de vue et se cacher, sinon échec. Un « ! » rouge sur Rachidath : échec immédiat. Deuxième alerte rouge sur Koffi : échec.
- **Pas de bagarre :** frapper un garde déclenche l'alerte générale (échec). La mission se termine sans un coup.

## Déroulement
| N° | Objectif affiché | Déclencheur | Réussite | Échec |
|---|---|---|---|---|
| 1 | « Rejoins Rachidath à l'Étoile Rouge » | Appel | Marqueur sur le trottoir sud ; cinématique de la cérémonie (50 s, passable) | Aucun |
| 2 | « Conduis Rachidath à l'entrepôt d'Akpakpa » | Fin de la cinématique | Marqueur sous le manguier du terrain vague | Santé à 0 ; 2 étoiles ; plus de 4 min |
| — | **Point de contrôle 1** | Arrivée sous le manguier | — | — |
| 3 | « Entre par la brèche du mur » | À pied | Koffi dans la cour (barre du discours lancée) | Vu par les gardes n° 1 ou 2 en passant devant le portail |
| 4 | « Prends la clé à étiquette rouge dans la guérite » | Entrée dans la cour | Clé ramassée pendant que le garde n° 3 est au robinet, ou après un caillou | Alerte rouge non rompue en 20 s ; deuxième alerte ; fin du discours |
| 5 | « Fais avancer Rachidath jusqu'au quai (signal) » | Clé en poche | Rachidath à la cachette n° 4 (derrière les fûts du quai) | Comme l'étape 4 ; Rachidath vue |
| 6 | « Couvre le bruit : monte le son de la radio » | Rachidath au quai | Volume à fond | Comme l'étape 5 |
| 7 | « Monte au bureau avec Rachidath et ouvre la porte » | Radio à fond | Tous deux dans le bureau, porte refermée | Comme l'étape 5 |
| — | **Point de contrôle 2** | Porte du bureau refermée | Discours rendu : 3 min 15 au moins | — |
| 8 | « Trouve les 4 bordereaux (E) pendant que Rachidath photographie » | Dans le bureau | 4 bordereaux désignés ; chaque photo prend 8 s. Au 3e, le garde n° 6 s'approche de l'escalier : « Fais diversion : la corde des palettes » | Le garde atteint la 10e marche (12 s) sans diversion ; fin du discours |
| 9 | « Ressors par la brèche avec Rachidath » | 4e photo | Tous deux dans le terrain vague | Comme l'étape 5 |
| 10 | « Quitte le quartier » | Sortie | S'éloigner de 200 m à moto | Santé à 0 |

**Prime :** aucun « ! » orange ni rouge de toute la mission : + 3 000 FCFA et réplique 055.

## Dialogues

### Étape 1 — Étoile Rouge (cinématique)
001 ANIMATEUR : Mi kwabo [bienvenue à vous] ! Mesdames et messieurs, un bienfaiteur, un ami des familles : Monsieur Fortuné !
002 FORTUNÉ : Merci, merci. Dans l'épreuve, chacun doit donner ce qu'il peut. Moi, je peux cent sacs.
003 KOFFI : Cent sacs avec son nom dessus. Il a peur que le riz oublie qui l'a acheté.
004 RACHIDATH : Cent donnés ici. Combien gardés là-bas ? C'est la seule question.
005 FORTUNÉ : On dit que les prix montent. Cela m'inquiète sincèrement. Le désordre coûte cher à tout le monde.
006 KOFFI : Regardez à droite de l'estrade. Capitaine. Et ses meilleurs hommes avec lui.
007 RACHIDATH : Donc ils ne sont pas à Akpakpa. Le discours dure quarante minutes, j'ai le programme.
008 KOFFI : Vous voulez entrer ? Dans l'entrepôt ? En plein jour ?
009 RACHIDATH : Il me faut des papiers, pas des sacs. Une preuve, c'est une rumeur ; deux, c'est un article.
010 KOFFI : Et moi, je fais quoi là-dedans ?
011 RACHIDATH : Vous passez devant et vous me dites quand avancer. Je photographie. Chacun son métier.

### Étape 2 — trajet à moto
012 KOFFI : La dernière fois, on est restés sous l'arbre. Cette fois on entre. Ma mère ne doit jamais le savoir.
013 RACHIDATH : La mienne lit le journal. Elle le saura lundi.
014 KOFFI : S'ils nous voient, on court. On ne tape personne. D'accord ?
015 RACHIDATH : Je suis journaliste, Koffi. Je ne tape qu'à la machine.

### Étapes 3 et 4 — la brèche, la guérite
016 KOFFI : Un muret. Je saute, je regarde, je vous siffle. Tout bas.
017 RACHIDATH : Vous savez siffler tout bas ?
018 KOFFI : Non. On va apprendre ensemble.
019 CRAMPON 3 : (au téléphone, écoutant la cérémonie) Le patron parle bien quand même. Nous on garde les sacs, lui il garde le micro.
020 KOFFI : (chuchoté) Il va boire. Étiquette rouge, étiquette rouge… Je l'ai.
021 CRAMPON 4 : (bruit de caillou) Eh ? C'est quoi ? … Encore la tôle qui travaille au soleil.

### Étapes 5 à 7 — le quai et l'escalier
022 KOFFI : (signal) Maintenant. Derrière les fûts.
023 RACHIDATH : (garde tourné vers elle) Pas maintenant.
024 RACHIDATH : (arrivée à la cachette) J'y suis. Vous sifflez comme une bouilloire.
025 FORTUNÉ : (radio du quai) … car l'ordre, chers amis, c'est d'abord le respect des circuits…
026 CRAMPON 5 : Le respect des circuits. Moi je respecterais bien un déjeuner.
027 KOFFI : (chuchoté, après la radio à fond) Voilà. Merci, Monsieur Fortuné, parlez plus fort.
028 CRAMPON 6 : Baisse ça ! … Bon, laisse, c'est le patron.
029 KOFFI : L'escalier. Quatorze marches en fer. Dèdè [doucement], dèdè…
030 RACHIDATH : La clé tourne ? Dites-moi que la clé tourne.
031 KOFFI : Elle tourne. Entrez, je referme.

### Étape 8 — le bureau
032 RACHIDATH : Cherchez tout ce qui porte un tampon du magasin. Je photographie.
033 KOFFI : (1er bordereau) Ici ! « Entrées juillet : 4 800 sacs ».
034 RACHIDATH : Un. Ne le déplacez pas, je le prends où il est.
035 KOFFI : (2e) « Entrées août : 4 440 sacs ». Et la colonne « sorties »… elle est vide.
036 RACHIDATH : Deux. Neuf mille deux cent quarante. Aucun sorti depuis deux mois.
037 KOFFI : (3e) Dans la corbeille : « Consigne : ne rien livrer avant nouvel ordre ». Avec une signature.
038 RACHIDATH : Trois. Ça, c'est la moitié de mon titre.
039 KOFFI : Quelqu'un vient vers l'escalier ! Les palettes… la corde, là, par la fenêtre.
040 CRAMPON 6 : (fracas dans la cour) Qu'est-ce qui est tombé encore ? Qui a empilé ça comme un débutant ?
041 CRAMPON 4 : C'est toi qui les as empilées !
042 KOFFI : (4e) Sur le tableau : la liste des cent sacs du don. « Lot abîmé par l'humidité, à écouler. »
043 RACHIDATH : Quatre. Il donne les sacs mouillés. Koffi, ne riez pas, vous allez nous faire prendre.
044 KOFFI : Je ne ris pas. Je m'étouffe poliment.

### Étapes 9 et 10 — sortie et réussite
045 FORTUNÉ : (radio) … et je vous remercie de votre confiance.
046 KOFFI : Il a fini. Ils applaudissent. On sort avec les applaudissements.
047 RACHIDATH : (signal) J'arrive. Ne sifflez plus jamais, par pitié.
048 KOFFI : Dehors ! Vous avez tout ?
049 RACHIDATH : Quatre bordereaux, une consigne signée. La deuxième preuve.
050 KOFFI : Et personne n'a pris un coup. Même pas une palette. Enfin, si, les palettes.
051 RACHIDATH : Lundi, « Le riz qui dort », en première page. Votre nom n'y sera pas.
052 KOFFI : Awanou. [Merci.] Mon nom, moins Monsieur Fortuné le lit, mieux je dors.
053 RACHIDATH : Le mien, il va le lire. C'est le métier.
054 KOFFI : Alors mangez bien dimanche. À partir de lundi, il va « s'inquiéter » pour vous.
055 RACHIDATH : (prime) Pas une alerte. Vous mentez mal, mais vous vous cachez très bien.

### Échecs
056 CRAMPON 4 : (alerte non rompue) Eh ! Toi, le maillot vert ! Fermez le portail !
057 CRAMPON 6 : (Rachidath vue) Une femme avec un appareil photo ! Appelez Capitaine !
058 CAPITAINE : (fin du discours) Quelqu'un est entré sur mon terrain pendant le match ? Carton rouge. Trouvez-les.
059 CRAMPON 6 : (escalier, sans diversion) La porte du bureau est ouverte ? Qui est là-haut ?
060 RACHIDATH : (garde frappé) Vous l'avez frappé ? Maintenant c'est nous, l'histoire. Je ne peux plus rien publier.
061 KOFFI : (étape 2, 2 étoiles) Arriver à une infiltration avec la police derrière soi. Bravo, Koffi.
