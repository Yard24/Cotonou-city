# Circulation : fonctionnement attendu

Code : `scripts/trafic.gd` (création des véhicules, avance le long des trajets, distance de sécurité, motos qui remontent les files) et `scripts/circulation.gd` (toutes les règles ci-dessous). Vérifications : `scripts/selftest_circulation.gd`, lancé par le test automatique ; il fait rouler la circulation lui-même puis remet tout comme au lancement.

On roule à droite. Les chiffres sont des réglages de départ, à ajuster après essai. Les validations de Bravo sont considérées comme acquises ; tout reste modifiable sur simple demande.

## Réseau de voies
- Les véhicules suivent des trajets fermés, tracés sur la voie de droite de chaque route (à 3,5 m de l'axe). Il y en a 9 : quatre tours de quartier qui passent par la place de l'Amazone, le grand tour, le boulevard de la Marina (demi-tour aux deux bouts), et trois trajets ajoutés pour que les véhicules se croisent : une grande boucle de la Marina au nord de la ville, et deux traversées de la place.
- 12 carrefours : la place de l'Amazone (rond-point), 4 carrefours à feux (les « grands carrefours », sur les routes x = ±120 aux croisements z = -120 et z = 0), 7 carrefours à priorité à droite.
- Chaque véhicule garde ses distances : il s'arrête derrière ce qui se trouve droit devant lui à moins de 8,5 m.
- Plus tard : trajets propres à chaque quartier de la vraie carte, plusieurs voies par sens, ponts.
- Test : 9 trajets, 6 km de voies, tous sur la chaussée et à droite de l'axe ; les 12 carrefours sont traversés ; un véhicule seul fait plus de 100 m en 10 s sans quitter la route.

## Feux tricolores
- Un poteau à trois lampes sur le trottoir de droite de chaque entrée des 4 grands carrefours (16 poteaux).
- Cycle de 38 s : vert 14 s pour un axe, orange 3 s, tout le monde au rouge 2 s, puis l'autre axe. Les carrefours sont décalés entre eux.
- Au rouge, le véhicule freine tranquillement (4 m/s²) et s'arrête 2,5 m avant le carrefour ; les suivants font la queue derrière lui, sans doubler. Les motos remontent la file jusqu'à la ligne.
- À l'orange, il s'arrête s'il en a la place, sinon il passe.
- Au vert, il vérifie quand même que le carrefour est dégagé (voir priorités).
- Le joueur n'est pas encore tenu de respecter les feux (pas de police pour l'instant).
- Plus tard : amende si le joueur grille un feu devant un policier, feux en panne ou clignotants la nuit, agent qui fait la circulation.
- Test : jamais deux axes ouverts ensemble, durées et ordre des couleurs, lampes allumées ; arrêt au rouge avant la ligne, file derrière, redémarrage au vert ; à l'orange, passage à 2 m de la ligne et arrêt à 30 m.

## Priorités aux carrefours
- Sans feu ni rond-point : priorité à droite, partout, y compris au bout du boulevard de la Marina.
- Face à face (aussi au feu vert) : celui qui tourne à gauche laisse passer celui qui va tout droit.
- On n'entre jamais dans un carrefour tant qu'un véhicule dont la route coupe la nôtre s'y trouve, ni si la sortie est occupée.
- Deux trajets qui ne se coupent pas ne se gênent pas : personne ne ralentit.
- Carrefour bloqué (chacun attend l'autre) : après 5 secondes d'attente environ, l'un des conducteurs s'avance.
- Plus tard : panneaux stop et cédez-le-passage, conducteurs plus ou moins pressés.
- Test : le prioritaire passe sans ralentir, l'autre s'arrête, jamais moins de 3,5 m entre eux, dans les deux sens de la règle ; tourne-à-gauche ; pas de ralentissement sans croisement ; deux voitures arrêtées face au carrefour finissent par repartir.

## Ronds-points
- Place de l'Amazone : anneau de 21 m de rayon, tout le monde tourne dans le même sens, terre-plein à gauche.
- Priorité à l'anneau : celui qui arrive freine et s'arrête au besoin à 4,5 m de l'anneau ; il entre quand aucun véhicule de l'anneau ne va passer devant lui dans les 22 m.
- Plus tard : d'autres ronds-points (Étoile Rouge), clignotant à la sortie.
- Test : 6 trajets dans le bon sens ; la voiture qui entre laisse passer celle de l'anneau, qui ne ralentit pas ; anneau vide, on entre sans s'arrêter.

## Dépassements
- Une voiture ne double que ce qui ne repartira pas : véhicule accidenté ou en panne, voiture garée ou laissée sur la voie, véhicule du joueur à l'arrêt.
- Elle s'arrête derrière, attend 2,5 s, vérifie que le couloir est libre et que personne n'arrive en face à moins de 30 m après l'obstacle, puis se déporte de 2,8 m à gauche, passe à 22 km/h au plus et se rabat 6 m plus loin.
- Jamais de dépassement dans un carrefour ni juste avant, ni d'une file qui attend à un feu.
- Les motos, elles, remontent toutes les files par le couloir (décision 61).
- Plus tard : dépassement d'un véhicule lent qui roule, camions qui ne doublent pas.
- Test : attente, écart de 2,8 m, vitesse, rabattement ; avec une voiture en face, elle attend qu'elle soit passée.

## Embouteillages aux heures de pointe
- De 7 h à 9 h et de 17 h à 20 h (décision 60), avec un quart d'heure pour s'installer et se résorber.
- Il y a alors moitié plus de véhicules, et sur les 70 m qui précèdent les grands carrefours et la place les voitures avancent au pas (9 km/h) ; avec les feux, de vraies files se forment.
- Les motos avancent quand même, à 18 km/h, en remontant les files (décision 61). Une fois le carrefour passé, on roule normalement.
- Plus tard : ponts, bouchons qui débordent d'un carrefour sur l'autre, klaxons rares dans la file (décision 59).
- Test : à 8 h les voitures roulent à 8 km/h avant les grands carrefours contre 22 à 11 h, et y sont 26 contre 10 ; les motos vont presque deux fois plus vite ; ailleurs on roule à 50 km/h ; aucun accident ; pas de bouchon à un petit carrefour.

## Réactions au klaxon
- Le joueur klaxonne (touche H) : les véhicules qui roulent devant lui dans sa file, à moins de 25 m, se serrent à droite (voiture 1,5 m, moto 1 m) et ralentissent à 60 % de leur vitesse pendant 5 s, puis reprennent leur place.
- Ne réagissent pas : ceux de derrière, ceux d'en face, ceux qui sont arrêtés à un feu, à une priorité ou derrière un autre véhicule, et les accidentés.
- Les passants proches sursautent (déjà fait). La circulation, elle, klaxonne rarement (décision 59, déjà fait).
- Plus tard : conducteur qui répond d'un geste ou d'un mot, taxi qui ne se pousse pas.
- Test : écart et vitesse de la voiture et de la moto, retour en place, aucune réaction des autres ni de la voiture au feu rouge.

## Accidents entre véhicules
- Un véhicule de la circulation percuté (par le joueur, ou par un autre) à plus de 18 km/h d'écart s'arrête, feux de détresse allumés : 8 s pour un petit choc, 20 s à partir de 50 de dégâts. Ensuite il repart.
- À 80 de dégâts ou plus, il ne repart pas : il reste en panne sur la voie jusqu'à ce que le joueur ne le voie plus.
- Les voitures qui suivent attendent puis le dépassent ; les motos passent à côté.
- Les conducteurs de la circulation sont prudents : livrés à eux-mêmes ils ne se rentrent pas dedans (vérifié sur plusieurs minutes). Un frottement lent n'a pas de suite. Pas d'explosion, personne n'est blessé (décisions 4 et 57).
- Plus tard : conducteurs qui sortent discuter, arrivée de la police, dépanneuse.
- Test : arrêt de 8 s avec feux de détresse puis redémarrage ; gros choc et dépassement par la voiture suivante ; épave qui ne repart pas ; deux véhicules de la circulation qui se percutent ; frottement sans suite.

## Densité selon l'heure
- Horloge : une journée de jeu = 48 minutes réelles (décision 89), soit 2 minutes par heure ; le jeu commence à 10 h. Quand le cycle jour-nuit existera, c'est lui qui donnera l'heure.
- Journée normale : 38 véhicules. Heures de pointe : 61. Nuit (22 h à 5 h) : 12, au moins un par trajet. Le passage de l'un à l'autre est progressif.
- Plus tard : plus de taxis le soir, camions la nuit, réglage selon le niveau graphique.
- Test : valeurs aux heures clés, horloge, nombre de véhicules à 3 h, midi et 8 h.

## Apparition et disparition hors champ
- Un véhicule n'apparaît ou ne disparaît jamais sous les yeux du joueur : seulement à plus de 40 m de lui et hors de l'image (ou au-delà de la brume).
- Il apparaît sur sa voie, hors des carrefours, à 14 m au moins de tout autre véhicule, déjà lancé. Deux fois par seconde, un véhicule de plus ou de moins par trajet au maximum.
- Une épave est enlevée dès que le joueur ne la voit plus ; le véhicule revient réparé.
- Une voiture empruntée par le joueur sort de la circulation pour de bon.
- Plus tard : véhicules cachés par les immeubles, apparition aux entrées de la ville.
- Test : les véhicules en vue restent en place quand la nuit tombe ; ceux qui apparaissent sont hors de la vue, sur leur voie, espacés ; épave ; voiture empruntée.

## Limites connues
- Deux carrefours à moins de 20 m l'un de l'autre : le conducteur ne regarde le second qu'une fois sorti du premier.
- Le joueur n'est soumis à aucune règle ; les véhicules s'arrêtent pour lui mais ne l'évitent pas.
- Rien n'a été regardé à l'écran : tout est vérifié par le calcul.
