# 环境配置

作为 Flutter 项目，你须预先安装好 Flutter。

## 配置环境的一般步骤

我完全可以建议阅读官方文档，但是在这里我仍然要提及一些官方文档没有涉及的细节。

在电脑上安装好 Flutter，就跟着[中文社区教程](https://docs.flutter.cn/get-started/install)（或者[官方教程](https://docs.flutter.dev/get-started/install)）走就好。如果你需要，就跟着教程配置 `pub.dev` 镜像地址。在 `flutter` 命令可以用之后，在终端里跑一遍 `flutter doctor`，跟着上面的指引走。举个例子：

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

要构建 Windows 及 Android 版本，遵循下面的指引：

## Windows

目前桌面版本仍然只是在计划之中。

你需要安装 Visual Studio。如果你日常使用 Visual Studio，使用社区版或者其他版本就可以。如果你不想安装这么笨重的环境，就改用 Visual Studio 构建工具（Visual Studio Building Tools）。要么安装“使用 C++ 的桌面开发”工作负载，要么一个一个安装 `flutter doctor` 所列的包。

## Android

类似 Visual Studio，你可考虑采用 Android Studio 作为开发用的 IDE。这样的话，安装 Android Studio，然后创建一个项目，点击右上角的设置按钮，选择“SDK Manager”，然后选择“SDK Tools”。你至少要选择“Android SDK Command-Line Tools (latest)”。要调试的话，根据需求选择“Android Emulator”或者“Google USB Driver”。

如果不想安装整个 IDE，改用命令行工具也可以。还是要看[官方文档（国内的）](https://developer.android.google.cn/studio?hl=zh-cn)。

如果需要，同意 Android 许可条款：

```
flutter doctor --android-licenses
```

不要忘了把 `你的android/studio/所在的/位置/Sdk/cmdline-tools/latest（或者别的什么版本）/bin` 放到 PATH 变量里。

### Android 模拟器

TODO: 待完成

### Android 真机

使用真机调试，需要预先安装 `adb`：

```
sdkmanager "platform-tools"
```

这里以 Windows 为例。为了使用刚刚安装的 `adb.exe`，将 `the/path/to your/android/studio/Sdk/platform-tools` 加入到环境变量以在任意位置访问。

使用 USB 线把设备和电脑连起来，或者就将其放在同一 WLAN 局域网下。按照教程设置 ADB 连接，这样你就可以在 `adb devices` 里找到该设备。然后使用 `flutter devices` 看看 Flutter 能不能找到这台设备。

在项目根目录下启动调试：

```
flutter run -d <your device>
```

确保网络连接稳定，直到在设备上看到应用安装页面。

### 其他操作系统

我暂时无法在其他操作系统上编译。对此我的建议就是阅读对应平台的文档。