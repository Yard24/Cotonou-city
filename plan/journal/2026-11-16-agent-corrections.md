# 16 novembre 2026 — agent « corrections » (branche agent-corrections)

`plan/taches.csv` n'est pas modifié par cet agent : les statuts sont à reporter par le coordinateur.

## Partie 1 — décisions de Bravo de ce matin
- **M pour accepter une course**, E ne fait plus que monter et descendre. Les touches du jeu sont repérées par leur place (ZQSD) ; pour M : la place du M AZERTY (point-virgule QWERTY) et la touche qui écrit « m » (QWERTY). M avec un client à bord le dépose ; E avec un client : pilote et client descendent, course non payée. Textes de l'écran d'accueil et du bas d'écran mis à jour.
- **Missions à 5 000, 7 500 et 3 000 FCFA.**
- **Inclinaison réaliste de la moto** : angle d'équilibre réel (tangente = v² ÷ (rayon × 9,81)), plafond 38° ; caméra 8° (extérieure) et 20° (guidon). Mise sur l'angle à 90°/s. Pas de chute sans collision, caméra qui penche : confirmés.
- T0060, T0092, T0115 : fermeture acceptée ; consigne « c'est oui, on avance » notée.

## Partie 2 — monter et descendre des véhicules
Tâches terminées et testées : T0116, T0119, T0120, T0121, T0122, T0125, T0126, T0127, T0128, T0130, T0131, T0132, T0133, T0134, T0135, T0136. Voitures et moto garées à contresens : corrigées.
Non fait : T0138 (attend l'essai de Bravo, T0137) ; T5252 (P3, mesure de performance).

## Changements de comportement à connaître
- La moto tourne nettement moins court à vitesse élevée (29 m de rayon à 54 km/h) : il faut ralentir avant un carrefour. Reculer pour se dégager d'un mur prend 2,5 s au lieu de 1,2 s.
- On n'emprunte plus une voiture de la circulation lancée : il faut l'arrêter en se mettant devant.
- E au-dessus de 22 km/h ne fait plus « rien » : c'est un saut en marche.
- La voiture rouge du départ et la moto de Romaric sont tournées vers le sud (elles étaient à contresens).

## Test automatique
`SELFTEST OK`, aucune ligne `SCRIPT ERROR`. Le nouveau test est enchaîné à la fin de `selftest_moto_ville.gd` pour ne pas toucher `selftest.gd`.

Non vérifié : aucune image regardée (portières, angle de la moto) ; la sensation au clavier ; la touche M sur un vrai clavier AZERTY sous Windows (vérifiée par le calcul des touches seulement) ; la fabrication du .exe.

## À confirmer par Bravo
- La moto ainsi assagie convient-elle, ou faut-il la rendre plus vive quitte à tricher un peu sur l'angle ?
- Coût du saut en marche, délai côté passager, proportion de voitures fermées à clé.
