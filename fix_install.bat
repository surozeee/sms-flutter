@echo off
echo ========================================
echo APK Installation Fix Script
echo ========================================
echo.

echo Step 1: Cleaning previous builds...
call flutter clean
echo.

echo Step 2: Getting dependencies...
call flutter pub get
echo.

echo Step 3: Building debug APK...
call flutter build apk --debug
echo.

echo Step 4: Checking if device is connected...
call flutter devices
echo.

echo Step 5: Attempting to install...
call flutter install
echo.

echo ========================================
echo If installation failed, try manually:
echo 1. Enable "Install Unknown Apps" in device settings
echo 2. Uninstall existing app: adb uninstall com.example.campaign_connect
echo 3. Install APK: adb install -r build\app\outputs\flutter-apk\app-debug.apk
echo ========================================
pause

