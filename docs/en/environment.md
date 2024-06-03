# Environment Configuration

As a Flutter project, you must have Flutter installed preciously.

## General Environment Configuration

After all I can suggest reading the offical doc. But there are many aspects that're not refered and have to note here.

Install Flutter on your computer. Get started via [the official guide](https://docs.flutter.dev/get-started/install) is just okay. When the command `flutter` is available, run `flutter doctor` on your terminal and follow the guide according to the platform you want to build. Here is an example:

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.19.2, on Microsoft Windows [Version 10.0.22621.3155], locale zh-CN)
[✓] Windows Version (Installed version of Windows is version 10 or higher)
[!] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    ✗ cmdline-tools component is missing
      Run `path/to/sdkmanager --install "cmdline-tools;latest"`
      See https://developer.android.com/studio/command-line for more details.
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/docs/get-started/install/windows#android-setup for more details.
[✗] Chrome - develop for the web (Cannot find Chrome executable at .\Google\Chrome\Application\chrome.exe)
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.
[!] Visual Studio - develop Windows apps (Visual Studio Building Tools 2022 17.8.6)
    ✗ Visual Studio is missing necessary components. Please re-run the Visual Studio installer for the "Desktop
      development with C++" workload, and include these components:
        MSVC v142 - VS 2019 C++ x64/x86 build tools
         - If there are multiple build tool versions available, install the latest
        C++ CMake tools for Windows
        Windows 10 SDK
[✓] Android Studio (version 2023.1)
[✓] VS Code (version 1.87.0)
[✓] Connected device (2 available)
[!] Network resources
    ✗ A cryptographic error occurred while checking "https://pub.dev/": Connection terminated during handshake
      You may be experiencing a man-in-the-middle attack, your network may be compromised, or you may have malware
      installed on your computer.
```

If you want to build for Windows and Android, follow the corresponding guide.

## Windows

Currently the desktop version is just PLANNED.

Generally Visual Studio is needed. If you use Visual Studio as your daily IDE, the community version or other suitable versions would work. If you don't want such a huge thing, use Visual Studio Building Tools instead. Either choose "Desktop development with C++" workload, or add packages listed on `flutter doctor`.

## Android

Like Visual Studio, you can consider use Android Studio as your IDE for development. For this case, after installing Android Studio, create a project with it, click the Settings button in the top right-hand corner, choose "SDK Manager", and then choose "SDK Tools". You need to choose "Android SDK Command-Line Tools (latest)" at least. To debug, you should choose "Android Emulator" or "Google USB Driver" due to your needs.

If you don't want a huge IDE, install the command-line tools instead. Also from the [official site](https://developer.android.google.com/studio).

Anyway, accept the Android licenses by

```
flutter doctor --android-licenses
```

if you have to.

Don't forget to add `the/path/to/your/android/studio/Sdk/cmdline-tools/latest(or any other version)/bin` to the PATH variable.

### Android Emulator

You may want an Android Emulator to debug. Ensure you have JDK installed and environment variables like `JAVA_HOME` configured first, then create an Android AVD image:

```
avdmanager create avd -n flutter -k "system-images;android-34;google_apis;x86_64"
```

Now you can create a Flutter Android Emulator:

```
flutter emulators --create --name android
```

Finally launch the emulator to 

TODO: complete this part

### Android Real Machines

You need `adb` installed to debug with a real machine.

```
sdkmanager "platform-tools"
```

Let's see Windows as an example. To reach `adb.exe` just added on your computer, add `the/path/to your/android/studio/Sdk/platform-tools` to the environment variable to get access to it everywhere.

Either use a USB cable to link between the device and the computer, or let them be on the same WLAN. Follow the guide on line to set ADB connect between them until you can find it on `adb devices`. Then seek for its name by `flutter devices`.

Start debugging on the root of this project:

```
flutter run -d <your device>
```

Ensure you have a stable network connection. Wait until you can see the app installation on your device.

## Other Operating System

I'm not able to build the project on any other operating systems. For them the only suggestion I can give is to follow the official guideline for the platform you are building for.