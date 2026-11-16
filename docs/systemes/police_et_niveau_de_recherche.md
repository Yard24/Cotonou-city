# Police et niveau de recherche : fonctionnement attendu

Code proposé : `scripts/recherche.gd` (étoiles, infractions, zone de recherche), `scripts/police.gd` (agents, véhicules, poursuite, arrestation), `scripts/barrage.gd`. Vérifications : `scripts/selftest_police.gd`, sur un quartier d'essai en damier de 400 × 400 m, tirage fixé.

Cadre (à respecter à la lettre) : étoiles de 1 à 5 (décision 73) ; la police ne tire que dans des scènes d'histoire écrites (75) : en jeu libre, **aucun tir**, à aucun niveau ; arrestation = amende et retour devant le commissariat, on garde ses véhicules (76) ; proposer de l'argent est risqué (77) ; la corruption est toujours réprimée (19) ; uniforme inventé bleu nuit (45). Le joueur n'a pas d'arme à feu (3). Temps : 1 heure de jeu = 2 minutes réelles.

## Niveau de recherche
- Affiché en haut à droite : 5 étoiles, pleines selon le niveau ; elles clignotent quand la police a perdu Koffi de vue (voir « Fin de recherche »).
- **Infractions**. Une infraction ne compte que si elle est **vue** : par un policier à moins de 50 m avec ligne de vue (effet immédiat), ou par un témoin qui téléphone (effet après 6 s, voir `pietons.md`). Sans témoin ni policier : rien.

| Infraction | Effet |
|---|---|
| Bousculer 6 passants en 30 s devant un agent | 1 étoile (après un avertissement) |
| Frapper un passant | 1 étoile |
| Renverser un passant | 1 étoile ; 2 s'il y en a 3 en moins de 60 s |
| Percuter un véhicule de la circulation et repartir (plus de 25 points de dégâts causés) | 1 étoile |
| Emprunter un véhicule occupé | 0 la première fois ; 1 étoile si le joueur recommence dans les 24 h de jeu, ou tout de suite à moins de 50 m d'un policier (décision 54) |
| Emprunter un véhicule garé | 0, sauf devant un policier : 1 étoile |
| Bagarre de rue avec des adversaires (non passants) | 1 étoile seulement devant un policier |
| Forcer un contrôle ou fuir un agent qui a sifflé | passe à 2 étoiles |
| Percuter un véhicule de police | +1 étoile (2 au moins) |
| Frapper un policier | +2 étoiles (3 au moins) |
| Forcer un barrage | +1 étoile (4 au moins) |
| Entrer dans une zone interdite (quais sous douane du port, pistes de l'aéroport) | 2 étoiles après 10 s de sommation |
| Transporter de la contrebande (missions) devant un contrôle | 2 étoiles |

- Le niveau ne monte que par ces événements, jamais seul avec le temps. Plafond 5. Au-delà du niveau 3, il faut des actes graves répétés : 4 = barrage forcé ou 3 véhicules de police percutés ; 5 = tout cela pendant plus de 3 minutes réelles à 4 étoiles, ou un second barrage forcé.
- **Ce qui est déployé** (cumulatif) :

| Étoiles | Forces | Comportement |
|---|---|---|
| 1 | 1 agent à pied ou 1 motard | siffle, veut verbaliser sur place |
| 2 | 1 voiture de patrouille (2 agents) + le motard | poursuite, tente de bloquer |
| 3 | 3 voitures + 2 motards, barrages sur les axes | encerclement |
| 4 (proposé) | 4 voitures, 2 pick-up de brigade (4 agents chacun, descendent à pied), herses aux barrages | les véhicules poussent celui du joueur |
| 5 (proposé) | 6 voitures, 3 pick-up, ponts et sorties du quartier fermés, Adjudant Barnabé en personne dans un pick-up | bouclage : la zone de recherche ne se quitte plus par la route |

- Difficulté : en « Tranquille », le niveau 5 n'existe pas (plafond 4) et une unité de moins à chaque niveau ; en « Corsé », une voiture de plus dès 2 étoiles.
- Dans toutes les situations, les policiers n'utilisent que le sifflet, la matraque (pour maîtriser, 10 points de santé par coup, voir `combat.md`), leurs véhicules et les barrages.
- Pendant une recherche : pas de sauvegarde, pas de zémidjan ni de taxi, pas de travail, boutiques fermées au joueur (« Reviens quand tu seras tranquille »).
- Test : chaque ligne du tableau d'infractions jouée devant un policier donne le niveau attendu, et rien sans témoin ; premier emprunt de véhicule occupé loin de tout agent : 0 ; second dans la journée : 1 ; même geste à 40 m d'un agent : 1 ; jamais plus de 5 ; à chaque niveau, le nombre d'unités créées en 60 s correspond au tableau ; aucun projectile tiré sur 10 minutes simulées à 5 étoiles.

## Patrouilles
- Présence ordinaire, sans recherche :
  - **Agents à pied**, par deux : un binôme à chaque grand carrefour en journée (Étoile Rouge, Place de l'Amazone, entrée de Dantokpa, Ganhi-Banques, entrées des ponts), 6 h-21 h. Ils marchent dans un rayon de 40 m autour de leur poste, règlent la circulation aux heures de pointe (un agent au milieu du carrefour, gestes des bras).
  - **Motards** : 3 dans toute la ville, sur des boucles de 2 à 3 km, à 40 km/h.
  - **Voitures de patrouille** (berline blanche à bande bleu nuit, rampe lumineuse) : 2 le jour, 4 la nuit, sur des boucles de boulevards, à 35 km/h.
  - **Contrôles routiers** : 2 points fixes par jour de jeu, tirés parmi 8 emplacements, de 9 h à 12 h et de 21 h à 24 h : deux agents, une moto, des cônes. Ils arrêtent 1 véhicule sur 5 de la circulation (20 s) et **toujours** le joueur s'il a plus de 50 points de dégâts, roule sans phare la nuit ou porte la chemise jaune sans carte de conducteur (chapitre 1). Contrôle : dialogue de 2 répliques ; en règle : on repart ; pas en règle : contravention de 1 000 FCFA (ou « petit geste », voir « Amende »). Forcer le contrôle : 2 étoiles.
- **Champ de vision** d'un agent : cône de 120°, portée 50 m le jour, 30 m la nuit hors éclairage public, 20 m sous forte pluie ou harmattan épais ; il faut une ligne de vue (les bâtiments, les camions et les étals cachent). Ouïe : il se retourne vers un choc de véhicules ou des cris à moins de 40 m.
- **Chapitres** : chapitre 3 : patrouilles doublées la nuit, couvre-feu de 21 h à 5 h (être dehors devant un agent : sommation, puis 1 étoile si on ne rentre pas) ; chapitre 4 : agents postés aux chantiers.
- L'Adjudant Barnabé (décision 38) patrouille à Dantokpa en journée : c'est un agent « droit » ; le policier corrompu (décision 39) tient un contrôle à Missèbo aux chapitres 2 à 4, puis disparaît (arrêté).
- Création et retrait hors champ, comme les passants ; jamais plus de 12 policiers actifs hors recherche.
- Test : à 10 h, un binôme à chacun des postes listés ; aucun binôme à 23 h ; 4 voitures la nuit ; un agent ne voit pas le joueur derrière un mur à 10 m, le voit à 45 m en terrain dégagé de jour, pas à 45 m de nuit sans éclairage ; contrôle : le joueur en règle repart sans frais, 1 000 FCFA avec 60 points de dégâts.

## Poursuite à pied
- Un agent qui poursuit court à **9 m/s** (Koffi : 10 m/s) ; il a 25 s d'endurance, puis retombe à 6 m/s pendant 10 s. Koffi, lui, n'a pas encore de jauge d'endurance (voir `joueur_a_pied.md`) : quand elle existera, garder l'avantage de 1 m/s.
- **Sommation** : à 1 étoile, l'agent siffle et crie « Hé ! Arrête-toi là ! ». Si Koffi s'immobilise 2 s à moins de 8 m, l'agent vient à lui : arrestation douce (voir « Arrestation »). S'il s'éloigne de plus de 15 m après le sifflet : 2 étoiles.
- **Obstacles** : l'agent franchit les murets jusqu'à 1,2 m (1 s, plus lent que Koffi : 0,45 s), ne monte pas sur les toits ni sur les empilements de caisses de plus de 1,5 m, ne saute pas dans l'eau (il longe la rive et appelle une pirogue à partir de 3 étoiles), ne traverse pas une foule de marché plus vite que 4 m/s (Koffi : 6 m/s).
- **Rattraper** : à moins de 1,5 m, l'agent tente une saisie (0,6 s). Koffi qui court en ligne droite est saisi ; un changement de direction de plus de 60° ou une esquive (voir `combat.md`) dans les 0,4 s fait rater la saisie, l'agent trébuche 1,2 s. Trois saisies ratées : l'agent sort la matraque (coup de 10 points, ralentit Koffi à 5 m/s pendant 1,5 s).
- **Coordination** : dès 2 étoiles, les agents à pied se répartissent : un suit, un coupe par la rue parallèle. Un agent qui perd Koffi de vue va au dernier endroit où il l'a vu, regarde autour 5 s, puis fouille 3 cachettes proches (voir « Fin de recherche »).
- **Monter dans un véhicule** : si Koffi monte en voiture à moins de 3 m d'un agent, l'agent ouvre la portière et le sort (arrestation) si le véhicule ne dépasse pas 10 km/h dans la seconde. À moto, l'agent attrape le porte-bagages : la moto ne dépasse pas 15 km/h pendant 1 s, puis il lâche.
- Les passants s'écartent ; un passant « courageux » sur dix tend la jambe au passage de Koffi à 2 étoiles et plus (ralentissement à 5 m/s pendant 1 s, sans chute).
- Les agents ne frappent jamais un Koffi immobile ou accroupi les mains levées (rester immobile 1 s = se rendre).
- Test : ligne droite de 100 m, agent parti 5 m derrière : pas de saisie avant 45 m ; arrêt du joueur : arrestation en moins de 4 s ; slalom entre des poteaux : au moins une saisie ratée et un trébuchement ; muret franchi par l'agent en 1 s ; caisses de 2 m non franchies ; dans la foule, l'écart grandit ; joueur immobile jamais frappé.

## Poursuite en voiture
- **Véhicules** : voiture de patrouille (maximum 115 km/h, un peu moins que la voiture du joueur : 122), moto de police (100 km/h, plus que la moto de zémidjan : 94), pick-up de brigade (105 km/h, lourd : c'est lui qui pousse).
- **Comportement par niveau** :
  - 1 étoile : le motard se place à côté et fait signe de se ranger ; s'arrêter moins de 5 s après = contravention simple. Ne pas s'arrêter après 10 s : 2 étoiles.
  - 2 étoiles : la patrouille suit à 15 m, sirène et rampe allumées, et tente de se placer devant pour ralentir (elle freine devant le joueur).
  - 3 étoiles : deux voitures encadrent (une derrière, une à côté), la troisième prend une rue parallèle pour couper la route ; barrages.
  - 4 étoiles : les pick-up poussent l'arrière du véhicule du joueur en virage (perte de 20 à 40° de cap, 5 à 10 points de dégâts) ; herses.
  - 5 étoiles : bouclage ; toutes les unités convergent.
- **Prudence de la police** : elle ne roule jamais sur un trottoir occupé, freine pour les piétons (c'est une faille que le joueur peut exploiter, mais renverser des passants en fuyant monte le niveau), ne percute pas un véhicule de la circulation exprès. Dans les marchés et les « vons » de 5 m, les voitures renoncent et envoient les motards et les agents à pied.
- **Circulation** : au son de la sirène (moins de 40 m), les véhicules de la circulation se rangent à droite et s'arrêtent. Dans un embouteillage, la voiture de police est bloquée comme les autres ; les motards passent (décision 61).
- **Moto du joueur** : elle sème les voitures dans les embouteillages et les ruelles, mais les motards la suivent partout ; un contact latéral d'un véhicule de police à plus de 25 km/h d'écart fait tomber Koffi (règle de chute de `conduite_moto.md`) : il a 3 s pour se relever avant la saisie.
- **Véhicule du joueur immobilisé** : sous 5 km/h pendant 3 s avec un véhicule de police à moins de 6 m : les agents descendent (1,5 s) et viennent ouvrir la portière (2 s) : arrestation, sauf si le joueur redémarre ou sort et s'enfuit à pied.
- **Dégâts** : les véhicules de police s'abîment comme les autres ; à 80 points de dégâts, ils abandonnent (fumée), remplacés après 20 s par une unité créée hors champ, à 150 m au moins.
- **Eau** : en pirogue (chapitre 2 et après), la police ne suit qu'à partir de 3 étoiles, avec une vedette (une seule), 45 km/h.
- Apparition des renforts : toujours hors champ, sur une route, à 120-250 m, de préférence devant le joueur à partir de 3 étoiles.
- Test : à 2 étoiles sur un boulevard vide, la patrouille reste entre 8 et 40 m du joueur roulant à 80 km/h pendant 30 s ; à 122 km/h l'écart grandit ; véhicule arrêté 3 s : arrestation ; la police ne touche aucun piéton sur 5 minutes simulées en ville ; la circulation se range à la sirène ; dans un embouteillage simulé, seuls les motards restent au contact ; unité à 80 points de dégâts retirée et remplacée.

## Barrages
- À partir de 3 étoiles. Un barrage est posé sur la route **devant** le joueur, à 200-350 m par la route, hors champ au moment de la pose, sur un tronçon sans carrefour sur 40 m. Un nouveau barrage toutes les 40 s au plus ; 2 actifs au plus à 3 étoiles, 3 à 4 étoiles, 5 à 5 étoiles (dont les ponts).
- **Composition** :
  - 3 étoiles : 2 voitures de patrouille en chicane (en biais, laissant un passage en S de 2,5 m praticable sous 30 km/h), 4 cônes, 3 agents à pied.
  - 4 étoiles : chicane + **herse** (bande à pointes de 6 m) 15 m avant ; les trottoirs restent libres.
  - 5 étoiles : route fermée par 2 pick-up nez à nez, herse, 6 agents ; les trottoirs sont barrés par des barrières métalliques (franchissables à pied avec Espace, pas en véhicule).
- **Franchir** :
  - se présenter sous 30 km/h et s'arrêter : arrestation ;
  - passer la chicane sans s'arrêter : possible à moto facilement, en voiture sous 30 km/h ; compte comme « barrage forcé » (+1 étoile, 4 au moins) ;
  - percuter les voitures du barrage : dégâts selon le barème des véhicules ; elles ne bougent pas en dessous de 60 km/h ; au-delà, elles pivotent de 1 m et le passage s'ouvre, mais le choc coûte au moins 40 points de dégâts et de la santé ;
  - herse : pneus crevés ; la voiture est plafonnée à 40 km/h et tire du côté du premier pneu touché, la moto à 30 km/h ; réparation au garage (`garage.md`) ;
  - contourner par un trottoir, une cour, une station-service : permis, ne compte pas comme forçage ; à pied, on passe en courant (les agents poursuivent).
- Les véhicules de la circulation s'arrêtent en file devant le barrage ; les agents les laissent passer un par un (une voiture toutes les 8 s), ce qui crée un bouchon : indice visible de loin pour le joueur, avec les lumières bleues.
- Le GPS ne connaît pas les barrages ; ils apparaissent sur la mini-carte (trait bleu épais) dès qu'ils sont à moins de 150 m.
- Un barrage est retiré quand le joueur est à plus de 400 m ou 30 s après la fin de la recherche.
- **Ponts** : à 5 étoiles, les trois ponts ont un barrage complet ; reste la pirogue, la nage (Koffi sait nager, décision 82) ou se cacher.
- Jamais de barrage devant une école, un lieu de culte, dans une allée de marché, ni à moins de 60 m du point de départ d'une mission.
- Test : à 3 étoiles sur un boulevard, un barrage existe devant le joueur en moins de 40 s, à 200 m au moins, hors champ à sa création ; nombre de barrages actifs conforme ; chicane franchie à 25 km/h en voiture sans dégât, +1 étoile ; herse : vitesse plafonnée à 40 km/h ; arrêt devant le barrage : arrestation ; barrage retiré à 400 m.

## Arrestation
- **Conditions** (une seule suffit) :
  - à pied : saisie réussie, ou Koffi immobile 2 s à moins de 8 m d'un agent qui le poursuit ;
  - en véhicule : arrêté (moins de 5 km/h) 3 s avec un agent à moins de 4 m de sa portière, ou 5 s à moto ;
  - Koffi à terre après une chute à moto avec un agent à moins de 3 m ;
  - santé tombée à zéro pendant une recherche (au lieu du centre de santé : soins facturés en plus de l'amende).
- **Se rendre** : touche **C maintenue 1 s** immobile devant un agent (Koffi lève les mains) : arrestation immédiate et amende réduite de 25 %.
- **Scène** (6 s, non jouable, passable avec Entrée après 2 s) : l'agent tient Koffi par le bras ; une réplique de l'agent et une de Koffi selon le niveau (« Chef, on peut s'arranger… — On va s'arranger au commissariat. ») ; fondu au noir.
- **Conséquences** (décision 76) : amende (section suivante) ; l'horloge avance de 1 heure de jeu par étoile ; Koffi ressort devant le commissariat le plus proche (il y en a 3 : Ganhi, Dantokpa, Akpakpa) ; santé remise à 50 au moins ; niveau de recherche à 0.
- **Véhicules** : on les garde. Le véhicule utilisé au moment de l'arrestation, s'il appartient à Koffi ou lui est prêté, est garé sur le parc du commissariat, dans l'état où il était. Un véhicule emprunté à quelqu'un est rendu à son propriétaire (il disparaît).
- **Objets** : l'objet tenu en main (bâton, planche) est confisqué. La marchandise de contrebande d'une mission est saisie : la mission échoue (voir `moteur_de_missions.md`). Les marchandises légales sont gardées.
- **Mission en cours** : une arrestation fait échouer la mission, sauf si elle est prévue par l'histoire ; reprise au dernier point de contrôle, sans amende (l'amende ne s'applique qu'en jeu libre).
- **Casier** : compteur d'arrestations (statistiques). Toutes les 5 arrestations, les amendes augmentent de 10 % (plafond +50 %) ; le compteur de majoration redescend d'un cran tous les 7 jours de jeu sans arrestation. Barnabé a des répliques différentes à la 1re, 3e et 10e arrestation.
- Métier : arrêté en chemise jaune : −3 de réputation de conducteur.
- Test : chacune des quatre conditions provoque l'arrestation, et le fait de rouler à 10 km/h l'empêche ; après la scène, le joueur est à moins de 15 m de la porte du commissariat le plus proche, niveau 0, santé ≥ 50 ; sa moto est sur le parc avec les mêmes dégâts ; l'horloge a avancé de 3 h pour 3 étoiles ; se rendre : −25 % ; en mission, pas d'amende et reprise au point de contrôle.

## Amende et sortie du commissariat
- **Barème** (jeu libre), selon le niveau le plus haut atteint pendant la recherche :

| Étoiles | Chapitres 1-2 | Chapitres 3-4 | Chapitres 5-6 |
|---|---|---|---|
| 1 | 1 000 | 2 000 | 3 000 |
| 2 | 3 000 | 6 000 | 10 000 |
| 3 | 8 000 | 20 000 | 40 000 |
| 4 | 20 000 | 50 000 | 120 000 |
| 5 | 50 000 | 120 000 | 300 000 |

- Difficulté : × 0,5 en « Tranquille », × 1,5 en « Corsé ». Majoration de casier : voir « Arrestation ». Reddition : −25 %.
- **Plafond** : l'amende ne dépasse jamais 30 % de l'argent total de Koffi (espèces + KwabôPay), arrondi à 50, avec un minimum égal à l'amende d'une étoile. S'il a moins que ce minimum, il donne tout ce qu'il a et l'horloge avance de 6 heures de plus (« garde à vue »). On ne passe jamais en négatif et une arrestation ne crée pas de dette.
- **Reçu** : l'amende officielle est toujours accompagnée d'un reçu (texte « Amende payée : 3 000 FCFA — reçu n° … »). C'est ce qui la distingue d'un « petit geste ».
- **Proposer un « petit geste »** (décision 77), possible seulement **avant** l'arrestation, à 1 ou 2 étoiles, à pied ou arrêté à un contrôle, face à un seul agent ou un binôme : touche E devant l'agent → choix « Proposer un arrangement » ; montant = 50 % de l'amende, minimum 500 FCFA.
  - Chaque agent a un caractère fixe, tiré à sa création : **droit** (70 %) ou **arrangeable** (30 %). Aucun signe visible sûr ; indice : un agent arrangeable regarde autour de lui avant de répondre (1 s).
  - Agent arrangeable : il prend l'argent, le niveau tombe à 0, pas de reçu. Chaque « geste » accepté alimente un compteur caché par quartier.
  - Agent droit : « Tu veux m'acheter, moi ? » : arrestation immédiate et **amende doublée**. Barnabé est toujours droit.
  - **La corruption est toujours réprimée (décision 19)** : dans les 48 h de jeu qui suivent un geste accepté, l'agent en question est remplacé à son poste par un agent droit, et la radio parlée l'annonce (« Un agent du contrôle de Missèbo suspendu pour indélicatesse », voir `radio_en_voiture.md`). Après 3 gestes acceptés dans un même quartier en 7 jours de jeu, tous les agents de ce quartier sont droits pendant 14 jours de jeu (« l'inspection est passée »).
  - Jamais possible à 3 étoiles et plus, ni devant un pick-up de brigade.
- **Sortie du commissariat** : Koffi apparaît sur le trottoir devant la porte, tourné vers la rue ; une réplique (il se parle à lui-même, décision 107 ; 12 variantes, par exemple « Maman ne doit jamais apprendre ça. »). Son véhicule est sur le parc à moins de 20 m. Sauvegarde automatique.
- **Entrer dans un commissariat** (bâtiment visitable, décision 92), hors recherche : guichet pour payer une contravention en attente, panneau des avis, banc. Aucune mission ne s'y moque de la police.
- Cas limites : arrêté avec 0 FCFA : garde à vue seule. Amende supérieure aux espèces : complément pris sur KwabôPay sans frais. Deux arrestations en moins de 10 minutes réelles : la seconde amende est normale (pas d'acharnement), mais Barnabé le remarque en réplique.
- Test : barème vérifié pour 5 niveaux × 3 périodes ; avec 10 000 FCFA au chapitre 1 et 3 étoiles : 3 000 (plafond de 30 %) ; avec 400 FCFA et 1 étoile : 400 donnés et +6 h ; geste devant un agent droit : amende × 2 exactement ; devant un agent arrangeable : niveau 0, argent −50 % de l'amende, agent remplacé dans les 48 h de jeu et flash radio mis en file ; quatrième tentative dans le quartier : refusée.

## Fin de recherche
- **Zone de recherche** : cercle centré sur le dernier endroit où un policier a vu Koffi, affiché en bleu translucide sur la mini-carte et la grande carte.

| Étoiles | Rayon | Temps à tenir sans être vu |
|---|---|---|
| 1 | 80 m | 20 s |
| 2 | 130 m | 35 s |
| 3 | 200 m | 50 s |
| 4 | 280 m | 70 s |
| 5 | 380 m | 90 s |

- **Perdu de vue** : aucun policier n'a de ligne de vue sur Koffi (voir le champ de vision dans « Patrouilles »). Les étoiles clignotent et un compte à rebours discret (anneau autour des étoiles) démarre. S'il est revu : le cercle se recentre et le compte repart de zéro.
- Le compte à rebours tourne **deux fois plus vite** si Koffi est hors du cercle, et la recherche s'arrête dès qu'il est à plus de 2 fois le rayon du centre sans être vu (sauf à 5 étoiles : bouclage, il faut tenir le temps).
- **Descente par paliers** : à la fin du compte, le niveau ne tombe pas d'un coup à 0 pour les niveaux 4 et 5 : il passe à 3 (les barrages restent 30 s), puis un nouveau compte de 50 s mène à 0. Les niveaux 1 à 3 tombent directement à 0.
- **Se cacher** (voir aussi `combat.md`, « Mise à couvert ») : accroupi hors de vue derrière un obstacle, la portée de vue des agents à son égard est divisée par 2. Cachettes marquées (entrées de cour, étals bâchés, dessous d'escalier) : E pour s'y glisser ; un agent ne vous y trouve que s'il vous a vu y entrer ou s'il fouille cette cachette (il en fouille 3 parmi les plus proches du dernier point de vue ; 4 s chacune).
- **Changer d'allure** :
  - changer de véhicule sans être vu : les agents cherchent encore l'ancien véhicule ; on n'est reconnu qu'à moins de 15 m ;
  - **repeindre** le véhicule au garage (`garage.md`) : met fin à une recherche de 1 à 3 étoiles si on y entre sans être vu ; refusé à 4 et 5 ;
  - changer de tenue dans un logement ou une boutique sans être vu : reconnu seulement à moins de 15 m, et le temps à tenir est divisé par 2 ;
  - entrer dans un de ses logements sans être vu : fin immédiate à 1 ou 2 étoiles ; à 3 et plus, un agent frappe à la porte après 20 s (il faut ressortir par-derrière).
- **Se mêler à la foule** : immobile ou en marche (pas en course) dans une foule de marché de plus de 6 passants à 3 m : portée de reconnaissance réduite à 10 m.
- **Après la recherche** : les unités repartent, sirènes coupées ; pendant 60 s, toute nouvelle infraction vue redonne directement le niveau précédent (les agents « l'ont encore en tête »). Le véhicule utilisé reste « signalé » 10 minutes réelles : un contrôle routier l'arrête à coup sûr.
- Les étoiles ne s'achètent pas et il n'y a pas d'objet à ramasser qui les efface.
- Missions : certaines fixent le niveau (poursuite écrite) ; il ne peut alors ni monter ni descendre avant la fin de l'objectif (drapeau `recherche_verrouillee`).
- Test : à 1 étoile, hors de vue 20 s dans le cercle : niveau 0 ; revu à 15 s : compte remis à zéro et cercle recentré ; hors du cercle : 10 s suffisent ; à plus de 160 m (2 rayons) : fin immédiate ; à 4 étoiles : passage à 3 puis à 0 après 50 s ; peinture acceptée à 3, refusée à 4 ; accroupi derrière un muret à 20 m d'un agent de jour : non vu ; debout : vu ; infraction dans les 60 s après la fin : retour direct au niveau précédent.

## Choix faits par Claude (à confirmer)
- Contenu des étoiles 4 et 5 (pick-up de brigade, herses, bouclage des ponts), que la décision 73 laisse à valider ; aucun tir en jeu libre à aucun niveau.
- Amende plafonnée à 30 % de l'argent du joueur ; pas de dette de police ; garde à vue = temps qui passe.
- 30 % d'agents « arrangeables », systématiquement remplacés dans les 48 h de jeu avec annonce à la radio (décision 19).
- Touche C maintenue pour se rendre.
