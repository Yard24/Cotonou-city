# Moteur de missions : fonctionnement attendu

Code : aujourd'hui trois missions d'essai écrites dans `scripts/main.gd` (colonne jaune, récompense). Cible proposée : `scripts/mission.gd` (moteur : états, objectifs, points de contrôle), `scripts/mission_journal.gd` (journal), une fiche de données par mission dans `missions/<chapitre>_<numéro>_<nom>.json`. Vérifications : `scripts/selftest_mission.gd`, qui joue trois missions d'essai factices (`essai_aller`, `essai_chrono`, `essai_filature`) par simulation des entrées.

Cadre : environ 8 missions principales par chapitre, 6 chapitres (décision 100) ; missions de 5 à 12 minutes, reprise au dernier point de contrôle (101) ; aucune mission n'oblige à faire du mal à un innocent (102) ; missions secondaires : courses de zémidjan, livraisons chronométrées, courses de motos sur la plage, dépannages, objets perdus (103) ; sauvegarde automatique après chaque mission (115) ; trois difficultés (116). Temps : 1 heure de jeu = 2 minutes réelles.

Une mission est une **suite d'étapes** ; chaque étape a un ou plusieurs **objectifs**, des **conditions d'échec** et, à la fin, éventuellement un **point de contrôle**. États d'une mission : `verrouillée`, `disponible`, `en cours`, `réussie`, plus `échouée` (passager : on reprend).

## Déclencheurs
- Une mission `disponible` démarre par un de ces déclencheurs :

| Déclencheur | Ce que voit le joueur | Détail |
|---|---|---|
| Marqueur au sol | colonne jaune (principale) ou bleue (secondaire) de 1,2 m de rayon, lettre du donneur sur la carte | y entrer à pied ou arrêté en véhicule (moins de 5 km/h) pendant 0,5 s |
| Personnage | le donneur attend à un endroit, icône au-dessus de sa tête à moins de 20 m | E à moins de 2,6 m |
| Appel ou message | le téléphone sonne (`telephone_du_joueur.md`) | décrocher ou lire lance la mission ou pose son marqueur |
| Lieu et heure | rien avant ; la mission s'annonce à l'arrivée | entrer dans une zone pendant un créneau horaire |
| Événement | suite directe d'une autre mission ou d'un acte du joueur (premier achat de propriété, 3e arrestation) | démarrage ou pose du marqueur après un délai de 0 à 24 h de jeu |

- **Conditions de disponibilité** (toutes vérifiées) : missions précédentes réussies ; chapitre ; créneau horaire éventuel (par exemple 6 h-10 h pour une mission avec Maman Koffi à son étal) ; argent minimum ; palier de réputation ; propriété possédée ; véhicule exigé (type) ; niveau de recherche à 0 ; pas d'autre mission en cours.
- **Une seule mission à la fois.** Pendant une mission, les autres marqueurs sont masqués sur la carte et inactifs.
- Si le joueur se présente hors créneau, le texte du bas le dit (« Maman Koffi vend le matin : reviens entre 6 h et 10 h. ») et propose **d'attendre** : E maintenu 1 s, fondu, l'horloge saute au début du créneau (au plus 24 h de jeu).
- **Confirmation** : les missions principales s'ouvrent sur leur scène d'introduction, sans question. Les secondaires affichent un carton (titre, donneur, récompense, durée estimée) : E accepter, Échap refuser.
- **Ordre** : dans un chapitre, les missions principales forment un fil avec au plus 2 missions disponibles en même temps (deux donneurs différents) ; la dernière du chapitre exige toutes les autres.
- **Ce qui est figé au démarrage** : heure et météo si la fiche l'exige ; véhicule fourni placé ; circulation et passants autour du départ nettoyés des gêneurs (aucun véhicule de la circulation arrêté sur le marqueur).
- **Refus de démarrage** : en combat, pendant une recherche, dans un véhicule emprunté à quelqu'un si la mission commence par une scène chez un proche : message explicite, jamais de refus muet.
- Cas limites : marqueur sous l'eau d'une inondation : il se déplace au point praticable le plus proche (10 m au plus) ; donneur renversé ou bousculé : il se relève, la mission reste disponible, il a une réplique fâchée ; chargement d'une sauvegarde faite en mission : impossible (on ne sauvegarde pas en mission), on recharge l'état d'avant.
- Test : marqueur : la mission démarre après 0,5 s à l'arrêt, pas en le traversant à 30 km/h ; mission à créneau refusée à 12 h avec le bon message, « attendre » amène l'horloge à 6 h ; avec 1 étoile : refus ; une mission en cours rend les autres marqueurs inactifs ; mission dont la précédente n'est pas réussie : marqueur absent de la scène et de la carte.

## Objectifs
- Types d'objectifs (liste fermée ; toute mission est une combinaison) :

| Type | Réussi quand | Affichage |
|---|---|---|
| `aller` | le joueur est dans la zone (rayon 3 à 15 m), éventuellement à l'arrêt, à pied ou dans un type de véhicule donné | colonne + point sur la carte + itinéraire GPS |
| `monter` | le joueur est dans le véhicule désigné | flèche au-dessus du véhicule |
| `parler` | dialogue terminé avec le personnage | icône au-dessus de sa tête |
| `prendre` / `deposer` | E sur l'objet ou le colis ; colis remis au point | contour, compteur « Colis 2/5 » |
| `escorter` | le véhicule ou le personnage accompagné arrive à destination | sa santé ou ses dégâts en petite jauge |
| `suivre` | filature menée jusqu'au bout (voir plus bas) | jauge de distance |
| `semer` | niveau de recherche revenu à 0, ou poursuivants distancés de 150 m pendant 10 s | étoiles, ou compteur de poursuivants |
| `battre` | tous les adversaires désignés sont sonnés | compteur « 2/4 » |
| `tenir` | temps écoulé en restant dans une zone ou en gardant quelque chose intact | compte à rebours |
| `chrono` | un autre objectif accompli avant la fin du temps | chronomètre |
| `photographier` | photo valide du sujet (`telephone_du_joueur.md`) | cadre de visée |
| `payer` / `gagner` | somme remise, ou somme atteinte (par exemple 5 000 FCFA de courses) | compteur d'argent |
| `choisir` | réponse donnée dans un dialogue à choix (`dialogues.md`) | — |

- **Texte d'objectif** : une ligne en haut à gauche, à l'infinitif ou à l'impératif tutoyé, 60 caractères au plus (« Conduis Nan Akouavi à l'entrepôt du port. »). Il change avec un son discret et reste visible ; la touche **O** le réaffiche en grand 3 s.
- **Objectifs facultatifs** : au plus 2 par mission, en italique (« Sans abîmer la moto », « En moins de 4 minutes ») ; ils donnent une prime (voir « Récompenses »), jamais d'échec.
- **Objectifs simultanés** : une étape peut en demander plusieurs (« tous ») ou un parmi plusieurs (« au choix ») ; c'est le mécanisme des missions à embranchement.
- **Conditions d'échec** (liste fermée) : Koffi évanoui ; arrêté ; temps écoulé ; véhicule de mission hors d'usage (100 points de dégâts) ; personnage escorté évanoui ou perdu ; cible de filature perdue ou alertée ; colis perdu ou trop abîmé ; abandon de la zone (plus de 300 m de l'objectif pendant 30 s, après un avertissement à 150 m) ; argent de mission dépensé ; acte interdit par la fiche (par exemple renverser un passant dans une mission de conduite prudente).
- **Protection des innocents (décision 102)** : aucun objectif `battre` ne vise un passant, un vendeur, un policier droit ; aucun objectif n'exige de renverser, voler ou tromper un innocent à ses dépens ; l'outil de vérification des fiches refuse un objectif `battre` dont la cible n'a pas l'étiquette `adversaire`.
- **Guidage** : après 45 s sans progrès vers l'objectif, Koffi dit une phrase d'aide (décision 107) ; après 2 minutes, le texte d'objectif clignote et l'itinéraire GPS se recalcule.
- Test : pour chaque type, une mission d'essai d'une étape : l'objectif se valide dans la situation prévue et pas juste en dehors (zone manquée de 1 m, mauvais véhicule, colis non pris) ; chaque condition d'échec déclenche l'échec ; l'avertissement d'abandon apparaît à 150 m, l'échec après 30 s à plus de 300 m ; le vérificateur refuse une fiche avec `battre` sur un passant ; texte de plus de 60 caractères refusé.

## Points de contrôle
- Un point de contrôle est posé **à la fin d'une étape** marquée dans la fiche. Règle d'écriture : un point de contrôle au moins toutes les 4 minutes de jeu prévues, donc 1 à 3 par mission de 5 à 12 minutes ; toujours un juste avant une épreuve difficile (poursuite, chrono serré, bagarre) et juste après une longue scène de dialogue (on ne la revoit pas).
- **Ce qui est enregistré** : numéro de l'étape ; position et orientation de reprise (un emplacement écrit dans la fiche, pas la position exacte du joueur) ; véhicule de mission, remis à 30 points de dégâts au plus et un quart de réservoir au moins ; heure et météo ; santé de Koffi (60 au moins à la reprise) ; argent au moment du point ; compteurs de mission (colis livrés, adversaires déjà sonnés) ; objectifs facultatifs déjà perdus.
- **Ce qui ne l'est pas** : niveau de recherche (remis à 0, sauf mission qui l'impose) ; passants et circulation (recréés) ; objets tenus en main.
- Le point de contrôle vit **en mémoire seulement**, pour la séance en cours. Quitter le jeu ou revenir au menu en pleine mission : au retour, la mission est à recommencer du début (la sauvegarde automatique date d'avant la mission ; voir `sauvegarde.md`, autre agent). Le menu de pause le dit avant de quitter.
- Affichage : « Point de contrôle » 2 s en bas de l'écran, avec un son bref.
- Argent : l'argent gagné ou dépensé entre le point de contrôle et l'échec est annulé à la reprise (retour à la somme enregistrée), pour qu'on ne puisse ni s'enrichir ni se ruiner en boucle.
- Cas limites : point atteint avec un véhicule très abîmé (plus de 80 points de dégâts, fumée noire) : le point est pris quand même, le véhicule sera réparé à 30 à la reprise ; point atteint pendant une recherche : la recherche continue, mais la reprise se fera à 0 étoile, sauf mission qui l'impose.
- Test : mission d'essai à 3 étapes avec point après la 2e : échec en 3e étape → reprise à l'étape 3, à l'emplacement prévu (moins de 1 m), santé ≥ 60, argent égal à celui du point, véhicule à 30 points de dégâts au plus ; échec en 1re étape → reprise au début ; retour au menu puis rechargement : mission `disponible`, non commencée.

## Échec et reprise
- **Écran d'échec** : l'image ralentit (0,5 s) et s'assombrit ; « Mission échouée » et la raison en une ligne (« La moto de Romaric est hors d'usage. », « Tu as perdu Expédit de vue. ») ; Koffi dit une réplique courte, de préférence drôle, tirée d'une liste par raison.
- **Choix** (E, flèches) :
  1. « Reprendre au dernier point de contrôle » (par défaut ; « Recommencer la mission » s'il n'y a pas encore de point) ;
  2. « Recommencer la mission depuis le début » ;
  3. « Abandonner » : la mission redevient `disponible`, Koffi est remis au point de départ de la mission, avec l'état (argent, véhicules, heure) d'avant la mission.
- La reprise est **gratuite** : pas de frais de soins ni d'amende en mission (décision 101 ; les frais ne valent qu'en jeu libre).
- **Délai** : moins de 5 s entre le choix et le retour au jeu (fondu, rechargement de l'étape).
- **Aide après échecs répétés** au même point : au 2e échec, une phrase de conseil sous la raison (« Prends la rue derrière le marché : les voitures n'y passent pas. ») ; au 3e, la mission devient plus souple pour cette tentative (chrono +15 %, adversaires −20 % de résistance, distance de filature +20 %) ; au 5e, le jeu propose « Passer cette épreuve » pour les étapes marquées `passable` dans la fiche (jamais la dernière étape d'un chapitre) ; passer ne donne pas la prime des objectifs facultatifs. Le tout se désactive en difficulté « Corsé ».
- **Abandon volontaire** : menu de pause → « Abandonner la mission » (avec confirmation) ; même effet que le choix 3.
- **Sans échec possible** : les étapes purement narratives (aller parler à quelqu'un, premier trajet du jeu) n'ont aucune condition d'échec autre que l'évanouissement.
- **Scènes déjà vues** : à la reprise, les dialogues et cinématiques d'avant le point de contrôle ne sont pas rejoués ; ceux de l'étape reprise le sont en version courte (passables tout de suite).
- Statistiques : nombre d'échecs par mission enregistré (pour l'équilibrage et l'écran de statistiques), jamais affiché de façon moqueuse.
- Cas limites : deux conditions d'échec au même instant : la raison affichée suit l'ordre évanoui > arrêté > véhicule > cible > temps ; échec pendant une cinématique : impossible (les conditions sont suspendues).
- Test : chaque raison d'échec affiche son texte ; les trois choix mènent à l'état attendu ; reprise en moins de 5 s ; au 3e échec le chrono d'essai passe de 60 à 69 s ; « Passer » proposé au 5e échec seulement sur une étape `passable` ; en « Corsé », aucune aide.

## Récompenses
- **Argent**, versé à l'écran de réussite (« Mission réussie », titre, somme qui s'ajoute au compteur avec un son de pièces ou de KwabôPay à partir du chapitre 2). Fourchettes par chapitre, pour les missions principales :

| Chapitre | Récompense par mission principale | Mission secondaire |
|---|---|---|
| 1 (2017) | 1 000 à 15 000 FCFA | 300 à 2 000 |
| 2 (2018-2019) | 10 000 à 60 000 | 1 000 à 8 000 |
| 3 (2020) | 25 000 à 120 000 | 2 000 à 15 000 |
| 4 (2021-2022) | 80 000 à 400 000 | 5 000 à 40 000 |
| 5 (2023-2024) | 200 000 à 1 000 000 | 10 000 à 80 000 |
| 6 (2025-2026) | 500 000 à 2 500 000 | 20 000 à 150 000 |

- Les trois missions d'essai actuelles (500, 750 et 300 FCFA) sont des missions de prise en main et restent sous la fourchette, exprès.
- **Prime des objectifs facultatifs** : +10 % de la récompense par objectif réussi (deux au plus), arrondie à 50.
- **Difficulté** : les sommes ne changent pas avec la difficulté (pas de punition pour qui joue en « Tranquille »).
- **Autres récompenses** (écrites dans la fiche) : déblocage (mission suivante, quartier, métier, boutique, véhicule, propriété à vendre, station de radio, contact du téléphone) ; réputation de quartier ou de conducteur ; objet ou tenue ; remise de dette (Tonton Gratien, chapitres 1 et 2).
- **Retenues visibles** : si la mission prévoit un remboursement (dette, part de Romaric), l'écran l'affiche ligne par ligne : « Livraison : +8 000 / Part de Tonton Gratien : −3 000 / Pour toi : 5 000 ».
- **Rejouer** : une mission principale réussie peut être rejouée depuis le journal ; elle ne rapporte alors ni argent ni déblocage (seulement son temps et ses objectifs facultatifs pour les statistiques). Les missions secondaires répétables (courses, livraisons chronométrées) paient à chaque fois, selon leur propre barème.
- **Après la réussite** : sauvegarde automatique (décision 115) ; Koffi garde le véhicule de mission s'il est à lui, sinon le véhicule reste sur place 2 minutes réelles puis est rendu ; la santé est remise à 50 au moins ; un appel ou un message peut suivre après 20 à 60 s (jamais pendant l'écran de réussite).
- **Fin de chapitre** : la dernière mission affiche un bilan (argent gagné dans le chapitre, missions, temps de jeu), puis l'ellipse vers les années suivantes (cinématique), et applique les changements de ville (décision 91) et de prix.
- Test : récompense créditée une seule fois, exacte ; +10 % par objectif facultatif ; rejouer une mission principale : argent inchangé ; sauvegarde automatique écrite après la réussite (date du fichier) ; déblocage visible (marqueur de la mission suivante présent) ; le vérificateur de fiches signale une récompense hors fourchette du chapitre.

## Cinématiques
- Deux formes :
  1. **Scène dirigée** : caméra placée par la fiche, personnages animés, dialogue sous-titré et doublé ; le joueur ne contrôle rien. Durée : 20 à 90 s ; 150 s au plus pour les ouvertures et fins de chapitre.
  2. **Dialogue en jeu** : les personnages parlent pendant que le joueur garde la main (en conduisant surtout) ; pas de changement de caméra. C'est la forme préférée : au moins la moitié du texte d'une mission passe par là (décision 107).
- **Mise en scène des scènes dirigées** : avec les moyens du moteur du jeu (pas de vidéo) ; plans fixes ou lents (travelling de 2 m au plus, panoramique de 30° au plus), 3 à 8 plans par scène, changement de plan à chaque changement d'interlocuteur ; bandes noires en haut et en bas (12 % de la hauteur chacune) ; interface masquée. Tenue de Koffi, véhicule, heure et météo réels du joueur, sauf si la fiche les impose.
- **Passer** : Entrée fait avancer d'une réplique ; Entrée maintenue 1 s (anneau qui se remplit) passe toute la scène. Passer n'ôte jamais une information nécessaire : l'objectif qui suit reprend l'essentiel en une ligne. Première vision d'une ouverture de chapitre : passable après 3 s seulement.
- **Entrée et sortie** : fondu de 0,4 s ; à l'entrée, la circulation et les passants à moins de 30 m sont écartés ou figés hors champ, le niveau de recherche est gelé, les dégâts et l'horloge suspendus ; à la sortie, le joueur est posé à l'emplacement prévu, tourné vers son prochain objectif, véhicule à côté de lui.
- **Pause** : Échap met en pause pendant une scène (son coupé) ; le menu propose « Reprendre » et « Passer la scène ».
- **Sous-titres, voix, lèvres** : voir `dialogues.md`. Sans fichier de voix, la réplique reste affichée selon sa longueur.
- **Contenu** (décisions 2, 3, 6, 42, 75) : comédie d'action réaliste ; pas de sang détaillé ; aucun personnage principal ne meurt ; les rares tirs de la police sont dans des scènes dirigées, sans blessé montré.
- **Ellipses** entre chapitres : carton « Cotonou, 2018 » sur un plan large de la ville qui a changé (chantier, immeuble neuf), 6 s, puis Koffi dans sa nouvelle tenue (décision 27).
- **Rejouer** : les scènes vues se revoient depuis le journal de missions.
- La mise en scène détaillée (objectifs de caméra, règles de cadrage) est dans le document « Caméra et cinématiques » (autre agent) ; ce document-ci ne fixe que le déroulement.
- Test : scène d'essai de 3 répliques : Entrée avance d'une réplique, maintien 1 s : fin de scène ; pendant la scène, la position du joueur et l'horloge ne changent pas, aucun dégât n'est reçu (voiture lancée sur lui : elle est écartée) ; à la sortie, joueur à l'emplacement prévu (moins de 0,5 m), interface revenue ; durée déclarée de chaque scène des fiches ≤ 150 s.

## Missions chronométrées
- **Affichage** : chronomètre en haut au centre, minutes et secondes ; blanc, puis orange sous 30 s, rouge clignotant sous 10 s, avec un bip par seconde sous 10 s.
- **Calcul du temps accordé** (pour l'auteur de la fiche et pour les missions répétables générées) : `temps = distance par la route / vitesse de référence × marge + temps fixe`.

| Véhicule | Vitesse de référence | 
|---|---|
| À pied | 6 m/s |
| Moto | 11 m/s (40 km/h de moyenne en ville) |
| Voiture, taxi | 10 m/s |
| Tricycle, minibus, camionnette | 8 m/s |
| Camion | 6,5 m/s |
| Pirogue | 7 m/s |

- Marge selon la difficulté : × 1,5 « Tranquille », × 1,25 « Normal », × 1,1 « Corsé ». Temps fixe : 10 s par arrêt (chargement, client). Heures de pointe : × 1,2 de plus si l'itinéraire passe par un pont ou un grand carrefour entre 7 h-9 h et 17 h-20 h (sauf si la fiche fige l'heure). Arrondi aux 5 s supérieures.
- Exemple : livraison à moto de 1 800 m en « Normal », un arrêt : 1 800 / 11 × 1,25 + 10 = 214,5 → 3 min 35 s.
- **Variantes** : compte à rebours simple ; **relais** (chaque point atteint ajoute du temps : +`distance suivante / vitesse × 1,1`) pour les courses à étapes ; **échéance à l'horloge du jeu** (« avant 18 h », pour les livraisons du marché : on voit l'heure du jeu, pas un chrono) ; **chrono caché** (le personnage s'impatiente par des répliques à 50 %, 75 % et 90 % du temps ; pour les missions où un chronomètre casserait l'ambiance).
- **Pause du chrono** : pendant les cinématiques, les dialogues à choix, le menu de pause ; pas pendant le téléphone ni la grande carte.
- **Fin du temps** : échec « Trop tard. » ; pour les missions secondaires de livraison, pas d'échec mais paiement réduit (voir « Missions de livraison »).
- **Médailles** (missions secondaires répétables : courses de motos sur la plage, livraisons chronométrées) : bronze = temps accordé ; argent = 85 % ; or = 70 %. Meilleur temps gardé dans le journal. Primes : +0 %, +25 %, +50 % de la récompense.
- **Équité** : pas de barrage de police ni de contrôle routier créé sur l'itinéraire d'une mission chronométrée, sauf si la fiche le veut ; une inondation présente au départ est prise en compte dans la distance (itinéraire praticable).
- Interdits pendant un chrono : « passer le trajet » en zémidjan ou en taxi ; dormir ; attendre.
- Test : calcul de l'exemple = 215 s ; mêmes données en « Tranquille » = 260 s (255,5 arrondi à 260), en « Corsé » = 190 s ; chrono figé pendant un dialogue à choix, actif pendant la grande carte ; à 0 : échec et raison « Trop tard. » ; relais : temps ajouté conforme ; médaille d'or à 69 % du temps, d'argent à 84 %.

## Missions de filature
- But : suivre une cible (à pied, à moto, en voiture ou en pirogue) jusqu'à sa destination, **sans la perdre et sans se faire remarquer**. Usage typique : suivre Expédit au chapitre 4, un camion de Capitaine au chapitre 5.
- **Jauge de distance** en haut au centre : une barre avec trois zones ; le curseur est la distance réelle à la cible.

| Mode | Trop près (soupçon monte) | Bonne distance | Trop loin (perte) |
|---|---|---|---|
| À pied | moins de 8 m | 8 à 35 m | plus de 35 m |
| En véhicule, en ville | moins de 15 m | 15 à 70 m | plus de 70 m |
| En véhicule, sur route dégagée ou en pirogue | moins de 30 m | 30 à 120 m | plus de 120 m |

- **Soupçon** (0 à 100), affiché par un œil qui s'ouvre au-dessus de la jauge :
  - trop près : +12 par seconde ; +25 d'un coup pour un klaxon, un choc près de la cible (moins de 30 m), un passant renversé en vue ;
  - la cible **se retourne** de temps en temps (écrit dans la fiche, ou toutes les 20 à 40 s) pendant 2 s : si Koffi est dans son champ (cône de 100°, 40 m) à découvert et immobile ou marchant : +10 ; s'il court : +30 ; caché (accroupi derrière un obstacle, dans une cachette, ou derrière un autre véhicule en roulant) : 0 ;
  - à bonne distance et hors de vue : −5 par seconde ;
  - à 60 : la cible change de comportement (accélère, fait un détour, s'arrête pour regarder) ; à 100 : échec « Il t'a repéré. ».
- **Perte** : trop loin ou sans ligne de vue pendant plus de 12 s (20 s en « Tranquille », 8 s en « Corsé ») : échec « Tu l'as perdu de vue. ». Un compte à rebours discret et une réplique de Koffi préviennent à mi-temps. La dernière position connue de la cible est marquée sur la mini-carte pendant ce délai.
- **Comportement de la cible** : elle suit un itinéraire écrit, avec 2 à 4 **pièges** par mission : arrêt à un étal (il faut s'arrêter aussi, à distance), demi-tour, passage dans une ruelle où un véhicule ne passe pas (il faut descendre), feu ou embouteillage (à moto on risque de la dépasser), changement de véhicule (elle monte dans un zémidjan).
- **Tenue et véhicule** : en chemise jaune de zémidjan, Koffi est un zém parmi d'autres : soupçon × 0,5 en véhicule. Dans un véhicule très abîmé (fumée) ou sirène de police à ses trousses : soupçon × 2.
- **Fin** : la cible arrive ; Koffi doit souvent ensuite écouter (rester 20 s dans une zone à 10 m sans être vu) ou photographier (objectif `photographier`).
- Un point de contrôle est placé à mi-parcours de toute filature de plus de 3 minutes.
- La circulation ne doit pas ruiner la filature : les véhicules de la circulation ne s'intercalent pas durablement (ils ne restent pas plus de 5 s entre Koffi et la cible si cela fait sortir de la bonne distance).
- Test (`essai_filature`, cible à 30 km/h sur 400 m) : rester à 40 m : soupçon à 0, réussite ; coller à 8 m pendant 9 s : échec « repéré » (12 × 9 > 100) ; rester à 100 m en ville : échec « perdu » après 12 s ; retournement de la cible, joueur accroupi derrière un muret : +0 ; debout : +10 ; en chemise jaune à 10 m en véhicule : +6 par seconde ; à 60 de soupçon, la cible accélère.

## Missions de livraison
- But : porter un chargement d'un point à un autre, dans le temps et en bon état. C'est le cœur de l'histoire (décision 12) et le métier de livreur (décision 67).
- **Chargement** : au point de départ, à l'arrêt, E : les colis sont chargés (2 s par colis, barre de progression ; le joueur reste sur le véhicule). Capacités :

| Véhicule | Capacité (colis standard de 20 kg) |
|---|---|
| À pied | 1 (porté à deux mains : pas de course au-delà de 6 m/s, pas de saut) |
| Moto | 2 (porte-bagages) ; 0 avec un passager |
| Tricycle de livraison | 10 |
| Voiture, taxi | 6 (coffre et banquette) |
| Camionnette | 30 |
| Camion | 120 |
| Pirogue à moteur | 15 |

- **Effet sur la conduite** : chargé à plein : accélération −25 %, freinage −15 %, virage qui penche davantage (voir les documents de conduite) ; proportionnel au remplissage.
- **État de la marchandise** : jauge de 100 à 0. Elle baisse de la moitié des points de dégâts encaissés par le véhicule à chaque choc ; marchandise **fragile** (œufs, verrerie, médicaments du chapitre 3) : baisse égale aux dégâts, plus 2 points par freinage d'urgence et 5 par dos-d'âne pris à plus de 30 km/h ; **périssable** (poisson, glace) : −1 point toutes les 10 s après le temps prévu ; sous forte pluie, marchandise non bâchée (moto, tricycle) : −1 toutes les 5 s pour le tissu et le ciment. Chute à moto : −30 et les colis tombent : il faut les ramasser (E, 2 s chacun).
- **Paiement** : `prix de base × état / 100 × facteur de temps`, arrondi à 50. Facteur de temps : 1,2 si livré avant 80 % du temps accordé, 1 dans le temps, 0,7 en retard de moins de 50 %, 0,4 au-delà. État sous 30 : le destinataire refuse la livraison (rien n'est payé ; en mission principale : échec).
- **Prix de base des livraisons répétables** (panneau du marché, appels de Nan Akouavi) : 200 FCFA par colis + 1,5 FCFA par mètre de route par tranche de 5 colis, arrondi à 50. Exemples : 2 colis à moto sur 1 200 m : 400 + 1 800 = 2 200 ; 10 colis en tricycle sur 2 000 m : 2 000 + 6 000 = 8 000. Chapitres 4 à 6 : × 1,3.
- **Tournées** : jusqu'à 5 destinataires ; ordre libre ; le GPS propose l'ordre le plus court. Chaque arrêt : E, 2 s par colis.
- **Contrôles** : marchandise légale : aucun souci aux contrôles routiers (10 s perdues). Contrebande des missions d'histoire (kpayo, marchandises du port sans papiers, décision 5) : passer un contrôle = 2 étoiles et saisie si arrestation ; les fiches proposent toujours un itinéraire qui évite les contrôles, plus long.
- **Vol** : aux chapitres 4 et 5, des hommes de Capitaine peuvent tenter d'arrêter le véhicule (barrage de fortune) ; s'arrêter plus de 5 s près d'eux : 1 colis volé toutes les 3 s.
- **Livraisons à pied** (marchés) : colis porté ; une bousculade en courant le fait tomber (−10).
- Chapitre 3 : livraisons de vivres et de médicaments (décision 95) : marchandise fragile, rues vides, contrôles nombreux mais bienveillants (laissez-passer montré d'office).
- Test : chargement de 2 colis en 4 s ; un troisième refusé à moto ; choc de 20 points de dégâts : état 90 (fragile : 80) ; livraison dans le temps à l'état 90 pour un prix de base de 2 200 : 1 980 → 2 000 ; en avance : 2 376 → 2 400 ; état 25 : refus ; chute à moto : colis au sol, −30, ramassables ; tournée de 3 points : l'ordre proposé est le plus court des 6 possibles.

## Journal de missions
- Accès : menu de pause → « Missions », ou téléphone → application « Carnet ». Koffi le tient comme un carnet d'affaires (ton à la première personne).
- **Onglets** : « En cours », « Disponibles », « Terminées », « Secondaires ».
- **En cours** : titre, donneur, objectif courant, objectifs facultatifs (et s'ils sont encore possibles), point de contrôle atteint, temps écoulé ; bouton « Abandonner ».
- **Disponibles** : pour chaque mission : titre, donneur et son portrait, lieu de départ, conditions non remplies en clair (« Entre 6 h et 10 h », « Il te faut une moto », « Reviens avec 20 000 FCFA ») ; bouton « Montrer sur la carte » (pose l'itinéraire GPS). Les missions verrouillées n'apparaissent pas ; s'il n'y a rien de disponible, une ligne dit quoi faire (« Attends l'appel de Romaric », « Gagne encore 12 000 FCFA pour rembourser Tonton Gratien »).
- **Terminées** : par chapitre, dans l'ordre ; pour chacune : résumé en 2 phrases écrit par Koffi (« J'ai livré les pagnes de Nan Akouavi. Sous la pluie. Elle n'a compté que les taches. »), date du jeu, récompense, objectifs facultatifs réussis, nombre d'essais, boutons « Rejouer » et « Revoir les scènes ».
- **Secondaires** : par type (courses de zémidjan, livraisons, courses de motos sur la plage, dépannages, objets perdus) : nombre réussi sur le total, meilleurs temps et médailles.
- **Progression** : en tête, « Chapitre 2 — 5 missions sur 8 » et un pourcentage global (missions principales 60 %, secondaires 25 %, propriétés et flotte 15 %).
- **Dette** (chapitres 1 et 2) : ligne permanente « Dette envers Tonton Gratien : 38 000 FCFA » avec la prochaine échéance.
- **Notifications** : une mission qui devient disponible fait apparaître 4 s « Nouveau dans le carnet : … » ; jamais pendant une mission ou une cinématique (mis en attente).
- Navigation : flèches, E pour ouvrir, Échap pour revenir ; le jeu est en pause dans le journal ouvert depuis le menu, pas depuis le téléphone.
- Textes : titres de 30 caractères au plus ; résumés de 160 caractères au plus ; aucun texte ne révèle une mission future.
- Le journal est sauvegardé (états, essais, meilleurs temps) ; format dans `sauvegarde.md` (autre agent).
- Test : après la mission d'essai 1 réussie : elle est dans « Terminées » avec sa récompense, la suivante dans « Disponibles » ; condition horaire non remplie affichée en clair ; « Montrer sur la carte » crée un itinéraire dont l'arrivée est le marqueur ; aucune mission `verrouillée` listée ; pourcentage = 100 quand tout est réussi dans un jeu d'essai ; titres et résumés dans les limites de longueur.

## Choix faits par Claude (à confirmer)
- Les points de contrôle ne survivent pas à la fermeture du jeu (la sauvegarde automatique est faite après la mission, décision 115).
- Aide progressive après 2, 3 et 5 échecs, désactivée en « Corsé ».
- Fourchettes de récompenses par chapitre, cohérentes avec les prix de `economie.md` et `proprietes.md`.
- Touche O pour réafficher l'objectif ; fiches de mission en JSON dans `missions/`.
