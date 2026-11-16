# Icônes de la carte

- Tâche : T5246 (« Créer les icônes de la carte »).
- Fichiers : `icones/carte_<nom>.svg` (30 icônes).
- Couleurs et règles générales : `charte.md`.

Icônes de la mini-carte et de la grande carte (`grande_carte.md`). Dessins originaux et génériques : aucun logo, aucune marque, aucun emblème réel.

| Fichier | Famille | Usage |
|---|---|---|
| `icones/carte_joueur.svg` | Repères | Position et direction de Koffi ; la pointe indique où il regarde. Tourne avec lui. |
| `icones/carte_mission_principale.svg` | Missions | Départ d'une mission de l'histoire. |
| `icones/carte_mission_secondaire.svg` | Missions | Départ d'une mission secondaire. |
| `icones/carte_personnage.svg` | Missions | Personnage qui attend Koffi (donneur de mission, rendez-vous). |
| `icones/carte_destination.svg` | Repères | Destination de la course ou de l'objectif en cours (la colonne bleue dans la rue). |
| `icones/carte_repere.svg` | Repères | Repère posé par le joueur sur la grande carte. |
| `icones/carte_domicile.svg` | Lieux de Koffi | Logement du héros : sauvegarde, garde-robe, repos. |
| `icones/carte_garage.svg` | Lieux de Koffi | Garage : réparer, faire le plein, améliorer, changer de véhicule. |
| `icones/carte_entrepot.svg` | Lieux de Koffi | Entrepôt ou siège de l'entreprise de Koffi. |
| `icones/carte_a_vendre.svg` | Lieux de Koffi | Propriété ou moto à acheter. |
| `icones/carte_vehicule.svg` | Lieux de Koffi | Dernier véhicule laissé par le joueur. |
| `icones/carte_boutique.svg` | Commerces | Boutique générale : vivres, carburant en bidon, équipement. |
| `icones/carte_vetements.svg` | Commerces | Boutique de vêtements (écran Garde-robe en mode achat). |
| `icones/carte_maquis.svg` | Commerces | Maquis ou vendeuse de rue : manger rend de la santé. |
| `icones/carte_coiffeur.svg` | Commerces | Salon de coiffure (métier jouable). |
| `icones/carte_marche.svg` | Commerces | Marché (Dantokpa, Missèbo) : étals et grossistes. |
| `icones/carte_banque.svg` | Commerces | Banque fictive : dépôt, retrait, prêt. |
| `icones/carte_station_service.svg` | Carburant | Station officielle : plein cher et sûr. |
| `icones/carte_kpayo.svg` | Carburant | Vendeur de kpayo : essence moins chère, risque pour le moteur. |
| `icones/carte_centre_de_sante.svg` | Services | Centre de santé : réveil après un évanouissement, soins. |
| `icones/carte_commissariat.svg` | Services | Commissariat : retour après une arrestation. |
| `icones/carte_police.svg` | Services | Patrouille qui recherche le joueur (mini-carte et grande carte). |
| `icones/carte_port.svg` | Transports | Port de Cotonou : missions de transit et de marchandises. |
| `icones/carte_aeroport.svg` | Transports | Aéroport : voyage rapide Cotonou-Parakou. |
| `icones/carte_embarcadere.svg` | Transports | Embarcadère : pirogue à moteur vers le village lacustre. |
| `icones/carte_client_zem.svg` | Travail | Client qui lève le bras pour une course de zémidjan. |
| `icones/carte_livraison.svg` | Travail | Livraison à prendre ou à déposer. |
| `icones/carte_course.svg` | Travail | Départ d'une course de motos (plage de Fidjrossè). |
| `icones/carte_depannage.svg` | Travail | Véhicule en panne à dépanner. |
| `icones/carte_objet_perdu.svg` | Travail | Zone de recherche d'un objet perdu. |

## Règles de dessin
- Boîte de 48 × 48 (`viewBox="0 0 48 48"`). Affichage : 32 × 32 sur la grande carte, 20 × 20 sur la mini-carte, 28 × 28 dans la légende, 40 × 40 dans le journal. Exporter en PNG 64 × 64 et 128 × 128 pour Godot, ou importer le SVG tel quel.
- Forme = famille : carré arrondi (42 × 42, coins 10, bord 3) pour un lieu ; disque pour une mission ou un personnage ; goutte pour le repère ; flèche pour le joueur. La famille se lit donc sans la couleur.
- Couleur du fond par famille : lieux de Koffi terre `b5653a` ; commerces bleu `2a86b5` ; station verte `008751` ; kpayo jaune `f2c200` ; centre de santé vert `1f8a3a` ; police bleu nuit `1e2a33` ; transports gris-bleu `3c4b57` ; travail jaune `fcd116` ; missions or `f5c400`.
- Pictogramme crème `f4f1ea` sur fond foncé (bord crème), brun `140a05` sur fond jaune ou or (bord brun). Traits de 2,5 à 3,5 au moins : lisible à 20 px.
- Centre de santé : croix blanche sur fond vert, jamais de croix rouge sur fond blanc (emblème protégé). Commissariat : écusson sans inscription (décision 45). Station et banque : aucune enseigne.
- Pour une mission principale, le jeu peut remplacer le point d'exclamation par l'initiale du personnage (Barlow Condensed Bold 26, brun, centrée) : R pour Romaric, N pour Nan Akouavi, etc.
- Familles et filtres de la carte : voir le tableau « Filtres et icônes » de `grande_carte.md`.
