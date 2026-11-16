# Menus : fonctionnement attendu

Code : `scripts/hud.gd` (écran d'accueil et de pause), `scripts/menus.gd` (boutons ajoutés et panneaux), `scripts/options.gd` (réglages, fichier, touches, manette), branchés par `scripts/systemes.gd`. Vérifications : `scripts/selftest_menus.gd` (et le début de `scripts/selftest.gd` pour la pause).

Tout l'écran d'accueil tient dans une fenêtre de 1280 × 720. Tous les menus se manient à la souris, au clavier (flèches, Entrée, Échap) et à la manette (croix ou manche, A, B).

## Menu principal
- Au lancement : titre « MARINA CITY », sous-titre « Cotonou, 2017-2026 » (décisions 1 et 23), bande vert-jaune-rouge, rappel des touches, puis les boutons.
- « Jouer (Entrée) » : commence ou reprend la partie en cours. Entrée fait la même chose tant que « Jouer » est choisi.
- Ligne suivante : « Continuer » (seulement s'il existe une sauvegarde : charge la plus récente), « Charger une partie » (grisé sans sauvegarde), « Options ».
- « Quitter le jeu ».
- Le jeu est figé derrière le menu.
- Plus tard : « Nouvelle partie » avec choix de la difficulté (décision 116), image de fond de la Marina, crédits.
- Test : titre, sous-titre, Jouer, Quitter présents ; sans sauvegarde ni « Continuer » ni « Sauvegarder », « Charger » grisé ; avec une sauvegarde, « Continuer » la recharge et lance le jeu.

## Pause
- Échap (ou Start à la manette) en jeu : le jeu se fige, titre « PAUSE », bouton « Reprendre ». Échap de nouveau : reprise.
- Ligne suivante : « Charger une partie », « Sauvegarder », « Options ». Puis « Quitter le jeu ».
- Les touches de déplacement sont relâchées à l'ouverture : le héros ne repart pas tout seul.
- Tant qu'un panneau (Sauvegarder, Charger, Options) est ouvert, Échap ou B ferme le panneau et revient à la pause, sans reprendre le jeu.
- Plus tard : « Retour à l'écran d'accueil », carte de la ville.
- Test : la circulation ne bouge pas pendant la pause ; « Sauvegarder » visible en pause seulement ; Entrée sur un autre bouton que « Reprendre » ne reprend pas le jeu.

## Options
Quatre onglets : Graphismes, Audio, Touches, Manette. Chaque réglage agit tout de suite et est enregistré tout de suite dans `user://options.json` (pas de bouton « Appliquer »). Fichier absent ou abîmé : réglages d'origine. Valeur hors limites : ramenée dans ses limites.

### Options graphiques
- Niveau graphique : Bas (petits PC), Moyen, Élevé, Ultra ; d'origine Élevé. C'est le même réglage que F4 en jeu : changer l'un change l'autre, et le choix est gardé d'un lancement à l'autre.
- Plein écran : oui/non ; d'origine non (fenêtre agrandie).
- Synchronisation verticale : oui/non ; d'origine oui.
- Images par seconde au plus : 30, 60, 120, sans limite ; d'origine sans limite.
- Afficher les images par seconde : oui/non (même réglage que F3).
- Plus tard : résolution, distance d'affichage, qualité des ombres et densité de la circulation séparées du niveau.
- Test : Bas (pas d'ombres, rendu à 70 %) et Ultra appliqués ; niveau 9 refusé ; limite à 60 appliquée, 45 refusée ; compteur caché ; plein écran et fenêtre ; F4 et F3 en jeu enregistrés ; réglages relus par un nouveau lancement.

### Options audio
- Quatre curseurs de 0 à 100, par pas de 5 : Volume général (d'origine 80), Musique et radio (70), Bruitages (100), Voix (100).
- 100 = plein volume, 50 = moitié (-6 dB), 0 = muet.
- Quatre pistes de mixage : générale, « Musique », « Effets », « Voix ». Aujourd'hui seul le klaxon existe : il passe par « Effets ». La musique, la radio et les voix à venir devront utiliser leur piste.
- Plus tard : sous-titres (taille, fond), choix de la sortie audio.
- Test : pistes présentes ; musique à 50 = -6,02 dB ; 0 = muet ; 150 ramené à 100 ; général à 25 = -12 dB ; valeurs enregistrées ; klaxon sur la piste « Effets ».

### Touches
- 14 actions modifiables : avancer, reculer, gauche, droite, monter/descendre/utiliser, sauter, courir, s'accroupir, frein à main, klaxon, phares, clignotants gauche et droit, caméra. Touches d'origine : celles de la décision 113 (ZQSD sur un clavier français ; on retient la place de la touche, pas la lettre).
- On clique sur la touche d'une action, « appuie sur la nouvelle touche » s'affiche, on appuie. Échap annule sans fermer le panneau.
- Touche déjà utilisée par une autre action de la même situation (à pied, ou en véhicule) : les deux actions échangent leurs touches et le message le dit. Une action à pied et une action de véhicule peuvent partager une touche (Espace : sauter et frein à main).
- Touches réservées, refusées : Échap, Entrée, F3, F4, les quatre flèches, Ctrl. Les flèches restent toujours valables pour se diriger.
- « Remettre les touches d'origine ».
- Limite connue : les rappels de touches écrits à l'écran (accueil, aides en jeu) citent encore les touches d'origine.
- Test : klaxon passé de H à G par le menu ; échange phares/klaxon ; saut et klaxon sur la même touche ; quatre touches réservées refusées ; Échap annule ; avancer sur T répond aussi à la flèche et plus à Z ; enregistrement, relecture, remise d'origine ; chaque action a une seule touche principale.

### Manette
- Décision 114. Toute manette reconnue par le système marche sans réglage ; l'onglet affiche son nom ou « aucune manette branchée ».
- Commandes fixes : manche gauche = se diriger (progressif en véhicule) ; gâchette droite = accélérer, gauche = freiner et reculer ; croix gauche/droite = tourner ; A = sauter ou frein à main ; B = s'accroupir ; X = courir ; Y = monter, descendre, utiliser ; boutons d'épaule = clignotants ; clic du manche gauche = klaxon ; croix haut = phares ; Sélection = caméra ; Start = pause.
- Dans les menus : croix ou manche pour choisir, A valider, B retour.
- Réglages : « Utiliser la manette » (d'origine oui), « Vibrations » (oui), « Zone morte des manches » de 5 à 60 % (25 %).
- Vibrations : quand Koffi perd 5 points de santé ou plus ; force et durée selon la blessure (20 points : moitié de la force, 0,3 s ; 40 points et plus : pleine force, 0,5 s).
- Plus tard : commandes de manette modifiables, caméra au manche droit, dessin des boutons selon la marque de la manette.
- Test : les 19 commandes agissent sur la bonne action ; manche à 20 % sans effet, à 60 % effet partiel, à fond effet total ; zone morte à 10 % appliquée, 99 ramené à 60 ; vibration selon la blessure, aucune pour une égratignure ni si elles sont coupées ; blessure réelle = vibration ; manette désactivée = plus aucune commande, clavier intact ; réactivée sans doublon ; menus à la manette.

Non vérifié par le test automatique : une vraie manette branchée (le test envoie les signaux d'une manette), et le changement réel de la fenêtre (le test tourne sans écran).
