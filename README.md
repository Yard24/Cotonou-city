# Marina City

Jeu en monde ouvert 3D inspiré de Cotonou (Bénin), fait avec Godot 4.3, moteur de rendu « Compatibility » pour tourner sur de petits PC.

- `scripts/` : code du jeu (`main.gd` monde, missions, monter et descendre des véhicules, `car.gd` véhicules (conduite, suspension, dégâts visibles), `moto.gd` moto (équilibre, freinage, chute du pilote), `car_fx.gd` feux, clignotants et klaxon, `trafic.gd` circulation, motos qui remontent les files et passants, `zem.gd` courses de zémidjan (clients, passager, tarif), `embarquement.gd` monter et descendre (portières, côtés, verrouillage, place libre, saut en marche), `vue.gd` caméra, `player.gd` héros, `relief.gd` mer, ponton, murets et caisses, `decor.gd` statue, marché, panneaux et palmiers, `interaction.gd` objets à utiliser avec E, `hud.gd` affichage, `minimap.gd` mini-carte, `selftest.gd` test automatique, `selftest_voiture.gd` test de la conduite voiture, `selftest_moto.gd` test de la conduite moto, `selftest_moto_ville.gd` test du passager et du passage entre les voitures, `selftest_embarquement.gd` test de monter et descendre, `tactile.gd` commandes tactiles et adaptations Android, `fusion.gd` décor regroupé sur téléphone, `selftest_tactile.gd` test des commandes tactiles)
- `docs/` : conventions, style graphique et budget de polygones, échelle du monde, fonctionnement attendu des systèmes
- `plan/taches.csv` : plan de production complet avec RACI (R réalise, A valide, C consulté, I informé)
- `plan/gen.py` : générateur du plan

## Tester
- Test automatique : `godot --headless --fixed-fps 60 -- --selftest` (doit afficher `SELFTEST OK`)
- Fabriquer le .exe : `godot --headless --export-release "Windows" build/MarinaCity.exe`
- Fabriquer le .apk Android : voir `docs/android.md` (fait automatiquement par GitHub Actions : Actions > dernier passage > « MarinaCity-Android »)

## Graphismes
Quatre niveaux, touche F4 en jeu ou Options > Graphismes : Bas (petits PC, sans ombres), Moyen, Élevé, Ultra. On vise la meilleure qualité possible en gardant le niveau Bas jouable.

## Android
Version Android 5.0 et plus (arm64-v8a, armeabi-v7a), jouable au doigt : manette virtuelle à gauche, boutons à droite, niveau graphique Bas par défaut. Commandes : `docs/systemes/commandes_tactiles.md` ; fabrication : `docs/android.md`.

## Règles de contenu
Personnages, partis et entreprises fictifs. Français, avec quelques expressions fon élémentaires. Voix générées, pas de comédiens.
