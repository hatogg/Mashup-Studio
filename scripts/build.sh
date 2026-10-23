#!/usr/bin/env bash
# Збирає й підписує APK без Android SDK: потрібні лише Java 11+ і curl.
# Підпис релізним ключем: KEY_PASS=пароль [KEYSTORE=keys/release.jks] [KEY_ALIAS=mashup] scripts/build.sh
# Без KEY_PASS APK підписується вбудованим налагоджувальним ключем.
set -euo pipefail
cd "$(dirname "$0")/.."

APKTOOL_VER=2.12.1
SIGNER_VER=1.3.0
mkdir -p tools build

[ -f tools/apktool.jar ] || curl -fL -o tools/apktool.jar \
  "https://github.com/iBotPeaches/Apktool/releases/download/v${APKTOOL_VER}/apktool_${APKTOOL_VER}.jar"
[ -f tools/uber-apk-signer.jar ] || curl -fL -o tools/uber-apk-signer.jar \
  "https://github.com/patrickfav/uber-apk-signer/releases/download/v${SIGNER_VER}/uber-apk-signer-${SIGNER_VER}.jar"

mkdir -p android/assets
cp web/index.html android/assets/index.html

rm -rf build/signed build/unsigned.apk
java -jar tools/apktool.jar b android -o build/unsigned.apk

if [ -n "${KEY_PASS:-}" ]; then
  KS="${KEYSTORE:-keys/release.jks}"
  ALIAS="${KEY_ALIAS:-mashup}"
  if [ ! -f "$KS" ]; then
    mkdir -p "$(dirname "$KS")"
    keytool -genkeypair -keystore "$KS" -alias "$ALIAS" -keyalg RSA -keysize 2048 -validity 12000 \
      -storepass "$KEY_PASS" -keypass "$KEY_PASS" -dname "CN=Mashup Studio, C=UA"
  fi
  java -jar tools/uber-apk-signer.jar --apks build/unsigned.apk --ks "$KS" --ksAlias "$ALIAS" \
    --ksPass "$KEY_PASS" --ksKeyPass "$KEY_PASS" --out build/signed
else
  java -jar tools/uber-apk-signer.jar --apks build/unsigned.apk --out build/signed
fi

cp build/signed/*.apk build/MashupStudio.apk
echo "Готово: build/MashupStudio.apk"
