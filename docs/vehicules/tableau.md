# Tableau récapitulatif des véhicules

Les 45 fiches du dossier `docs/vehicules/`, avec leurs chiffres côte à côte pour vérifier la cohérence d'ensemble. Une fiche et ce tableau doivent toujours dire la même chose : si un chiffre change, le changer aux deux endroits.

Unités : mètres, kilogrammes, km/h (et m/s pour le code), m/s². Références déjà dans le jeu : la moto de zémidjan reprend les réglages de `scripts/moto.gd` (94 km/h, 18 m/s², frein 20 m/s²) et la berline récente ceux de `scripts/car.gd` (122 km/h, 16 m/s², frein 30 m/s²).

## 1. Dimensions, masse et performances

### Deux-roues et charrette
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Moto de zémidjan | `moto_zemidjan.md` | 1,90 | 0,80 | 1,10 | 110 | 94 | 26,1 | 18 | 20 | 2,2 | 5/5 |
| Moto de ville | `moto_de_ville.md` | 2,00 | 0,80 | 1,10 | 140 | 112 | 31,1 | 20 | 22 | 2,5 | 4/5 |
| Scooter | `scooter.md` | 1,80 | 0,70 | 1,15 | 100 | 80 | 22,2 | 15 | 18 | 1,9 | 5/5 |
| Moto tout-terrain | `moto_tout_terrain.md` | 2,10 | 0,85 | 1,25 | 120 | 105 | 29,2 | 21 | 20 | 2,4 | 4/5 |
| Moto de police | `moto_de_police.md` | 2,15 | 0,85 | 1,35 | 190 | 125 | 34,7 | 20 | 24 | 2,6 | 4/5 |
| Vélo | `velo.md` | 1,75 | 0,60 | 1,05 | 14 | 25 | 6,9 | 4 | 8 | 1,6 | 5/5 |
| Charrette à bras (pousse-pousse) | `charrette_a_bras.md` | 2,40 | 1,20 | 1,00 | 90 | 7 | 1,9 | 1,5 | 3 | 1,5 | 3/5 |

### Tricycles
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Tricycle de livraison | `tricycle_de_livraison.md` | 3,30 | 1,30 | 1,45 | 380 | 62 | 17,2 | 9 | 14 | 3,0 | 3/5 |
| Tricycle taxi | `tricycle_taxi.md` | 2,80 | 1,35 | 1,75 | 360 | 58 | 16,1 | 9 | 14 | 2,8 | 4/5 |

### Voitures
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Taxi jaune | `taxi_jaune.md` | 4,40 | 1,75 | 1,45 | 1 150 | 110 | 30,6 | 13 | 30 | 5,2 | 3/5 |
| Berline ancienne | `berline_ancienne.md` | 4,50 | 1,72 | 1,42 | 1 200 | 108 | 30,0 | 12 | 26 | 5,3 | 3/5 |
| Berline récente | `berline_recente.md` | 4,60 | 1,80 | 1,45 | 1 350 | 122 | 33,9 | 16 | 30 | 5,4 | 4/5 |
| Petite citadine | `petite_citadine.md` | 3,60 | 1,60 | 1,48 | 900 | 104 | 28,9 | 14 | 30 | 4,6 | 5/5 |
| Break familial | `break_familial.md` | 4,70 | 1,76 | 1,50 | 1 350 | 112 | 31,1 | 12,5 | 28 | 5,6 | 3/5 |
| 4x4 de ville | `quatre_quatre_de_ville.md` | 4,70 | 1,90 | 1,75 | 1 900 | 130 | 36,1 | 15 | 28 | 5,8 | 3/5 |
| 4x4 de brousse | `quatre_quatre_de_brousse.md` | 4,85 | 1,90 | 1,95 | 2 200 | 115 | 31,9 | 12 | 26 | 6,4 | 2/5 |
| Voiture officielle | `voiture_officielle.md` | 4,95 | 1,88 | 1,47 | 1 800 | 135 | 37,5 | 15 | 30 | 5,9 | 3/5 |
| Voiture de sport | `voiture_de_sport.md` | 4,30 | 1,90 | 1,22 | 1 300 | 165 | 45,8 | 22 | 34 | 5,5 | 5/5 |
| Coupé de luxe | `coupe_de_luxe.md` | 4,80 | 1,90 | 1,36 | 1 750 | 150 | 41,7 | 18 | 32 | 5,7 | 4/5 |
| Limousine | `limousine.md` | 7,50 | 1,90 | 1,50 | 2 700 | 105 | 29,2 | 8 | 24 | 9,5 | 1/5 |
| Voiture épave | `voiture_epave.md` | 4,40 | 1,70 | 1,25 | 800 | 0 | 0,0 | 0 | 0 | — | 0/5 |

### Pick-up, camionnette et minibus
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Pick-up bâché | `pick_up_bache.md` | 5,20 | 1,80 | 2,00 | 1 700 | 108 | 30,0 | 11,5 | 26 | 6,2 | 3/5 |
| Pick-up de chantier | `pick_up_de_chantier.md` | 5,20 | 1,80 | 1,80 | 1 750 | 105 | 29,2 | 11 | 26 | 6,2 | 3/5 |
| Camionnette de livraison | `camionnette_de_livraison.md` | 5,00 | 1,90 | 2,20 | 1 900 | 105 | 29,2 | 10 | 24 | 6,0 | 3/5 |
| Minibus tokpa-tokpa | `minibus_tokpa_tokpa.md` | 4,70 | 1,70 | 1,95 | 1 700 | 95 | 26,4 | 9 | 22 | 5,8 | 3/5 |
| Minibus de voyage | `minibus_de_voyage.md` | 5,40 | 1,90 | 2,30 | 2 300 | 105 | 29,2 | 8,5 | 22 | 6,6 | 2/5 |

### Bus et camions
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Bus de ville | `bus_de_ville.md` | 11,00 | 2,50 | 3,10 | 11 000 | 75 | 20,8 | 5 | 16 | 10,5 | 1/5 |
| Car inter-villes | `car_inter_villes.md` | 12,00 | 2,50 | 3,50 | 13 000 | 100 | 27,8 | 4,5 | 16 | 11,5 | 1/5 |
| Camion de marchandises | `camion_de_marchandises.md` | 8,50 | 2,45 | 3,40 | 7 500 | 85 | 23,6 | 5 | 15 | 9,0 | 1/5 |
| Camion-citerne | `camion_citerne.md` | 9,00 | 2,50 | 3,20 | 9 000 | 80 | 22,2 | 4,5 | 14 | 9,5 | 1/5 |
| Camion porte-conteneur | `camion_porte_conteneur.md` | 15,50 | 2,50 | 4,00 | 14 000 | 78 | 21,7 | 3,5 | 13 | 12,5 | 1/5 |
| Camion-benne | `camion_benne.md` | 7,50 | 2,45 | 3,10 | 11 000 | 80 | 22,2 | 4,5 | 14 | 8,5 | 1/5 |

### Police et secours
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Voiture de police | `voiture_de_police.md` | 4,60 | 1,80 | 1,60 | 1 450 | 135 | 37,5 | 17 | 32 | 5,4 | 4/5 |
| Pick-up de police | `pick_up_de_police.md` | 5,25 | 1,85 | 1,95 | 1 900 | 125 | 34,7 | 14 | 28 | 6,2 | 3/5 |
| Ambulance | `ambulance.md` | 5,40 | 1,95 | 2,50 | 2 400 | 120 | 33,3 | 11 | 26 | 6,3 | 3/5 |
| Camion de pompiers | `camion_de_pompiers.md` | 7,80 | 2,50 | 3,20 | 12 000 | 90 | 25,0 | 5,5 | 16 | 8,8 | 1/5 |

### Engins
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Engin de chantier | `engin_de_chantier.md` | 5,90 | 2,30 | 3,50 | 8 000 | 35 | 9,7 | 3 | 10 | 4,5 | 2/5 |
| Chariot élévateur du port | `chariot_elevateur_du_port.md` | 3,60 | 1,50 | 2,40 | 4 500 | 22 | 6,1 | 4 | 10 | 2,4 | 5/5 |

### Bateaux
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Pirogue | `pirogue.md` | 7,00 | 1,00 | 0,60 | 150 | 7 | 1,9 | 1 | 1,5 | 4,0 | 4/5 |
| Barque à moteur | `barque_a_moteur.md` | 8,50 | 1,40 | 0,90 | 350 | 32 | 8,9 | 3 | 3 | 8,0 | 3/5 |
| Bateau de pêche | `bateau_de_peche.md` | 14,00 | 2,60 | 1,80 | 3 500 | 22 | 6,1 | 1,5 | 1,5 | 20,0 | 1/5 |
| Vedette rapide | `vedette_rapide.md` | 9,50 | 2,80 | 2,60 | 4 000 | 70 | 19,4 | 6 | 5 | 14,0 | 4/5 |

### Aériens (non pilotables, décision 56)
| Véhicule | Fiche | Long. | Larg. | Haut. | Masse à vide | V. max | V. max (m/s) | Accél. | Frein | Rayon de braquage | Maniabilité |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Avion de ligne régional | `avion_de_ligne_regional.md` | 27,00 | 27,00 | 7,60 | 13 000 | 500 | 138,9 | 2,5 | 3 | 20,0 | 1/5 |
| Petit avion | `petit_avion.md` | 8,30 | 11,00 | 2,70 | 800 | 220 | 61,1 | 2,5 | 3 | 10,0 | 1/5 |
| Hélicoptère | `helicoptere.md` | 10,50 | 2,00 | 3,30 | 1 500 | 220 | 61,1 | 4 | 4 | — | 5/5 |

Pour les trois appareils aériens, la « largeur » est l'envergure (ou la largeur aux patins pour l'hélicoptère) et la vitesse est celle de croisière, jamais montrée en entier.

## 2. Jeu : places, solidité, usage, budget

Solidité = nombre par lequel on multiplie les dégâts reçus (1,00 = voiture de référence ; plus c'est petit, plus c'est solide). Poids de tirage = part relative dans la circulation routière tirée au hasard (0 = placé à la main).

### Deux-roues et charrette
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Moto de zémidjan | T2023 | 2 | 1,00 | oui | 38 | 5 000 / 2 500 / 750 | Moto, zémidjan (avec conducteur) | `moto_petite` |
| Moto de ville | T2033 | 2 | 1,00 | oui | 6 | 5 000 / 2 500 / 750 | Moto, zémidjan (avec conducteur) | `moto_grosse` |
| Scooter | T2043 | 2 | 1,10 | oui | 5 | 5 000 / 2 500 / 750 | Moto, zémidjan (avec conducteur) | `scooter` |
| Moto tout-terrain | T2053 | 2 | 0,90 | oui | 2 | 5 000 / 2 500 / 750 | Moto, zémidjan (avec conducteur) | `moto_grosse` |
| Moto de police | T2283 | 2 | 0,80 | non | 1 | 5 000 / 2 500 / 750 | Moto, zémidjan (avec conducteur) | `moto_grosse` |
| Vélo | T2353 | 1 | 1,00 | missions | 2 | 1 200 / 600 / 180 | Moto, zémidjan (avec conducteur) | — |
| Charrette à bras (pousse-pousse) | T2363 | 0 | 0,70 | missions | 2 | 900 / 450 / 140 | Moto, zémidjan (avec conducteur) | — |

### Tricycles
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Tricycle de livraison | T2063 | 1 | 1,00 | oui | 6 | 6 000 / 3 000 / 900 | Voiture, taxi | `tricycle` |
| Tricycle taxi | T2073 | 4 | 1,10 | oui | 3 | 6 500 / 3 250 / 980 | Voiture, taxi | `tricycle` |

### Voitures
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Taxi jaune | T2083 | 5 | 1,00 | oui | 9 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_ancienne` |
| Berline ancienne | T2093 | 5 | 1,10 | oui | 8 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_ancienne` |
| Berline récente | T2103 | 5 | 1,00 | oui | 6 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_recente` |
| Petite citadine | T2113 | 4 | 1,20 | oui | 4 | 7 000 / 3 500 / 1 050 | Voiture, taxi | `voiture_recente` |
| Break familial | T2123 | 5 | 1,00 | oui | 3 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_ancienne` |
| 4x4 de ville | T2133 | 5 | 0,80 | oui | 3 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `diesel_leger` |
| 4x4 de brousse | T2143 | 5 | 0,65 | oui | 2 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `diesel_leger` |
| Voiture officielle | T2313 | 5 | 0,85 | non | 1 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_recente` |
| Voiture de sport | T2323 | 2 | 1,20 | oui | 0,3 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `sport` |
| Coupé de luxe | T2333 | 4 | 1,00 | oui | 0,5 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `sport` |
| Limousine | T2343 | 10 | 0,90 | missions | 0,2 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_recente` |
| Voiture épave | T2463 | 0 | — | non | 0 | 4 000 / 2 000 / 600 | Voiture, taxi | — |

### Pick-up, camionnette et minibus
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Pick-up bâché | T2153 | 3 | 0,80 | oui | 3 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `diesel_leger` |
| Pick-up de chantier | T2163 | 5 | 0,75 | oui | 2 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `diesel_leger` |
| Camionnette de livraison | T2213 | 3 | 0,85 | oui | 3 | 8 500 / 4 250 / 1 280 | Bus, camion | `diesel_leger` |
| Minibus tokpa-tokpa | T2173 | 15 | 0,90 | oui | 4 | 9 000 / 4 500 / 1 350 | Bus, camion | `diesel_leger` |
| Minibus de voyage | T2183 | 18 | 0,85 | oui | 1,5 | 9 500 / 4 750 / 1 420 | Bus, camion | `diesel_leger` |

### Bus et camions
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Bus de ville | T2193 | 31 | 0,40 | non | 1 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |
| Car inter-villes | T2203 | 52 | 0,40 | non | 0,5 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |
| Camion de marchandises | T2223 | 3 | 0,40 | oui | 2 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |
| Camion-citerne | T2233 | 2 | 0,40 | missions | 1 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |
| Camion porte-conteneur | T2243 | 2 | 0,35 | missions | 1,5 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |
| Camion-benne | T2253 | 2 | 0,35 | missions | 1,5 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |

### Police et secours
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Voiture de police | T2263 | 4 | 0,80 | non | 1 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `voiture_recente` |
| Pick-up de police | T2273 | 5 | 0,70 | non | 1 | 8 000 / 4 000 / 1 200 | Voiture, taxi | `diesel_leger` |
| Ambulance | T2293 | 4 | 0,85 | non | 0,5 | 9 000 / 4 500 / 1 350 | Bus, camion | `diesel_leger` |
| Camion de pompiers | T2303 | 6 | 0,35 | non | 0,3 | 10 000 / 5 000 / 1 500 | Bus, camion | `diesel_lourd` |

### Engins
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Engin de chantier | T2443 | 1 | 0,30 | missions | 0,3 | 10 000 / 5 000 / 1 500 | Bus, camion | `engin` |
| Chariot élévateur du port | T2453 | 1 | 0,50 | missions | 0 | 6 000 / 3 000 / 900 | Voiture, taxi | `engin` |

### Bateaux
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Pirogue | T2373 | 6 | 1,00 | oui | 0 | 3 000 / 1 500 / 450 | Pirogue, petit bateau | — |
| Barque à moteur | T2383 | 9 | 1,00 | oui | 0 | 3 000 / 1 500 / 450 | Pirogue, petit bateau | `hors_bord` |
| Bateau de pêche | T2393 | 12 | 0,50 | non | 0 | 3 000 / 1 500 / 450 | Pirogue, petit bateau | `hors_bord` |
| Vedette rapide | T2403 | 6 | 0,60 | non | 0 | 3 000 / 1 500 / 450 | Pirogue, petit bateau | `hors_bord_gros` |

### Aériens (non pilotables, décision 56)
| Véhicule | Tâche | Places | Solidité | Pilotable | Poids de tirage | Triangles (fin / 50 % / 15 %) | Ligne de budget | Famille de moteur (sons) |
|---|---|---|---|---|---|---|---|---|
| Avion de ligne régional | T2413 | 74 | — | non | 0 | 10 000 / 5 000 / 1 500 | Bus, camion | — |
| Petit avion | T2423 | 4 | — | non | 0 | 6 000 / 3 000 / 900 | Voiture, taxi | — |
| Hélicoptère | T2433 | 6 | — | non | 0 | 8 000 / 4 000 / 1 200 | Voiture, taxi | — |

Somme des poids de tirage : 126,1. Les deux-roues et tricycles pèsent 65, soit 52 % de la circulation : Cotonou est une ville de motos.

## 3. Vérifications de cohérence

Classement par vitesse maximale (véhicules terrestres et bateaux) :

Voiture de sport (165) > Coupé de luxe (150) > Voiture de police (135) > Voiture officielle (135) > 4x4 de ville (130) > Moto de police (125) > Pick-up de police (125) > Berline récente (122) > Ambulance (120) > 4x4 de brousse (115) > Moto de ville (112) > Break familial (112) > Taxi jaune (110) > Berline ancienne (108) > Pick-up bâché (108) > Moto tout-terrain (105) > Pick-up de chantier (105) > Limousine (105) > Minibus de voyage (105) > Camionnette de livraison (105) > Petite citadine (104) > Car inter-villes (100) > Minibus tokpa-tokpa (95) > Moto de zémidjan (94) > Camion de pompiers (90) > Camion de marchandises (85) > Scooter (80) > Camion-citerne (80) > Camion-benne (80) > Camion porte-conteneur (78) > Bus de ville (75) > Vedette rapide (70) > Tricycle de livraison (62) > Tricycle taxi (58) > Engin de chantier (35) > Barque à moteur (32) > Vélo (25) > Chariot élévateur du port (22) > Bateau de pêche (22) > Charrette à bras (pousse-pousse) (7) > Pirogue (7).

Classement par accélération au démarrage (m/s²) :

Voiture de sport (22) > Moto tout-terrain (21) > Moto de ville (20) > Moto de police (20) > Moto de zémidjan (18) > Coupé de luxe (18) > Voiture de police (17) > Berline récente (16) > Scooter (15) > 4x4 de ville (15) > Voiture officielle (15) > Petite citadine (14) > Pick-up de police (14) > Taxi jaune (13) > Break familial (12,5) > Berline ancienne (12) > 4x4 de brousse (12) > Pick-up bâché (11,5) > Pick-up de chantier (11) > Ambulance (11) > Camionnette de livraison (10) > Tricycle de livraison (9) > Tricycle taxi (9) > Minibus tokpa-tokpa (9) > Minibus de voyage (8,5) > Limousine (8) > Vedette rapide (6) > Camion de pompiers (5,5) > Bus de ville (5) > Camion de marchandises (5) > Car inter-villes (4,5) > Camion-citerne (4,5) > Camion-benne (4,5) > Vélo (4) > Chariot élévateur du port (4) > Camion porte-conteneur (3,5) > Engin de chantier (3) > Barque à moteur (3) > Charrette à bras (pousse-pousse) (1,5) > Bateau de pêche (1,5) > Pirogue (1).

- Vérifié : La moto de zémidjan et la berline récente gardent exactement les chiffres déjà testés dans le jeu.
- Vérifié : Une moto démarre plus vite qu'une voiture courante mais plafonne plus bas (la moto gagne en ville, la voiture sur boulevard).
- Vérifié : La voiture de police est plus rapide que toutes les voitures courantes du joueur ; seuls le coupé de luxe et la voiture de sport (fin de jeu) la dépassent.
- Vérifié : La moto de police est plus rapide que toutes les motos du joueur.
- Vérifié : La vedette de police est plus rapide que la barque à moteur du joueur.
- Vérifié : Plus un véhicule est lourd, plus il est solide : aucun véhicule de plus de 5 000 kg n'a une solidité supérieure à 0,50.
- Vérifié : Aucun véhicule de plus de 5 000 kg n'accélère à plus de 6 m/s² ni ne dépasse 100 km/h (hors avion).
- Vérifié : Tous les véhicules larges de plus de 2,0 m sont des poids lourds, des bateaux ou des aéronefs : ils ne circulent que sur les voies de 3,5 m.
- Vérifié : Tous les deux-roues font 0,85 m de large au plus : ils passent dans le couloir de 1,4 m entre deux voitures (décision 61).
- Vérifié : Les tricycles (1,30 et 1,35 m) ne passent pas dans ce couloir mais passent dans 1,7 m.
- Vérifié : Chaque fiche respecte le plafond de triangles de sa ligne, et son niveau à 15 % respecte le plafond « vu de loin ».
- Vérifié : Aucune hauteur de véhicule routier ne dépasse 4,00 m : le tablier des ponts et les portiques doivent laisser 4,50 m libres.

Ces vérifications ont été calculées sur les chiffres du tableau au moment de l'écriture ; les refaire si un chiffre change.

## 4. Budget d'une image

Estimation au niveau « Bas » (250 000 triangles visibles), avec les niveaux allégés : un carrefour chargé de 30 zémidjans au niveau 2 (750 chacun), 10 voitures au niveau 2 (1 200), 2 minibus (1 350), 1 camion (1 500), plus 4 véhicules proches en détail fin (2 motos, 1 taxi, 1 minibus : 27 000) = environ 66 000 triangles de véhicules, soit un peu plus du quart du budget. C'est le maximum à viser ; au-delà, réduire le nombre de véhicules proches affichés en détail fin.

## 5. Familles de sons de moteur
| Famille | Véhicules qui la partagent |
|---|---|
| `moto_petite` : petit monocylindre de moto, aigu et saccadé | Moto de zémidjan |
| `moto_grosse` : moto plus grave et plus ronde | Moto de ville, Moto tout-terrain, Moto de police |
| `scooter` : bourdonnement continu de scooter à variateur | Scooter |
| `tricycle` : monocylindre poussif, pétaradant | Tricycle de livraison, Tricycle taxi |
| `voiture_ancienne` : moteur à essence fatigué, léger cliquetis | Taxi jaune, Berline ancienne, Break familial |
| `voiture_recente` : moteur à essence discret | Berline récente, Petite citadine, Voiture de police, Voiture officielle, Limousine |
| `diesel_leger` : diesel de camionnette, claquant au ralenti | 4x4 de ville, 4x4 de brousse, Pick-up bâché, Pick-up de chantier, Pick-up de police, Minibus tokpa-tokpa, Minibus de voyage, Camionnette de livraison, Ambulance |
| `sport` : moteur rauque qui monte haut dans les tours | Voiture de sport, Coupé de luxe |
| `diesel_lourd` : gros diesel grave, avec sifflement de turbo | Bus de ville, Car inter-villes, Camion de marchandises, Camion-citerne, Camion porte-conteneur, Camion-benne, Camion de pompiers |
| `engin` : diesel lent d'engin, régime presque constant | Engin de chantier, Chariot élévateur du port |
| `hors_bord` : petit hors-bord deux-temps nasillard | Barque à moteur, Bateau de pêche |
| `hors_bord_gros` : deux gros hors-bord, grondement grave | Vedette rapide |

12 familles de moteur × 4 fichiers = 48 sons de moteur pour 38 véhicules. Sans moteur : vélo, charrette, pirogue, épave. Sons propres : avion régional, petit avion, hélicoptère. Trois klaxons seulement (`bruit_klaxon_moto.ogg`, `bruit_klaxon_voiture.ogg`, `bruit_klaxon_camion.ogg`), plus ceux du minibus de voyage, du car et du cortège de mariage. Sirènes distinctes : police (voiture, pick-up et version courte de la moto), ambulance, pompiers, corne de la vedette.

## 6. Choix faits par l'agent de rédaction (modifiables)

- Les chiffres de vitesse et d'accélération sont des réglages de jeu « arcade », à la même échelle que la moto et la voiture déjà testées ; ce ne sont pas des valeurs réelles (une vraie voiture n'atteint pas 100 km/h en 2 secondes).
- Les dimensions des fiches sont celles du modèle 3D. Le gabarit de collision simplifié de `docs/monde.md` (voiture 2,0 × 4,4 m, moto 0,8 × 1,8 m) reste valable pour la circulation tant que chaque véhicule n'a pas sa propre boîte.
- Solidité : un seul nombre par véhicule, qui multiplie les dégâts du barème validé le 16 novembre. Rien d'autre à coder.
- Pilotable : la liste de la décision 55 est appliquée telle quelle. Les véhicules de police, l'ambulance, les pompiers et la voiture officielle sont réservés à l'IA. Vélo, charrette, engin de chantier, chariot élévateur et limousine ne sont utilisables que dans des missions précises. Avions et hélicoptère ne sont jamais pilotables (décision 56).
- L'hélicoptère de police en poursuite et le pick-up en renfort sont proposés pour les étoiles 4 et 5, dont le détail reste à valider par Bravo (décision 73). Sans validation, ils restent du décor.
- Budget de polygones des véhicules absents du tableau du style : avion régional et engin de chantier sur la ligne « bus, camion » ; petit avion, hélicoptère, tricycles, chariot élévateur et épave sur la ligne « voiture, taxi » (avec des cibles plus basses) ; vélo et charrette sur la ligne « moto », cycliste ou pousseur compris ; bateau de pêche et vedette sur la ligne « pirogue, petit bateau ».
- Avant des modèles vers +Z, parce que `scripts/car.gd` calcule la marche avant ainsi.
- Noms inventés utilisés dans les fiches (à remplacer si un autre document du projet fixe la liste des marques fictives) : « Bus Littoral », « Air Littoral », « Pétro-Littoral », « Travaux du Littoral », « Étoile du Nord », « Trans-Nokoué », « Pain Doré du Littoral ». Devises peintes : toutes neutres et sans référence religieuse (décision 18).
- Emblème des secours : croix verte simple, inventée, pour ne reprendre aucun emblème protégé. Police : bleu nuit et blanc, d'après l'uniforme de la décision 45.
- Aucune recherche sur le web n'a été faite : pas de source à citer. Aucune marque, aucun modèle réel n'est nommé.
