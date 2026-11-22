#!/usr/bin/env bash
# Vérifie le .apk fabriqué : identifiant du paquet, nom, version minimale d'Android,
# moteur pour les deux types de processeurs, signature. S'arrête à la première erreur.
# Usage : .github/verifier_apk.sh build/MarinaCity.apk DOSSIER_DES_OUTILS_ANDROID
set -euo pipefail
APK="$1"
OUTILS="$2"   # dossier qui contient aapt2 (ou aapt) et apksigner, par ex. $ANDROID_HOME/build-tools/34.0.0
AAPT="$OUTILS/aapt2"; [ -x "$AAPT" ] || AAPT="$OUTILS/aapt"
test -s "$APK" || { echo "ERREUR : $APK absent ou vide"; exit 1; }
INFOS=$("$AAPT" dump badging "$APK")
grep -q "^package: name='com.yard24.marinacity'" <<< "$INFOS" || { echo "ERREUR : identifiant du paquet"; exit 1; }
grep -q "^application-label:'Marina City'" <<< "$INFOS" || { echo "ERREUR : nom de l'application"; exit 1; }
grep -q "^sdkVersion:'21'" <<< "$INFOS" || { echo "ERREUR : version minimale d'Android (21 attendue)"; exit 1; }
grep -q "^native-code: 'arm64-v8a' 'armeabi-v7a'" <<< "$INFOS" || { echo "ERREUR : processeurs"; exit 1; }
LISTE=$(unzip -l "$APK")
for abi in arm64-v8a armeabi-v7a; do
  grep -q "lib/$abi/libgodot_android.so" <<< "$LISTE" || { echo "ERREUR : moteur absent pour $abi"; exit 1; }
done
"$OUTILS/apksigner" verify --print-certs "$APK" | grep -E "Signer #1 certificate (DN|SHA-256)"
echo "$INFOS" | grep -E "^package|^sdkVersion|^targetSdkVersion|^native-code|^application-label:"
echo "APK OK : $(du -h "$APK" | cut -f1)"
