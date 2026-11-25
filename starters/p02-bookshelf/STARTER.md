# Starter: P2 BookShelf (Flutter)

The Guided starter for **P2 BookShelf** (module 3). It is the `bookshelf/` folder, with the set-up done and every piece of logic left for you.
It was written by hand to match `flutter create` for Flutter 3.50 (see the kit's `VERSIONS.md`); the copy step below adds the Android and web folders.

## What is included

| Path | What it is |
|---|---|
| `pubspec.yaml`, `analysis_options.yaml` | The project with `http` already added, Dart 3.14 or newer, and the Flutter lint rules |
| `lib/main.dart` | The app: `MaterialApp` opening `SearchScreen` |
| `lib/screens/search_screen.dart` | **The one screen that is done**: the search box, the Search button and the empty results area. No searching yet |
| `lib/models/book.dart` | An empty `Book` class: you copy yours from task 6 |
| `lib/data/book_repository.dart` | `BookRepository` with its constructor (a real or a fake `http.Client`) and the `search` signature |
| `test/book_repository_test.dart` | One skipped placeholder. You write every test |

## Copy it in (task 7)

In Git Bash, in task 7's folder:

```bash
cd ~/flutter-ess-kit && git pull && cd -
cp -r ~/flutter-ess-kit/starters/p02-bookshelf bookshelf
cd bookshelf
flutter create --platforms android,web .
rm -f test/widget_test.dart
mkdir -p test/fixtures
cp ~/flutter-ess-kit/data/books/sample-search.json ~/flutter-ess-kit/data/books/sample-work.json test/fixtures/
```

`flutter create .` adds only the missing files (the `android/` and `web/` folders); it keeps the starter's code. Then do task 7 step 6 yourself: the `INTERNET` permission in `android/app/src/main/AndroidManifest.xml`.

## Run it

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

`flutter analyze` reports no issues, `flutter test` shows the placeholder as skipped, and the app opens with the search box.

## The TODOs

`grep -rn "TODO(task" lib test` lists them.

| Task | File | What you write |
|---|---|---|
| 7 | `lib/models/book.dart`, `lib/data/book_repository.dart`, `lib/screens/search_screen.dart` | Your `Book`, `search()` with the User-Agent, the results list; the manifest permission |
| 8 | `book_repository.dart`, `search_screen.dart` | Timeouts, `BookShelfException` (a new file) and the four screen states |
| 9 | `lib/main.dart`, `book_repository.dart`, `search_screen.dart` | `go_router` and Provider, `work()`, the detail screen (new files `lib/router.dart`, `lib/screens/book_screen.dart`) |
| 10 | `lib/main.dart`, `search_screen.dart` | The reading list: new files `lib/state/reading_list.dart`, `lib/data/reading_list_store.dart`, `lib/screens/reading_list_screen.dart` and a test |
| 16 | `book_repository.dart` | The search cache (new file `lib/data/search_cache.dart`) and cached covers |
| 17 | `search_screen.dart` | Debounced search as you type |
| 18 | `test/book_repository_test.dart` | Repository tests with `MockClient`, plus `test/fakes/` and a screen test |
| 19 | `search_screen.dart` | Accessibility fixes and `test/a11y_test.dart` |
| 20 | `book_repository.dart`, `search_screen.dart` | Paging and pull to refresh |
| 21 | `lib/main.dart` | Light and dark themes, icons and empty states |
| 22 | none | The wrap-up is writing and a demo: no starter code |

## What you still write yourself

All the logic: parsing, the requests and their errors, the screen states, routes, the reading list and its storage, the cache, the debounce, paging, accessibility and every test.
Also your product's `README.md` in the wrap-up (this `STARTER.md` is not it). Commit `pubspec.lock` with your code.
