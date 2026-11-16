# Agent de sécurité du port

Tâche T2626 · entrée du plan : « Militaire » · personnage inventé, toute ressemblance avec une personne réelle serait fortuite.

> **Substitution : l'entrée « Militaire » du plan est remplacée par un agent de sécurité de l'administration du port, non armé. Raisons : le pouvoir dans le jeu est l'administration (décision 17), seule la police porte une arme (décision 3), et l'histoire ne contient aucun soldat.**

## Rôle dans le jeu
- **Rôle :** Agent non armé de l'administration du port : garde les barrières, vérifie les badges, donne l'alerte par radio (c'est la police qui intervient). Sert d'obstacle dans les infiltrations.
- **Où on le croise :** Barrières d'entrée et de sortie du port, rondes entre les conteneurs, guérite de l'immeuble des transitaires.
- **Chapitres :** 2 à 6 (port : 2.3, 4.6, 5.8, 6.8 et monde ouvert)

## Physique
- **Âge :** 28 à 45 ans (3 visages).
- **Taille :** 1,80 à 1,88 m.
- **Corpulence :** Carré, sportif.
- **Visage :** Peau brun foncé, visage fermé, mâchoire carrée ; variantes : moustache, barbe courte, glabre.
- **Coiffure :** Rasé ou très court sous le béret.

## Tenues (3 variantes)
1. Jour : chemise sable à manches courtes avec pattes d'épaule vides (aucun galon), brassard orange « sécurité » remplacé par un pictogramme de cadenas, pantalon marron foncé, rangers noirs, béret marron sans insigne.
2. Nuit : même tenue, gilet réfléchissant jaune, lampe-torche longue allumée (cône de lumière = zone de détection).
3. Guérite : polo sable, casquette marron, assis ; badge plastifié au cou.

Tous les motifs de pagne sont inventés pour le jeu (aucun tissu de marque copié) ; aucun logo ni texte réel.

## Accessoires
Lampe-torche ; radio portative ; sifflet ; cahier d'entrées ; aucun armement.

## Démarche et gestes
Ronde lente et régulière, s'arrête pour balayer à la lampe. Lève la barrière à la main. Barre le passage bras écartés. Parle à sa radio en cas d'alerte.

**Animations à prévoir :** ronde, balayage à la lampe, bras écartés, lève la barrière, parle à la radio, coup de sifflet, course courte, bâille (nuit).

## Caractère et façon de parler
Consciencieux, peu bavard, s'ennuie la nuit. Vouvoie.

Répliques d'ambiance :
1. « Badge, s'il vous plaît. »
2. « Zone réservée. Faites demi-tour. »
3. « Qui est là ? … Sûrement un chat. »
4. « Poste trois à poste un : rien à signaler. »
5. « On n'entre pas sans bordereau. »
6. « Hé ! Vous, là-bas ! J'appelle la police. »

## Voix
Homme de 28 à 45 ans, voix grave, neutre, débit lent.

## Budget de polygones
Catégorie « Passant » de `docs/style_graphique.md` : **3 000 triangles** au détail fin, **600** vu de loin, plus deux niveaux allégés (environ 50 % et 15 %). Trois matières au plus (peau, tenue, accessoires). Texture : 512 px. Chaque variante de tenue respecte le même budget.

## Consigne de génération 3D (en anglais)
```
Athletic Beninese port security guard, closed square-jawed face, plain sand-coloured short-sleeved shirt with empty shoulder straps, no rank, no weapon, dark brown trousers, black boots, plain brown beret without badge, long flashlight, handheld radio. Stylized low-poly game character, slightly stocky proportions, simple face, flat colours (one tint per surface, no photo textures), crisp edges, warm late-afternoon light, full body, A-pose, neutral expression, single mesh, plain background. No logo, no real brand, no readable text. Entirely fictional person, must not resemble any real individual. Target about 3 000 triangles, at most 3 materials.
```
