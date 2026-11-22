# Commandes tactiles : fonctionnement attendu

Code : `scripts/tactile.gd`, branché par `scripts/systemes.gd` (construit au lancement, appelé au début de chaque image, avant le reste du jeu). Réglages : `scripts/options.gd` et onglet « Tactile » de `scripts/menus.gd`. Vérifications : `scripts/selftest_tactile.gd`. Fabrication Android : `docs/android.md`.

## Principe : une seule logique de jeu
Les boutons tactiles n'ont aucune logique de jeu. Ils appuient sur les **mêmes actions d'entrée** que le clavier (`up`, `down`, `left`, `right`, `enter`, `course`, `jump`, `run`, `crouch`, `brake`, `horn`, `cam`, `lights`, `blink_l`, `blink_r`, `quit`), avec `Input.action_press` et `Input.action_release`. Le jeu (`main.gd`, `player.gd`, `car.gd`, `moto.gd`, `zem.gd`) ne sait pas si l'appui vient d'un doigt, d'une touche ou d'une manette.
- Un toucher très bref reste appuyé une image au moins : Godot 4.3 ne signale un appui « tout neuf » qu'à l'image qui suit l'appui.
- La manette virtuelle donne une force progressive (on marche doucement en poussant peu ; la direction est progressive en véhicule).

## Quand elles s'affichent
- Sur un téléphone ou une tablette (système mobile avec écran tactile) : toujours, sauf pendant l'écran d'accueil, la pause et les panneaux de menu (là, on touche directement les boutons des menus).
- Sur PC : seulement si l'option « Commandes tactiles même sans écran tactile » est cochée (Options > Tactile). La souris joue alors le rôle d'un doigt. Un PC portable à écran tactile ne les affiche pas d'office : le jeu Windows reste exactement comme avant.

## Disposition (paysage)
- **À gauche : manette virtuelle.** Cercle en bas à gauche. Le pouce peut se poser n'importe où dans le bas de la moitié gauche : la manette se centre dessous, puis revient à sa place quand on lève le pouce. Zone morte : 18 % de la course.
  - À pied : haut avancer, bas reculer, gauche et droite tourner (comme les flèches).
  - En véhicule : gauche et droite dirigent. Haut et bas n'accélèrent ou ne freinent qu'au-delà de 55 % de la course, pour qu'un pouce qui dirige n'accélère pas par mégarde ; on accélère normalement avec la pédale de droite.
- **À droite : boutons d'action**, trois colonnes en bas à droite.
  - À pied : Sauter, Courir, S'accroupir (Courir et S'accroupir s'allument d'un appui et s'éteignent au suivant ; en nageant, « Courir » devient « Nager vite »).
  - En véhicule : Accélérer (grande pédale), Freiner/reculer, Frein à main (« Frein arrière » à moto).
  - Ligne au-dessus : le bouton d'action (E), Course (M), Klaxon.
- **Sous la mini-carte** : Caméra, Phares, Clignotant gauche, Clignotant droit (en véhicule). Avec de très grands boutons, ils passent sur la ligne d'action, à gauche du klaxon.
- **En haut à droite, à gauche de la mini-carte : Pause**, toujours visible en jeu.
- L'aide en bas et la vitesse se placent entre la manette et les boutons ; la ligne de mission s'arrête avant le bouton Pause. Rien ne cache la mini-carte, les étoiles de recherche, l'argent, la santé ni les messages.

## Boutons qui n'apparaissent que quand ils servent
- Bouton d'action (E) : à pied, seulement s'il y a quelque chose à faire, avec le mot juste : « Monter », « Relever » (moto tombée), « Acheter », « S'asseoir », « Lire », « Utiliser » ; même choix que `press_e()` de `main.gd`. En véhicule : « Descendre », ou « Sauter en marche » au-dessus de 22 km/h.
- Course (M) : « Accepter la course » quand un client propose sa course ; « Déposer le client » à l'arrêt avec un client à bord.
- Frein à main : en véhicule, au-dessus de 7 km/h.
- Klaxon : en véhicule, avec un passant à moins de 25 m ou un véhicule à moins de 30 m devant.
- Sauter, Courir, S'accroupir : cachés quand le héros est assis, par terre, évanoui ou en train d'escalader ; Sauter et S'accroupir cachés dans l'eau.

## Plusieurs doigts
Chaque doigt est suivi à part : on tourne avec la manette et on accélère avec la pédale en même temps. Un doigt qui glisse d'une pédale à l'autre change de pédale.

## Tailles
- Grand bouton : 11 mm de côté visés (calculé avec la densité de l'écran), jamais moins de 9,5 mm, et pas plus de 20 % de la hauteur de l'écran. Petits boutons : 72 % d'un grand, jamais moins de 9,5 mm.
- Option « Taille des boutons » de 70 à 150 % et « Opacité des boutons » de 20 à 100 % (Options > Tactile).
- Au doigt, les boutons des menus font 76 unités de haut (environ 7 mm sur un téléphone de 6,5 pouces), les textes sont plus grands, et un panneau trop haut pour l'écran défile.

## Textes à l'écran
Quand on joue au doigt, un texte qui cite une touche du clavier cite le bouton tactile : « Appuie sur E pour monter sur la moto » devient « Appuie sur « Monter » pour monter sur la moto », « M : accepter la course » devient « « Course » : accepter la course », « (F4) » devient « (Options) », « Jouer (Entrée) » devient « Jouer ». L'aide de l'écran d'accueil est remplacée par une aide tactile. La conversion se fait au moment d'afficher (`sys.adapter`, appelé par `hud.gd`, `main.gd` et `menus.gd`) : un nouveau message écrit avec « E », « M », « Espace », « Maj », « V »… est converti tout seul s'il suit les tournures habituelles (« touche E », « avec E », « E : », « (Espace) », « E pour »). Au clavier, aucun texte ne change.

## Android
- Bouton Retour : fait comme Échap (pause, reprise, retour dans un panneau de menu). Il ne ferme jamais le jeu (`application/config/quit_on_go_back=false`).
- Jeu mis en arrière-plan (appel, autre application) : pause, puis sauvegarde automatique (emplacement automatique, mêmes règles que `sauvegarde.gd` : refusée seulement si Koffi est évanoui). Rien n'est sauvegardé depuis l'écran d'accueil (la partie n'a pas commencé). Sur PC, perdre le focus de la fenêtre ne fait rien de nouveau.
- Zone sûre (encoche, bords arrondis) : relue toutes les demi-secondes (le téléphone peut être retourné). L'affichage et les menus sont légèrement réduits pour y tenir ; les commandes tactiles s'y placent, avec 14 unités de plus pour les coins arrondis.

## Test automatique (`selftest_tactile.gd`)
Faux touchers d'écran (`InputEventScreenTouch`, `InputEventScreenDrag`) envoyés à `tactile.gd` :
- réglages Android du projet et du préréglage d'export ;
- commandes cachées sur PC, affichées par l'option ;
- six écrans simulés (720 × 1600, 1080 × 2400, 480 × 854, tablette 800 × 1280, encoche à gauche, à droite) en tailles 70, 100 et 150 % : boutons de 9 mm au moins, dans la zone sûre, sans chevauchement, loin de la mini-carte, des étoiles, de l'argent, de la santé, des messages, de l'aide et de la mission ;
- textes : 23 messages du jeu ne citent plus aucune touche au doigt ; les autres textes ne changent pas ;
- manette : avancer, gauche à mi-course, zone morte, reculer, recentrage ;
- boutons : toucher bref, bascule Courir, Pause, deux doigts (direction et accélérateur ensemble, la moto avance en tournant), glisser d'une pédale à l'autre ;
- boutons utiles seulement ; menus ; bouton Retour ; arrière-plan ; onglet Tactile ;
- puis quelques secondes de vrai jeu : « Monter » au doigt fait monter sur la moto, et deux doigts la font rouler en tournant.
