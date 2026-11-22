# Version Android : comment elle est fabriquée, et comment la refaire

Ce document explique d'où vient le fichier `MarinaCity.apk`, ce qu'il contient, et comment le fabriquer à nouveau, automatiquement ou à la main. La procédure suit la documentation officielle de Godot 4.3, page « Exporting for Android » (source : `tutorials/export/exporting_for_android.rst` du dépôt `godotengine/godot-docs`, branche `4.3`), vérifiée aussi dans le code de Godot 4.3 (`platform/android/export/`).

## En bref
- Fichier : `MarinaCity.apk`, environ 44 Mo, à installer directement sur le téléphone (pas de Play Store pour l'instant).
- Identifiant du paquet : `com.yard24.marinacity`. Nom affiché : « Marina City ». Version 0.1 (numéro 1).
- Android 5.0 (API 21) au minimum, visé : Android 14 (API 34).
- Processeurs : `arm64-v8a` (téléphones récents) et `armeabi-v7a` (anciens ou très bon marché). Les deux sont dans le même fichier.
- Signé avec une **clé de test**. Ce n'est pas une clé de publication : le Play Store la refuserait. La publication se fera plus tard, avec Bravo.
- Fabriqué par GitHub Actions à chaque envoi sur `main` (et sur la branche `android`), à côté du `.exe` Windows.

## Pourquoi Android 5.0 au minimum
Le jeu utilise le moteur de rendu « Compatibility » (OpenGL ES 3.0). Avec ce moteur et les modèles d'export tout prêts de Godot 4.3, la version minimale est Android 5.0 (API 21) : c'est la valeur `minSdk` des modèles (`platform/android/java/app/config.gradle`, constante `OPENGL_MIN_SDK_VERSION = 21`). Descendre plus bas demanderait de recompiler Godot. Le téléphone doit aussi savoir faire de l'OpenGL ES 3.0, ce qui est le cas de presque tous les téléphones vendus depuis 2014.

## Où télécharger le .apk
1. Sur GitHub : dépôt `Yard24/cotonou-city`, onglet **Actions**.
2. Cliquer sur le dernier passage marqué d'une coche verte.
3. En bas de la page, section **Artifacts** : **MarinaCity-Android** (un fichier `.zip` qui contient `MarinaCity.apk`). Il faut être connecté à GitHub.
4. Les fichiers restent disponibles 90 jours en principe (réglage du dépôt).

## Ce que fait GitHub Actions (fichier `.github/workflows/build.yml`, tâche `android`)
1. Télécharge Godot 4.3 pour Linux et ses modèles d'export, n'en garde que les modèles Android (`android_release.apk`, `android_debug.apk`, `version.txt`).
2. Installe Java (OpenJDK 17, comme demandé par la documentation de Godot 4.3).
3. Installe les outils Android avec `sdkmanager` : `platform-tools`, `build-tools;34.0.0`, `platforms;android-34`. (La documentation cite aussi CMake et le NDK : ils ne servent qu'à la fabrication « Gradle », que nous n'utilisons pas.)
4. Écrit les réglages de l'éditeur Godot (`~/.config/godot/editor_settings-4.3.tres`) avec les deux chemins demandés par la documentation : `export/android/android_sdk_path` et `export/android/java_sdk_path`.
5. Clé de test : la reprend dans le cache de GitHub Actions, ou la crée au premier passage (`keytool`, mot de passe tiré au hasard, jamais écrit dans le dépôt ni affiché dans le journal). Elle est donnée à Godot par les variables de la documentation : `GODOT_ANDROID_KEYSTORE_RELEASE_PATH`, `GODOT_ANDROID_KEYSTORE_RELEASE_USER`, `GODOT_ANDROID_KEYSTORE_RELEASE_PASSWORD`.
6. Fabrique : `godot --headless --export-release "Android" build/MarinaCity.apk`.
7. Vérifie avec `.github/verifier_apk.sh` : identifiant du paquet, nom, Android 5.0 minimum, moteur pour les deux processeurs, signature. Une erreur arrête tout.
8. Met le fichier à disposition sous le nom **MarinaCity-Android**.

La tâche `build` (test automatique et `.exe` Windows) est restée la même ; elle refuse maintenant en plus toute ligne `SCRIPT ERROR` dans le test.

### La clé de test et les mises à jour
Android n'installe une nouvelle version par-dessus l'ancienne que si les deux sont signées avec la même clé. La clé de test est donc gardée dans le cache de GitHub Actions (nom `cle-test-android-v1`). GitHub efface un cache inutilisé pendant 7 jours : la clé suivante sera alors différente, et il faudra **désinstaller l'ancienne version avant d'installer la nouvelle** (ce qui efface les sauvegardes du téléphone). Le message d'Android est alors « Application non installée » ou « conflit avec un paquet existant ».

## Les réglages du projet pour Android
- `project.godot` :
  - `display/window/handheld/orientation=4` : paysage imposé (« Sensor Landscape » : le téléphone peut être tenu dans les deux sens, jamais en portrait).
  - `application/config/quit_on_go_back=false` : le bouton Retour d'Android ne ferme pas le jeu ; il ouvre la pause (voir `docs/systemes/commandes_tactiles.md`).
  - `rendering/textures/vram_compression/import_etc2_astc=true` : compression de textures ETC2/ASTC, exigée par Godot pour exporter vers Android, et nécessaire aux futurs modèles 3D.
  - `lights_and_shadows/directional_shadow/size.mobile=2048` : ombres moins coûteuses sur téléphone (niveaux Moyen et plus ; le niveau Bas n'a pas d'ombres).
- `export_presets.cfg`, préréglage « Android » : export sans Gradle, APK, deux processeurs, plein écran (« immersive »), icônes de `icones/`, aucune clé ni mot de passe (ils arrivent par les variables d'environnement). `docs/`, `plan/` et `.github/` ne sont pas mis dans le .apk. Le préréglage Windows exclut `icones/`.
- Icône provisoire : `icones/` (192 × 192, et 432 × 432 avant-plan et fond pour Android 8 et plus), dessinée par `icones/dessiner_icone.py` (Python et Pillow) : un zémidjan en chemise jaune et casque vert au coucher du soleil. Godot 4.3 n'a pas de réglage pour l'icône monochrome d'Android 13 : Android utilise alors celle de Godot dans ce mode seulement.

## Ce que le jeu fait de différent sur téléphone
Tout est dans le code commun ; les différences passent par `OS.has_feature("mobile")` et sont sans effet sur PC.
- Commandes tactiles affichées (`scripts/tactile.gd`), textes qui citent les boutons au lieu des touches.
- Niveau graphique de départ « Bas » (`options.gd`, `QUALITE_MOBILE`) ; les autres niveaux restent au choix dans Options > Graphismes.
- Image 3D calculée sur 540 lignes au plus au niveau Bas (720, 900, 1080 aux niveaux suivants), puis agrandie à la taille de l'écran (`main.gd`, `_apply_quality`).
- Décor fixe regroupé en morceaux de 64 m (`scripts/fusion.gd`) : environ 56 objets à dessiner au lieu de 1 133, image identique.
- Affichage et menus resserrés dans la zone sûre de l'écran (encoche, bords arrondis), mise en pause et sauvegarde automatique quand le jeu passe en arrière-plan.
- Pas de case « Plein écran » dans les options (le jeu occupe toujours tout l'écran).
- Les sauvegardes et les options restent dans le dossier privé de l'application (`user://`, soit `/data/data/com.yard24.marinacity/files/` sur le téléphone) ; aucune permission n'est demandée.

## Refaire le .apk à la main (sur un PC Linux ou Windows)
1. Installer OpenJDK 17 (Adoptium Temurin 17).
2. Installer les outils Android en ligne de commande (« Command line tools only » sur developer.android.com), puis :
   `sdkmanager --sdk_root=<dossier_sdk> "platform-tools" "build-tools;34.0.0" "platforms;android-34"`
3. Installer Godot 4.3 et ses modèles d'export (Éditeur > Gérer les modèles d'export, ou décompresser `Godot_v4.3-stable_export_templates.tpz` dans le dossier des modèles, sous-dossier `4.3.stable`).
4. Dans Godot : Éditeur > Paramètres de l'éditeur > Export > Android : « Java SDK Path » = dossier de Java 17, « Android Sdk Path » = dossier du SDK.
5. Créer une clé de test (une seule fois, à garder) :
   `keytool -genkeypair -keystore test.keystore -alias marinacity-test -keyalg RSA -keysize 2048 -validity 10000`
6. Fabriquer, en donnant la clé par les variables d'environnement (ne jamais la mettre dans `export_presets.cfg`) :
   `GODOT_ANDROID_KEYSTORE_RELEASE_PATH=test.keystore GODOT_ANDROID_KEYSTORE_RELEASE_USER=marinacity-test GODOT_ANDROID_KEYSTORE_RELEASE_PASSWORD=<mot de passe> godot --headless --export-release "Android" build/MarinaCity.apk`
7. Vérifier : `.github/verifier_apk.sh build/MarinaCity.apk <dossier_sdk>/build-tools/34.0.0`.

## Plus tard : publication sur le Play Store (à faire avec Bravo)
Le Play Store demande un fichier AAB (pas un APK), une vraie clé de publication gardée hors du dépôt (secret GitHub ou coffre), un compte développeur Google (payant), un numéro de version qui augmente à chaque envoi (`version/code`), une politique de confidentialité et une icône monochrome. L'AAB passe par la fabrication « Gradle » (`gradle_build/use_gradle_build=true`, NDK et CMake requis). Rien de tout cela n'est fait.

## Limites connues
- Aucun essai sur un vrai téléphone : lancement, fluidité, confort au doigt, encoche et bouton Retour ne sont vérifiés que par le test automatique et des captures d'écran sur PC.
- La fluidité sur un téléphone de 3 à 4 Go n'est pas mesurée. Les véhicules (environ 40) et les passants (environ 70) restent faits de nombreux petits blocs et ne sont pas regroupés ; la circulation et la physique tournent à 60 images par seconde.
- Si la clé de test change (cache effacé), il faut désinstaller avant de réinstaller.
- L'icône monochrome d'Android 13 est celle de Godot (réglage absent de Godot 4.3).
