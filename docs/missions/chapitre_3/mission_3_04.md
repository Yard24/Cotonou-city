# Mission 3.4 — Chaîne du froid

Tâches couvertes : T3792 (synopsis), T3793 (objectifs et échecs), T3794 (dialogues), T3795 (expressions fon). Rédigé le 16 novembre 2026.

- **Type :** livraison sous contrainte (LIV) : jauge de température, pas d'arrêt long, pas de gros choc.
- **Date dans l'histoire :** le même vendredi de mai 2020 que 3.3, de 15 h à 16 h 30. Soleil dur, 33 °C.
- **Durée visée :** 8 minutes.
- **Disponible :** suite directe de 3.3 (événement, marqueur posé au port 2 h de jeu après).
- **Véhicule :** camionnette blanche des Mamans du Pavillon (`vehicule_camionnette_blanche`), glacière bleue de 60 litres sanglée à l'arrière. Première voiture à quatre roues conduite en mission : rappel des touches à l'écran pendant 20 s.
- **Récompense :** 15 000 FCFA (10 000 du centre de santé d'Abomey-Calavi, 5 000 du pharmacien).
- **Identifiants des répliques :** `c3m4_<personnage>_<numéro>`.

## Lieux
| Repère | Lieu | Détail |
|---|---|---|
| A | Port, magasin n° 4 | Quai de chargement ; Brice a amené la camionnette |
| B | Boulevard de la Marina puis place de l'Amazone | Vide, deux ralentisseurs |
| C | Carrefour de Cadjèhoun, puis route de Godomey | Chaussée dégradée sur 300 m (nids-de-poule) |
| D | Échangeur de Godomey — barrage sanitaire de la sortie nord | File ordinaire : 14 véhicules à l'arrêt ; file prioritaire à gauche, cône orange et panneau « Santé – Vivres » |
| E | Carrefour Kpota, Abomey-Calavi | Marché de Calavi sur la droite, un tricycle en travers |
| F | Centre de santé d'Abomey-Calavi | Cour, médecin-chef sur le perron |

Le trajet hors de Cotonou est condensé comme le reste de la carte : 5,2 km en tout, dont 2,4 km après le barrage. La zone d'Abomey-Calavi n'est ouverte que pour cette mission au chapitre 3.

## Personnages présents
Koffi, Brice (au départ), Madame Félicité (téléphone), deux agents du barrage, le médecin-chef d'Abomey-Calavi (Docteur Pascaline).

## Synopsis
Le lot de la pharmacie sort du port l'après-midi même.
Six cartons ne vont pas à Ganhi : ce sont des flacons à garder entre 2 et 8 °C, attendus au centre de santé d'Abomey-Calavi.
Une moto ne suffit plus ; Nan Akouavi prête la camionnette des Mamans du Pavillon, que Brice amène au quai.
Il y a compté les cartons trois fois et rempli la glacière de glace achetée au port de pêche.
Koffi n'a jamais conduit autre chose qu'une moto et un tricycle : quatre roues, un volant, et pas le droit de secouer.
Madame Félicité appelle : la glace tient tant qu'on roule, elle fond dès qu'on s'arrête au soleil.
Plus de trente secondes d'arrêt, ou la glacière au-dessus de 8 °C, et tout le lot est bon à jeter.
À la sortie nord, le barrage sanitaire a une file de quatorze véhicules qui n'avance pas.
Le laissez-passer de Barnabé, que Koffi trouvait bien cher payé, ouvre la file prioritaire.
À Calavi, un tricycle en travers et une route cassée mettent la jauge dans le rouge.
Le médecin-chef contrôle le thermomètre avant même de dire bonjour.
Le soir, on parle de « Maillot Vert » dans un quartier où Koffi n'avait jamais mis les pieds.

## Règles de la mission
- **Jauge de température** (affichée : thermomètre, vert jusqu'à 6 °C, orange de 6 à 8, rouge au-delà). Départ : 4,0 °C. Échec à **8,0 °C**.
  - À l'arrêt ou sous 5 km/h : + 0,5 °C toutes les 10 s.
  - Entre 5 et 30 km/h : température stable.
  - Au-dessus de 30 km/h (l'air refroidit la caisse) : − 0,2 °C toutes les 10 s, plancher 4,0 °C.
  - Gros choc (plus de 18 km/h perdus d'un coup, barème des dégâts) : + 1,0 °C (le couvercle saute). Nid-de-poule pris à plus de 40 km/h : + 0,3 °C.
- **Arrêt :** un compteur « Arrêt : 0:30 » apparaît dès que la vitesse passe sous 5 km/h ; à 0, échec. Il se remet à 30 s après 5 s de roulage au-dessus de 15 km/h.
- **Difficulté :** Tranquille : échec à 9 °C, arrêt 40 s ; Corsé : départ à 5 °C, arrêt 25 s.
- Pas de chronomètre global : c'est la température qui presse.

## Déroulement
| N° | Objectif affiché | Déclencheur | Réussite | Échec |
|---|---|---|---|---|
| 1 | « Monte dans la camionnette » | Dialogue avec Brice au quai | Koffi au volant | Aucun |
| 2 | « Sors du port et prends le boulevard de la Marina » | Moteur démarré (jauge active) | Passage de la grille du port | 8 °C ; arrêt de plus de 30 s ; camionnette à 100 de dégâts ; santé à 0 ; 2 étoiles |
| 3 | « Rejoins la sortie nord par Cadjèhoun » | Grille du port | Arrivée à 150 m du barrage | Comme l'étape 2 ; quitter la camionnette plus de 20 s |
| — | **Point de contrôle 1** | 150 m avant le barrage | Température rendue : 6,0 °C au plus | — |
| 4 | « Prends la file prioritaire, à gauche » | Point de contrôle 1 | Arrêt à moins de 4 m de l'agent de la file prioritaire | Comme l'étape 2 ; entrer dans la file ordinaire et y rester 30 s (compteur d'arrêt) ; forcer le barrage : échec immédiat |
| 5 | « Montre ton laissez-passer (E) » | Arrêt devant l'agent | E pressé ; contrôle de 12 s (le compteur d'arrêt est gelé, la température monte quand même) | 8 °C |
| — | **Point de contrôle 2** | Barrière levée | Température rendue : 6,5 °C au plus | — |
| 6 | « Roule jusqu'au centre de santé d'Abomey-Calavi » | Barrière levée | Passage du carrefour Kpota (contourner le tricycle par la droite, sans s'arrêter) | Comme l'étape 2 |
| 7 | « Gare-toi dans la cour, à l'ombre » | Entrée de la cour | Arrêt sur le marqueur sous le manguier | Comme l'étape 2 |

**Prime :** température jamais au-dessus de 6 °C : + 3 000 FCFA et réplique 044.

## Dialogues

### Étape 1 — quai du magasin n° 4
001 BRICE : Six cartons. Je les ai comptés trois fois. La glacière est pleine jusqu'au bord.
002 KOFFI : Et la camionnette de la Nan ? Elle sait que c'est moi qui conduis ?
003 BRICE : Elle a dit : « S'il la raye, il la repeint. À la main. »
004 KOFFI : Elle a quatre roues, Brice. Moi j'ai toujours vécu sur deux.
005 BRICE : C'est pareil, avec plus de place pour se tromper. Le volant, c'est le rond devant toi.

### Appel — Madame Félicité (à la grille du port)
006 FÉLICITÉ : Monsieur Koffi. Les flacons doivent rester sous huit degrés. Au-dessus, on jette tout.
007 KOFFI : Huit degrés ? Madame, dehors il en fait trente-trois !
008 FÉLICITÉ : La glace tient si vous roulez. À l'arrêt, elle fond. Pas plus de trente secondes au soleil.
009 KOFFI : Donc je ne m'arrête pas, je ne secoue pas, et je ne traîne pas.
010 FÉLICITÉ : C'est exact. Je l'ai noté. Bonne route.

### Conduite, Cotonou (au hasard, une fois chacune)
011 KOFFI : Un volant, trois pédales… Romaric ne me croira jamais.
012 KOFFI : Elle est large, cette affaire. En moto je passais entre deux taxis ; là, c'est moi le taxi.
013 KOFFI : Dèdè [doucement] sur le dos-d'âne… Voilà. Les flacons n'ont rien senti.
014 KOFFI : La Marina vide, et moi au volant. Maman ne va pas me reconnaître.
015 KOFFI : (température à 6 °C) Ça chauffe derrière ! Roule, Koffi, roule, il faut du vent.
016 KOFFI : (gros choc) Aïe ! Le couvercle ! Pardon, les flacons, pardon, Nan Akouavi.
017 KOFFI : (compteur d'arrêt à 10 s) Pas le temps de saluer, je repars !

### Étapes 4 et 5 — barrage de Godomey
018 KOFFI : Quatorze véhicules à l'arrêt en plein soleil. Si je me mets là, je livre de la soupe.
019 KOFFI : « Santé – Vivres ». C'est moi, ça. Les deux à la fois.
020 AGENT DU BARRAGE : Halte. Cette file est réservée. Vous transportez quoi ?
021 KOFFI : Des médicaments au froid pour le centre de santé d'Abomey-Calavi, chef. Voici le laissez-passer.
022 AGENT DU BARRAGE : Signé de l'Adjudant Barnabé… Lui, il ne signe pas facilement.
023 KOFFI : Il m'a fallu trois ans et une infirmière, chef.
024 AGENT DU BARRAGE : Ouvrez l'arrière. Je regarde, je ne touche pas.
025 KOFFI : Regardez vite, chef, chaque seconde c'est un glaçon.
026 AGENT DU BARRAGE : C'est bon. Levez la barrière ! Kudo azo. [Bon travail.]
027 KOFFI : Awanou [merci], chef ! Barnabé, je retire ce que j'ai pensé de ton papier.

### Appel — Madame Félicité (après le barrage)
028 FÉLICITÉ : Vous êtes passé ?
029 KOFFI : Par la file prioritaire, Madame. Comme un grand patron, mais avec de la glace.
030 FÉLICITÉ : Il reste le plus mauvais morceau de route. La température ?
031 KOFFI : Elle tient. Moi, je transpire pour deux.

### Conduite, Abomey-Calavi
032 KOFFI : Abomey-Calavi. Afi veut venir étudier ici. Elle fera cette route tous les jours ?
033 KOFFI : Un tricycle en travers ! Je ne m'arrête pas, je contourne… Pardon, pardon, c'est urgent !
034 CONDUCTEUR DU TRICYCLE : Eh ! Tu es pressé pour quoi ?
035 KOFFI : Pour des malades, mon frère ! Je t'expliquerai au retour !
036 KOFFI : Ces trous… Celui qui a dessiné cette route n'a jamais porté un flacon.

### Réussite — cour du centre de santé
037 MÉDECIN-CHEF : Ne dites rien. Le thermomètre d'abord.
038 KOFFI : Bonjour quand même, Docteur.
039 MÉDECIN-CHEF : Sous huit degrés. Bonjour. Kwabo [bienvenue] à Calavi, Monsieur… ?
040 KOFFI : Koffi. Maillot Vert livraison. Enfin, aujourd'hui c'est camionnette blanche.
041 MÉDECIN-CHEF : On attendait ces flacons depuis trois semaines. Qui vous a appris à conduire comme ça ?
042 KOFFI : Une infirmière avec un carnet. Elle fait très peur.
043 MÉDECIN-CHEF : Laissez-moi votre numéro. Ici aussi, on a des choses à faire porter.
044 FÉLICITÉ : (appel, prime) Six degrés au plus haut. Je n'ai rien à noter. C'est rare.
045 KOFFI : (seul, au volant) Des clients à Calavi… Koffi, ton quartier vient de grandir.

### Échecs
046 FÉLICITÉ : (appel, 8 °C) C'est trop chaud. Le lot est perdu. Ramenez la glacière, je vais prévenir le Docteur.
047 KOFFI : (arrêt de 30 s) Trente secondes… La glace a rendu l'âme. Et moi mon courage.
048 AGENT DU BARRAGE : (barrage forcé) Barrage forcé ! Camionnette blanche, vers le nord !
049 BRICE : (appel, camionnette détruite) La Nan demande de quelle couleur tu veux le pinceau.
050 KOFFI : (camionnette quittée) Je ne peux pas laisser des médicaments seuls au soleil !
051 KOFFI : (2 étoiles) Poursuivi avec une glacière… Non, non, on recommence proprement.
