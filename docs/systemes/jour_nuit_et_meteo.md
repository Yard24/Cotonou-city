# Jour, nuit et météo : fonctionnement attendu

Code proposé : `scripts/horloge.gd` (heure, date, saison), `scripts/ciel.gd` (soleil, lune, couleurs), `scripts/meteo.gd` (tirage et transitions), `scripts/inondation.gd`, `scripts/courant.gd` (coupures). Vérifications : `scripts/selftest_meteo.gd`, en forçant l'heure et la météo, tirage fixé.

Cadre : une journée de jeu = 48 minutes réelles (décision 89) : 1 heure de jeu = 2 minutes, 1 minute de jeu = 2 secondes ; météo : soleil, harmattan, grosses pluies avec rues inondées (90) ; embouteillages 7 h-9 h et 17 h-20 h (60) ; pas d'explosion (57). Les lampadaires eux-mêmes (modèles, renversement) sont décrits dans `physique_du_decor.md` ; ce document fixe l'heure, le ciel et la météo.

**Calendrier** : semaine de 7 jours, mois de 30 jours ramenés à **6 jours de jeu** (une année = 72 jours de jeu), pour que les saisons défilent. Saisons, comme sur la côte béninoise : grande saison sèche (décembre à mars, harmattan en décembre-janvier), grande saison des pluies (avril à juillet), petite saison sèche (août-septembre), petite saison des pluies (octobre-novembre). L'histoire peut fixer la date au début d'un chapitre. L'heure et la date s'affichent dans le menu de pause, sur le téléphone et sur la grande carte.

## Soleil et ombres
- **Heures** (constantes toute l'année, on est près de l'équateur) : premières lueurs 6 h 00, lever 6 h 30, zénith 12 h 45, coucher 18 h 45, nuit noire 19 h 15. Le soleil monte presque à la verticale : hauteur maximale 80°, course d'est en ouest légèrement inclinée vers le sud.
- **Lumière** selon l'heure (passages continus) :

| Heure | Couleur du soleil | Intensité | Ciel |
|---|---|---|---|
| 6 h 00-7 h 00 | orangé rosé | 0,3 → 0,8 | bleu pâle, brume légère sur la lagune |
| 7 h 00-10 h 00 | blanc chaud | 0,8 → 1,2 | bleu franc |
| 10 h 00-15 h 30 | blanc | 1,3 | bleu délavé par la chaleur, horizon laiteux |
| 15 h 30-18 h 00 | doré | 1,2 → 0,9 | bleu profond |
| 18 h 00-18 h 45 | orange puis rouge | 0,9 → 0,3 | dégradé orange-violet côté mer |
| 18 h 45-19 h 15 | — | 0,3 → 0 | bleu nuit, premières étoiles |
- **Ombres** : une seule lumière directionnelle avec ombres ; portée des ombres 80 m au niveau « Moyen » (voir « Performance ») ; ombres courtes et dures à midi, longues le matin et le soir (longueur plafonnée à 6 fois la hauteur de l'objet, en dessous de 10° de soleil les ombres s'estompent). Les arbres, parasols et auvents donnent une ombre utile : les passants s'y tiennent de 13 h à 15 h (`pietons.md`).
- Le déplacement du soleil est continu (0,125° par seconde réelle) : jamais de saut visible, sauf quand l'heure saute (sommeil, voyage, garde à vue), toujours derrière un fondu.
- **Chaleur** (effet visuel seulement) : de 12 h à 15 h par temps clair, léger tremblement de l'air au-dessus du goudron au-delà de 60 m.
- **Intérieurs** : lumière du jour par les portes et fenêtres, plus sombre de 60 % ; pas de calcul d'ombres portées du soleil à l'intérieur.
- **Jeu** : phares obligatoires de 18 h 45 à 6 h 30 (contrôle routier, voir `police_et_niveau_de_recherche.md`) ; un soleil bas dans l'axe d'un boulevard (7 h et 18 h) éblouit légèrement (halo) sans gêner la conduite.
- Test : à 12 h 45 la hauteur du soleil vaut 80° ± 1 ; à 6 h 30 et 18 h 45, 0° ± 1 ; l'ombre d'un poteau de 3 m mesure moins de 1 m à 12 h 45 et plus de 6 m à 7 h 15 ; 48 minutes simulées ramènent exactement la même heure ; aucune variation d'intensité de plus de 5 % entre deux images hors fondu.

## Nuit et éclairage public
- **Nuit** : de 19 h 15 à 6 h 00. Lumière ambiante bleutée à 12 % du jour (on voit toujours la silhouette de Koffi et la route : jamais de noir complet) ; lune en 8 phases sur 24 jours de jeu, qui fait varier l'ambiante de 8 à 16 % ; étoiles par temps clair ; lueur orangée de la ville à l'horizon.
- **Éclairage public** : allumage à 18 h 45 et extinction à 6 h 30, par vagues (voir `physique_du_decor.md`). Boulevards et ponts : éclairés en continu ; rues de quartier : un lampadaire tous les 60 m, dont 1 sur 6 en panne ; « vons » : aucun lampadaire, seulement les lumières des maisons.
- **Lumières de la vie** : fenêtres allumées (60 % à 20 h, 20 % à 23 h, 5 % à 2 h) ; enseignes de boutiques jusqu'à la fermeture ; lampes à pétrole puis lampes solaires (à partir du chapitre 4) sur les étals du soir ; braises des vendeurs de brochettes ; guirlandes des maquis ; phares de la circulation ; lampes torches des gardiens.
- **Phares du joueur** : touche L (déjà en place en voiture) ; portée utile 40 m, 60 m en pleins phares ; moto : un phare, 35 m. Sans phares la nuit hors boulevard, on ne voit les obstacles qu'à 15 m.
- **Ce que la nuit change** : circulation divisée par 4 après 22 h, par 10 après minuit ; passants : voir `pietons.md` ; police : 4 voitures au lieu de 2, vue des agents réduite à 30 m hors éclairage ; zémidjans et taxis plus rares et +20 à +50 % ; boutiques fermées, maquis ouverts jusqu'à 1 h ; discrétion deux fois meilleure hors éclairage (`combat.md`).
- **Sons** : grillons et crapauds près de la lagune, chiens au loin, musique des maquis qui porte à 80 m, muezzin et cloches à leurs heures comme simple ambiance lointaine (décision 18).
- **Dormir** : voir `proprietes.md` ; **attendre** : sur un banc, E maintenu : l'heure avance de 1 heure de jeu par 2 s, tant qu'on tient (12 h au plus).
- Chapitre 3 : couvre-feu de 21 h à 5 h, rues vides, patrouilles.
- Test : à 0 h, lumière ambiante entre 8 et 16 % de celle de midi ; lampadaires allumés à 18 h 50, éteints à 6 h 35 ; aucun lampadaire dans un « von » ; à 23 h, nombre de véhicules de la circulation inférieur à 30 % de celui de 18 h ; phares éteints à 0 h dans une rue sans lampadaire : un obstacle n'est éclairé qu'à moins de 15 m ; attendre 2 s sur un banc : +1 h.

## Saison des pluies
- **États de la météo** : `clair`, `voilé`, `nuageux`, `averse`, `grosse pluie`, `orage`, `harmattan`. Un tirage toutes les 2 heures de jeu, selon la saison ; passage d'un état à l'autre en 1 à 3 minutes réelles (jamais instantané), toujours par l'état voisin (`clair` → `nuageux` → `averse`…).

| Saison | Clair ou voilé | Nuageux | Averse | Grosse pluie ou orage |
|---|---|---|---|---|
| Grande saison sèche (hors harmattan) | 85 % | 12 % | 3 % | 0 % |
| Grande saison des pluies | 30 % | 25 % | 20 % | 25 % |
| Petite saison sèche | 65 % | 25 % | 8 % | 2 % |
| Petite saison des pluies | 45 % | 25 % | 18 % | 12 % |
- **Durées** : averse 10 à 20 minutes de jeu (20 à 40 s réelles) ; grosse pluie 1 à 3 heures de jeu (2 à 6 minutes réelles) ; orage : grosse pluie avec vent, éclairs toutes les 8 à 20 s et tonnerre 1 à 4 s après. Pas plus de 2 grosses pluies par jour de jeu ; jamais de grosse pluie pendant les 2 premières heures réelles d'une nouvelle partie.
- **Avant la pluie** (2 minutes réelles) : le ciel noircit par le sud-ouest, le vent se lève, les vendeuses bâchent, les passants pressent le pas, Koffi commente.
- **Ce qu'on voit** : rideau de pluie (particules dans un volume de 30 m autour de la caméra), visibilité 250 m en averse, 100 m en grosse pluie ; chaussée luisante et reflets des phares ; éclaboussures ; gouttes sur l'écran en vue intérieure et essuie-glaces automatiques ; ruissellement le long des trottoirs ; flaques qui grandissent.
- **Ce que la pluie change** :
  - adhérence : freinage × 1,3 en distance sous averse, × 1,6 sous grosse pluie ; la moto dérape plus tôt (voir les documents de conduite) ; pistes en terre (« vons ») : boue, vitesse plafonnée à 30 km/h en moto ;
  - passants : densité × 0,2, abrités sous les auvents ; parapluies ;
  - circulation : vitesse −25 %, zémidjans rares (certains s'abritent sous les stations-service, moteur arrêté) ; clients de zémidjan et de taxi × 1,5, prix +20 % ;
  - marchandise non bâchée qui s'abîme (`moteur_de_missions.md`) ; police : vue à 20 m ;
  - Koffi : trempé (tenue assombrie 10 minutes de jeu après la pluie), pas de perte de santé.
- **Après la pluie** : chaussée mouillée 1 heure de jeu, flaques 3 heures, air lavé (visibilité maximale, couleurs plus vives), odeur de terre évoquée par une réplique.
- **Missions** : une fiche peut imposer ou interdire un état ; sinon le tirage vaut aussi en mission.
- Option des menus : « éclairs atténués » (pas de flash plein écran).
- Test : sur 720 tirages simulés par saison, les parts sont celles du tableau à ± 5 points ; aucune transition directe de `clair` à `grosse pluie` ; durée d'une grosse pluie entre 1 et 3 heures de jeu ; distance de freinage d'une voiture depuis 100 km/h : 13 m au sec, environ 21 m sous grosse pluie ; densité des passants à 20 % ± 5 ; au plus 2 grosses pluies par jour sur 100 jours simulés.

## Harmattan
- **Quand** : décembre et janvier du calendrier du jeu (12 jours de jeu par an). Chaque matin de la période : 60 % `harmattan léger`, 25 % `harmattan épais`, 15 % clair. Il se lève vers 5 h, culmine de 7 h à 11 h, s'éclaircit l'après-midi et revient à la nuit.
- **Ce qu'on voit** : voile de poussière beige ; visibilité de 600 m (léger) ou 200 m (épais) au lieu de 2 000 m ; soleil réduit à un disque blanc pâle qu'on peut regarder, sans ombres nettes (ombres à 30 % d'opacité en léger, absentes en épais) ; couleurs désaturées de 25 % ; poussière fine sur les voitures garées (elles se salissent 3 fois plus vite, voir `garage.md`) ; feuilles sèches et sachets qui volent ; lagune brumeuse le matin.
- **Ce qu'on entend** : vent sec par rafales, ville assourdie.
- **Fraîcheur** : le matin, les passants portent pulls, bonnets, cache-nez ; les zémidjans roulent en blouson ; vendeuses de bouillie très entourées (Maman Koffi vend plus : réplique). Lèvres et peau sèches : sujet de répliques, sans effet de jeu sur la santé.
- **Ce que l'harmattan change** : vue des agents de police 20 m en épais ; discrétion deux fois meilleure en épais ; circulation −15 % de vitesse en épais, phares allumés en plein jour ; avion pour Parakou : vols retardés de 1 à 3 heures de jeu en épais (voir « Avion et voyages ») ; pirogue : rives invisibles au-delà de 200 m, navigation aux bouées ; photos de défi « pont sous l'harmattan » possibles seulement alors ; pas de pluie pendant la période.
- **Chapitres** : l'ouverture du chapitre 1 se passe sous un harmattan léger (retour de Koffi en décembre 2017), à confirmer par l'agent chargé de l'histoire.
- Test : en forçant le 10 janvier à 8 h en `harmattan épais` : visibilité 200 m ± 20, ombres absentes, saturation −25 % ; aucun tirage d'harmattan en juin sur 100 jours simulés ; aucun tirage de pluie en janvier ; vue d'un agent : 20 m ; la salissure d'une voiture garée progresse 3 fois plus vite.

## Rues inondées
- **Où** : seulement dans des **zones inondables** tracées à la main sur la carte (creux réels de la ville condensée) : environ 25 tronçons, surtout près de la lagune, autour de Dantokpa, dans les quartiers bas et les « vons ». Les boulevards principaux et les ponts ne s'inondent jamais : la ville reste toujours traversable.
- **Montée de l'eau** : chaque zone a un niveau de 0 à sa profondeur maximale (de 20 à 70 cm selon la zone). Sous grosse pluie : +1 cm par 4 s réelles ; sous averse : +1 cm par 20 s jusqu'à 15 cm au plus ; après la pluie : −1 cm par 10 s (une zone de 60 cm se vide en 10 minutes réelles, 5 heures de jeu). En grande saison des pluies, les 5 zones les plus basses gardent 10 cm en permanence.
- **Aspect** : nappe d'eau brune, plane, qui épouse le creux ; rides sous la pluie ; sillage derrière les véhicules ; objets flottants (sachets, sandale, bidon). Les riverains posent des parpaings et des planches pour passer à pied (à partir de 20 cm) ; des jeunes proposent de pousser les véhicules calés : 200 FCFA.
- **Effets selon la profondeur** :

| Profondeur | À pied | Moto | Voiture, taxi | Camionnette, minibus, camion |
|---|---|---|---|---|
| moins de 10 cm | normal, éclaboussures | normal | normal | normal |
| 10-25 cm | marche à 80 %, course à 70 % | 40 km/h au plus | 50 km/h au plus | normal |
| 25-40 cm | marche à 60 %, pas de course | 15 km/h au plus ; **cale** après 5 s (redémarre hors de l'eau après 4 s, ou en poussant) | 25 km/h au plus | 40 km/h au plus |
| 40-60 cm | marche à 50 % | impraticable : cale tout de suite | **cale** après 6 s ; +10 points de dégâts au moteur | 20 km/h au plus |
| plus de 60 cm | marche à 40 % (jamais de nage en ville) | impraticable | impraticable | camion seulement, 10 km/h |
- **Pousser** : à pied, E maintenu derrière son véhicule calé : il avance à 1 m/s ; hors de l'eau il redémarre.
- **Éclabousser** : passer à plus de 30 km/h dans plus de 10 cm d'eau à moins de 3 m d'un passant l'arrose : il proteste ; devant un agent, simple remarque.
- **Circulation et piétons** : les véhicules de la circulation évitent les zones au-delà de leur seuil (demi-tour ou file d'attente au bord) ; les motos font le détour ; les piétons passent par les planches ou attendent.
- **GPS** : voir `carte_et_gps.md` (tronçons interdits ou pénalisés) ; les zones vues sont hachurées sur la carte.
- **Missions** : marqueurs déplacés hors de l'eau ; livraisons : colis posés dans l'eau = −20 d'état.
- **Chapitres** (décision 91) : au chapitre 6, les rues refaites (caniveaux neufs) perdent 8 de leurs zones inondables : on voit la ville s'améliorer.
- Santé : l'eau des rues ne rend pas malade (pas de punition cachée).
- Test : zone d'essai de 50 cm sous grosse pluie forcée : niveau à 50 cm après 200 s ± 10, puis vide 500 s après la pluie ; moto à 30 cm : calée après 5 s, redémarre 4 s après la sortie ; voiture à 45 cm : calée après 6 s et +10 dégâts ; camion à 55 cm : passe à 20 km/h au plus ; aucun boulevard ni pont dans la liste des zones ; toujours un itinéraire entre deux quartiers quelconques avec toutes les zones pleines.

## Coupures de courant
- **Fréquence** (accordée à `physique_du_decor.md`) : chapitres 1 à 3 : chaque quartier a 1 chance sur 5 par nuit de perdre le courant, pendant 1 à 3 heures de jeu, entre 19 h et 23 h de préférence ; plus une coupure de jour sur 10 jours (sans effet sur l'éclairage, mais sur les boutiques). Chapitre 4 : 1 sur 8. Chapitres 5 et 6 : 1 sur 20. Sous orage : chance doublée. Jamais deux quartiers voisins en même temps ; 2 quartiers au plus à la fois sur 10.
- **Ce qui s'éteint** : lampadaires du quartier (sauf les solaires), fenêtres, enseignes, feux de circulation quand il y en aura (un agent vient régler le carrefour), frigos des boutiques (boissons « pas fraîches » : +10 santé au lieu de +15), pompes des stations officielles (pas d'essence : il reste le kpayo), guichet de banque, kiosques Zékôm (recharge et retrait impossibles ; les paiements KwabôPay déjà possibles le restent).
- **Ce qui reste ou s'allume** : lampes à pétrole, bougies, lampes torches et lampes solaires sur les étals et aux fenêtres (10 % des fenêtres) ; groupes électrogènes bruyants devant 1 boutique sur 6, les maquis et la banque (bruit porté à 40 m) ; phares des véhicules ; le centre de santé et le commissariat ont toujours du courant.
- **Extinction et retour** : le quartier s'éteint d'un coup avec un « clac » et une exclamation collective lointaine (« Éééé ! ») ; au retour, tout se rallume en 2 s et on entend des cris de joie (« Ils ont remis ! »). Une réplique de Koffi une fois sur deux.
- **Effets de jeu** : dans le quartier coupé : nuit vraiment sombre (ambiante seule), vue des agents 30 m, discrétion doublée ; passants −30 %, assis devant les maisons ; maquis avec groupe électrogène plus fréquentés (+30 %) ; garage personnel : pas d'amélioration ni de peinture possibles pendant la coupure (réparation simple permise) ; radio de la voiture : marche (batterie) ; téléphone : marche.
- **Information** : le quartier coupé est assombri sur la grande carte ; à partir du chapitre 4, publication sur Kpôlè ; la radio parlée l'annonce avec retard (ressort comique).
- **Histoire** : une fiche de mission peut déclencher ou interdire une coupure (une mission d'infiltration au port en profite au chapitre 4, à confirmer par l'agent chargé de l'histoire).
- **Achat utile** : groupe électrogène pour la boutique ou le garage de Koffi (150 000 FCFA, `proprietes.md`) : plus d'interruption d'activité ni de revenu réduit pendant les coupures.
- Test : sur 500 nuits simulées au chapitre 1 : entre 17 et 23 % de nuits coupées par quartier, durée de 1 à 3 heures de jeu, jamais 2 voisins ensemble, jamais plus de 2 quartiers ; pendant la coupure : 0 lampadaire non solaire allumé dans le quartier, lampadaires allumés dans le quartier voisin, centre de santé éclairé ; station officielle refusant de servir ; au chapitre 6 : entre 3 et 7 %.

## Choix faits par Claude (à confirmer)
- Année de jeu de 72 jours (mois de 6 jours) pour voir passer les saisons ; lever 6 h 30, coucher 18 h 45 toute l'année.
- Zones inondables tracées à la main ; boulevards et ponts toujours secs ; pas de nage ni de maladie en ville.
- Fréquences des coupures alignées sur `physique_du_decor.md` ; elles se raréfient avec les chapitres.
