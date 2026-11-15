# Procédure de travail automatique (à suivre à chaque passage)

Tu es Claude et tu travailles seul sur le jeu Cotonou City. Personne ne te regarde : ne pose pas de question, décide et note tes choix dans le journal.

## 1. Préparer
1. Le dépôt est Yard24/cotonou-city, branche `main`. Fais `git pull --rebase` avant tout.
2. Installe Godot 4.3 :
   `curl -sSL -o /tmp/godot.zip https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip && unzip -o -q /tmp/godot.zip -d /tmp`
3. Lis `README.md`, `docs/decisions.md` (décisions validées par Bravo, à respecter), puis les 3 derniers fichiers de `plan/journal/`.

## 2. Choisir le travail
- Ouvre `plan/taches.csv`. Prends les prochaines tâches dont « R (réalise) » = Claude et « Statut » = « à faire », priorité P1 d'abord, dans l'ordre du fichier, en restant sur un même lot cohérent (5 à 15 tâches par passage).
- Saute les tâches qui demandent un outil extérieur non branché (génération 3D, voix, musique) ou une validation de « Toi » : laisse-les « à faire » et note-le.
- Ne touche jamais aux tâches dont R = Toi.

## 3. Réaliser
- Code en GDScript, commentaires en français, fichiers dans `scripts/`. Découpe `main.gd` en fichiers plus petits quand il grossit.
- Formes simples générées par le code tant qu'aucun modèle 3D n'est fourni.
- Contenu : personnages, partis et entreprises fictifs ; aucune personne réelle. Français avec quelques expressions fon élémentaires, pas d'autre langue locale. Le jeu doit rester jouable au niveau graphique « Bas ».
- Ajoute ou étends le test automatique (`--selftest` dans `scripts/main.gd`) pour chaque fonction ajoutée.

## 4. Vérifier avant d'enregistrer
- `/tmp/Godot_v4.3-stable_linux.x86_64 --headless --import` puis
  `/tmp/Godot_v4.3-stable_linux.x86_64 --headless --fixed-fps 60 -- --selftest` doit afficher `SELFTEST OK` et aucune ligne `SCRIPT ERROR`.
- Si le test échoue et que tu ne peux pas corriger, annule tes changements du lot : `main` doit toujours rester jouable.

## 5. Enregistrer
- Passe à « fait » dans `plan/taches.csv` uniquement les tâches réellement terminées et testées.
- Écris `plan/journal/AAAA-MM-JJ-HHhMM.md` : ce qui est fait, ce qui bloque, ce que Bravo doit décider ou tester, tes choix.
- Un commit par lot, message en français, puis `git pull --rebase` et `git push origin main`. En cas de conflit sur `taches.csv`, garde la version distante et réapplique tes statuts.
- Chaque push sur `main` fabrique le .exe Windows (GitHub > Actions > dernier passage > « CotonouCity-Windows »).
