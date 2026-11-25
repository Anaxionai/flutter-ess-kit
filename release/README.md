# Release your app to testers (Flutter)

This guide takes your app from your laptop to your testers' phones through **Google Play internal testing**. You use it in P3 ShopList and again in the capstone (CP2).

**You never pay anything and never need your own Play developer account.** The centre has one Google Play developer account. You build and sign the app; your mentor uploads it to that account's internal testing track and adds your testers.

Checked on 24 November 2026 against https://docs.flutter.dev/deployment/android, https://pub.dev/packages/flutter_launcher_icons and the Play Console Help pages listed at the end.

## How it works, in one picture

```text
you                                    your mentor (centre's Play account)        testers
---                                    -----------------------------------        -------
1. application ID from your mentor
2. app icon
3. upload key in your user folder
4. flutter build appbundle  --- .aab ---> 5. upload to Internal testing
                                           6. add testers' emails
                            <-- release name, version code, status, opt-in link
7. join with the opt-in link                                          ---> 8. join, install from Play
```

## Two keys, and why yours never goes into Git

Android apps are signed. Google Play uses **two keys** (Play App Signing):

- the **upload key**: yours. You sign each `.aab` with it, so Google knows the upload came from you;
- the **app signing key**: Google's. Play re-signs the app with it before it reaches phones. Google keeps it safe.

Your upload key is a file (`upload-keystore.jks`) with two passwords. Anyone who has the file and the passwords can upload in your name. So:

- keep the keystore in your **user folder** (`C:\Users\<your name>\upload-keystore.jks`), never inside your repository;
- keep the passwords in `android/key.properties`, which the kit's `.gitignore` keeps out of Git;
- back the keystore up somewhere private (a USB stick or your own cloud drive), and write the passwords in a password manager.

**Lost the upload key?** You are not locked out: the upload key can be reset. Make a new key (Step 3), export its certificate, and tell your mentor; they request an upload key reset in Play Console.
**Pushed a key or `key.properties` to GitHub by mistake?** Tell your mentor the same day. Deleting the file in a new commit is not enough: it stays in the history. Make a new key, and your mentor resets the upload key.

## Step 1: The application ID from your mentor

Every app on Play has a unique **application ID**, and it can never change after the first upload. Apps starting with `com.example` are refused.
The course uses this pattern; your mentor confirms yours:

```text
com.anaxionai.<your github user name>.<app name>
```

- all lowercase; letters, digits and `_` only (change `-` to `_`); each part starts with a letter;
- examples: `com.anaxionai.asha_k.shoplist`, `com.anaxionai.ravi99.studytimer`.

**Set it when you create the app, before `flutterfire configure`.** `flutter create` builds the ID from `--org` and the project name:

```bash
flutter create --org com.anaxionai.asha_k --platforms=android,web shoplist
```

gives the ID `com.anaxionai.asha_k.shoplist`. Firebase registers your Android app under this ID when you run `flutterfire configure`, so set it first.

Check it (or fix an existing project) in `android/app/build.gradle.kts`, in `defaultConfig`:

```kotlin
applicationId = "com.anaxionai.asha_k.shoplist"
```

And the name under the icon, in `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="ShopList"
```

Firestore apps: after changing the ID, run `flutterfire configure` again and choose the new Android app, so Firebase knows it (see [`firebase/README.md`](../firebase/README.md)).

## Step 2: The app icon

Make a square PNG, 1024 by 1024 pixels, with no text smaller than you can read on a phone. For an adaptive icon, also make a foreground PNG with transparent edges (keep the picture in the middle 60%).
Save them in your project as `assets/icon.png` and `assets/icon-foreground.png`. Free tools: Excalidraw, Figma, or any drawing app; use only images you made or may use.

Add the package and its settings to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.4

flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icon-foreground.png"
```

Then:

```bash
flutter pub get
dart run flutter_launcher_icons
```

Run the app on your phone: the new icon is on the home screen.

## Step 3: Create your upload key (once per app)

In Git Bash, in your **user folder**:

```bash
cd ~
keytool -genkey -v -keystore ~/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

It asks for a password (twice), your name and a few details (you may press Enter for the details), then `Is CN=... correct?`: type `yes`.

`keytool: command not found`? It comes with Java. Run `flutter doctor -v`, find `Java binary at:` and use `keytool` from that folder, for example:
`"/c/Program Files/Android/Android Studio/jbr/bin/keytool" -genkey ...` (the JDK 21 from `setup/windows.md` has `keytool` too).

## Step 4: Tell Gradle about the key

Create `android/key.properties` (inside your app; it is ignored by Git):

```properties
storePassword=<the password you chose>
keyPassword=<the password you chose>
keyAlias=upload
storeFile=C:\\Users\\<your name>\\upload-keystore.jks
```

On Windows, write the path with **double backslashes**, as above.

Check that Git ignores it, in your app's folder:

```bash
git check-ignore -v android/key.properties
```

It prints the `.gitignore` line that ignores it. **No output means it is not ignored**: copy the kit's `.gitignore` to the top of your repository first (`setup/windows.md`, Step 2b).

Then edit `android/app/build.gradle.kts`. At the top, load the file:

```kotlin
import java.util.Properties
import java.io.FileInputStream

// (the plugins { } block stays here)

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
```

Inside `android { }`, add the signing config and use it for release builds:

```kotlin
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
```

Remove the template's `signingConfig = signingConfigs.getByName("debug")` line from `release`.

## Step 5: The version

In `pubspec.yaml`:

```yaml
version: 1.0.0+1
```

`1.0.0` is the **version name** testers see. The number after `+` is the **version code**: Play needs a **bigger** version code for every upload, so raise it each time (`1.0.0+2`, `1.0.1+3` ...). Play refuses an upload whose version code it has already seen.

Play also needs new apps to target **API level 36** (Android 16) since 31 August 2026. Flutter's template sets `targetSdk = flutter.targetSdkVersion`; check it with your mentor if Play reports a target API error.

## Step 6: Build the app bundle

```bash
flutter build appbundle
```

The last lines show the file:

```text
√ Built build/app/outputs/bundle/release/app-release.aab (21.3MB)
```

Paste the last lines into `evidence.md`, with the version name and code. The first release build takes several minutes.

Never commit the `.aab` (the kit's `.gitignore` ignores `*.aab`). Before you hand it over, install the release on your own phone and try the main flow: `flutter run --release`.

## Step 7: Hand the bundle to your mentor

Send the `.aab` to your mentor **outside Git**, in the way your mentor gives you (usually the centre's shared upload folder; the file is too big for chat). Name it `<github user name>-<app>-<version code>.aab`, for example `asha_k-shoplist-3.aab`. Send with it:

- the application ID and the version name and code;
- the Google account emails of your testers (yourself and up to a few classmates or family), in a private message to your mentor, **never in your repository**;
- one line on what to test.

## Step 8: What your mentor does, and sends back

On the centre's account in Play Console, your mentor:

1. creates the app (once) with your application ID's name;
2. opens **Test and release → Testing → Internal testing**, creates a release, uploads your `.aab` and names the release (for example `3 (1.0.0)`);
3. adds your testers' emails to the internal testers list (internal testing allows up to 100 testers per app);
4. rolls the release out and sends you, as text:
   - the **release name**, the **version code** and the **track status** (for example "Internal testing: available to internal testers"),
   - the **opt-in link** for testers.

Paste that text into `evidence.md` as your task asks. Internal test releases usually reach testers within minutes, but may need review: if nothing arrives the same day, ask your mentor.

## Step 9: Testers join and install

Each tester:

1. opens the **opt-in link** on their phone while signed in to the Google account your mentor added;
2. selects **Accept invite** (or "Become a tester"), then the link to download it from Google Play;
3. installs the app from Google Play like any app.

Testers cannot find the app by searching Play: only the link works. A new upload reaches them as an update in Play.

## Why not a public release?

A new personal Play account must run a **closed test with at least 12 testers for 14 days in a row** before it may apply for production. The course has no time for that, so every app stays in internal testing, which is enough to put it on real phones. Production release is out of scope.

## Release checklist

- [ ] Application ID from your mentor, not `com.example...`
- [ ] App name (`android:label`) and icon set
- [ ] Upload key in your user folder, backed up privately
- [ ] `git check-ignore -v android/key.properties` prints a line
- [ ] Version code raised since the last upload
- [ ] `flutter build appbundle` succeeded; `flutter run --release` works on your phone
- [ ] `.aab` sent to your mentor outside Git, with the testers' emails sent privately
- [ ] Release name, version code, status and opt-in link pasted into `evidence.md`
- [ ] No key, password, `key.properties` or `.aab` in any commit

## Sources (checked 24 November 2026)

- Build and release an Android app: https://docs.flutter.dev/deployment/android
- App icons: https://pub.dev/packages/flutter_launcher_icons
- Internal testing (up to 100 testers, opt-in link): https://support.google.com/googleplay/android-developer/answer/9845334
- Play App Signing and resetting a lost upload key: https://support.google.com/googleplay/android-developer/answer/9842756
- Testing requirements for new personal accounts (12 testers, 14 days): https://support.google.com/googleplay/android-developer/answer/14151465
- Target API level: https://developer.android.com/google/play/requirements/target-sdk
- Registration fee (paid once by the centre, never by you): https://support.google.com/googleplay/android-developer/answer/6112435
