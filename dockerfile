# Étape de construction
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# 1. Configure l'environnement Android
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux
ENV PATH="${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools"

# 2. Accepte les licences Android
RUN yes | sdkmanager --licenses

# 3. Copie les fichiers nécessaires (optimisation du cache Docker)
COPY pubspec.yaml pubspec.lock ./
COPY lib ./lib
COPY assets ./assets
COPY android ./android
COPY ios ./ios
COPY test ./test
COPY web ./web
COPY macos ./macos
COPY windows ./windows
COPY . .

# 4. Installe les dépendances et construit l'APK
RUN flutter pub get
RUN flutter build apk --release

# Étape d'extraction
FROM alpine:latest AS output

WORKDIR /output
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk .