# Marina City

Jeu en monde ouvert 3D inspiré de Cotonou (Bénin), fait avec Godot 4.3, moteur de rendu « Compatibility » pour tourner sur de petits PC.

- `scripts/` : code du jeu (`main.gd` monde, missions, monter et descendre des véhicules, `car.gd` véhicules (conduite, suspension, dégâts visibles), `moto.gd` moto (équilibre, freinage, chute du pilote), `car_fx.gd` feux, clignotants et klaxon, `trafic.gd` circulation, motos qui remontent les files et passants, `zem.gd` courses de zémidjan (clients, passager, tarif), `vue.gd` caméra, `player.gd` héros, `relief.gd` mer, ponton, murets et caisses, `decor.gd` statue, marché, panneaux et palmiers, `interaction.gd` objets à utiliser avec E, `hud.gd` affichage, `minimap.gd` mini-carte, `selftest.gd` test automatique, `selftest_voiture.gd` test de la conduite voiture, `selftest_moto.gd` test de la conduite moto, `selftest_moto_ville.gd` test du passager et du passage entre les voitures)
- `docs/` : conventions, style graphique et budget de polygones, échelle du monde, fonctionnement attendu des systèmes
- `plan/taches.csv` : plan de production complet avec RACI (R réalise, A valide, C consulté, I informé)
- `plan/gen.py` : générateur du plan

## Tester
- Test automatique : `godot --headless --fixed-fps 60 -- --selftest` (doit afficher `SELFTEST OK`)
- Fabriquer le .exe : `godot --headless --export-release "Windows" build/MarinaCity.exe`

## Graphismes
Quatre niveaux, touche F4 en jeu : Bas (petits PC, sans ombres), Moyen, Élevé, Ultra. On vise la meilleure qualité possible en gardant le niveau Bas jouable.

## Règles de contenu
Personnages, partis et entreprises fictifs. Français, avec quelques expressions fon élémentaires. Voix générées, pas de comédiens.
