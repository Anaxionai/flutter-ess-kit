# Set up your Windows laptop for Flutter

This guide sets up a Windows laptop for the whole course. **Git Bash is your terminal**, inside VS Code.
Do Part 1 in the Launchpad (week 1) when your task says so, and Part 2 at the start of P3 ShopList (week 6). After each step, run its check before you go on.

The versions are in [`VERSIONS.md`](../VERSIONS.md). Steps that need your phone are in [`phone.md`](phone.md).

## Before you start

- **Windows 10 or 11, 64-bit.** Press Windows+R, type `winver` and press Enter to see your version.
- **At least 8 GB of memory.** You run apps on your own Android phone, not in an emulator: see [`phone.md`](phone.md).
- **About 15 GB of free disk space** for Flutter, the Android SDK and Android Studio (our estimate; the downloads grow over time).
- **An administrator account** on the laptop, and a good Wi-Fi connection: Part 1 downloads about 3 GB.
- **Your Android phone and its USB cable** (a cable that carries data, not only charge).
- Keep the charger plugged in. If your laptop does not run Windows, ask your mentor for the matching steps.

## What you install, and when

| Tool | What it is for | When |
|---|---|---|
| Git for Windows (Git Bash) | Version control and your terminal; Flutter needs Git | Week 1, Launchpad task 6 |
| VS Code + the Flutter extension | Where you write and run code | Week 1, Launchpad task 7 |
| The course kit | The files your tasks link to and copy. It lives in your home folder: `~/flutter-ess-kit` | Week 1, Launchpad task 7 |
| Flutter SDK (with Dart) | Builds and runs your apps | Week 1 |
| Google Chrome | Runs your app in the browser | Week 1 |
| Android Studio (SDK only) | Installs the Android SDK, `adb` and the licences. You never use it to write code | Week 1 |
| Node.js 24 | Runs the Firebase CLI | Week 6 |
| Firebase CLI and FlutterFire CLI | Connect your app to Firebase and run the emulator | Week 6 |
| Java (JDK 21 or newer) | Runs the Firebase Local Emulator Suite | Week 6 |

Run every command in **Git Bash**, unless a step says PowerShell.

## Part 1, week 1

Launchpad task 6 does Step 1. Task 7 does Steps 2 to 6, all in Git Bash. Task 11 does Step 7, with your phone.

### Step 1: Git for Windows

Launchpad task 6 installs Git from https://git-scm.com/downloads/win with the default options. Those options include Git Bash and Git Credential Manager (for signing in to GitHub).

Check it in Git Bash:

```bash
git --version
```

You see `git version 2.` and more numbers. Any version from 2.45 is fine.

### Step 2: VS Code, Git Bash and LF line endings

1. Install VS Code from https://code.visualstudio.com/download with the default options. Tick **Add to PATH** if the installer asks.
2. Make Git Bash the terminal: press Ctrl+Shift+P, type `Terminal: Select Default Profile` and choose **Git Bash**.
3. Line endings: open **Settings** (Ctrl+,), search for `eol` and set **Files: Eol** to `\n`. This is the setting `"files.eol": "\n"`.
4. Select **Extensions** (Ctrl+Shift+X), search for **Flutter** and install the extension from **Dart Code** (dartcode.org). It installs the Dart extension with it.

Check it: open a new terminal (**Terminal**, then **New Terminal** in the top menu). The prompt shows `MINGW64`. Open a new file: the status bar at the bottom right shows `LF`, not `CRLF`. In Git Bash, this prints the Eol setting:

```bash
grep eol "$APPDATA/Code/User/settings.json"
```

Your task asks you to paste that line into `evidence.md`. If it prints nothing, set **Files: Eol** under the **User** tab of Settings, not Workspace.

### Step 2b: The course kit, and its two Git files in your repository

Clone the kit next to your course repository (never inside it). Launchpad task 7 does this in its step 3, in Git Bash:

```bash
cd ~ && git clone https://github.com/Anaxionai/flutter-ess-kit.git
ls ~/flutter-ess-kit
```

You see `README.md`, `VERSIONS.md`, `setup` and the other folders.

Your course repository needs the kit's `.gitignore` (keeps `build/`, `.dart_tool/`, keys and `key.properties` out of Git) and `.gitattributes` (LF line endings). Copy them to the **top folder** of your course repository once. Launchpad task 7 does this in its last step, after the clone:

```bash
cd <your course repository>
cp ~/flutter-ess-kit/.gitignore ~/flutter-ess-kit/.gitattributes .
git add .gitignore .gitattributes
git commit -m "chore: add the course kit's gitignore and gitattributes"
```

If your repository already has a `.gitignore`, add the kit's lines to the end of yours instead: `cat ~/flutter-ess-kit/.gitignore >> .gitignore`.

### Step 3: The Flutter SDK

The Flutter docs recommend installing the SDK through the VS Code extension:

1. In VS Code, press Ctrl+Shift+P, type `Flutter: New Project` and press Enter.
2. VS Code says it cannot find a Flutter SDK. Select **Download SDK**.
3. Choose the folder `C:\dev` (make it if it does not exist). Any folder with **no spaces** and no special characters in its path works; never use `C:\Program Files`.
4. Wait while it clones Flutter (several minutes). When VS Code asks **Add SDK to PATH**, select it.
5. Close the new-project prompt (press Escape): you make your first project in a task.
6. **Close VS Code completely and open it again**, so that its terminals see the new PATH.

If the download fails, use the manual way from https://docs.flutter.dev/install/manual: download the Windows zip for the version in `VERSIONS.md`, extract it to `C:\dev\flutter`, and add `C:\dev\flutter\bin` to your user PATH (Start → "Edit environment variables for your account" → Path → New).

Check it in Git Bash:

```bash
flutter --version
dart --version
```

You see `Flutter 3.50.` and `Dart SDK version: 3.14.` (or the version in `VERSIONS.md`). The first run takes a minute while Flutter sets itself up.
If you see `flutter: command not found`, the PATH is not set: close every VS Code window and open it again, then ask your mentor.

### Step 4: Chrome, and your first run in the browser

Install Google Chrome from https://www.google.com/chrome/ if you do not have it.

Check it:

```bash
flutter devices
```

The list includes **Chrome (web)**. Launchpad task 7 runs the counter app with `flutter run -d chrome`.

### Step 5: Android Studio, only for the Android SDK

Flutter needs the Android SDK, its command-line tools and `adb`. Android Studio installs them. You keep writing code in VS Code.

1. Install Android Studio from https://developer.android.com/studio (or in PowerShell: `winget install -e --id Google.AndroidStudio`).
2. Start it. In the setup wizard choose **Custom**, keep **Android SDK** and **Android SDK Platform** ticked, and **untick Android Virtual Device**. You do not need the emulator: you use your phone. Accept the licences and finish. It downloads about 2 GB.
3. On the welcome screen select **More Actions → SDK Manager**:
   - **SDK Platforms**: tick **Android 16.0 ("Baklava")**, API level 36.
   - **SDK Tools**: tick **Android SDK Build-Tools**, **Android SDK Command-line Tools (latest)** and **Android SDK Platform-Tools**. Leave **Android Emulator** unticked unless your laptop has 16 GB of memory.
   - Select **Apply**, then **OK**.
4. Close Android Studio. It uses a lot of memory: you only open it again to update the SDK.

Accept the Android licences in Git Bash (type `y` and Enter at each question):

```bash
flutter doctor --android-licenses
```

It ends with `All SDK package licenses accepted.`

Put `adb` on your PATH, so you can run it in Git Bash. Add this line to the end of `~/.bashrc`, then open a new terminal:

```bash
echo 'export PATH="$PATH:$LOCALAPPDATA/Android/Sdk/platform-tools"' >> ~/.bashrc
```

Check it: `adb version` prints `Android Debug Bridge version 1.0.41` and `Version 37.` or newer.

### Step 6: flutter doctor

```bash
flutter doctor
```

You want a tick (`[√]`) for **Flutter**, **Windows Version**, **Android toolchain**, **Chrome** and **Connected device** (once your phone is plugged in).

- `[X] Visual Studio - develop Windows apps` is **fine**: the course does not build Windows desktop apps.
- `[!] Android Studio` warnings are fine as long as **Android toolchain** has a tick.
- `cmdline-tools component is missing`: go back to Step 5, item 3, and tick **Android SDK Command-line Tools (latest)**.
- `Android license status unknown`: run `flutter doctor --android-licenses` again.

Paste the output into your task's `evidence.md` when the task asks for it.

### Step 7: Your phone

Follow [`phone.md`](phone.md) to turn on developer options and USB debugging. Then plug in the phone and check:

```bash
adb devices
flutter devices
```

`adb devices` lists your phone with the word `device` after its serial number. `flutter devices` lists your phone by its model name, next to Chrome.

## Part 2, week 6: Firebase tools for P3 ShopList

### Step 8: Node.js 24

The Firebase CLI runs on Node.js.

1. Download the **Windows Installer (.msi)** for **Node.js 24 LTS** from https://nodejs.org/en/download (choose v24 in the version list), and run it with the default options. (Node 26 also works.)
2. Close and reopen VS Code.

Check it: `node --version` prints `v24.12` or newer (the rules tests in P3 need 24.12 or newer), and `npm --version` prints a number.

### Step 9: Firebase CLI

```bash
npm install -g firebase-tools
firebase --version
firebase login
```

`firebase --version` prints `15.` or newer. `firebase login` opens your browser: sign in with the Google account you use for the course. If Git Bash waits forever, press Ctrl+C and run `firebase login --no-localhost`, then follow its steps.

### Step 10: FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

Dart installs it into `%LOCALAPPDATA%\Pub\Cache\bin`. Put that folder on your PATH:

```bash
echo 'export PATH="$PATH:$LOCALAPPDATA/Pub/Cache/bin"' >> ~/.bashrc
```

Open a new terminal. Check it: `flutterfire --version` prints `1.5.` or newer.
`firebase/README.md` uses it to connect your app.

### Step 11: Java 21 for the Firebase emulator

The Firebase Local Emulator Suite runs on Java, and the Firebase CLI refuses Java older than 21 (the emulator install page still says 11; the CLI's release notes are newer). In **PowerShell**:

```powershell
winget install -e --id Microsoft.OpenJDK.21
```

Close and reopen VS Code. Check it in Git Bash:

```bash
java -version
```

You see `openjdk version "21.` If you see `java version "1.8.`, an old Oracle Java comes first on your PATH: open "Edit the system environment variables" → Environment Variables → Path, and move the `Microsoft\jdk-21...` line above any `Oracle\Java` line (or uninstall the old Java). Ask your mentor if you are not sure.

Do **not** set `JAVA_HOME` for Flutter: Flutter builds Android apps with the Java inside Android Studio.

**keytool** (for the release key in P3) comes with Java and sits next to `java`. Check it: `keytool -help` prints its commands. If Git Bash says `keytool: command not found`, run `where java` in PowerShell and use `keytool` from the same folder, or the one in Android Studio's `jbr/bin` folder (`flutter doctor -v` shows it after "Java binary at:"). See `release/README.md`.

## When something goes wrong

| What you see | What to do |
|---|---|
| `flutter: command not found` | Close every VS Code window and open VS Code again. Then check that the Flutter `bin` folder is in your user PATH |
| `Waiting for another flutter command to release the startup lock` | Another Flutter command is still running. Wait, or close the other terminals |
| A build fails with `Gradle` and `Java` in the message | Run `flutter doctor -v` and send the Android toolchain part to your mentor |
| The first Android build takes 5 to 10 minutes | Normal: Gradle downloads what it needs once. Later builds are much faster |
| The laptop is very slow while building | Close Android Studio, Chrome tabs and other apps. Never run an emulator on an 8 GB laptop |
| Antivirus warnings about Flutter or Gradle | Ask your mentor; do not turn antivirus off yourself |

## Sources (checked 24 November 2026)

- Install Flutter on Windows for Android: https://docs.flutter.dev/get-started/install/windows/mobile and https://docs.flutter.dev/install/manual
- Set up Android development: https://docs.flutter.dev/platform-integration/android/setup
- Android Studio and the SDK: https://developer.android.com/studio
- Firebase CLI: https://firebase.google.com/docs/cli ; FlutterFire: https://firebase.google.com/docs/flutter/setup
- Emulator requirements: https://firebase.google.com/docs/emulator-suite/install_and_configure
