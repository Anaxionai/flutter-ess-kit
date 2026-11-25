# Day 1: Flutter in your browser with DartPad

On day 1 you install nothing. You write Dart and change a real Flutter app in **DartPad**, a free editor from the Dart team that runs in your browser.
Tomorrow you install Git, and later in the week Flutter itself ([`windows.md`](windows.md)).

## Open DartPad

**https://dartpad.dev**

- Use Chrome or Edge on your laptop. A phone browser works too, but the screen is small.
- You need no account and no sign-in.
- DartPad runs Dart, and Flutter apps too: the Dart docs say it "supports the `package:flutter` and `dart:ui` libraries".

What you see: the code on the left, the output on the right (the app, or the console for plain Dart), and a **Run** button above the code.

## The samples your tasks use

Open the **Samples** menu at the top of DartPad (on a narrow screen it may be behind the menu icon).

| Sample | Kind | Task |
|---|---|---|
| **Hello world** | Dart only: it prints text in the console | Dart values, variables and `print` |
| **Counter** | A Flutter app: a title bar, a number and a + button | Your first Flutter app, and your own tap counter |

If you chose **Counter** and see code but no app, select **Run**. If you see only a console, you opened a Dart-only sample: choose **Counter** again.

## What to change in the Counter sample (day 1)

Your tasks give the exact steps. This is the map of the Counter code, so you can find each part:

| You want to change | Find this in the code | Try |
|---|---|---|
| The title at the top | `title:` inside `MyApp` (and `MyHomePage(title: ...)`) | Your own name: `Asha's Counter` |
| Every colour | `seedColor: Colors.deepPurple` | `Colors.teal`, `Colors.orange`, `Colors.indigo` |
| What + does | `_counter++;` inside `_incrementCounter` | `_counter += 2;` |
| The text above the number | `'You have pushed the button this many times:'` | Your own sentence |
| The screen's layout | the `Column` inside `build` | Add a widget to its `children` list |

After each change, select **Run**. If DartPad shows a red message, read it: it names the line. Check that every `(`, `[` and `{` has a partner, and that the line before ends in `,` or `;`.

## Saving your work

DartPad does not keep your code when you close the tab. Before you close it:

1. Select all the code (Ctrl+A) and copy it (Ctrl+C).
2. Paste it into a file in your course repository on GitHub's website, as your task says (**Add file → Create new file**, then **Commit changes**).

## If DartPad does not load

- Refresh the page, or try another browser (Chrome or Edge).
- A college network may block it: try your phone's hotspot.
- Still stuck: the same samples are in the Flutter docs, which have DartPad built in (for example https://docs.flutter.dev/ui/widgets-intro). Tell your mentor.

## Sources (checked 24 November 2026)

- DartPad: https://dart.dev/tools/dartpad
- Introduction to widgets: https://docs.flutter.dev/ui/widgets-intro
