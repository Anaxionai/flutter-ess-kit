# Starter: P1 HabitLoop (Flutter)

The Guided starter for **P1 HabitLoop** (module 2). It is the `habitloop/` folder, with the set-up done and every piece of logic left for you.
It was written by hand to match `flutter create` for Flutter 3.50 (see the kit's `VERSIONS.md`); Step 2 below adds the Android and web folders.

## What is included

| Path | What it is |
|---|---|
| `pubspec.yaml`, `analysis_options.yaml` | The project, Dart 3.14 or newer, and the Flutter lint rules |
| `lib/main.dart` | The app: `MaterialApp` with a teal theme, opening `HomeScreen` |
| `lib/screens/home_screen.dart` | **The one screen that is done**: app bar, a "Today" line, the empty state and the add button. No data, no logic |
| `lib/models/habit.dart`, `lib/models/check_in.dart` | Empty classes with notes: **you write the models** in task 8 |
| `lib/widgets/habit_dialog.dart` | The dialog's signature, for task 10 |
| `lib/logic/streak.dart` | The streak functions' signatures, for task 21 |
| `lib/data/habit_store.dart`, `lib/state/habits_model.dart` | Empty classes with notes, for tasks 20 and 22 |
| `test/*_test.dart` | One skipped placeholder per test file. You write every test |

## Copy it in (task 8)

In Git Bash, in task 8's folder:

```bash
cd ~/flutter-ess-kit && git pull && cd -
cp -r ~/flutter-ess-kit/starters/p01-habitloop habitloop
cd habitloop
flutter create --platforms android,web .
rm -f test/widget_test.dart
```

`flutter create .` in a folder that already has a project adds only the missing files (the `android/` and `web/` folders and a few hidden files); it keeps the starter's `lib/`, `pubspec.yaml` and tests. It may write `test/widget_test.dart`, the counter test, which you delete (task 8 says so).

## Run it

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

`flutter analyze` reports no issues, `flutter test` shows the placeholders as skipped, and the app opens with "No habits yet". From task 20 the app uses SQLite and runs on your phone only (`flutter run` with the phone plugged in).

## The TODOs

`grep -rn "TODO(task" lib test` lists them.

| Task | File | What you write |
|---|---|---|
| 8 | `lib/models/habit.dart`, `lib/models/check_in.dart`, `test/models_test.dart` | The two model classes and at least four unit tests |
| 9 | `lib/screens/home_screen.dart` | The lists, `today()`, `isDoneToday`, the count line and the tickable list |
| 10 | `lib/widgets/habit_dialog.dart`, `home_screen.dart` | The validated form; add and rename |
| 11 | `home_screen.dart` | Swipe to delete, with Undo |
| 20 | `lib/data/habit_store.dart`, `lib/main.dart`, `home_screen.dart`, `test/habit_store_test.dart` | SQLite storage, loading at start, the restart test |
| 21 | `lib/logic/streak.dart`, `home_screen.dart`, `test/streak_test.dart` | `dayOf`, `currentStreak`, `longestStreak`, the six kit cases and the restart case |
| 22 | `lib/state/habits_model.dart`, `lib/main.dart`, `home_screen.dart`, `lib/screens/stats_screen.dart` | Provider state and the stats screen |
| 23 | `test/home_screen_test.dart` | Five widget tests |
| 24 | none | The wrap-up is writing and a demo: no starter code |

## What you still write yourself

All the logic: the models, the list, the form, delete and Undo, saving, the streaks, the shared state, the stats screen and every test.
Also your product's `README.md` in the wrap-up (this `STARTER.md` is not it). Commit `pubspec.lock` with your code.
