# Starter: P3 ShopList (Flutter)

The Guided starter for **P3 ShopList** (module 4). It is the `shoplist/` folder, with the layout and file plan done and every piece of Firebase logic left for you.
It was written by hand to match `flutter create` for Flutter 3.50 (see the kit's `VERSIONS.md`). **You set your own application ID** when you add the Android folder below.

## What is included

| Path | What it is |
|---|---|
| `pubspec.yaml`, `analysis_options.yaml` | The project, Dart 3.14 or newer, the Flutter lint rules. You add the Firebase packages in task 7 |
| `lib/main.dart` | The app: `MaterialApp` opening `HomeScreen` |
| `lib/screens/home_screen.dart` | **The one screen that is done**: app bar with Sign out, the empty state and a New list button. No data yet |
| `lib/models/shop_list.dart`, `lib/models/item.dart` | Empty classes with notes, for tasks 9 and 10 |
| `lib/data/list_repository.dart` | An empty repository with the plan of its methods |
| `lib/services/notifier.dart`, `lib/services/list_watcher.dart` | Empty classes with notes, for task 18 |
| `firestore.rules` | The deny-all start, from the kit's `firebase/firestore.rules.example` |
| `test/item_test.dart` | One skipped placeholder. You write every test |

## Copy it in (task 7)

Ask your mentor for your application ID first ([`release/README.md`](../../release/README.md)): `com.anaxionai.<your github user name>.shoplist`. In Git Bash, in task 7's folder:

```bash
cd ~/flutter-ess-kit && git pull && cd -
cp -r ~/flutter-ess-kit/starters/p03-shoplist shoplist
cd shoplist
flutter create --org com.anaxionai.<your github user name> --platforms=android,web .
rm -f test/widget_test.dart
```

`--org` plus the folder name `shoplist` makes your application ID. Check it: `grep applicationId android/app/build.gradle.kts`. Then carry on from task 7 step 2 (the Firebase project, `flutterfire configure`).

## Run it

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

`flutter analyze` reports no issues, `flutter test` shows the placeholder as skipped, and the app opens with "No lists yet".

## The TODOs

`grep -rn "TODO(task" lib test firestore.rules` lists them.

| Task | File | What you write |
|---|---|---|
| 7 | `lib/main.dart`, `home_screen.dart` | Firebase start-up after `flutterfire configure`; the project id on screen |
| 8 | `lib/main.dart`, `home_screen.dart` | Sign-in, verify email and sign out (new files `lib/screens/sign_in_screen.dart`, `lib/screens/auth_gate.dart`) |
| 9 | `firestore.rules`, `lib/models/shop_list.dart`, `lib/data/list_repository.dart`, `home_screen.dart` | The temporary rule, lists and sharing |
| 10 | `lib/models/item.dart`, `list_repository.dart`, `lib/main.dart` | Live items and the list screen |
| 11 | `firestore.rules` | Your rules and the `rules-test/` folder ([`firebase/README.md`](../../firebase/README.md), section 6) |
| 17 | `item.dart`, `list_repository.dart`, `test/item_test.dart` | Offline edits, conflicts and the Item tests |
| 18 | `lib/services/notifier.dart`, `lib/services/list_watcher.dart` | Local notifications for other people's items |
| 19 | none here | The workflow file goes at the repository root (`.github/workflows/`), as the brief says |
| 20 | none here | Release signing is set up in `android/` and `pubspec.yaml` ([`release/README.md`](../../release/README.md)) |
| 21 | none | The wrap-up is writing and a demo: no starter code |

## What you still write yourself

All the logic: Firebase start-up, sign-in, lists, sharing, live items, rules and their tests, offline conflicts, notifications, CI and the release.
Also your product's `README.md` in the wrap-up (this `STARTER.md` is not it). Commit `pubspec.lock`, `lib/firebase_options.dart`, `firebase.json` and `firestore.rules`; never `google-services.json`, keys or `key.properties`.
