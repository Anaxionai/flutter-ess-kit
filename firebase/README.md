# Firebase on the free Spark plan

P3 ShopList (and a capstone that shares data) uses **Firebase Authentication** (email and password sign-in) and **Cloud Firestore** (a live database), on Firebase's free **Spark** plan.
This page sets up a project, connects your app, and tests your security rules on your laptop with the **Local Emulator Suite**.

Checked on 24 November 2026 against https://firebase.google.com/pricing, https://firebase.google.com/docs/projects/billing/firebase-pricing-plans, https://firebase.google.com/docs/storage/faqs-storage-changes-announced-sept-2024, https://firebase.google.com/docs/emulator-suite/install_and_configure, https://firebase.google.com/docs/firestore/security/get-started and https://firebase.google.com/docs/flutter/setup.

## 1. The Spark plan: free, no card, and what it leaves out

Spark needs **no payment method**. Never add a card or upgrade to Blaze for this course: if a page asks you to, stop and ask your mentor.

What Spark gives you (from the pricing page):

| Product | Free on Spark |
|---|---|
| Cloud Firestore | 1 GiB stored; **50,000 document reads, 20,000 writes and 20,000 deletes a day**; 10 GiB of network egress a month |
| Authentication | Email and password sign-in, up to 50,000 monthly active users |

If a project goes over a free quota, Firebase turns that product off for the project until the quota resets; nothing is charged. A shopping list for a family uses a tiny part of these limits. The way to blow them is a bug: a listener inside a loop, or a screen that re-reads everything on every rebuild. Watch **Firestore → Usage** in the console in your first week.

**What Spark does not include, so the course does not use it:**

| Not on Spark | Why it matters |
|---|---|
| **Cloud Storage for Firebase** | Since 3 February 2026 every Cloud Storage bucket, even the default one, needs the paid Blaze plan; Spark projects get 402 or 403 errors. So: **no photo or file uploads** |
| **Cloud Functions** | Needs Blaze. So: no server code, and **no server push notifications**. ShopList notifies with local notifications from the app's own Firestore listener |
| **Phone-number sign-in** (SMS) | Not available on Spark. The course uses email and password only |

## 2. Create your project (once per app)

1. Open https://console.firebase.google.com and sign in with the Google account you use for the course.
2. Select **Create a project**. Name it `shoplist-<your name>` (for the capstone, `<app>-<your name>`). Turn **Google Analytics off**: the course does not use it. Finish.
3. Check the plan: the project's settings show **Spark**. Leave it.
4. **Authentication**: open **Build → Authentication → Get started**, then **Sign-in method → Email/Password → Enable → Save**.
5. **Firestore**: open **Build → Firestore Database → Create database**. Choose a location near your users (you cannot change it later) and **production mode**. Production mode denies every read and write until you deploy rules, which is the safe start.

## 3. Connect your Flutter app with the FlutterFire CLI

You need the Firebase CLI (`firebase login` done) and the FlutterFire CLI on your PATH (`setup/windows.md`, Part 2).

1. **Set the app's ID first.** Create the app with your application ID from [`release/README.md`](../release/README.md): `flutter create --org com.anaxionai.<your github user name> --platforms=android,web shoplist`. FlutterFire registers the Android app under that ID.
2. In the app's folder, add the packages, then configure:

```bash
flutter pub add firebase_core firebase_auth cloud_firestore
flutterfire configure --project=<your project id> --platforms=android,web
```

`flutterfire configure` adds an **Android app** and a **web app** to your Firebase project for you (you do not add them by hand in the console), and writes:

| File | What it is | Git |
|---|---|---|
| `lib/firebase_options.dart` | Your project's config for each platform | **Commit it.** These values are not secrets: the rules protect your data |
| `android/app/google-services.json` | The Android config file | Kept out by the kit's `.gitignore` (the course's choice). Run `flutterfire configure` again on a new laptop |
| `firebase.json` | FlutterFire writes a `flutter` key here | **Commit it**, after section 4 |

3. In `main.dart`, before `runApp`:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

(`main` becomes `Future<void> main() async`; import `package:firebase_core/firebase_core.dart` and `firebase_options.dart`.)

4. Run it in Chrome and on your phone. If the Android build asks for a higher `minSdk`, set `minSdk = 24` in `android/app/build.gradle.kts`, as the build message says.
5. Changed the application ID later? Run `flutterfire configure` again and choose the new Android app.

To add an Android app by hand instead (Project settings → **Add app** → Android), you need only the package name; the SHA-1 fingerprint is not needed for email and password sign-in.

**Connecting the app to the emulator** (for practice and tests): after `Firebase.initializeApp`, call `FirebaseAuth.instance.useAuthEmulator('localhost', 9099)` and `FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080)`. On a phone, `localhost` is the phone itself: use the emulator from Chrome, or your laptop's Wi-Fi IP address with `"host": "0.0.0.0"` added to each emulator in `firebase.json`.

## 4. `firebase.json`: rules and emulators

The kit's [`firebase.json.example`](firebase.json.example) points the Firebase CLI at your rules file and sets the emulator ports:

| Emulator | Port |
|---|---|
| Authentication | 9099 |
| Cloud Firestore | 8080 |
| Emulator Suite UI | 4000 (open http://localhost:4000) |

FlutterFire already wrote a `firebase.json` with a `flutter` key. **Do not replace it**: open the example and copy its `firestore` and `emulators` keys into your file, next to `flutter`. The result has three top-level keys:

```json
{
  "flutter": { "...": "what FlutterFire wrote, unchanged" },
  "firestore": { "rules": "firestore.rules" },
  "emulators": { "...": "the example's emulators block" }
}
```

Commit `firebase.json` and `firestore.rules`. They hold no secrets.

## 5. Security rules: start from "deny everything"

The kit's [`firestore.rules.example`](firestore.rules.example) denies every read and write:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

Copy it to `firestore.rules` in your app's folder. Then open up **only** what your app needs, for example "a signed-in member of a list may read it", and prove each rule with a test in the emulator (section 6) **before** you deploy:

```bash
firebase deploy --only firestore:rules --project <your project id>
```

Your Firebase config values (the API key and project id in your app) are **not secrets**: every user's phone has them. What protects your data is the rules. A stranger who knows a list's id must still be stopped by a rule.

## 6. The Local Emulator Suite: test without touching the real project

The emulators run Authentication and Firestore on your laptop. Nothing reaches your real project, nothing counts against your quota, and you can break things freely.

**You need:** the Firebase CLI, **Java 21 or newer** (the CLI refuses older Java, although the install page still says 11) and, for rules tests, **Node 24.12 or newer**. `setup/windows.md` installs them; check with `firebase --version`, `java -version` and `node --version`.

**Use a demo project id.** A project id that starts with `demo-`, such as `demo-shoplist`, needs no real project and can never reach the cloud:

```bash
firebase emulators:start --project demo-shoplist
```

- Open http://localhost:4000 for the Emulator Suite UI: the Authentication tab (add test users), the Firestore tab (see and edit documents) and the logs.
- Stop with Ctrl+C. The data is thrown away (add `--import` and `--export-on-exit` with a folder name to keep it; the kit's `.gitignore` ignores `emulator-data/`).
- **Port already in use** (often 8080 on Windows): change the port in `firebase.json` and in your app's emulator connection, or stop the other program.
- `java` not found or too old: see `setup/windows.md`, the Java step.

### Rules tests with `@firebase/rules-unit-testing`

Rules are tested in **Node**: there is no Dart library for it, so a small Node folder sits next to your Flutter app. The library loads your rules into the Firestore emulator and lets a test act as any user. In your app's folder:

```bash
mkdir rules-test && cd rules-test
npm init -y
npm install --save-dev @firebase/rules-unit-testing firebase
npm pkg set scripts.test="node --test"
cd ..
```

A first test, `rules-test/rules.test.mjs`, that proves the deny-all file denies a read:

```js
import { test, before, after } from "node:test";
import { readFileSync } from "node:fs";
import { initializeTestEnvironment, assertFails } from "@firebase/rules-unit-testing";
import { doc, getDoc } from "firebase/firestore";

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: "demo-shoplist",
    firestore: { rules: readFileSync(new URL("../firestore.rules", import.meta.url), "utf8") },
  });
});

after(async () => {
  await env.cleanup();
});

test("a signed-in user cannot read a list under deny-all rules", async () => {
  const db = env.authenticatedContext("alice", { email: "alice@example.com", email_verified: true }).firestore();
  await assertFails(getDoc(doc(db, "lists/l1")));
});
```

Run it inside the emulator, from your app's folder:

```bash
firebase emulators:exec --only firestore --project demo-shoplist "npm --prefix rules-test test"
```

`emulators:exec` starts the emulator, runs the command and stops the emulator again. The output ends with `ℹ pass 1` and `ℹ fail 0` (Node 24's test report); paste it into `evidence.md`. Your P3 task then adds the real cases: a member reads, a stranger fails, a signed-out user fails, and so on. Seed data with `env.withSecurityRulesDisabled(...)`, and use `assertSucceeds` for what must work.

You need not ignore `rules-test/node_modules/` yourself: the kit's `.gitignore` already ignores every `node_modules/`. Commit `rules-test/package.json`, `package-lock.json` and the tests.


## 7. Offline and conflicts, in one paragraph

Firestore on Android keeps a local cache **on by default**: reads work offline from what the phone has seen, and writes made offline are queued and sent when the phone reconnects. When two phones change the same field, the **last write to reach the server wins**. So update only the fields that changed (`update`, not `set` of the whole document), use `FieldValue.increment` for counts, and `FieldValue.serverTimestamp()` for times. P3 has you prove this with two phones, one of them offline.

## Sources (checked 24 November 2026)

- Pricing and the Spark plan: https://firebase.google.com/pricing and https://firebase.google.com/docs/projects/billing/firebase-pricing-plans
- Cloud Storage needs Blaze: https://firebase.google.com/docs/storage/faqs-storage-changes-announced-sept-2024
- Emulator Suite: https://firebase.google.com/docs/emulator-suite/install_and_configure and https://firebase.google.com/docs/emulator-suite/connect_firestore (the `demo-` prefix)
- Java 21 for the emulators: https://firebase.google.com/support/release-notes/cli
- Rules: https://firebase.google.com/docs/firestore/security/get-started ; rules tests: https://firebase.google.com/docs/rules/unit-tests (`@firebase/rules-unit-testing` 6.0.0 needs Node 24.12 or newer)
- Firebase CLI: https://firebase.google.com/docs/cli
- FlutterFire: https://firebase.google.com/docs/flutter/setup
- Offline data: https://firebase.google.com/docs/firestore/manage-data/enable-offline
