@echo off
"C:\\Users\\User\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\src\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=23" ^
  "-DANDROID_PLATFORM=android-23" ^
  "-DANDROID_ABI=arm64-v8a" ^
  "-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a" ^
  "-DANDROID_NDK=C:\\Users\\User\\AppData\\Local\\Android\\Sdk\\ndk\\27.2.12479018" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\User\\AppData\\Local\\Android\\Sdk\\ndk\\27.2.12479018" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\User\\AppData\\Local\\Android\\Sdk\\ndk\\27.2.12479018\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\User\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=G:\\- DEv\\JavaScript\\LANA\\Flutter\\GMail Manager\\gmail_manager\\android\\app\\build\\intermediates\\cxx\\Debug\\1u1g2y4v\\obj\\arm64-v8a" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=G:\\- DEv\\JavaScript\\LANA\\Flutter\\GMail Manager\\gmail_manager\\android\\app\\build\\intermediates\\cxx\\Debug\\1u1g2y4v\\obj\\arm64-v8a" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BG:\\- DEv\\JavaScript\\LANA\\Flutter\\GMail Manager\\gmail_manager\\android\\app\\.cxx\\Debug\\1u1g2y4v\\arm64-v8a" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
