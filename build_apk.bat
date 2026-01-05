@echo off
REM Build APK script for Flutter project

echo Building APK...
echo.

REM Flutter path found at D:\flutter\bin\flutter.bat
set FLUTTER_PATH=D:\flutter\bin\flutter.bat

if exist "%FLUTTER_PATH%" (
    echo Flutter found at: %FLUTTER_PATH%
    echo.
    echo Cleaning project...
    "%FLUTTER_PATH%" clean
    echo.
    echo Getting dependencies...
    "%FLUTTER_PATH%" pub get
    echo.
    echo Building release APK...
    "%FLUTTER_PATH%" build apk --release
    echo.
    if exist "build\app\outputs\flutter-apk\app-release.apk" (
        echo.
        echo ========================================
        echo APK built successfully!
        echo Location: build\app\outputs\flutter-apk\app-release.apk
        echo ========================================
    ) else (
        echo.
        echo Build completed but APK not found at expected location.
    )
) else (
    echo Flutter not found at: %FLUTTER_PATH%
    echo.
    echo Please update FLUTTER_PATH in this script with your Flutter installation path.
    pause
)

