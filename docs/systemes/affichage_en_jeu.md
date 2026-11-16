# Affichage en jeu : fonctionnement attendu

Code : `scripts/hud.gd` (argent, jauge de santé, mission, aide, vitesse, mini-carte), `scripts/affichage.gd` (valeur et alertes de santé, objet en main, notifications, recherche), `scripts/etoiles.gd` (dessin des étoiles), branchés par `scripts/systemes.gd`. Vérifications : `scripts/selftest_affichage.gd`.

Disposition : en haut à gauche l'argent, la santé, l'objet en main puis les notifications ; en haut au centre la mission ; en haut à droite la mini-carte et, dessous, les étoiles de recherche ; en bas au centre l'aide ; en bas à droite la vitesse. Tout reste lisible au niveau graphique « Bas » et passe sous l'écran de pause.

## Santé
- Jauge de 200 pixels sous l'argent : verte au-dessus de 60 %, jaune de 30 à 60 %, rouge en dessous. La valeur (de 0 à 100) est écrite à droite de la jauge ; elle n'affiche 0 que si Koffi est évanoui.
- Blessure : éclair blanc sur la jauge pendant 0,4 s et voile rouge sur tout l'écran, d'autant plus marqué que la blessure est forte (30 points : opacité 0,34 ; plafond 0,45 à partir de 40 points), effacé en moins d'une seconde. La manette vibre (voir `menus.md`).
- Sous 30 % : la jauge bat (environ une fois par seconde) et la valeur passe au rouge, jusqu'à ce que la santé remonte.
- Santé qui remonte (repos, eau, banc) : ni éclair ni voile.
- Plus tard : bruit de cœur sous 30 %, jauge d'endurance à côté.
- Test : à 100 rien ; blessure de 30 : « 70 », éclair, voile à 0,34, jauge à 140 pixels ; tout effacé après 1 s ; gros choc plafonné à 0,45 ; à 25 la jauge bat et le chiffre rougit ; après soins l'alerte s'arrête ; arrondis.

## Argent
- En haut à gauche, en vert : `1250 FCFA`, mis à jour à chaque image.
- Chaque gain ou dépense est aussi annoncé par une notification : `+500 FCFA` en vert, `-100 FCFA` en rouge. Rien n'est annoncé après un chargement.
- Plus tard : séparateur de milliers, solde KwabôPay à part à partir du chapitre 2 (décision 66).
- Test : texte exact ; gain et dépense annoncés une seule fois ; rien après un chargement ; zéro.

## Objet en main (ancienne tâche « arme »)
- Le joueur n'a aucune arme à feu (décision 3), ni couteau ni machette (décision 78) : pas de munitions, pas de viseur, pas de roue des armes.
- À pied, sous la santé : « Mains nues » en gris, ou le nom de l'objet ramassé, « Bâton » ou « Planche », avec une petite jauge d'usure.
- Un bâton tient 8 coups, une planche 5 ; au dernier coup l'objet casse (notification « Bâton cassé »), retour à « Mains nues ».
- Caché à bord d'un véhicule ; l'objet est gardé et réapparaît en descendant.
- Tout autre nom d'objet est refusé par le code : on ne peut pas faire apparaître une arme par erreur.
- Le ramassage et les coups eux-mêmes viendront avec le système « Combat » : il appellera `prendre`, `user` et `lacher`.
- Test : « Mains nues » sans jauge ; pistolet, fusil, couteau et machette refusés ; bâton affiché, jauge à 62,5 % après 3 coups ; caché en voiture, retrouvé à la descente ; cassé au 8e coup avec notification ; planche à 5 coups.

## Notifications
- Petits messages empilés à gauche, sous l'objet en main : 4 au plus à l'écran, 4 secondes chacun (2,5 s pour la sauvegarde automatique), fondu sur la dernière demi-seconde.
- Au-delà de 4, les suivants attendent et prennent la place libérée, dans l'ordre ; au plus 12 en attente, les plus anciens sont abandonnés.
- Le même message répété n'est pas empilé : il est compté (« Bonjour ×3 ») et repart pour 4 secondes.
- Couleur selon le type : blanc (information), vert (gain), rouge clair (perte), orange (alerte), bleu clair (sauvegarde).
- Envoyées aujourd'hui : gains et dépenses, sauvegarde manuelle et automatique, objet cassé, hausse et fin de recherche.
- Elles ne remplacent ni le bandeau central (« MISSION ACCOMPLIE ») ni l'aide du bas de l'écran. Figées pendant la pause.
- Plus tard : petit son, icône par type, messages de téléphone (Afi, Romaric).
- Test : affichage, compteur ×3, couleurs, type inconnu traité comme information, 4 à l'écran et 3 en attente, fondu, remplacement dans l'ordre, effacement, file limitée à 12, sauvegarde annoncée.

## Indicateur de recherche
- Cinq étoiles sous la mini-carte (décision 73 : niveau de 1 à 5). Étoiles jaunes jusqu'au niveau, grises au-delà.
- Niveau 0 : rien n'est affiché.
- Le niveau monte : notification orange « Recherché par la police : 3 étoiles ». Il redescend sans notification. Retour à 0 : « La police ne te cherche plus ».
- La police a perdu le joueur de vue : les étoiles clignotent (0,4 s allumées, 0,4 s éteintes) jusqu'à ce qu'elle abandonne ou le retrouve.
- Le système de police (pas encore codé) pilotera l'indicateur par `regler_recherche(niveau, perdu_de_vue)` ; en attendant il reste caché en jeu.
- Plus tard : zone de recherche sur la mini-carte.
- Test : caché à 0 ; 3 étoiles affichées et annoncées ; baisse sans annonce ; 9 ramené à 5 ; clignotement à moitié du temps ; arrêt du clignotement ; fin de recherche annoncée ; rien à perdre de vue à 0.
