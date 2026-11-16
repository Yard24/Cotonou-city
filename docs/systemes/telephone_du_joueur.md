# Téléphone du joueur : fonctionnement attendu

Code proposé : `scripts/telephone.gd` (ouverture, applications, appels, messages), `scripts/photo.gd`, données dans `telephone/contacts.json` et `telephone/messages.json`. Vérifications : `scripts/selftest_telephone.gd`, par simulation des entrées, sans décor.

Cadre : opérateur et services inventés (décision 25) : opérateur « Zékôm », paiement « KwabôPay » (66), réseau social « Kpôlè » ; Afi apprend à Koffi le paiement mobile et les réseaux (41) ; Koffi parle beaucoup (107). Temps : 1 heure de jeu = 2 minutes réelles.

**Appareil** : touche **T** (manette : croix haut maintenue) ; le téléphone monte en bas à droite de l'écran (30 % de la hauteur), le jeu continue. Flèches pour naviguer, E valider, Échap ou T fermer. Utilisable à pied, en passager et à l'arrêt en véhicule ; en conduisant au-dessus de 10 km/h, seuls décrocher et raccrocher marchent (à moto : dans le casque). Impossible en nageant, en combat, pendant une cinématique.
- **Deux appareils** : chapitres 1 à 3, téléphone à touches (écran de 4 lignes : Contacts, Messages, Carnet ; à partir du chapitre 2 : KwabôPay par menu à codes) ; à partir du chapitre 4, téléphone tactile (60 000 FCFA, ou offert par la mission d'Afi) : grille d'icônes, Carte, Appareil photo, Kpôlè.
- **Crédit** : appeler coûte 25 FCFA de crédit par appel passé ; recevoir est gratuit ; recharges de 200, 500, 1 000 FCFA aux kiosques Zékôm. Sans crédit : on reçoit toujours ; Romaric et Maman Koffi restent joignables (« bip » : ils rappellent). À partir du chapitre 4, forfait : 1 000 FCFA par 7 jours de jeu, prélevé sur KwabôPay, appels illimités.
- **Batterie** : pas de jauge (pas de corvée de recharge). **Réseau** : 0 à 4 barres ; absent au milieu de la lagune, dans les entrepôts fermés du port, sur la route du Nord entre les étapes.

## Contacts
- Liste par ordre d'apparition dans l'histoire ; chaque contact : portrait, nom tel que Koffi l'a enregistré, rôle en une ligne, actions.

| Contact (nom enregistré) | Depuis | Actions |
|---|---|---|
| « Romaric Mécano » | début | dépannage (il vient réparer sur place : 20 % de plus qu'au garage, arrivée en 60 à 120 s), conseil sur la mission |
| « Maman » | début | prendre des nouvelles (réplique ; +1 relation une fois par jour de jeu), lui envoyer de l'argent (chapitre 2) |
| « Tonton Gratien » | chapitre 1 | solde de la dette, rembourser par KwabôPay (chapitre 2) |
| « Le Doyen » | chapitre 1 | réputation de conducteur, état des motos confiées (chapitre 4) |
| « Nan Akouavi » | chapitre 2 | demander une livraison (mission répétable) |
| « Afi » | chapitre 2 | aide sur KwabôPay et Kpôlè (rappels de tutoriel) |
| « Expédit Transit » | chapitre 2 | marchandises du port ; ne répond plus après sa trahison (chapitre 4) |
| « Rachidath Journal » | chapitre 5 | lui envoyer une photo (missions) |
| « Zém » | début | fait venir un zémidjan où que soit Koffi (même règle que héler, délai +10 s, 25 FCFA de crédit) |
| « Taxi Ganhi » | chapitre 2 | fait venir un taxi |
| « Centre de santé » | début | indique le plus proche sur la carte |
- Jamais de contact pour Monsieur Fortuné, Capitaine ni Barnabé : ce sont eux qui appellent (numéro masqué pour les deux premiers).
- **Appeler** : E sur le contact puis sur l'action ; 2 à 4 sonneries (1,5 s chacune) ; le contact décroche selon ses horaires (Maman : 5 h-21 h ; Tonton Gratien : 8 h-18 h ; Romaric : toujours, en râlant la nuit) ; sinon « Ne répond pas » et il rappelle dans l'heure de jeu si c'est utile à une mission.
- Contact indisponible pour raison d'histoire : grisé avec une mention (« Ne répond plus »).
- Un contact avec du nouveau (mission, recette à relever) porte une pastille orange.
- 24 contacts au plus ; pas de numéro à saisir, pas de contact à créer soi-même.
- Test : au début d'une partie : 4 contacts ; appel à Tonton Gratien à 20 h : pas de réponse ; appel « Zém » : un zémidjan arrive en moins de 35 s, crédit −25 ; sans crédit : appel refusé sauf Romaric et Maman ; Expédit grisé après le drapeau de trahison.

## Appels entrants
- **Signal** : sonnerie (3 mélodies au choix dans les réglages du téléphone, toutes composées pour le jeu, décision 110), vibration de la manette, bandeau en haut à droite : portrait, nom, « T : décrocher — Retour arrière : refuser ». À moto : sonnerie dans le casque.
- **Durée de sonnerie** : 12 s. Sans réponse : appel manqué, noté dans le journal d'appels ; pour un appel de mission, le personnage rappelle 3 minutes réelles plus tard, puis envoie un message avec le marqueur.
- **Décrocher** : dialogue en jeu (le joueur garde la main, voix filtrée « téléphone », sous-titres avec « (téléphone) »). Certains appels ont un choix de réponse (`dialogues.md`). Entrée passe une réplique ; maintenir Retour arrière raccroche (le personnage peut s'en vexer : relation −1 ; jamais pour Maman : Koffi ne raccroche pas au nez de sa mère, la touche est sans effet).
- **Quand le jeu n'appelle pas** : pendant une mission (sauf appel écrit par elle), un combat, une recherche, une cinématique, un dialogue, les 20 s après une mission ; les appels sont mis en file (un seul à la fois, 60 s au moins entre deux) et expirent après 24 h de jeu s'ils ne sont plus utiles.
- **Types d'appels** : lancement de mission ; suite d'histoire ; Romaric ou le Doyen (panne d'une moto confiée, recette prête) ; client régulier de zémidjan (réputation 80 : course réservée, accepter place le marqueur, 3 minutes réelles pour s'y rendre) ; Tonton Gratien (échéance) ; Maman (elle appelle si Koffi n'est pas passé la voir depuis 5 jours de jeu, ou après une arrestation : Barnabé la connaît) ; faux numéro comique (1 tous les 10 jours de jeu, 12 écrits).
- En conduisant, décrocher ne gêne pas la conduite ; Koffi commente moins (ses commentaires sont suspendus pendant l'appel).
- Mode silencieux (réglage) : pas de sonnerie, bandeau seulement ; les missions de filature et d'infiltration le mettent d'office (un téléphone qui sonne à moins de 15 m d'un garde : +30 de soupçon s'il n'est pas en silencieux).
- Test : appel d'essai : bandeau et sonnerie pendant 12 s puis « manqué » ; T décroche et lance la première réplique en moins de 0,5 s ; aucun appel déclenché pendant une mission d'essai, il arrive 20 à 80 s après ; deux appels en file : 60 s d'écart au moins ; appel de mission manqué : rappel après 3 minutes, puis message avec marqueur ; raccrocher au nez de Maman impossible.

## Messages
- Boîte de réception : conversations par contact, la plus récente en haut ; pastille du nombre de non-lus sur l'icône ; son bref à l'arrivée et bandeau de 4 s avec le début du texte.
- **Longueur** : 160 caractères au plus par message (comme un vrai texto) ; les personnages ont leur style : Romaric écrit en rafales de 3 messages, Maman dicte et signe « Maman », Tonton Gratien n'écrit que des chiffres (« Reste 38 000. Vendredi. »), Afi abrège, Nan Akouavi ne met pas de point.
- **Contenu utile** : un message peut porter une **pièce jointe** : lieu (E : « Montrer sur la carte », pose l'itinéraire), mission (E : l'ajoute au carnet), argent KwabôPay (crédité à la lecture), photo.
- **Répondre** : pas de saisie libre ; quand une réponse est attendue, 2 ou 3 réponses toutes faites (même règles que les choix de dialogue), sans limite de temps.
- **Sources** : personnages ; KwabôPay (reçus : « Vous avez reçu 600 FCFA de 97 •• •• 12. Solde : 12 400 FCFA. ») ; opérateur Zékôm (crédit bas, fausses promotions comiques) ; clients réguliers ; faux messages d'arnaque à partir du chapitre 2 (voir `economie.md`), reconnaissables : fautes, urgence, demande de code.
- **Rythme** : 2 à 6 messages par jour de jeu hors missions, jamais plus d'un toutes les 90 s ; mêmes moments interdits que les appels, sauf en conduite (le message arrive, on le lit plus tard).
- **Conservation** : 100 messages ; les plus anciens sans pièce jointe non utilisée sont effacés d'abord ; un message de mission non lu n'est jamais effacé.
- Les messages lus qui portent une consigne restent marqués d'une étoile et sont repris dans l'historique des dialogues.
- Test : message d'essai avec lieu : bandeau, pastille 1, E pose un itinéraire dont l'arrivée est le lieu ; message avec 500 FCFA : crédité une seule fois, à la lecture ; 101e message : le plus ancien lu disparaît, un message de mission non lu reste ; aucun message de plus de 160 caractères dans les données ; deuxième réponse à une arnaque : aucune perte.

## Carte
- Application « Carte » : c'est la **grande carte** de `carte_et_gps.md`, affichée dans le cadre du téléphone puis en plein écran (même écran que la touche M). Le jeu passe en pause en plein écran.
- **Selon l'appareil** : chapitres 1 à 3 (téléphone à touches) : pas d'application ; la touche M ouvre un **plan papier** de Cotonou (dessin au trait, plié), avec les mêmes fonctions sauf la position en direct des véhicules de la flotte et le trafic. À partir du chapitre 4 : application avec position précise, embouteillages en orange sur les grands axes aux heures de pointe, motos confiées en petits points jaunes.
- **Sans réseau** (téléphone tactile) : la carte s'affiche, mais sans trafic ni flotte, et la position de Koffi est figée au dernier endroit couvert, marquée « position approximative » ; l'itinéraire déjà calculé reste affiché.
- **Depuis les autres applications** : « Montrer sur la carte » dans un message, un contact (centre de santé, propriété) ou le carnet de missions ouvre la carte centrée sur le lieu, curseur dessus, avec « E : y aller » (itinéraire).
- **Partage de position** dans les appels : quand Koffi appelle « Romaric Mécano » pour un dépannage ou « Zém », le lieu de rendez-vous est sa position ; s'il bouge de plus de 50 m, l'autre appelle : « Tu es où ? Reste là où tu es ! » et le délai repart.
- Test : au chapitre 1, T n'offre pas « Carte » et M ouvre le plan papier sans points de flotte ; au chapitre 4, la carte montre les motos confiées ; sans réseau : mention « position approximative » et trafic masqué ; « Montrer sur la carte » centre à moins de 5 m du lieu.

## Appareil photo
- Disponible à partir du chapitre 4 (téléphone tactile). Avant, une mission du chapitre 2 prête à Koffi un petit appareil pour une seule photo.
- **Prise de vue** : icône Appareil photo, à pied et à l'arrêt seulement. Vue à la première personne à travers l'écran du téléphone ; flèches ou souris pour viser (±60° en hauteur) ; molette ou Maj/C : zoom de 1 à 4 ; **E ou clic** : photo (bruit d'obturateur, écran blanc 0,1 s) ; V : retourner l'appareil (autoportrait : Koffi prend une pose parmi 6) ; Échap : ranger. Koffi marche à 2,5 m/s en visant.
- **Photo valide pour une mission** (objectif `photographier`) : le sujet occupe au moins 8 % de la hauteur de l'image, est à moins de 60 m, visible à plus de 50 % (pas caché), dans le cadre central (60 % de l'image), et l'image n'est pas bougée (Koffi immobile depuis 0,3 s). Le cadre devient vert quand tout est bon. Preuve du chapitre 5 pour Rachidath : il faut en plus que **deux** sujets soient dans l'image (la personne et la marchandise).
- **Discrétion** : lever le téléphone à moins de 15 m d'un garde ou de la cible qui regarde : soupçon +20 par seconde (`moteur_de_missions.md`, filature) ; la nuit sans éclairage : photo invalide (« trop sombre ») ; pas de flash.
- **Galerie** : 30 photos gardées (vignettes de 320 × 180 enregistrées dans la sauvegarde) ; E : plein écran ; R : supprimer ; « Publier sur Kpôlè » ; « Envoyer à Rachidath » pendant ses missions.
- **Respect** : en visant un passant à moins de 5 m pendant plus de 2 s, il se détourne ou cache son visage, et proteste (« On ne filme pas les gens comme ça ! ») ; enfants : l'appareil refuse de déclencher si un enfant occupe plus de 10 % de l'image ; lieux de culte : photo permise de l'extérieur, aucune mission ne le demande (décision 18) ; policiers : sommation (« Range ça ») puis rien de plus.
- **Défis photo** (secondaire) : 20 lieux à photographier (monuments simplifiés, coucher de soleil à Fidjrossè, pont sous l'harmattan…), liste dans le carnet ; 2 000 FCFA par photo validée, payés par un journal local inventé.
- Test : sujet d'essai à 20 m, plein cadre : valide ; à 80 m ou caché à 60 % : invalide ; en mouvement : invalide ; 31e photo : la plus ancienne non protégée est retirée ; enfant dans le cadre : pas de déclenchement ; photo de nuit sans lumière : « trop sombre » ; la vignette est restaurée après sauvegarde et rechargement.

## Réseau social fictif
- **« Kpôlè »** (nom inventé ; logo : bulle jaune) : installé par Afi au chapitre 4 (décision 41). Aucun lien ni ressemblance avec un réseau réel ; aucune connexion à internet : tout est simulé (décision 71).
- **Fil** : 8 à 12 publications nouvelles par jour de jeu, à faire défiler : texte de 200 caractères au plus, parfois une image du jeu, auteur fictif, nombre de « pouces », 0 à 3 commentaires. Quatre sources :
  1. **la ville** : embouteillage sur un pont, pluie annoncée, coupure de courant dans un quartier, chantier (ces publications disent vrai : elles reflètent l'état réel du jeu et servent d'information) ;
  2. **échos du joueur** : vidéos de badauds (bagarre, chute à moto spectaculaire, livraison record), sans jamais nommer Koffi au début (« Le zém au maillot vert ») ;
  3. **l'histoire** : enquêtes de Rachidath (chapitre 5), communiqués polis de l'entreprise de Monsieur Fortuné, rumeurs ;
  4. **la vie** : blagues, annonces de vendeuses, photos de plats, football de quartier (équipes inventées). Aucune politique, aucun parti, aucune personne réelle (décision 17).
- **Publier** : une photo de la galerie avec une légende choisie parmi 4 proposées par Koffi (décision 107 : elles sont à son image). Effet : des « pouces » arrivent pendant 2 heures de jeu selon le sujet (défi photo, véhicule propre et repeint, propriété neuve : beaucoup ; mur quelconque : 3 pouces et un commentaire d'Afi : « Grand frère… »).
- **Abonnés** : de 12 (la famille) à 50 000. Gains : publication réussie +10 à +500 ; missions d'histoire ; échos positifs. Pertes : vidéo de Koffi renversant un passant ou arrêté (−50 à −500).
- **À quoi ça sert** (effets de jeu mesurés) : à 1 000 abonnés, clients de zémidjan et de taxi +10 % (« Ah, c'est toi ! ») ; à 5 000, publier une annonce pour l'entreprise (une fois par jour de jeu) donne +10 % de revenus des livraisons pendant ce jour ; à 20 000, un passant sur vingt demande un autoportrait (refuser ou accepter, 3 s). Jamais d'argent direct, de publicité réelle ni d'achat (décision 71).
- **Messages privés** : non (les messages restent dans « Messages »).
- **Ton** : gentiment moqueur, jamais de harcèlement ; les commentaires méchants sont rares, courts et drôles ; aucune moquerie sur l'origine, la religion, l'accent (104).
- **Quantité à écrire** : 150 publications « ville » à trous, 60 échos, 80 d'histoire, 200 de vie ; une publication ne revient pas avant 20 jours de jeu.
- Sans réseau : « Impossible d'actualiser », le dernier fil reste lisible.
- Test : application absente avant le chapitre 4 ; 8 à 12 publications par jour simulé, aucune répétée sur 20 jours ; publication « embouteillage au pont » seulement si l'embouteillage existe dans la simulation ; publier une photo de défi : abonnés en hausse dans les 2 h de jeu ; paliers 1 000 et 5 000 : effets appliqués et mesurables (taux de clients, revenus) ; l'outil de contrôle des textes refuse plus de 200 caractères.

## Choix faits par Claude (à confirmer)
- Touche T ; téléphone à touches aux chapitres 1 à 3, tactile à partir du chapitre 4 (plan papier avant).
- Noms inventés : opérateur « Zékôm », réseau « Kpôlè » (à faire valider comme les expressions fon : le mot est voulu inventé).
- Pas de batterie à recharger ; crédit d'appel simple, puis forfait.
- L'appareil photo ne déclenche pas sur un enfant.
