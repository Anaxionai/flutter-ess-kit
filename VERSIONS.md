# Versions

The tools and packages Flutter Essentials uses, and the version of each.
Briefs never name versions: when a version matters, a task points here.
**Checked on 24 November 2026** against each project's official release page or package registry (the sources are at the end).

How to read the tables:

- **Course version** means: install this version. A newer patch release (the last number) is fine.
- **Current** means: the newest release on 24 November 2026, which the course was written against. Your project's `pubspec.lock` pins the exact version you get; commit it.
- **Minimum** means: this version or newer.

## On your laptop (Windows)

[`setup/windows.md`](setup/windows.md) installs these.

| Tool | Version | Kind | Notes |
|---|---|---|---|
| Windows | 10 or 11, 64-bit | minimum | Flutter supports Windows 10 and 11 (x64 and Arm64) |
| Laptop memory | 8 GB | minimum | 8 GB is enough with your own phone. The Android emulator wants 16 GB: see [`setup/phone.md`](setup/phone.md) |
| Git for Windows (Git Bash) | 2.56.1 | course version | Any 2.45 or newer works. Flutter needs Git |
| VS Code | the newest (1.146 on 24 Nov 2026) | — | It updates itself. Add the **Flutter** extension (it adds Dart too) |
| **Flutter SDK (stable channel)** | **3.50.1** | course version | Released 20 November 2026. Any 3.50.x works |
| **Dart SDK** | **3.14.0** | comes with Flutter | Never install Dart on its own: Flutter brings it |
| Android Studio | 2026.2.2 | course version | Used only to install the Android SDK, the command-line tools and the licences. You edit code in VS Code, not here |
| Android SDK Platform | API level 36 (Android 16) | course version | Google Play needs new apps and updates to target API 36 since 31 August 2026 |
| Android SDK Platform-Tools (adb) | 37.0.3 | course version | Comes with Android Studio's SDK Manager |
| Java for Android builds | the JDK inside Android Studio | — | Flutter uses Android Studio's own JDK for Gradle builds. Do not set `JAVA_HOME` to another JDK for Flutter |
| Google Chrome | the newest (158 on 24 Nov 2026) | — | The browser target: `flutter run -d chrome` |
| Node.js | 24.22.3 LTS ("Krypton") | course version | Only for the Firebase CLI and the rules tests in P3. The rules-testing library (`@firebase/rules-unit-testing` 6.0.0) needs **Node 24.12 or newer**. Node 24 is a supported LTS until April 2028. Node 26 (what `winget install OpenJS.NodeJS.LTS` gives today) also works |
| Firebase CLI (`firebase-tools`) | 15.37.0 | course version | `npm install -g firebase-tools`. Needs Node 20 or newer |
| FlutterFire CLI (`flutterfire_cli`) | 1.5.0 | course version | `dart pub global activate flutterfire_cli`. Needs the Firebase CLI first |
| Java for the Firebase Local Emulator Suite | **JDK 21 or newer** (Microsoft Build of OpenJDK 21.0.13) | minimum | The Firebase CLI release notes say the emulators no longer run on Java older than 21 (the emulator install page still says 11). `winget install -e --id Microsoft.OpenJDK.21` |

## Your phone

| What | Version | Kind | Notes |
|---|---|---|---|
| Android | the project's `minSdkVersion` or newer | minimum | `flutter create` sets it to `flutter.minSdkVersion`, which almost every phone in use today meets. Check your phone's version in Settings → About phone. If `flutter run` says the phone's API level is too low, tell your mentor |
| Wireless debugging | Android 11 (API 30) or newer | minimum | Older phones use a USB cable, which always works |
| iPhone | — | not used | The course has no Macs, so there are no iOS builds |

## Dart and Flutter packages

Add them with `flutter pub add`, for example `flutter pub add provider`. `pubspec.lock` then pins the exact version; commit it.
Each job has one package, named in the module that first uses it.

| Package | Current | Job | First used |
|---|---|---|---|
| `flutter_lints` | 6.0.0 | The recommended lint rules (`flutter create` adds them) | LP |
| `material_ui` | 1.11.1 | The Material widgets. Since Flutter 3.47, `flutter create` adds it and writes `import 'package:material_ui/material_ui.dart';`. The old `package:flutter/material.dart` still works but `flutter analyze` reports it as deprecated | LP |
| `provider` | 6.1.5+1 | Sharing state across screens (the Flutter docs' simple app-state example uses it) | P1 |
| `shared_preferences` | 2.5.6 | Saving small data on the device | P1 |
| `sqflite` | 2.4.6 | SQLite on the device (Android, not web) | P1 (optional) |
| `intl` | 0.20.3 | Formatting dates and numbers | P1 |
| `http` | 1.6.0 | HTTP requests; its `MockClient` is the fake client in tests | P2 |
| `go_router` | 18.1.4 | Routes and passing data between screens | P2 |
| `cached_network_image` | 4.0.7 | Covers that stay cached on the device | P2 |
| `firebase_core` | 5.2.0 | Connecting to Firebase | P3 |
| `firebase_auth` | 7.1.0 | Sign-in with email and password | P3 |
| `cloud_firestore` | 7.2.0 | The Firestore database, with offline writes | P3 |
| `flutter_local_notifications` | 23.0.4 | Local notifications. Needs `compileSdk = 37` and core library desugaring in `android/app/build.gradle.kts` (its README, Android setup) | P3 |
| `flutter_launcher_icons` | 0.14.4 | Making the app icon | P3, CP2 |

The course modules may name one more package for a job; when they do, their brief says which and why.

## npm packages for the rules tests (P3)

Firestore rules are tested in Node, in a small `rules-test/` folder next to your app ([`firebase/README.md`](firebase/README.md)). Add them with `npm install --save-dev`; `package-lock.json` pins them.

| Package | Current | Job |
|---|---|---|
| `@firebase/rules-unit-testing` | 6.0.0 | Loads your rules into the emulator and acts as any user. Needs Node 24.12 or newer |
| `firebase` | 13.4.0 | The JS SDK the rules tests read and write with |

## GitHub Actions (P3)

| Action | Version |
|---|---|
| `actions/checkout` | `v7` |
| `subosito/flutter-action` | `v2` (now v2.23.0), with `channel: stable` and `flutter-version: 3.50.1` |

Run jobs on `runs-on: ubuntu-latest`.

## Sources (read on 24 November 2026)

- Flutter releases: https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json (the stable hash `ae9b586f…` is 3.50.1, Dart 3.14.0, 2026-11-20) and https://docs.flutter.dev/release/archive
- Flutter on Windows for Android: https://docs.flutter.dev/get-started/install/windows/mobile, https://docs.flutter.dev/platform-integration/android/setup, https://docs.flutter.dev/reference/supported-platforms
- Android: https://developer.android.com/tools/releases/platform-tools (37.0.3), https://developer.android.com/google/play/requirements/target-sdk (API 36 from 31 Aug 2026), https://developer.android.com/studio/run/emulator (16 GB RAM for the emulator)
- Packages: https://pub.dev (each package page), https://pub.dev/packages/flutterfire_cli (1.5.0, 9 Nov 2026)
- Firebase CLI: https://registry.npmjs.org/firebase-tools/latest (15.37.0) and https://firebase.google.com/docs/cli
- Emulator Java: https://firebase.google.com/support/release-notes/cli (Java older than 21 no longer supported), https://firebase.google.com/docs/emulator-suite/connect_firestore and https://firebase.google.com/docs/emulator-suite/install_and_configure
- Node.js: https://nodejs.org/en/about/previous-releases and https://github.com/nodejs/Release (24 is Maintenance LTS to 30 April 2028)
- winget package versions (`winget show`): Git 2.56.1, Android Studio 2026.2.2.10, OpenJDK 21.0.13, Platform-Tools 37.0.3
- GitHub Actions: the releases pages of `actions/checkout` (v7.0.1) and `subosito/flutter-action` (v2.23.0)
