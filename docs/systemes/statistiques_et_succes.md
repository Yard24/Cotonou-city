# Statistiques et succès : fonctionnement attendu

Rien n'est encore codé. Code prévu : `scripts/stats.gd` (compteurs), `scripts/succes.gd` (succès et progression), liste des succès dans `data/succes.json`. Vérifications prévues : `scripts/selftest_stats.gd`.

Rappel des décisions : pas d'arme à feu (3) ; passants jamais tués (4) ; aucune mission n'oblige à faire du mal à un innocent (102) ; pas de jeux d'argent (70) ; pas de connexion obligatoire, pas d'achat (71) ; environ 8 missions principales par chapitre, 6 chapitres, deux fins (98, 100) ; sauvegarde automatique et 3 emplacements manuels (115) ; trois difficultés (116).

Conséquence : aucune statistique et aucun succès ne récompense la violence envers les passants, la casse gratuite ou le nombre d'étoiles de recherche. Tout fonctionne hors ligne, dans la sauvegarde.

## Statistiques du joueur
- **Où** : pause → « Statistiques », et téléphone → « Carnet ». Cinq onglets, 8 à 14 lignes chacun, gauche/droite pour changer d'onglet. Chaque ligne : un libellé, une valeur mise en forme (« 12 500 FCFA », « 42,3 km », « 3 h 12 min »).
- **Onglet Général** : temps de jeu ; jours de jeu écoulés ; chapitre en cours ; missions principales et secondaires terminées ; progression en % ; difficulté ; évanouissements ; arrestations ; nombre de sauvegardes.
- **Onglet Déplacements** : distance à pied, à la nage, à moto, en voiture, en camion, sur l'eau (chacune en km) ; vitesse maximale atteinte ; plus long trajet sans choc ; chutes à moto ; véhicules conduits (sur le nombre de modèles) ; litres de carburant achetés, dont kpayo ; voyages en avion et en car.
- **Onglet Travail et argent** : argent gagné au total ; argent dépensé ; plus grosse somme en poche ; courses de zémidjan réussies ; meilleur prix obtenu au marchandage ; marchandages gagnés et perdus ; livraisons à l'heure et en retard ; passagers transportés (taxi, minibus, barque) ; recettes versées par les conducteurs ; dette restante envers Tonton Gratien ; propriétés et véhicules possédés.
- **Onglet Ville** : repas pris ; plat préféré (le plus commandé) ; vendeuses fidélisées ; tenues possédées ; coupes de cheveux ; quartier où la réputation est la plus haute ; alliances scellées ; zones libres ; services rendus dans la rue ; étals dédommagés ; amendes payées.
- **Onglet Loisirs** : matchs de foot gagnés, nuls, perdus ; buts marqués ; médailles des courses de motos ; meilleur temps par parcours ; poisson pêché (kg) et plus grosse prise ; parties d'awalé gagnées et perdues ; niveaux de Force, Souffle, Technique ; capsules, plaques, cassettes, cartes postales trouvées ; photos prises.
- **Statistiques de bagarre**, discrètes, dans Général : bagarres gagnées ; adversaires sonnés ; adversaires qui ont fui ; adversaires laissés partir. Pas de compteur de passants bousculés ou renversés affiché (il existe en interne pour la réputation, il n'est pas un score).
- **Règles de comptage** :
  - les distances s'ajoutent à chaque image (vitesse × temps), seulement quand le joueur a la main (pas en cinématique, ni comme passager d'un car) ;
  - le temps de jeu ne compte ni la pause, ni les menus, ni le mode photo ;
  - une mission rejouée ne compte qu'une fois ; ce qui a été compté pendant une mission échouée puis reprise au point de contrôle est annulé (les compteurs sont copiés au point de contrôle et restaurés) — sauf le temps de jeu et les objets à collecter ;
  - les compteurs sont des entiers (mètres, secondes, FCFA) ; l'affichage convertit ;
  - valeurs bornées à 2 milliards ; aucune ne peut être négative.
- **Sauvegarde** : les statistiques appartiennent à la sauvegarde (chaque emplacement a les siennes). Charger une sauvegarde plus ancienne ramène les statistiques de cette sauvegarde.
- **Radio parlée** (décision 111) : certaines valeurs alimentent les infos (« Un zémidjan aurait transporté cent clients sans une égratignure… »).
- **Fin de chapitre** : un écran de bilan de 6 lignes choisies (temps, argent gagné, courses, livraisons, quartier préféré, une ligne drôle tirée parmi 10 : « Beignets mangés : 47. Maman Koffi est fière. »).
- Cas limites : statistique d'une fonction pas encore ouverte (pêche avant le chapitre 2) → ligne masquée, pas un zéro ; sauvegarde d'une ancienne version sans une statistique → créée à 0 ; outils de développement utilisés (téléportation, argent ajouté) → la sauvegarde est marquée « modifiée » et l'écran l'indique en petit.
- Test : rouler 100 m à moto ajoute entre 98 et 102 m à « distance à moto » et rien à « distance à pied » ; 10 secondes de pause n'ajoutent rien au temps de jeu ; une course réussie ajoute 1 course et son prix à l'argent gagné ; échouer une mission après 2 livraisons puis reprendre au point de contrôle remet le compteur de livraisons à sa valeur du point de contrôle ; toutes les valeurs sont identiques après sauvegarde et rechargement ; charger une ancienne sauvegarde sans le champ « kg de poisson » ne plante pas et donne 0 ; aucune ligne affichée ne compte de passants blessés.

## Succès
- **50 succès**, internes au jeu (pas besoin de plateforme en ligne ; si le jeu sort un jour sur une boutique qui en propose, la même liste y sera reliée). Chacun : identifiant, titre, description, icône (aplat de 2 couleurs, 128 px), condition, caché ou non, points (5, 10, 20 ou 50 ; total 600).
- **Notification** : bandeau en haut à droite, 4 secondes, son court (trois notes), « Succès : Premier client ». Jamais pendant une cinématique ou un dialogue : mis en attente et affiché ensuite, un à la fois, 1 seconde d'écart. Option pour couper les bandeaux.
- **Écran** : pause → « Succès » : grille de 50 cases, obtenus en couleur avec la date de jeu, les autres en gris avec leur description ; les 8 succès cachés (liés à l'histoire) affichent « ??? » jusqu'à leur obtention. Compteur « 23/50 — 240 points ».
- **Liste** (extrait fixé ; le reste suit le même esprit) :

| Titre | Condition | Points |
|---|---|---|
| Retour au pays | terminer la mission 1 | 5 |
| Premier client | première course de zémidjan | 5 |
| Dur en affaires | gagner 10 marchandages | 10 |
| Sans une égratignure | 25 courses de suite sans chute ni choc | 20 |
| Cent clients | 100 courses réussies | 20 |
| Patience | parcourir 100 km avec la moto de Romaric | 10 |
| Dette réglée | finir de rembourser Tonton Gratien (caché) | 20 |
| Toujours à l'heure | 50 livraisons dans le délai | 20 |
| Fragile ! | livrer 10 colis fragiles à 100 % | 10 |
| Patron | confier 5 motos à des conducteurs | 20 |
| Propriétaire | acheter sa première propriété | 10 |
| Enfant du quartier | +60 de réputation dans un quartier | 10 |
| Chez soi partout | +60 dans tous les quartiers de Cotonou | 50 |
| On est ensemble | sceller une alliance | 10 |
| Tout le monde s'y met | sceller les 5 alliances | 50 |
| Bien mis | porter un boubou trois pièces | 5 |
| Client fidèle | être reconnu par 10 vendeuses | 10 |
| Fin gourmet | goûter tous les plats des maquis | 10 |
| Petits poteaux | battre les trois équipes de foot | 10 |
| Roi de la plage | les 4 médailles d'or des courses de motos | 20 |
| Gros poisson | pêcher un capitaine de plus de 5 kg | 10 |
| Le Doyen s'incline | battre le Doyen à l'awalé | 20 |
| En forme | atteindre le niveau 5 dans les trois qualités | 10 |
| Capsules : 15, 30, 60 | trois succès | 5, 10, 20 |
| Mémoire des zems | les 20 plaques | 20 |
| Carte postale | les 12 points de vue | 10 |
| Marin d'eau douce | atteindre le village lacustre en pirogue à pagaie | 10 |
| Vu d'en haut | premier vol vers Parakou | 5 |
| La route du Nord | arriver à Parakou en camion (caché) | 20 |
| Citoyen modèle | 10 jours de jeu sans une étoile de recherche | 10 |
| J'ai payé mes dégâts | dédommager 10 étals | 5 |
| Laisse, il a compris | laisser partir 10 adversaires rattrapés | 10 |
| Coup de main | rendre 25 services dans la rue | 10 |
| Six chapitres, une ville | terminer l'histoire (caché) | 50 |
| Riche et seul / Modeste et entouré | chacune des deux fins (cachés) | 20 chacun |
| Cotonou, 2017-2026 | 100 % de progression | 50 |

- **Interdits** : aucun succès pour renverser des passants, casser, fuir la police, proposer de l'argent à un agent, ni pour quoi que ce soit lié à un jeu d'argent. Aucun succès impossible à obtenir après un point de l'histoire : tous restent accessibles en partie libre après la fin, sauf les deux fins (il faut rejouer la dernière mission, proposée depuis le menu une fois le jeu terminé).
- **Stockage** : les succès sont enregistrés à la fois dans la sauvegarde et dans un fichier de profil commun aux trois emplacements (`user://profil.cfg`) : un succès obtenu reste obtenu, même en chargeant une sauvegarde plus ancienne ou en recommençant.
- **Récompenses en jeu** : aucune qui change l'équilibre ; tous les 100 points, un objet décoratif pour le logement (affiche, trophée, radio ancienne).
- **Difficulté** : aucun succès ne dépend de la difficulté.
- **Outils de développement** : une sauvegarde marquée « modifiée » ne débloque plus de succès.
- Cas limites : deux succès au même instant → deux bandeaux à la suite ; condition déjà remplie avant l'ajout d'un succès par une mise à jour → accordé au chargement ; fichier de profil effacé → reconstruit à partir des sauvegardes présentes.
- Test : `data/succes.json` contient 50 identifiants uniques, des points valant 5, 10, 20 ou 50, un total de 600, 8 succès cachés, une icône existante pour chacun ; la première course débloque « Premier client » une seule fois ; le succès reste obtenu après chargement d'une sauvegarde antérieure ; pendant une cinématique le bandeau attend la fin ; une sauvegarde « modifiée » n'accorde rien ; aucun identifiant ne contient les mots de la liste d'interdits (passant, pari, pot-de-vin).

## Pourcentage de progression
- **Un seul chiffre**, de 0 à 100 %, affiché sur chaque emplacement de sauvegarde, dans la pause et dans le Carnet, avec le détail par catégorie (barre et « 31/48 »).
- **Calcul** : somme pondérée de 9 catégories ; chaque catégorie vaut (éléments faits ÷ éléments existants) × son poids.

| Catégorie | Éléments | Poids |
|---|---|---|
| Missions principales | 48 (8 par chapitre × 6) | 40 |
| Missions secondaires (zémidjan, livraisons chronométrées, dépannages, objets perdus) | 40 | 15 |
| Métiers (un palier atteint dans chacun des 6 métiers) | 6 | 6 |
| Activités annexes (foot contre les 3 équipes, une médaille sur chacun des 4 parcours de motos, pêche d'un capitaine, awalé contre les 4 adversaires, salle de sport niveau 5) | 13 | 8 |
| Objets à collecter | 108 (60 + 20 + 16 + 12) | 10 |
| Propriétés achetées | 5 types (chambre, garage, boutique, entrepôt, maison) | 5 |
| Zones libres | 40 | 6 |
| Alliances scellées | 5 | 5 |
| Quartiers au palier « connu » ou mieux | 10 | 5 |
| **Total** | | **100** |

- **L'histoire seule** donne 40 % ; un joueur qui suit l'histoire en faisant un peu de tout finit vers 60 à 70 %.
- **Les deux fins** : terminer avec une fin suffit pour les 40 points ; voir la seconde fin ne rapporte pas de pourcentage (seulement un succès).
- **Affichage** : entier arrondi vers le bas (99,6 % affiche 99 %) ; 100 % seulement si tout est fait. Si le nombre d'éléments d'une catégorie change avec une mise à jour, le pourcentage est recalculé au chargement (il peut baisser ; un message l'explique une fois : « Du nouveau à faire en ville ! »).
- **Version publique du chapitre 1** (décision 119) : la progression est calculée sur le contenu de cette version seulement (8 missions principales, 3 quartiers) et affichée « Chapitre 1 : 74 % » ; à l'import de cette sauvegarde dans le jeu complet, elle est recalculée.
- **À 100 %** : succès « Cotonou, 2017-2026 », une courte scène au maquis de Tantie Rosine avec tous les alliés (20 secondes), et la tenue « Fête de quartier ». Rien de réservé qui manquerait au joueur à 99 %.
- **Aide** : par catégorie incomplète, une phrase d'orientation (« Il reste 3 livraisons chronométrées : regarde au port. ») ; les éléments restants d'un quartier sont montrés sur la carte après la fin de l'histoire.
- **Rien ne ferme définitivement** : une zone non reprise ou une alliance non scellée pendant l'histoire reste faisable après la fin, sauf dans la fin « vendre », où les zones gardées par l'acheteur se rachètent (prix affichés) — le 100 % reste atteignable dans les deux fins.
- Cas limites : catégorie sans élément dans la version jouée → son poids est réparti sur les autres ; sauvegarde « modifiée » par les outils → pourcentage affiché avec un astérisque.
- Test : sauvegarde neuve → 0 % ; les 48 missions principales seules → 40 % exactement ; tout fait → 100 % ; tout sauf une capsule → 99 % ; la somme des poids vaut 100 ; les nombres d'éléments déclarés sont égaux aux nombres réels dans les données (missions, objets, zones) ; le pourcentage est identique après sauvegarde et rechargement ; en version chapitre 1, le calcul n'utilise que les éléments présents ; dans la fin « vendre », toutes les zones ont un prix de rachat.
