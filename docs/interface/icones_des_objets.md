# Icônes des objets

- Tâche : T5247 (« Créer les icônes des objets »).
- Fichiers : `icones/objet_<nom>.svg` (29 icônes).
- Couleurs et règles générales : `charte.md`.

Icônes des objets que Koffi achète, ramasse, transporte ou voit dans l'interface (`boutique.md`, `journal_de_missions.md`, `telephone.md`, bilans de mission). Dessins originaux et génériques : aucune marque, aucun billet ni pièce réels.

| Fichier | Famille | Usage |
|---|---|---|
| `icones/objet_argent.svg` | Argent | Billets en FCFA : récompense, prix, ramassage d'argent. |
| `icones/objet_piece.svg` | Argent | Pièce : petites sommes, monnaie rendue, marchandage. |
| `icones/objet_paiement_mobile.svg` | Argent | Paiement mobile fictif KwabôPay (à partir du chapitre 2). |
| `icones/objet_recu.svg` | Argent | Reçu ou reconnaissance de dette (dette envers Tonton Gratien, amende). |
| `icones/objet_sante.svg` | Santé | Santé du héros ; objet qui rend de la santé. |
| `icones/objet_medicaments.svg` | Santé | Boîte de médicaments (livraisons du chapitre 3, soins). |
| `icones/objet_beignets.svg` | Nourriture | Beignets de Maman Koffi : +10 de santé. |
| `icones/objet_bouillie.svg` | Nourriture | Bol de bouillie : +15 de santé. |
| `icones/objet_plat.svg` | Nourriture | Plat de maquis (riz et sauce) : +40 de santé. |
| `icones/objet_eau.svg` | Nourriture | Sachet d'eau : +5 de santé. |
| `icones/objet_carburant.svg` | Véhicule | Jauge de carburant et plein. |
| `icones/objet_bidon_kpayo.svg` | Véhicule | Bonbonne de kpayo (essence de contrebande) : plein moins cher, risque de panne. |
| `icones/objet_jerrican.svg` | Véhicule | Jerrican d'essence de station : plein de secours. |
| `icones/objet_piece_detachee.svg` | Véhicule | Pièce détachée de Missèbo : réparation, amélioration. |
| `icones/objet_pneu.svg` | Véhicule | Pneu : amélioration de l'adhérence, crevaison. |
| `icones/objet_outils.svg` | Véhicule | Caisse à outils : réparation sur place, dépannage. |
| `icones/objet_cle.svg` | Véhicule | Clé d'un véhicule ou d'une propriété achetée. |
| `icones/objet_casque.svg` | Équipement | Casque de moto (porté automatiquement). |
| `icones/objet_maillot.svg` | Équipement | Tenue de Koffi (le maillot vert du chapitre 1) ; vêtement acheté. |
| `icones/objet_telephone.svg` | Équipement | Téléphone de Koffi : appels, messages, paiement mobile. |
| `icones/objet_appareil_photo.svg` | Équipement | Mode photo. |
| `icones/objet_baton.svg` | Bagarre | Bâton ramassé (objet de bagarre, décision 78). |
| `icones/objet_planche.svg` | Bagarre | Planche ramassée (objet de bagarre, décision 78). |
| `icones/objet_colis.svg` | Marchandises | Colis à livrer. |
| `icones/objet_tissu.svg` | Marchandises | Rouleau de tissu de Nan Akouavi (motif inventé). |
| `icones/objet_vivres.svg` | Marchandises | Sac de vivres (riz, maïs) : livraisons du chapitre 3. |
| `icones/objet_faux_papiers.svg` | Marchandises | Faux papiers (trafic du jeu, décision 5). |
| `icones/objet_etoile_recherche.svg` | Affichage | Étoile du niveau de recherche (1 à 5). |
| `icones/objet_chrono.svg` | Affichage | Temps restant d'une livraison ou d'une course chronométrée. |

## Règles de dessin
- Boîte de 64 × 64 (`viewBox="0 0 64 64"`), sans fond : l'icône se pose sur une tuile `3a2516` ou sur un panneau. Affichage : 40 × 40 en liste, 32 × 32 dans une ligne de texte, 112 × 112 en fiche d'article.
- Style du jeu : aplats, pas de dégradé, pas de texture, 3 couleurs vives au plus par icône (règle de `docs/style_graphique.md`), couleurs prises dans la palette.
- Pas de contour général ; un contour seulement quand l'objet est clair sur clair (reçu, médicaments, faux papiers) ou doit ressortir partout (étoile de recherche).
- Aucun texte dans les icônes (la police n'est pas garantie dans un SVG) : billets et pièces sans valeur écrite, papiers avec des lignes grises.
- Médicaments : croix verte. Bagarre : seulement bâton et planche (décision 78), aucune arme.
- Les effets cités (santé rendue) sont ceux proposés dans `boutique.md`.
