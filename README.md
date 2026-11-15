# Cotonou City

Jeu en monde ouvert 3D inspiré de Cotonou (Bénin), fait avec Godot 4.3, moteur de rendu « Compatibility » pour tourner sur de petits PC.

- `scripts/` : code du jeu (`main.gd` monde et missions, `car.gd` véhicules, `player.gd` héros)
- `plan/taches.csv` : plan de production complet avec RACI (R réalise, A valide, C consulté, I informé)
- `plan/gen.py` : générateur du plan

## Tester
- Test automatique : `godot --headless --fixed-fps 60 -- --selftest` (doit afficher `SELFTEST OK`)
- Fabriquer le .exe : `godot --headless --export-release "Windows" build/CotonouCity.exe`

## PC cible
Intel Celeron N4020, Intel UHD 600, peu de mémoire : pas d'ombres, matières simples, distance d'affichage courte, objectif 30 images par seconde en 720p.

## Règles de contenu
Personnages, partis et entreprises fictifs. Français, avec quelques expressions fon élémentaires. Voix générées, pas de comédiens.
