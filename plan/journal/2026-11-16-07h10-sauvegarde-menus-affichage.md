# 16 novembre 2026, 07h10 — agent « sauvegarde, menus, affichage en jeu »

Branche `agent-sauvegarde`. `plan/taches.csv` non modifié (consigne) : les ID terminés sont listés ici pour l'intégration.

## Fait et testé
- Sauvegarde : T0404 à T0418 (manuelle, automatique, chargement, emplacements multiples, compatibilité entre versions).
- Menus : T0653, T0655, T0656 (description de l'accueil et de la pause, test de l'accueil), T0659 à T0670 (options graphiques, audio, touches, manette).
- Affichage en jeu : T0636 à T0639, T0641 à T0650 (santé, argent, objet en main à la place de « arme », notifications, indicateur de recherche).
- Descriptions : `docs/systemes/sauvegarde.md`, `menus.md`, `affichage_en_jeu.md`.

## Non fait
- T0420, T0652, T0672 (« corriger d'après tes retours ») : attendent l'essai de Bravo.

## Fichiers
- Nouveaux : `scripts/systemes.gd` (seul point d'entrée), `sauvegarde.gd`, `options.gd`, `menus.gd`, `affichage.gd`, `etoiles.gd`, `selftest_sauvegarde.gd`, `selftest_menus.gd`, `selftest_affichage.gd`.
- Partagés modifiés : `scripts/main.gd` (4 lignes : création de `sys`, `sys.build`, `sys.step` au début de la boucle), `scripts/selftest.gd` (2 lignes : appel de `m.sys.selftest`). README non modifié (à compléter à l'intégration avec la liste des nouveaux fichiers).

## Choix
- Sauvegarde automatique aussi après chaque course de zémidjan payée ; au chargement le héros est toujours à pied ; les voitures empruntées ne sont pas gardées.
- Format de fichier numéro 2 ; le « format 1 » est un format d'essai qui sert à prouver la chaîne de conversion.
- « Arme » = objet tenu en main (mains nues, bâton, planche) : aucune arme à feu, ni couteau ni machette ; le ramassage viendra avec le combat. Les étoiles de recherche attendent le système de police.
- Manette : commandes fixes (non modifiables pour l'instant), A/B ajoutés pour valider et revenir dans les menus.
- Les boutons Charger, Sauvegarder, Options sont sur une seule ligne pour que l'écran d'accueil tienne en 1280 × 720.

## Test
`SELFTEST OK`, aucune ligne `SCRIPT ERROR`. Le test utilise un dossier de sauvegardes et un fichier d'options à part. Images regardées (1280 × 720) : pause, panneau Sauvegarder, onglets Graphismes, Touches, Manette, affichage en jeu.

Non vérifié : une vraie manette, le plein écran réel, la sensation au clavier, le .exe.

## Remarqué sans y toucher
- `main.gd` active l'occlusion ambiante au niveau Ultra : le moteur « Compatibility » ne la gère pas et écrit un avertissement (déjà le cas avec F4).
- Les rappels de touches à l'écran citent toujours les touches d'origine, même après un changement dans les options.
