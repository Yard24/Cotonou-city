# Mission 2.5 — Par la lagune

Tâches couvertes : T3675 (synopsis), T3676 (objectifs et échecs), T3677 (dialogues), T3678 (expressions fon). Fiche rédigée le 16 novembre 2026.

## Fiche

| | |
|---|---|
| Date dans l'histoire | Lundi de novembre 2018, départ figé à 7 h 00, ciel clair ; averse écrite au retour (8 h 30) |
| Type | Pirogue à moteur : apprentissage, navigation entre les enclos de pêche, marchandage, livraison |
| Durée visée | 10 à 12 minutes |
| Donneuse | Nan Akouavi (marqueur à l'embarcadère de Dantokpa, de 6 h à 9 h) |
| Condition d'ouverture | Mission 2.4 réussie |
| Véhicules | Pirogue à moteur des piroguiers du village (`docs/vehicules/barque_a_moteur.md`, règles de `docs/systemes/navigation_sur_l_eau.md`), fournie avec le plein |
| Récompense | 18 000 FCFA sur KwabôPay ; déblocage du village lacustre (décision 86), de la location de pirogue à l'embarcadère et du contact « Sèna » |

## Lieux
- **Embarcadère de Dantokpa** : ponton de bois de 25 m sur la rive ouest de la lagune, au pied du marché (`docs/lieux/berge_de_la_lagune.md`).
- **Lagune et lac** : chenal balisé de piquets, puis nappe ouverte semée d'enclos de pêche en branchages (cercles de 12 à 30 m). Dans la carte condensée, 1,8 km d'eau séparent l'embarcadère du village.
- **Village lacustre** (`docs/lieux/village_lacustre_de_ganvie.md`) : maisons sur pilotis ; ponton de Sèna (plate-forme de 8 × 6 m, toit de tôle) à l'entrée sud. Zone lente : 5 m/s au plus à moins de 30 m des maisons.

## Personnages présents
Koffi, Nan Akouavi (à l'embarcadère), Sèna. Figurants : Brice (au ponton, une réplique), pêcheurs dans leurs pirogues, deux piroguiers de Sèna qui chargent.

## Synopsis
Novembre 2018. La route du port coûte le double et le Brigadier Parfait retenait les tricycles : Nan Akouavi regarde l'eau.
Sa grand-mère faisait venir ses pagnes par la lagune ; Monsieur Fortuné, lui, n'a pas un seul bateau.
Une partie des tissus sera déposée de l'autre côté du lac et traversera en pirogue jusqu'au ponton de Dantokpa.
Il faut quelqu'un pour négocier avec Sèna, la cheffe des piroguiers du village lacustre, et pour faire le premier voyage.
Koffi sait nager. C'est à peu près tout ce qu'il sait de l'eau.
Il apprend la pirogue à moteur entre six bidons, puis traverse sans accrocher les enclos des pêcheurs.
Sèna l'a regardé arriver depuis son ponton : chaque enclos touché, chaque vague sur un pêcheur augmente son prix.
Elle parle peu. Elle veut 40 000 FCFA par mois pour dix voyages ; Nan Akouavi a dit : pas plus de 30 000.
L'accord trouvé, dix balles sont chargées sous une bâche et la pirogue s'enfonce de vingt centimètres.
Au retour, une averse se lève : le rideau de pluie cache les piquets, l'eau entre, il faut ralentir et écoper.
Koffi accoste trempé, les balles sèches. Nan Akouavi vérifie la bâche avant de le regarder, lui.
La ville a désormais une route que Fortuné ne contrôle pas.

## Déroulement

### Étape 1 — L'idée de Nan Akouavi
- **Objectif affiché :** « Rejoins Nan Akouavi sur le ponton de Dantokpa. »
- **Réussite :** dialogue A.
- **Échec :** aucun.

### Étape 2 — Apprendre la pirogue
- **Objectif affiché :** « Monte dans la pirogue et passe entre les 6 bidons. »
- **Déclencheur :** fin du dialogue A ; pirogue amarrée au bout du ponton.
- **Réussite :** franchir 3 portes de bidons jaunes (largeur 8 m) à l'aller, demi-tour, s'arrêter le long du ponton (vitesse sous 1 m/s, à moins de 3 m).
- **Bulles d'aide :** « La pirogue tourne large : commence ton virage tôt. » ; « Lâche les gaz : elle glisse longtemps avant de s'arrêter. » ; « Eau claire avec des piquets = haut-fond : le moteur se relève et tu avances à 1 m/s. »
- **Échec :** aucun (porte manquée : on la repasse).
- **Point de contrôle 1 :** fin du tour.

### Étape 3 — La traversée (1,8 km)
- **Objectif affiché :** « Traverse jusqu'au village sans accrocher les enclos. »
- **Déclencheur :** réplique A-11. Pirogue à vide.
- **Compteurs affichés :** « Enclos touchés : 0/3 » et « Pêcheurs dérangés : 0/3 » (passer à plus de 5 m/s à moins de 10 m d'une pirogue de pêcheur).
- **Réussite :** accoster au ponton de Sèna (vitesse sous 1 m/s, à moins de 3 m).
- **Échec :**
  | Condition | Seuil |
  |---|---|
  | Enclos | 3 enclos touchés : « Trois enclos abîmés : Sèna ne te parlera pas. » |
  | Pêcheurs | 3 pêcheurs dérangés : « On ne fait pas de vagues chez les gens. » |
  | Temps | **5 min 00** (Sèna part relever ses nasses) |
  | Vitesse au village | plus de 5 m/s à moins de 30 m des maisons pendant 5 s : même échec que « Pêcheurs » |
  | Abandon | Koffi à la nage à plus de 60 m de la pirogue pendant 30 s |
  | Koffi | évanoui |
- La pirogue ne coule pas et ne se casse pas : un enclos touché l'arrête net (collision molle) et coûte 6 à 8 s.
- **Point de contrôle 2 :** accostage ; les deux compteurs sont enregistrés.

### Étape 4 — Le prix de Sèna (marchandage, 3 échanges au plus)
- **Objectif affiché :** « Négocie dix voyages par mois : 30 000 FCFA au plus. »
- **Prix de départ de Sèna :** 40 000 FCFA, +1 000 par enclos touché, +1 000 par pêcheur dérangé (au plus 44 000).
- **À chaque échange, trois réponses :**
  | Réponse | Effet |
  |---|---|
  | « Proposer un prix juste » (Koffi annonce un chiffre : 26 000, puis 28 000, puis 30 000) | Sèna descend de 5 000 |
  | « Parler de Fortuné » (bonne une seule fois : la lagune doit rester sans péage) | Sèna descend de 6 000 ; répétée : aucun effet |
  | « Vanter Nan Akouavi » (paie le 1er du mois, à l'heure) | Sèna descend de 4 000 |
  | « Faire une blague » | échange perdu, Sèna ne descend pas |
- **Réussite :** prix final de 30 000 FCFA ou moins à la fin des 3 échanges (exemple : 40 000 − 6 000 − 5 000 − 4 000 = 25 000). Sèna ne descend jamais sous 25 000.
- **Échec :** prix final au-dessus de 30 000 : « Nan Akouavi avait dit trente mille. » Reprise au point de contrôle 2.
- **Point de contrôle 3 :** accord ; chargement de 10 balles sous bâche (fondu de 3 s).

### Étape 5 — Le retour sous l'averse (1,8 km)
- **Objectif affiché :** « Ramène les 10 balles au ponton de Dantokpa, au sec. »
- **Pirogue chargée :** vitesse maximale réduite de 40 %, virage 30 % plus large.
- **Averse (écrite, 40 s après le départ) :** visibilité 60 m, vent d'est qui pousse de 0,5 m/s ; les piquets du chenal portent un chiffon rouge.
- **Jauge « Eau dans la pirogue » (0 à 100) :** +2 par seconde au-dessus de la moitié de la vitesse maximale ; +1 par seconde en dessous ; +15 par enclos touché. **Écoper :** pirogue presque arrêtée (moins de 1 m/s), E maintenu : −20 toutes les 3 s.
- **Réussite :** accoster à Dantokpa (vitesse sous 1 m/s) avec la jauge sous 100 ; dialogue D ; écran de réussite.
- **Échec :** jauge à 100 (« Les balles ont pris l'eau. ») ; **6 min 00** écoulées (« Le marché a ouvert sans les tissus. ») ; Koffi à la nage à plus de 60 m de la pirogue pendant 30 s ; Koffi évanoui.

### Objectifs facultatifs (+1 800 FCFA chacun)
- *Aucun enclos touché de toute la mission.*
- *Accord à 27 000 FCFA ou moins.*

## Dialogues

### A — Ponton de Dantokpa
- 2.5-A-01 — Koffi : A fon ganji a, Nan ? [Bien réveillée ?] Vous m'avez donné rendez-vous au bord de l'eau. Je dois m'inquiéter ?
- 2.5-A-02 — Nan Akouavi : Regarde la lagune. Tu vois une guérite ? Un maillot de foot ?
- 2.5-A-03 — Koffi : Je vois des pirogues et un monsieur qui dort dans la sienne.
- 2.5-A-04 — Nan Akouavi : Ma grand-mère recevait ses pagnes par ici. La route coûte le double, alors je reprends le chemin de ma grand-mère.
- 2.5-A-05 — Nan Akouavi : Au village sur l'eau, il y a Sèna. Elle commande les piroguiers. Dix voyages par mois, trente mille, pas un franc de plus.
- 2.5-A-06 — Koffi : Et c'est moi qui négocie ? Avec une dame que je ne connais pas, au milieu d'un lac ?
- 2.5-A-07 — Nan Akouavi : Elle n'aime pas les bavards. Ça te fera un exercice.
- 2.5-A-08 — Brice : La pirogue est là. Le moteur est derrière. Je préfère le dire.
- 2.5-A-09 — Koffi : Merci, Brice. Sans toi, je l'aurais cherché devant.
- 2.5-A-10 — Nan Akouavi : Tu sais nager ?
- 2.5-A-11 — Koffi : Oui. Je préférerais ne pas avoir à le prouver ce matin.

### B — Apprentissage et traversée
- 2.5-B-01 — Koffi : (départ) Pas de frein, pas de guidon, pas de route. Tout va bien.
- 2.5-B-02 — Koffi : (premier virage) Elle tourne quand elle veut, cette dame. Il faut la prévenir à l'avance.
- 2.5-B-03 — Koffi : (fin du tour) Six bidons, zéro noyé. Capitaine Koffi. Non, pas « Capitaine ». Pilote Koffi.
- 2.5-B-04 — Koffi : (large) Pas un embouteillage. Si les zéms savaient flotter, je serais riche.
- 2.5-B-05 — Koffi : (premier enclos proche) Des branches plantées dans l'eau. C'est le champ de quelqu'un, ça. On contourne.
- 2.5-B-06 — Koffi : (enclos touché) Pardon ! Pardon ! Je n'ai rien cassé ! Presque rien !
- 2.5-B-07 — Un pêcheur : (dérangé) Hé ! Dèdè ! [Doucement !] Tu secoues mes poissons !
- 2.5-B-08 — Koffi : (haut-fond) Ça racle. L'eau est plus claire ici… Je note : clair, c'est mauvais.
- 2.5-B-09 — Koffi : (village en vue) Des maisons debout dans l'eau. Et des enfants qui rament mieux que moi.
- 2.5-B-10 — Koffi : (45 s sans progrès) Le village est au nord. Le nord, c'est… par là où il y a les maisons.

### C — Ponton de Sèna
- 2.5-C-01 — Sèna : Kwabo. [Bienvenue.] Tu as mis du temps.
- 2.5-C-02 — Koffi : Bonjour, madame Sèna. Je viens de la part de Nan Akouavi. C'était ma première traversée.
- 2.5-C-03 — Sèna : (aucun enclos, aucun pêcheur) J'ai vu. Tu as fait le tour des enclos. C'est bien.
- 2.5-C-04 — Sèna : (enclos ou pêcheurs) J'ai vu. Tu as touché les enclos. Ça se paie.
- 2.5-C-05 — Koffi : Nan Akouavi voudrait dix voyages par mois, de l'autre rive jusqu'à Dantokpa.
- 2.5-C-06 — Sèna : Quarante mille.
- 2.5-C-07 — Koffi : (prix juste) Je vous propose vingt-six mille. C'est régulier, dix voyages, toute l'année.
- 2.5-C-08 — Sèna : (elle descend) Régulier, c'est vrai. Je baisse.
- 2.5-C-09 — Koffi : (Fortuné) Sur la route, un monsieur fait payer chaque porte. S'il n'y a plus que sa route, un jour il regardera l'eau.
- 2.5-C-10 — Sèna : (elle descend) Ici il n'y a pas de péage. Il n'y en aura pas. Je baisse.
- 2.5-C-11 — Sèna : (Fortuné répété) Tu l'as déjà dit.
- 2.5-C-12 — Koffi : (Nan Akouavi) Nan Akouavi paie le premier du mois, à l'heure. Demandez au marché.
- 2.5-C-13 — Sèna : (elle descend) J'ai demandé. C'est vrai. Je baisse.
- 2.5-C-14 — Koffi : (blague) À ce prix-là, je traverse à la nage avec les balles sur la tête !
- 2.5-C-15 — Sèna : (blague) …
- 2.5-C-16 — Koffi : (après le silence) D'accord. Ce n'était pas le moment.
- 2.5-C-17 — Sèna : (accord) C'est dit. Le premier du mois. Mes piroguiers chargent. Toi, tu ramènes celle-là.
- 2.5-C-18 — Koffi : Awanou, madame Sèna. [Merci.] Vous ne serrez pas la main ?
- 2.5-C-19 — Sèna : La pluie vient. Suis les chiffons rouges. Va dèdè. [Doucement.]
- 2.5-C-20 — Sèna : (refus, prix trop haut) Trois échanges. C'est fini. Reviens avec quelqu'un qui compte.

### D — Le retour
- 2.5-D-01 — Koffi : (départ chargé) Elle s'est enfoncée d'un coup. Dix balles, c'est dix passagers qui ne paient pas.
- 2.5-D-02 — Koffi : (début de l'averse) Elle avait raison, la pluie vient. Elle ne dit rien, mais quand elle parle, c'est vrai.
- 2.5-D-03 — Koffi : (visibilité réduite) Je ne vois plus la ville. Chiffon rouge… chiffon rouge… là !
- 2.5-D-04 — Koffi : (jauge à 50) J'ai les pieds dans l'eau. Dans une pirogue. Ce n'est pas le principe.
- 2.5-D-05 — Koffi : (en écopant) Et un seau pour le lac, et un seau pour le lac…
- 2.5-D-06 — Koffi : (jauge à 80) Stop, stop ! On écope, sinon Brice va compter dix serpillières !
- 2.5-D-07 — Koffi : (ponton en vue) Dantokpa ! Je n'ai jamais été aussi content de voir un embouteillage.
- 2.5-D-08 — Nan Akouavi : Soulève la bâche. … Sèches. Combien ?
- 2.5-D-09 — Koffi : (prix final, variable) Vingt-sept mille par mois, Nan. Le premier du mois.
- 2.5-D-10 — Nan Akouavi : (27 000 ou moins) Moins que ce que j'avais dit. Tu as donc écouté plus que parlé.
- 2.5-D-11 — Nan Akouavi : (28 000 à 30 000) C'est ce que j'avais dit. Bien.
- 2.5-D-12 — Koffi : Elle ne serre pas la main et elle ne sourit pas. Mais je crois qu'elle m'aime bien.
- 2.5-D-13 — Nan Akouavi : Elle t'a laissé repartir avec sa pirogue. Chez elle, c'est une déclaration. Va te sécher, je t'envoie tes dix-huit mille.

### Répliques d'échec
- 2.5-X-01 — Sèna : (trois enclos) Trois enclos. Tu répareras avant de parler. Rentre.
- 2.5-X-02 — Un pêcheur : (trois pêcheurs dérangés) Ici, celui qui fait des vagues mange seul ! Retourne sur ta route !
- 2.5-X-03 — Nan Akouavi : (balles mouillées) Du wax mouillé au lac, ça ne se vend plus, ça se donne. Recommence.
- 2.5-X-04 — Nan Akouavi : (temps écoulé, au téléphone) Le marché a ouvert. Mes clientes ont acheté ailleurs.
- 2.5-X-05 — Koffi : (chrono de l'aller) Elle est partie relever ses nasses. On ne fait pas attendre les gens qui se lèvent à quatre heures.

## Choix faits par l'agent
- Le village lacustre n'est pas nommé dans les dialogues, comme dans le plan ; sa description renvoie à la fiche de lieu existante. Le trajet est réduit à 1,8 km dans la carte condensée (décision 83).
- La pirogue ne peut ni couler ni se briser (règle du système de navigation) : l'échec passe par les enclos, les vagues et l'eau embarquée.
- Les maisons et les habitants sont montrés avec respect ; aucun pêcheur n'est blessé, ils protestent seulement.
