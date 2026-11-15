import csv, json, collections
C, T, N = "Claude", "Toi", "—"
rows = []
def add(phase, domaine, lot, tache, r=C, a=C, c=N, i=T, prio="P2"):
    rows.append([phase, domaine, lot, tache, r, a, c, i, prio])

# ---------------- Phase 0 : fondations ----------------
P0 = "0. Fondations"
for t in ["Créer le dépôt GitHub privé vide Yard24/cotonou-city", "Tester le jeu sur plusieurs PC et noter les images par seconde",
          "Ouvrir un compte Meshy et choisir un abonnement", "Ouvrir un compte ElevenLabs et choisir un abonnement", "Ouvrir un compte de génération musicale et choisir un abonnement",
          "Créer les clés API Meshy et ElevenLabs", "Déposer les clés API dans le coffre Supabase", "Fixer le budget mensuel du projet",
          "Choisir le nom définitif du jeu", "Valider le ton du jeu (humour, réalisme, niveau de violence)", "Valider le héros (nom, origine, caractère)"]:
    add(P0, "Démarrage", "À faire par toi", t, T, T, C, N, "P1")
for t in ["Attacher le dépôt à la session et pousser le plan", "Créer le projet Godot 4 vide (structure des dossiers)", "Définir les conventions de nommage des fichiers",
          "Configurer Git LFS pour les gros fichiers", "Écrire le README du projet", "Mettre en place les tests automatiques sans écran", "Mettre en place la fabrication automatique du .exe Windows",
          "Créer le projet Supabase du jeu (coffre de clés)", "Écrire la fonction de génération 3D par API", "Écrire la fonction de génération de voix par API",
          "Programmer la tâche de nuit", "Créer le modèle de compte rendu du matin", "Porter le prototype web vers Godot", "Écrire le document de référence (histoire, carte, style)",
          "Définir le style graphique (low-poly coloré) et la palette", "Définir le budget de polygones par type d'objet", "Définir l'échelle du monde (mètres, taille de la carte)",
          "Tracer la carte générale de Cotonou à partir de cartes publiques", "Découper la carte en zones chargées progressivement", "Définir l'ordre de construction des quartiers"]:
    add(P0, "Démarrage", "Mise en place", t, C, C, N, T, "P1")

# ---------------- Phase 1 : systèmes de jeu ----------------
P1 = "1. Systèmes de jeu"
SYS = {
 "Joueur à pied": "marche;course;saut;position accroupie;nage;chute et dégâts;franchissement de muret;caméra à la troisième personne;interaction avec les objets",
 "Conduite voiture": "accélération et freinage;direction;frein à main;marche arrière;suspension;collisions;dégâts visibles;phares et clignotants;klaxon;caméra de conduite",
 "Conduite moto": "équilibre et inclinaison;accélération;freinage;chute du pilote;passager à l'arrière;passage entre les voitures;caméra moto",
 "Monter et descendre des véhicules": "entrée côté conducteur;entrée côté passager;sortie;saut en marche;emprunt d'un véhicule occupé;verrouillage des portes;animation des portes",
 "Circulation": "réseau de voies;feux tricolores;priorités aux carrefours;ronds-points;dépassements;embouteillages aux heures de pointe;réactions au klaxon;accidents entre véhicules;densité selon l'heure;apparition et disparition hors champ",
 "Service de zémidjan": "héler un zémidjan;négociation du prix;trajet en passager;paiement;travail comme zémidjan;clients qui hèlent;réputation du conducteur",
 "Taxis et transports": "taxi-ville;minibus tokpa-tokpa;bus;arrêts;tarifs;travail comme taxi",
 "Piétons": "déplacement sur les trottoirs;traversée de route;réactions au danger;conversations d'ambiance;foules de marché;routines selon l'heure;variété des tenues",
 "Police et niveau de recherche": "niveau de recherche;patrouilles;poursuite à pied;poursuite en voiture;barrages;arrestation;amende et sortie du commissariat;fin de recherche",
 "Combat": "coups de poing;esquive;armes de mêlée;visée;armes à feu;mise à couvert;santé et protection;réaction des passants",
 "Moteur de missions": "déclencheurs;objectifs;points de contrôle;échec et reprise;récompenses;cinématiques;missions chronométrées;missions de filature;missions de livraison;journal de missions",
 "Dialogues": "sous-titres;choix de réponses;lecture des voix;mouvement des lèvres simplifié;expressions fon élémentaires;historique",
 "Économie": "argent en FCFA;boutiques;prix des biens;revenus des activités;achat de propriétés;paiement mobile fictif;marchandage",
 "Téléphone du joueur": "contacts;appels entrants;messages;carte;appareil photo;réseau social fictif",
 "Carte et GPS": "mini-carte;grande carte;itinéraire;icônes de lieux;découverte progressive;repères personnels",
 "Sauvegarde": "sauvegarde manuelle;sauvegarde automatique;chargement;emplacements multiples;compatibilité entre versions",
 "Jour, nuit et météo": "soleil et ombres;nuit et éclairage public;saison des pluies;harmattan;rues inondées;coupures de courant",
 "Radio en voiture": "stations;changement de station;animateurs fictifs;publicités fictives;flash info lié à l'histoire",
 "Garage": "garage personnel;réparation;peinture;améliorations;carburant et stations-service;lavage",
 "Propriétés": "achat;point de sauvegarde;garde-robe;revenus",
 "Vêtements et apparence": "boutiques de tissus;tailleur;tenues traditionnelles;coiffure;accessoires",
 "Nourriture et santé": "maquis et restaurants;vendeuses de rue;effets sur la santé;hôpital et réanimation",
 "Activités annexes": "football de rue;courses de motos;pêche en lagune;livraison de marchandises;awalé;salle de sport;objets cachés à collecter",
 "Navigation sur l'eau": "pirogue;barque à moteur;lagune de Cotonou;lac Nokoué;noyade",
 "Avion et voyages": "aéroport de Cotonou;achat de billet;cinématique de vol;arrivée à Parakou;trajet routier entre villes;chargement des villes",
 "Groupes et réputation": "groupes fictifs;réputation par quartier;territoires;alliances",
 "Comportement des adversaires": "perception;mise à couvert;fuite;appel de renforts",
 "Physique du décor": "objets renversables;étals de marché;clôtures;lampadaires",
 "Caméra et cinématiques": "caméra libre;plans de cinématique;mode photo",
 "Affichage en jeu": "santé;argent;arme;notifications;indicateur de recherche",
 "Menus": "menu principal;pause;options graphiques;options audio;touches;manette",
 "Performance": "niveaux de détail;distance d'affichage;chargement progressif du monde;masquage des objets cachés;niveaux graphiques bas, moyen, élevé, ultra;ombres et éclairage de qualité;reflets et eau;mesure des images par seconde",
 "Langues": "français;anglais;structure de traduction",
 "Tutoriel": "déplacement;conduite;première mission;téléphone",
 "Statistiques et succès": "statistiques du joueur;succès;pourcentage de progression",
 "Outils de développement": "console de débogage;téléportation;tests automatiques;rapport de plantage",
}
CORE = {"Joueur à pied", "Conduite voiture", "Conduite moto", "Monter et descendre des véhicules", "Circulation", "Piétons", "Moteur de missions", "Sauvegarde", "Carte et GPS", "Affichage en jeu", "Menus", "Performance", "Outils de développement", "Dialogues"}
for s, comps in SYS.items():
    pr = "P1" if s in CORE else "P2"
    for comp in comps.split(";"):
        add(P1, s, comp, f"{s} — {comp} : décrire le fonctionnement attendu", C, T, T, N, pr)
        add(P1, s, comp, f"{s} — {comp} : coder", C, C, N, T, pr)
        add(P1, s, comp, f"{s} — {comp} : écrire et passer le test automatique", C, C, N, T, pr)
    add(P1, s, "Essai", f"{s} : jouer sur ton PC et donner ton avis", T, T, C, N, pr)
    add(P1, s, "Essai", f"{s} : corriger d'après tes retours", C, T, T, N, pr)

# ---------------- Phase 2 : monde ----------------
P2 = "2. Monde — Cotonou"
QUART = ["Ganhi", "Zone portuaire", "Placodji", "Xwlacodji", "Missèbo", "Dantokpa", "Jonquet", "Guinkomey", "Saint-Michel", "Gbégamey", "Zongo", "Sikècodji", "Wologuèdè",
         "Sainte-Rita", "Vodjè", "Cadjèhoun", "Haie Vive", "Les Cocotiers", "Zone de l'aéroport", "Aïbatin", "Houéyiho", "Fidjrossè", "Fiyégnon", "Agla", "Mènontin", "Kouhounou",
         "Vèdoko", "Zogbo", "Fifadji", "Gbèdjromèdé", "Vossa", "Ladji", "Ahouansori", "Agontinkon", "Akpakpa centre", "Sègbèya", "Sènadé", "Kpondéhou", "Midombo", "Dédokpo",
         "Ayélawadjè", "Avotrou", "Tanou", "PK3", "PK6", "Zone des ambassades"]
QP1 = {"Ganhi", "Dantokpa", "Zone des ambassades", "Missèbo"}
QSTEPS = ["relever le plan des rues à partir de cartes publiques", "tracer les routes et les carrefours", "poser les trottoirs et les caniveaux", "placer les îlots de bâtiments",
          "poser les bâtiments du quartier", "ajouter commerces et enseignes fictives", "ajouter végétation et mobilier de rue", "poser l'éclairage public",
          "placer les stationnements et les véhicules garés", "tracer les trajets de circulation", "placer les piétons et leurs routines", "poser les collisions",
          "mesurer la fluidité"]
for q in QUART:
    pr = "P1" if q in QP1 else "P2"
    for st in QSTEPS:
        add(P2, "Quartiers", q, f"{q} : {st}", C, C, N, T, pr)
    add(P2, "Quartiers", q, f"{q} : visiter en jeu et dire si on reconnaît le quartier", T, T, C, N, pr)

LIEUX = {"Cotonou": ["Place de l'Amazone", "Place de l'Étoile Rouge", "Place des Martyrs", "Place Lénine", "Place de Bulgarie", "Monument aux Dévoués", "Marché Dantokpa", "Marché Missèbo",
   "Marché de Ganhi", "Port de Cotonou", "Port de pêche", "Aéroport de Cotonou", "Stade de l'Amitié", "Palais des Congrès", "Boulevard de la Marina", "Ancien pont", "Nouveau pont",
   "Troisième pont", "Cathédrale Notre-Dame", "Grande mosquée de Zongo", "Hôpital universitaire (CNHU)", "Centre de promotion de l'artisanat", "Plage de Fidjrossè", "Route des Pêches",
   "Carrefour Cica-Toyota", "Carrefour Le Bélier", "Carrefour Saint-Michel", "Carrefour Vèdoko", "Carrefour des Trois Banques", "Échangeur de Godomey", "Jardin de Mathieu",
   "Berge de la lagune", "Embarcadère de Calavi vers Ganvié", "Gare ferroviaire", "Hall des Arts", "Champ de foire", "Stade René Pleven", "Esplanade de la plage", "Rue des pavés de Haie Vive", "Gare routière de Jonquet"],
 "Calavi": ["Université d'Abomey-Calavi", "Carrefour Kpota", "Marché de Calavi", "Village lacustre de Ganvié"],
 "Porto-Novo": ["Place de l'Assemblée", "Grande mosquée de Porto-Novo", "Musée Honmè", "Jardin des plantes", "Pont de Porto-Novo", "Marché Ouando"],
 "Ouidah": ["Porte du Non-Retour", "Temple des Pythons", "Route des Esclaves", "Fort portugais", "Basilique de Ouidah", "Plage de Ouidah"],
 "Parakou": ["Aéroport de Parakou", "Marché Arzèkè", "Place Bio Guéra", "Gare de Parakou"]}
LP1 = {"Place de l'Amazone", "Marché Dantokpa", "Boulevard de la Marina", "Port de Cotonou", "Place de l'Étoile Rouge", "Ancien pont"}
LSTEPS = [("rassembler des références publiques", C, C, T, N), ("fournir tes propres photos si tu en as", T, T, C, N), ("écrire la fiche descriptive", C, C, N, T),
          ("dessiner la version stylisée", C, T, T, N), ("générer le modèle 3D", C, C, N, T), ("nettoyer et alléger le modèle", C, C, N, T), ("importer dans Godot", C, C, N, T),
          ("poser les collisions et placer sur la carte", C, C, N, T), ("valider la ressemblance", T, T, C, N)]
for ville, ls in LIEUX.items():
    ph = P2 if ville == "Cotonou" else "3. Monde — autres villes"
    for l in ls:
        pr = "P1" if l in LP1 else ("P2" if ville == "Cotonou" else "P3")
        for st, r, a, c, i in LSTEPS:
            add(ph, "Lieux emblématiques", l, f"{l} ({ville}) : {st}", r, a, c, i, pr)

P3 = "3. Monde — autres villes"
VSTEPS = ["tracer le plan simplifié de la ville", "tracer la route d'accès depuis Cotonou", "poser les routes principales", "poser les bâtiments", "ajouter commerces et enseignes fictives",
          "ajouter végétation et mobilier", "poser l'éclairage", "tracer la circulation", "placer les piétons", "poser les collisions", "créer le point d'arrivée du joueur",
          "créer les lieux de mission", "régler le chargement de la ville", "mesurer la fluidité"]
for v in ["Abomey-Calavi", "Porto-Novo", "Ouidah", "Parakou", "Sèmè-Kpodji", "Route inter-villes"]:
    for st in VSTEPS:
        add(P3, "Villes", v, f"{v} : {st}", C, C, N, T, "P3")
    add(P3, "Villes", v, f"{v} : visiter en jeu et valider", T, T, C, N, "P3")

# ---------------- Phase 4 : contenus 3D ----------------
P4 = "4. Véhicules, personnages, animations"
VEH = ["Moto de zémidjan", "Moto de ville", "Scooter", "Moto tout-terrain", "Tricycle de livraison", "Tricycle taxi", "Taxi jaune", "Berline ancienne", "Berline récente", "Petite citadine",
       "Break familial", "4x4 de ville", "4x4 de brousse", "Pick-up bâché", "Pick-up de chantier", "Minibus tokpa-tokpa", "Minibus de voyage", "Bus de ville", "Car inter-villes",
       "Camionnette de livraison", "Camion de marchandises", "Camion-citerne", "Camion porte-conteneur", "Camion-benne", "Voiture de police", "Pick-up de police", "Moto de police",
       "Ambulance", "Camion de pompiers", "Voiture officielle", "Voiture de sport", "Coupé de luxe", "Limousine", "Vélo", "Charrette à bras (pousse-pousse)", "Pirogue", "Barque à moteur",
       "Bateau de pêche", "Vedette rapide", "Avion de ligne régional", "Petit avion", "Hélicoptère", "Engin de chantier", "Chariot élévateur du port", "Voiture épave"]
VP1 = {"Moto de zémidjan", "Taxi jaune", "Berline ancienne", "4x4 de ville", "Minibus tokpa-tokpa", "Voiture de police", "Pick-up bâché"}
VST = ["écrire la fiche (dimensions, vitesse, style)", "générer le modèle 3D", "nettoyer et alléger le modèle", "séparer roues, portes et vitres", "créer les variantes de couleur",
       "importer dans Godot", "régler la conduite", "ajouter les sons", "ajouter les dégâts", "tester en circulation"]
for v in VEH:
    for st in VST:
        add(P4, "Véhicules", v, f"{v} : {st}", C, C, N, T, "P1" if v in VP1 else "P2")

PERS = ["Héros", "Ami d'enfance du héros", "Mère du héros", "Oncle commerçant", "Patronne du marché", "Chef des zémidjans", "Homme d'affaires", "Transitaire du port", "Journaliste",
        "Animateur radio", "Influenceuse", "Chef de chantier", "Douanier", "Commissaire", "Policier", "Policière", "Agent de circulation", "Militaire", "Chef de bande rival",
        "Homme de main", "Receleur", "Avocate", "Médecin", "Infirmière", "Pasteur", "Imam", "Dignitaire vodoun", "Roi traditionnel fictif", "Député fictif", "Maire fictif",
        "Conducteur de zémidjan", "Chauffeur de taxi", "Chauffeur de camion", "Apprenti de minibus", "Vendeuse de marché", "Vendeuse de bouillie", "Vendeuse de pain", "Vendeur d'essence au bord de la route",
        "Vendeur ambulant", "Porteur du marché", "Pêcheur", "Piroguier", "Docker", "Mécanicien", "Vulcanisateur", "Tailleur", "Coiffeuse", "Étudiant", "Étudiante", "Écolier en uniforme kaki",
        "Professeur", "Fonctionnaire", "Employée de banque", "Agent de paiement mobile", "Gardien", "Serveuse de maquis", "Cuisinière", "Musicien", "Danseur", "Footballeur de rue",
        "Touriste", "Expatrié", "Femme en pagne", "Homme en bomba", "Jeune en tenue de ville", "Vieil homme", "Vieille femme", "Enfant", "Mendiant", "Sportif de la plage"]
PP1 = {"Héros", "Ami d'enfance du héros", "Patronne du marché", "Chef des zémidjans", "Conducteur de zémidjan", "Vendeuse de marché", "Policier", "Femme en pagne", "Jeune en tenue de ville", "Chauffeur de taxi"}
PST = ["écrire la fiche (apparence, tenue, caractère)", "générer le modèle 3D", "nettoyer le modèle", "poser le squelette d'animation", "créer les variantes de tenue",
       "importer dans Godot", "attribuer une voix", "tester en jeu"]
for p in PERS:
    for st in PST:
        add(P4, "Personnages", p, f"{p} : {st}", C, C, N, T, "P1" if p in PP1 else "P2")
    add(P4, "Personnages", p, f"{p} : valider l'apparence (réaliste pour le Bénin ?)", T, T, C, N, "P1" if p in PP1 else "P2")

ANIM = ["marche", "course", "sprint", "arrêt", "saut", "chute", "nage", "accroupi", "franchissement", "montée en voiture", "sortie de voiture", "conduite voiture", "montée à moto",
        "conduite moto", "passager moto", "chute de moto", "coup de poing", "esquive", "prise de coup", "KO", "relevé", "visée", "tir", "rechargement", "mise à couvert", "téléphone",
        "salutation", "poignée de main", "discussion debout", "discussion assis", "assis sur une moto à l'arrêt", "port de charge sur la tête", "port de carton", "poussée de charrette",
        "vente à l'étal", "marchandage", "paiement", "manger", "boire", "danse 1", "danse 2", "danse traditionnelle", "prière", "balayage", "pagayer", "pêche au filet", "héler un zémidjan",
        "traverser en courant", "peur", "fuite", "mains en l'air", "arrestation", "rire", "colère", "pleurs", "jeu de football", "réparation mécanique", "coiffure", "couture", "attente"]
for an in ANIM:
    add(P4, "Animations", an, f"Animation « {an} » : trouver ou créer", C, C, N, T)
    add(P4, "Animations", an, f"Animation « {an} » : adapter au squelette du jeu", C, C, N, T)
    add(P4, "Animations", an, f"Animation « {an} » : intégrer et tester", C, C, N, T)

OBJ = ["étal de marché", "parasol", "bassine", "sac de riz", "cageot de tomates", "bidon d'essence", "bouteilles d'essence au bord de la route", "table de vendeuse", "banc", "kiosque de paiement mobile",
       "kiosque à pain", "panneau publicitaire", "panneau de rue", "feu tricolore", "lampadaire", "poteau électrique", "poubelle", "borne-fontaine", "pneu", "tas de sable", "brouette",
       "conteneur", "palette", "filet de pêche", "pirogue échouée", "palmier", "cocotier", "manguier", "flamboyant", "haie", "clôture en tôle", "mur en parpaings", "portail", "cabane en tôle",
       "maison basse", "immeuble de 3 étages", "immeuble de bureaux", "villa", "boutique", "pharmacie", "station-service", "maquis", "bar", "école", "église de quartier", "mosquée de quartier",
       "atelier de mécanique", "atelier de couture", "salon de coiffure", "cybercafé"]
for o in OBJ:
    for st in ["générer le modèle 3D", "nettoyer et alléger", "importer et poser les collisions", "créer 3 variantes"]:
        add(P4, "Objets et bâtiments types", o, f"{o.capitalize()} : {st}", C, C, N, T, "P1" if OBJ.index(o) < 15 else "P2")

# ---------------- Phase 5 : histoire ----------------
P5 = "5. Histoire et missions"
CHAP = ["Ch.1 (2017) Le retour à Cotonou", "Ch.2 (2018-2019) Les affaires du marché", "Ch.3 (2020) La ville à l'arrêt", "Ch.4 (2021-2022) Les grands chantiers",
        "Ch.5 (2023-2024) La route du Nord", "Ch.6 (2025-2026) Le prix de la réussite"]
for t in ["Écrire le résumé général de l'histoire", "Écrire l'arc du héros", "Écrire la fiche de chaque personnage principal", "Définir les groupes fictifs et leurs intérêts",
          "Dresser la chronologie fictive 2017-2026", "Lister les thèmes de société abordés", "Vérifier qu'aucune personne ni aucun parti réel n'est nommé"]:
    add(P5, "Écriture générale", "Trame", t, C, T, T, N, "P1")
for t in ["Valider l'histoire générale", "Valider la fin du jeu", "Relire les passages sensibles (politique, religion)"]:
    add(P5, "Écriture générale", "Trame", t, T, T, C, N, "P1")
MST = [("écrire le synopsis", C, T, T, N), ("définir les objectifs et les conditions d'échec", C, C, N, T), ("écrire les dialogues en français", C, T, T, N),
       ("ajouter quelques expressions fon élémentaires", C, T, T, N), ("programmer le déroulement", C, C, N, T), ("placer les lieux et les personnages", C, C, N, T),
       ("monter la cinématique d'ouverture", C, C, N, T), ("produire les voix", C, T, T, N), ("intégrer les voix et les sous-titres", C, C, N, T),
       ("régler la difficulté et la récompense", C, C, T, N), ("écrire et passer le test automatique", C, C, N, T), ("jouer la mission sur ton PC", T, T, C, N),
       ("corriger d'après tes retours", C, T, T, N)]
for ci, ch in enumerate(CHAP):
    for m in range(1, 11):
        for st, r, a, c, i in MST:
            add(P5, ch, f"Mission {ci+1}.{m}", f"Mission principale {ci+1}.{m} : {st}", r, a, c, i, "P1" if ci == 0 and m <= 3 else "P2")
SEC = {"Zémidjan": 8, "Marché": 8, "Port": 6, "Lagune": 6, "Calavi": 4, "Porto-Novo": 4, "Ouidah": 2, "Parakou": 2}
for k, n in SEC.items():
    for m in range(1, n + 1):
        for st, r, a, c, i in MST:
            add(P5, "Missions secondaires", f"{k} {m}", f"Mission secondaire {k} {m} : {st}", r, a, c, i, "P3")

# ---------------- Phase 6 : son ----------------
P6 = "6. Son, voix, musique"
SFX = ["moteur de moto", "moteur de voiture", "moteur de camion", "klaxon de moto", "klaxon de voiture", "klaxon de camion", "freinage", "dérapage", "choc de tôle", "vitre brisée",
       "portière", "démarrage", "pas sur goudron", "pas sur sable", "pas sur terre", "pas dans l'eau", "plongeon", "pagaie", "moteur de barque", "vagues", "pluie", "orage", "vent d'harmattan",
       "foule de marché", "cris de vendeuses", "appel du muezzin au loin", "cloches d'église", "chants de chorale au loin", "tam-tam au loin", "sifflet d'agent", "sirène de police",
       "sirène d'ambulance", "avion au décollage", "annonce d'aéroport", "sonnerie de téléphone", "notification", "pièces de monnaie", "paiement validé", "coup de poing", "chute", "tir",
       "rechargement", "générateur électrique", "coupure de courant", "télévision de maquis", "match de football à la radio", "friture", "pilon dans le mortier", "coq", "chiens la nuit",
       "grillons", "oiseaux du matin", "chantier", "port (grues et conteneurs)", "corne de bateau", "mission réussie", "mission échouée", "menu (clic)", "menu (retour)", "carte ouverte"]
for s in SFX:
    add(P6, "Bruitages", s, f"Bruitage « {s} » : produire ou trouver en licence libre", C, C, N, T)
    add(P6, "Bruitages", s, f"Bruitage « {s} » : nettoyer et normaliser", C, C, N, T)
    add(P6, "Bruitages", s, f"Bruitage « {s} » : intégrer en jeu", C, C, N, T)
RADIO = ["Radio afrobeat et musique urbaine", "Radio musique traditionnelle et tchinkoumé", "Radio zouk et rumba", "Radio gospel", "Radio info et débats", "Radio salsa et afro-cubain"]
for r_ in RADIO:
    add(P6, "Musique", r_, f"{r_} : écrire l'identité de la station", C, T, T, N)
    for k in range(1, 9):
        add(P6, "Musique", r_, f"{r_} : morceau {k} — écrire la consigne de style", C, C, N, T)
        add(P6, "Musique", r_, f"{r_} : morceau {k} — générer et choisir la meilleure version", C, T, T, N)
        add(P6, "Musique", r_, f"{r_} : morceau {k} — intégrer", C, C, N, T)
    add(P6, "Musique", r_, f"{r_} : écrire les interventions de l'animateur fictif", C, T, T, N)
    add(P6, "Musique", r_, f"{r_} : écouter et valider la station", T, T, C, N)
for t in ["Valider l'accent des voix françaises générées", "Valider la prononciation des expressions fon", "Vérifier les conditions d'usage commercial de chaque outil de génération"]:
    add(P6, "Voix et droits", "À faire par toi", t, T, T, C, N)
for t in ["Choisir une voix par personnage principal", "Générer les voix de foule en français", "Créer la musique du menu", "Créer les thèmes de mission", "Régler le mixage général", "Régler le son selon la distance"]:
    add(P6, "Voix et droits", "Production", t, C, T, T, N)

# ---------------- Phase 7 : interface ----------------
P7 = "7. Interface"
ECR = ["Écran titre", "Menu principal", "Nouvelle partie", "Chargement de partie", "Écran de chargement", "Menu pause", "Options graphiques", "Options audio", "Options de touches",
       "Grande carte", "Journal de missions", "Téléphone", "Boutique", "Garage", "Garde-robe", "Écran de mission réussie", "Écran de mission échouée", "Écran d'arrestation",
       "Écran d'hôpital", "Statistiques", "Succès", "Crédits", "Choix de la langue", "Mode photo", "Tutoriel à l'écran"]
for e in ECR:
    for st in ["dessiner la maquette", "coder", "rendre utilisable à la manette", "tester"]:
        add(P7, "Écrans", e, f"{e} : {st}", C, C, N, T, "P1" if ECR.index(e) < 6 else "P2")
for t in ["Créer le logo du jeu", "Choisir les polices", "Créer les icônes de la carte", "Créer les icônes des objets", "Créer l'image de couverture"]:
    add(P7, "Identité visuelle", "Création", t, C, T, T, N)

# ---------------- Phase 8 : qualité et sortie ----------------
P8 = "8. Qualité et sortie"
for s in SYS:
    add(P8, "Qualité", "Optimisation", f"{s} : mesurer le coût en performance et optimiser", C, C, N, T, "P3")
for q in QUART:
    add(P8, "Qualité", "Contrôle du monde", f"{q} : chercher les trous, objets flottants et murs invisibles", C, C, N, T, "P3")
for t in ["Jouer le chapitre 1 en entier et noter les problèmes", "Jouer le chapitre 2 en entier et noter les problèmes", "Jouer le chapitre 3 en entier et noter les problèmes",
          "Jouer le chapitre 4 en entier et noter les problèmes", "Jouer le chapitre 5 en entier et noter les problèmes", "Jouer le chapitre 6 en entier et noter les problèmes",
          "Faire tester le jeu par 5 personnes de ton entourage", "Tester sur un PC puissant et sur un PC modeste", "Décider du prix et du modèle de vente", "Créer le compte éditeur sur la boutique choisie",
          "Payer les frais d'inscription de la boutique", "Consulter un juriste sur les noms, lieux et musiques", "Décider de la structure juridique qui publie le jeu", "Valider la bande-annonce",
          "Annoncer le jeu sur tes réseaux", "Valider la version finale"]:
    add(P8, "Sortie", "À faire par toi", t, T, T, C, N, "P3")
for t in ["Corriger les problèmes du chapitre 1", "Corriger les problèmes du chapitre 2", "Corriger les problèmes du chapitre 3", "Corriger les problèmes du chapitre 4",
          "Corriger les problèmes du chapitre 5", "Corriger les problèmes du chapitre 6", "Réduire la taille du jeu", "Réduire les temps de chargement", "Créer l'installateur Windows",
          "Écrire la page de présentation du jeu", "Faire les captures d'écran", "Monter la bande-annonce", "Écrire le mode d'emploi", "Écrire les crédits", "Préparer la version de démonstration",
          "Mettre en place le suivi des plantages", "Préparer le premier correctif après sortie"]:
    add(P8, "Sortie", "Production", t, C, T, T, N, "P3")

# ---------------- sortie ----------------
hdr = ["ID", "Phase", "Domaine", "Lot", "Tâche", "R (réalise)", "A (valide)", "C (consulté)", "I (informé)", "Priorité", "Statut"]
DONE = ['Créer le dépôt GitHub privé vide Yard24/cotonou-city', 'Attacher le dépôt à la session et pousser le plan', 'Créer le projet Godot 4 vide (structure des dossiers)', 'Écrire le README du projet', 'Mettre en place les tests automatiques sans écran']
out = [[f"T{n:04d}"] + r + ["fait" if r[3] in DONE else "à faire"] for n, r in enumerate(rows, 1)]
with open("/home/claude/cotonou-city/plan/taches.csv", "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f); w.writerow(hdr); w.writerows(out)
json.dump(out, open("/home/claude/cotonou-city/plan/taches.json", "w", encoding="utf-8"), ensure_ascii=False, separators=(",", ":"))
print("TOTAL", len(out))
print("R", collections.Counter(r[5] for r in out))
print("A", collections.Counter(r[6] for r in out))
for k, v in sorted(collections.Counter(r[1] for r in out).items()): print(v, k)
print("PRIO", collections.Counter(r[9] for r in out))
print("DUP", len(out) - len(set(r[4] for r in out)))
