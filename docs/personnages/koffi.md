# Koffi

Tâche T2473 · entrée du plan : « Héros » · personnage inventé, toute ressemblance avec une personne réelle serait fortuite.

## Rôle dans le jeu
- **Rôle :** Héros jouable. Conducteur de zémidjan (2017), livreur, puis patron de Maillot Vert Express (43 personnes en 2025).
- **Où on le croise :** Partout : c'est le personnage du joueur. Points de départ : concession derrière Dantokpa (ch. 1-3), garage d'Akpakpa (ch. 4-6).
- **Chapitres :** 1 à 6 (jouable partout)

## Physique
- **Âge :** 24 ans en 2017, 33 ans en 2026 (né en 1993). Vieillit à chaque chapitre : barbe de trois jours au ch. 3, petite barbe taillée au ch. 4, premières rides du front au ch. 5, tempes légèrement grises au ch. 6.
- **Taille :** 1,90 m (gabarit du jeu, capsule de 0,40 m de rayon).
- **Corpulence :** Mince et sec aux ch. 1-4 (épaules étroites, avant-bras nerveux), un peu plus épais à partir du ch. 5. Corpulence non modifiable par le joueur (décision 50).
- **Visage :** Peau brun foncé, visage allongé, pommettes hautes, grands yeux expressifs, sourcils mobiles (on lit tout sur sa figure : mauvais menteur), sourire large légèrement de travers, petite cicatrice claire au sourcil gauche (repère fixe pour toutes les versions).
- **Coiffure :** Cheveux ras, contours nets ; même coupe du ch. 1 au ch. 6, seules les tempes changent.

## Tenues (3 variantes)
1. Chapitre 1 : maillot de football vert `008751` délavé, col rond un peu détendu, sans numéro ni écusson ; jean bleu usé aux genoux ; sandales de plastique noires. Casque de moto jaune rayé, posé automatiquement en selle (décision 52).
2. Chapitres 2-3 : chemise jaune `f2c200` de zémidjan en coton léger, n° 117 peint en noir dans le dos, ouverte sur le maillot vert ; jean ; sandales fermées (ch. 2) puis polo vert, jean propre, baskets blanches et cache-nez en tissu (ch. 3).
3. Chapitres 4-6 : chemise à manches courtes vert bouteille et pantalon de toile beige (ch. 4, casque de chantier jaune sur les chantiers) ; blouson léger gris, lunettes de soleil et montre (ch. 5) ; chemise blanche repassée et pantalon de costume anthracite, ou ensemble en pagne à motif inventé « feuilles de manioc » vert et or cousu par Maître Anselme pour les cérémonies (ch. 6). Le maillot vert du ch. 1 revient pour la balade de 6.10.

Tous les motifs de pagne sont inventés pour le jeu (aucun tissu de marque copié) ; aucun logo ni texte réel.

## Accessoires
Téléphone à touches (ch. 1), smartphone à écran fêlé (ch. 2-4) puis neuf (ch. 5-6) ; liasse de billets pliée dans la poche avant ; porte-clés en capsule de bouteille offert par Romaric ; casque de moto.

## Démarche et gestes
Marche rapide, légèrement penché en avant, bras qui balancent large. Parle avec les mains. Se gratte la nuque quand il ment. Tapote le réservoir de la moto pour la remercier. Compte ses billets deux fois quand il est nerveux. Lève les deux paumes pour négocier.

**Animations à prévoir :** marche, course, accroupi, saut, nage, monter/descendre de moto, conduite moto/tricycle/voiture/camion, combat à mains nues (esquive, poussée, coup de bâton), chute et relevé, négociation (paumes levées), gratte-nuque, comptage de billets, tape sur le réservoir, salut de la main, téléphone à l'oreille, assis sonné.

## Caractère et façon de parler
Débrouillard, blagueur, loyal envers sa famille, mauvais menteur, préfère négocier que se battre (décision 10). Phrases courtes, images de la route et du marché. Annonce ses plans à voix haute. Tutoie Romaric, Afi, Turbo ; vouvoie sa mère, Nan Akouavi, Le Doyen, Gratien, Barnabé, Fortuné. Jurons légers seulement.

Répliques d'ambiance :
1. « Bon. Plan simple. »
2. « Pardon, pardon, je passe, c'est pour le travail ! »
3. « Merci ma belle, tu as démarré. Je le dirai à Romaric. »
4. « Lagos m'a tout appris. Surtout ce qu'il ne faut pas faire. »
5. « Ah, c'est pas vrai ! Encore un nid-de-poule avec vue sur la mer. »
6. « On discute d'abord. On court après, si vraiment il faut. »

## Voix
Homme jeune (24 à 33 ans), timbre clair et chaleureux, médium, débit rapide, sourire audible ; un peu plus posé aux ch. 5-6.

## Budget de polygones
Catégorie « Héros » de `docs/style_graphique.md` : **10 000 triangles** au détail fin, **2 500** vu de loin, plus deux niveaux allégés (environ 50 % et 15 %). Trois matières au plus (peau, tenue, accessoires). Texture : 1 024 px. Chaque variante de tenue respecte le même budget.

## Consigne de génération 3D (en anglais)
```
Young Beninese man, mid-twenties, tall and lean, dark brown skin, very short cropped hair, expressive eyebrows, wide slightly crooked smile, small scar on left eyebrow. Faded plain green football jersey without number or crest, worn blue jeans, black plastic sandals. Stylized low-poly game character, slightly stocky proportions, simple face, flat colours (one tint per surface, no photo textures), crisp edges, warm late-afternoon light, full body, A-pose, neutral expression, single mesh, plain background. No logo, no real brand, no readable text. Entirely fictional person, must not resemble any real individual. Target about 10 000 triangles, at most 3 materials.
```
