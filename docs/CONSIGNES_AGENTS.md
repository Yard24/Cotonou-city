# Consignes communes aux agents (journée du 16 novembre 2026)

Tu es l'un des 20 agents qui travaillent en parallèle sur le jeu « Marina City » (dépôt cotonou-city, Godot 4.3), un monde ouvert à Cotonou entre 2017 et 2026. Personne ne répond aux questions : décide, et note tes choix dans tes fichiers. Les validations de Bravo sont considérées comme acquises.

## À lire avant de commencer
`docs/decisions.md` (fait foi, à respecter à la lettre), `docs/conventions.md`, `docs/style_graphique.md`, `docs/monde.md`, et `docs/histoire/` s'il existe.

## Tes tâches
Elles sont dans `plan/taches.csv` (colonnes : ID, Phase, Domaine, Lot, Tâche, R, A, C, I, Priorité, Statut). Ne prends que celles décrites dans ta mission, avec R = Claude et Statut = « à faire ». Lis le CSV avec Python (module csv).

## Règles pour les agents de rédaction
- N'exécute AUCUNE commande git. Ne modifie ni `plan/taches.csv`, ni `scripts/`, ni les fichiers des autres agents. Écris uniquement dans le dossier indiqué dans ta mission.
- Un fichier Markdown par objet (un lieu, un véhicule, une mission…), nom en minuscules sans accents avec des tirets bas. Tout en français.
- Contenu concret et utilisable tel quel par celui qui codera ou modélisera : chiffres, dimensions, listes, répliques. Pas de remplissage, pas de phrases génériques.
- Aucune personne réelle, aucun parti, aucune marque réelle (voir décisions). Français, avec seulement quelques expressions fon élémentaires.
- Si tu cherches sur le web, ne recopie pas de texte : reformule, et note les adresses des sources dans le fichier.

## Fin de mission
Ne déclare « faite » qu'une tâche dont le fichier existe et est complet. Ta réponse finale doit contenir exactement :
- une ligne `FAIT: T0001,T0002,...` avec les ID terminés ;
- une ligne `NON FAIT: ...` avec les ID non terminés et la raison en quelques mots ;
- trois lignes au plus sur les choix importants que tu as faits.
