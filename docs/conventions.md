# Conventions de nommage et de rangement

Règle générale : noms en minuscules, sans accent ni espace, mots séparés par `_` (les fichiers voyagent entre Windows, Linux et GitHub). Le texte affiché au joueur et les commentaires restent en français, avec les accents.

## Dossiers
| Dossier | Contenu |
|---|---|
| `scripts/` | Code GDScript. Un fichier par rôle (`player.gd`, `car.gd`, `relief.gd`, `decor.gd`, `interaction.gd`, `hud.gd`, `minimap.gd`, `selftest.gd`). |
| `scenes/` | Scènes Godot `.tscn` quand il y en aura (aujourd'hui tout est construit par le code). |
| `assets/modeles/` | Modèles 3D `.glb`, rangés par famille : `vehicules/`, `personnages/`, `batiments/`, `objets/`. |
| `assets/textures/` | Images `.png` ou `.webp`. |
| `assets/sons/` | `voix/`, `musique/`, `bruitages/`, en `.ogg`. |
| `docs/` | Documents de référence (ce dossier). `docs/systemes/` décrit le fonctionnement attendu de chaque système. |
| `plan/` | Plan de production (`taches.csv`) et journal (`plan/journal/AAAA-MM-JJ-HHhMM.md`). |

`docs/` et `plan/` contiennent un fichier vide `.gdignore` : Godot ne les importe pas et ils ne partent pas dans le .exe.

## Fichiers
- Scripts : `nom_du_role.gd`, au singulier (`car.gd`, pas `cars.gd`).
- Modèles : `famille_objet_variante.glb`, par exemple `vehicule_zem_jaune.glb`, `batiment_etal_marche_02.glb`.
- Sons : `voix_<personnage>_<mission>_<numéro>.ogg`, `bruit_klaxon_moto.ogg`, `musique_radio_<station>_<numéro>.ogg`.
- Documents : `nom_en_minuscules.md`.

## Code GDScript
- Variables et fonctions : `minuscules_avec_tirets_bas` ; constantes : `MAJUSCULES` ; scripts préchargés : `NomScript`.
- Fonctions internes à un fichier : préfixe `_` (`_world`, `_hud`).
- Noms courts en français ou en anglais simple, mais un seul mot pour une même chose dans tout le projet (`car`, `player`, `mission`).
- Unités : mètres, secondes, mètres par seconde ; l'affichage convertit en km/h. Argent en FCFA, nombre entier.
- Un fichier dépasse 600 lignes : le découper.
- Toute fonction de jeu ajoutée a sa vérification dans `scripts/selftest.gd`.

## Git
- Une seule branche, `main`, toujours jouable. Un commit par lot, message en français qui dit ce que le joueur gagne.
- Identifiants des tâches (`T0039`) cités dans le journal, pas dans le code.

## Version Android (depuis le 22 novembre 2026)
- Toute nouvelle commande passe par une action d'entrée (`InputMap`) ; si le joueur doit pouvoir la faire au doigt, ajouter son bouton dans `BOUTONS` de `scripts/tactile.gd` (avec la situation où il est utile, dans `contexte()`) et une vérification dans `scripts/selftest_tactile.gd`.
- Un message qui cite une touche l'écrit seule et en majuscule avec une tournure habituelle (« touche E », « avec E », « E : », « (Espace) », « E pour ») : il est converti tout seul au doigt. Pour une touche nouvelle, compléter `TOUCHES` et `nom_bouton()` dans `tactile.gd`, et la liste `TEXTES` du test.
- Sur téléphone, les blocs posés directement dans le monde (enfants directs de `main`, faits par `box()` ou `cyl()`) sont regroupés au lancement (`scripts/fusion.gd`) : un bloc qu'on modifie après sa création doit être rangé sous un autre nœud, ou porter la méta `ne_pas_fusionner`.
- Le jeu doit rester jouable au niveau « Bas » sur un téléphone d'entrée de gamme : pas de nouvel effet coûteux au niveau Bas.

