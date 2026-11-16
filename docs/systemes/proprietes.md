# Propriétés : fonctionnement attendu

Code proposé : `scripts/propriete.gd` (état de chaque propriété, achat, revenus, caisse), `scripts/logement.gd` (lit, armoire, coffre). Données : `proprietes/proprietes.json`. Vérifications : `scripts/selftest_propriete.gd`, avec une propriété d'essai de chaque type, tirage fixé.

Cadre : propriétés achetables : chambre, garage, boutique, entrepôt, maison (décision 69) ; une trentaine de bâtiments où l'on entre, dont les logements du héros (92) ; sauvegarde automatique après chaque mission, plus 3 emplacements manuels (115) ; tenue modifiable, pas le visage ni la corpulence (50) ; Koffi bâtit une entreprise de transport et de livraison (12) ; pas de jeux d'argent (70). Prix et conditions d'argent : `economie.md`, section « Achat de propriétés » (fait foi pour les montants). Format du fichier de sauvegarde : `sauvegarde.md` (autre agent). Détail des tenues : `vetements_et_apparence.md` (autre agent). Temps : 1 jour de jeu = 48 minutes réelles.

**Les six lieux de Koffi** :

| Lieu | Type | Où | Depuis | Prix (frais d'acte de 5 % compris) | Ce qu'on y trouve |
|---|---|---|---|---|---|
| Chez Maman Koffi | logement de départ (pas une propriété) | Dantokpa, cour familiale | début | — | natte dans la pièce commune, cantine en fer (garde-robe), 1 place de moto |
| Chambre | chambre | Dantokpa, cour commune derrière le marché, 3 × 4 m | chapitre 2 | 157 500 | lit, armoire, coffre, 1 place devant la porte |
| Garage | garage | Missèbo, à côté de l'atelier de Romaric | chapitre 3 | 630 000 | 6 emplacements, atelier (`garage.md`), lit de camp, casier |
| Boutique | boutique | Dantokpa, allée des tissus, 4 × 6 m + réserve | chapitre 4 | 1 575 000 | comptoir, vendeuse, caisse ; pas de lit |
| Entrepôt | entrepôt | Akpakpa, zone du port, 20 × 30 m | chapitre 5 | 4 200 000 | quai, 4 places de camion, bureau avec lit de camp et armoire, caisse |
| Maison | maison | Fidjrossè, deuxième rue derrière la plage | fin du chapitre 5 | 9 450 000 | 3 pièces, terrasse, cour avec 2 places, chambre avec lit, grande armoire, coffre |

## Achat
- **Repérer** : une propriété à vendre porte un panneau en bois peint « À VENDRE » (écriteau sans numéro réel) et une icône de clé verte sur la carte dès que sa mission de présentation est faite (ou dès que Koffi passe à moins de 40 m, mais alors grisée : « Pas encore pour toi. »).
- **Visiter** : E devant le panneau : le vendeur ou le gardien ouvre ; visite libre de 60 s au plus dans les lieux vides (on voit le lit, l'armoire, les emplacements en silhouettes claires), puis fiche de la propriété : nom, type, prix frais compris, ce qu'elle apporte (« Point de sauvegarde — Garde-robe — 6 véhicules — Revenu : 15 000 FCFA par jour »), conditions non remplies en clair.
- **Conditions** : chapitre atteint ; mission de présentation réussie ; propriété précédente de la liste achetée pour la boutique (il faut la chambre ou le garage) ; pas d'échéance de dette en retard ; niveau de recherche à 0 ; argent disponible dans la bonne poche (au-delà de 2 000 000 FCFA : compte en banque).
- **Marchander** : un seul échange (`economie.md`, « Marchandage ») : au mieux −5 % sur le prix hors frais ; vendeur vexé : prix affiché, sans conséquence durable.
- **Conclure** : choix « Acheter », écran de confirmation avec le total (« Acheter le garage pour 630 000 FCFA ? »), E maintenu 1 s. Scène courte (10 s, passable) : poignée de main, remise des clés et du papier tamponné par la mairie d'arrondissement ; Koffi a une réplique par propriété (chambre : « Quatre murs à moi. Enfin, trois et demi : celui-là penche. »). Argent débité une seule fois ; sauvegarde automatique.
- **Aussitôt après** : le panneau disparaît ; l'icône devient une clé pleine ; les services du lieu sont actifs ; pour le garage, la boutique et l'entrepôt, l'activité démarre au jour de jeu suivant ; un message de Maman Koffi ou de Nan Akouavi suit dans les 2 minutes réelles ; brève à la radio (`radio_en_voiture.md`).
- **Aménagements**, achetés ensuite sur place (E sur le tableau d'ardoise à l'entrée) :
  | Aménagement | Où | Prix | Effet |
  |---|---|---|---|
  | Coffre scellé | chambre, maison | 20 000 | argent à l'abri (voir « Point de sauvegarde ») |
  | Ventilateur puis climatiseur | chambre, maison | 15 000 / 120 000 | dormir rend « bien reposé » plus longtemps (4 h puis 8 h de jeu) |
  | Groupe électrogène | garage, boutique, entrepôt | 150 000 | plus d'arrêt pendant les coupures de courant |
  | Extension à 10 emplacements | garage | 300 000 | chapitre 5 |
  | Seconde vendeuse | boutique | 100 000 | revenu +25 % |
  | Chambre froide | entrepôt | 600 000 | revenu +20 %, livraisons de périssables sans perte |
  | Enseigne peinte au nom de l'entreprise | boutique, entrepôt, garage | 25 000 | +5 % de revenu chacune |
  | Décoration (3 styles) | chambre, maison | 10 000 à 200 000 | aspect seulement |
- **Pas de revente, pas de location à des tiers, pas de saisie** : une propriété achetée reste à Koffi jusqu'à la fin (la fin « vendre » est un événement d'histoire, décision 98).
- **Évolution visible** (décisions 27 et 91) : chaque lieu s'embellit par chapitre (murs repeints, enseigne, carrelage) sans action du joueur.
- Cas limites : argent suffisant mais en espèces pour l'entrepôt : « Passe déposer ça à la banque. » avec le montant manquant sur le compte ; achat pendant une mission : refusé ; Koffi évanoui ou arrêté pendant la visite : visite annulée, rien n'est débité.
- Test : fiche affichant le prix frais compris ; achat refusé pour chacune des conditions non remplies, avec son message ; achat accepté : argent −157 500 exactement, propriété `possédée`, panneau retiré, icône changée, fichier de sauvegarde automatique écrit ; marchandage réussi : 150 000 → 142 500, frais calculés sur le prix d'origine (7 500), total 150 000 ; second achat de la même propriété impossible ; revenus nuls le jour de l'achat.

## Point de sauvegarde
- **Où** : dans chaque lieu qui a un couchage : natte chez Maman Koffi, lit de la chambre, lit de camp du garage et du bureau de l'entrepôt, lit de la maison. La boutique n'en a pas.
- **Comment** : E devant le couchage → choix : « Sauvegarder », « Dormir jusqu'au matin (6 h) », « Faire une sieste (2 h de jeu) », « Dormir jusqu'à… » (choix de l'heure par pas de 1 h, 12 h au plus), « Annuler ». Dormir sauvegarde aussi.
- **Sauvegarder** : ouvre les 3 emplacements manuels (décision 115) : pour chacun, vignette, chapitre, lieu, date et heure du jeu, argent, temps de jeu ; E pour écrire, confirmation si l'emplacement est occupé. Écriture en moins de 1 s ; « Partie sauvegardée. » Le détail du fichier est dans `sauvegarde.md`.
- **Dormir** : fondu au noir de 2 s, horloge avancée, fondu d'ouverture ; Koffi se lève. Effets :
  - santé remise à 100 ;
  - état « **bien reposé** » pendant 2 heures de jeu (4 avec ventilateur, 8 avec climatiseur) : la santé remonte seule 2 fois plus vite ; chez Maman Koffi, s'y ajoute la bouillie du matin si on se réveille entre 6 h et 10 h (+30 et une réplique) ;
  - la météo et les événements des heures sautées sont tirés normalement (on peut se réveiller sous la pluie) ;
  - **les revenus passifs ne courent pas pendant le sommeil** (`economie.md`) ; les intérêts de la dette, eux, suivent le calendrier : dormir ne les arrête pas ;
  - appels en attente : remis au réveil, 30 s après.
- **Refus** : pendant une mission (« Ce n'est pas le moment de dormir. »), avec 1 étoile ou plus, en combat, ou si Koffi s'est réveillé il y a moins de 4 heures de jeu (« Je n'ai pas sommeil. ») : la sauvegarde seule reste possible hors mission et hors recherche.
- **Point de réapparition** : au chargement d'une sauvegarde manuelle, Koffi est debout à côté du couchage où elle a été faite. Au chargement d'une sauvegarde automatique (après une mission), il est à l'endroit où la mission s'est terminée.
- **Évanouissement et arrestation** : ne ramènent pas au logement (centre de santé et commissariat, décisions 76 et 80).
- **Coffre** (chambre et maison, après achat de l'aménagement) : E : déposer ou retirer des espèces par tranches (1 000 ; 10 000 ; 100 000 ; tout) ; l'argent du coffre n'entre ni dans le calcul des amendes ni dans les frais de soins ; plafond 5 000 000 FCFA (au-delà : la banque). Au chapitre 1 et jusqu'à la chambre, Koffi peut confier jusqu'à 20 000 FCFA à Maman Koffi (« Maman, garde-moi ça. ») : elle les rend sur demande, avec un commentaire.
- **Sécurité du lieu** : aucun adversaire ni policier n'entre dans un logement en jeu libre (à 3 étoiles et plus, un agent frappe à la porte après 20 s : voir `police_et_niveau_de_recherche.md`) ; pas de combat à l'intérieur (touche de frappe sans effet).
- **Intérieur** : on entre par la porte (E), sans temps de chargement visible de plus de 1 s ; l'heure et la météo se voient par la fenêtre ; radio posée sur une étagère (mêmes stations, touche R à côté).
- Test : E sur le lit : menu à 5 choix ; sauvegarde manuelle : fichier écrit, vignette présente, rechargement → joueur à moins de 2 m du lit, même heure, même argent ; dormir à 22 h jusqu'au matin : 6 h, santé 100, état « bien reposé » pendant 2 h de jeu ; caisse des propriétés identique avant et après le sommeil ; dette : intérêts appliqués si la semaine s'achève pendant le sommeil ; refus avec 1 étoile, en mission, et 3 h après un réveil ; coffre : 50 000 déposés, amende calculée sans eux.

## Garde-robe
- **Où** : dans chaque logement : cantine en fer chez Maman Koffi, armoire de la chambre, casier du garage, armoire du bureau de l'entrepôt, grande armoire de la maison. **Contenu partagé** : la même garde-robe partout (pas de tenue « restée dans l'autre maison »).
- **Ouvrir** : E devant le meuble : Koffi apparaît de face, en pied, sur fond du lieu ; il tourne avec gauche/droite. Le jeu n'est pas en pause, mais on est en sécurité dans un logement.
- **Écran** : colonnes par emplacement — haut, bas, chaussures, couvre-chef, accessoires (lunettes, montre, sacoche) — selon la liste de `vetements_et_apparence.md` ; chaque pièce : nom, image, effet éventuel (allure). Flèches pour parcourir, **E essayer** (changement immédiat sur le modèle), **Entrée valider**, Échap annuler et revenir à la tenue d'avant.
- **Tenues enregistrées** : 6 ensembles mémorisables (maintenir E 0,6 s sur un emplacement numéroté pour enregistrer la tenue portée ; E bref pour la remettre). Trois sont préremplis au fil de l'histoire : « Zém » (chemise jaune numérotée, décision 43), « Tous les jours », « Grande occasion ».
- **Ce qui ne change pas** : visage, corpulence, taille (décision 50) ; l'âge apparent suit le chapitre (décision 8). La coiffure se change chez le coiffeur, pas ici.
- **Tenue de base** : le maillot vert, le jean et les sandales du chapitre 1 (décision 27) restent toujours dans la garde-robe et ne peuvent être ni vendus ni perdus ; retirer une pièce sans la remplacer remet la pièce de base (jamais de Koffi dévêtu, décision 5). À chaque nouveau chapitre, la tenue de l'histoire s'ajoute et Koffi la porte d'office au premier réveil ; le joueur reste libre d'en changer.
- **Changer de tenue sert à** : remplir les conditions d'entrée de certains lieux et missions (allure, voir l'autre document) ; travailler comme zémidjan (chemise jaune) ; tromper une recherche de police (changer sans avoir été vu entrer : reconnu seulement à moins de 15 m et temps à tenir divisé par 2) ; le marchandage (en costume au marché : prix plus hauts).
- **Tenue imposée** : une mission peut imposer une tenue ; elle est rendue à la garde-robe à la fin et la tenue d'avant est remise.
- **Casque** : mis d'office à moto (décision 52) ; son modèle et sa couleur se choisissent ici une fois un second casque acheté.
- **Tenues sales ou mouillées** : après la pluie, une bagarre ou une chute, la tenue portée est marquée (assombrie, poussiéreuse) ; passer par la garde-robe la remet propre (une réplique sur la lessive de Maman une fois sur cinq).
- Durée du changement : 0,4 s de fondu, comme en cabine.
- Test : la garde-robe contient exactement les pièces achetées, identiques dans deux logements différents ; E essaye, Échap rétablit la tenue d'origine, Entrée la garde ; tenue enregistrée n° 1 remise en un appui ; retirer le haut remet le maillot vert ; la pièce de base n'est pas supprimable ; tenue conservée après sauvegarde et rechargement ; mission à tenue imposée : tenue d'avant restaurée à la fin ; aucun écran ne propose de modifier le visage ou la corpulence.

## Revenus
- **Ce que rapporte chaque propriété**, par jour de jeu (montants de `economie.md`) :

| Propriété | Activité montrée | Revenu de base | Avec tous les aménagements |
|---|---|---|---|
| Chambre, maison | logement | 0 | 0 |
| Garage | l'apprenti et un mécanicien réparent les motos du quartier | 15 000 | 15 750 (enseigne) |
| Boutique | une vendeuse vend des tissus fournis par Nan Akouavi | 40 000 | 52 500 (seconde vendeuse, enseigne) |
| Entrepôt | stockage et groupage de marchandises du port | 110 000 | 138 600 (chambre froide, enseigne) |
- **Calcul** : le revenu s'accumule en continu avec le **temps joué éveillé** (15 000 par jour = 312,5 FCFA par minute réelle, crédités par tranches de 50), de 7 h à 19 h du jeu seulement (les 24 h de revenu sont versées sur ces 12 heures d'ouverture). Rien pendant le sommeil, l'attente, les trajets passés, les voyages, les cinématiques.
- **Caisse** : l'argent va dans la caisse du lieu (tiroir du comptoir, boîte du bureau). Elle se remplit jusqu'à **3 jours de revenu**, puis l'activité continue sans rien ajouter (pastille orange sur l'icône du lieu dès 1 jour de caisse ; message du gérant à 3 jours : « Patron, la caisse est pleine. »).
- **Relever** : E sur la caisse : « +37 500 FCFA », en espèces. À partir du chapitre 4, option par lieu : **versement automatique sur KwabôPay** chaque soir à 19 h (frais de 1 %), dans la limite du plafond du compte ; ou, à partir de l'entrepôt, virement à la banque (sans frais, le lendemain).
- **Patente** : 5 % du revenu, retenus à la source et affichés au relevé (« Recette 40 000 — Patente 2 000 — Pour toi 38 000 »).
- **Ce qui fait varier le revenu** (multiplicateurs appliqués au jour en cours, affichés sur le tableau d'ardoise du lieu) :
  - réputation du quartier (voir « Groupes et réputation ») : de × 0,8 à × 1,2 ;
  - coupure de courant dans le quartier, sans groupe électrogène : × 0,5 pendant la coupure ;
  - grosse pluie : boutique × 0,7 pendant la pluie ; garage × 1,2 le lendemain (pannes) ;
  - rue du lieu inondée : × 0 tant que l'eau dépasse 25 cm devant la porte ;
  - chapitre 3 (ville à l'arrêt) : boutique × 0,5, garage × 0,8 ;
  - **approvisionnement** : la boutique et l'entrepôt ont un stock de 0 à 100 qui baisse de 10 par jour de jeu ; sous 30, revenu × 0,5 ; à 0, revenu nul. Le regarnir : une mission de livraison répétable (tissus de Nan Akouavi pour la boutique, +50 ; marchandises du port pour l'entrepôt, +40), ou payer un livreur (10 % d'une journée de revenu par tranche de 25, sans jouer). C'est ce qui lie les propriétés au métier de Koffi (décision 12) ;
  - événements d'histoire : sabotages de Capitaine au chapitre 5 (entrepôt à l'arrêt jusqu'à la mission qui règle le problème), hausse des prix du transport au chapitre 2.
- **Petits ennuis** (1 chance sur 10 par jour de jeu et par propriété active, jamais deux le même jour) : fuite du toit (réparation 5 000), contrôle de la mairie (en règle : rien ; enseigne non payée : 2 000), vendeuse malade (revenu × 0,5 ce jour-là, ou la remplacer en tenant le comptoir : mini-activité de 2 minutes), client mécontent au garage (dialogue). Chaque ennui arrive par message ; l'ignorer 2 jours de jeu : revenu × 0,8 jusqu'à ce qu'on s'en occupe. Jamais de perte de la propriété.
- **Employés** : payés d'office sur la recette (le revenu affiché est net de leurs salaires) ; ils ont un prénom, 6 répliques chacun, et saluent Koffi ; pas de gestion de personnel au-delà.
- **Tableau de bord** : application « Carnet » du téléphone → « Mes affaires » : par lieu : revenu du jour, caisse, stock, ennui en cours ; total par jour. Avant le chapitre 4 : la même page dans le carnet du menu de pause.
- **Lien avec la flotte** : les motos confiées (décision 68) rapportent selon `economie.md` ; leur recette se relève chez le Doyen, pas dans une propriété ; à partir de l'entrepôt, tout peut être centralisé au bureau de l'entrepôt (une seule caisse, plafond de 3 jours du total).
- **Ordres de grandeur** : au chapitre 5, garage + boutique + entrepôt + 10 motos : environ 245 000 FCFA par jour de jeu bien géré, à comparer aux 9 450 000 de la maison (une quarantaine de jours de jeu sans les missions, une quinzaine avec).
- Test : boutique sans variation, 24 minutes réelles simulées entre 7 h et 19 h : caisse +40 000 ± 50 (une journée d'ouverture) ; même durée la nuit : +0 ; dormir : +0 ; caisse plafonnée à 120 000 ; relevé : patente de 5 % exacte ; coupure de courant sans groupe : moitié pendant la coupure ; stock à 20 : × 0,5 ; stock à 0 : rien ; mission de réapprovisionnement : stock +50 ; ennui ignoré 2 jours : × 0,8 ; versement automatique à 19 h avec 1 % de frais.

## Choix faits par Claude (à confirmer)
- Chez Maman Koffi sert de logement et de point de sauvegarde gratuits dès le début ; six lieux en tout, à des adresses de quartiers réels.
- Frais d'acte de 5 % inclus dans le prix affiché ; aucune revente ni saisie de propriété.
- Dormir sauvegarde, rend la santé, mais ne fait pas courir les revenus ; pas de sommeil moins de 4 heures de jeu après un réveil.
- Garde-robe commune à tous les logements ; 6 tenues enregistrées.
- Stock à regarnir par des livraisons : les propriétés ramènent au métier de transporteur.
