# Fix APK Installation Issues

## Quick Fix Steps

### Method 1: Using Flutter Install (Recommended)
```bash
# Run the fix script
fix_install.bat

# OR manually:
flutter clean
flutter pub get
flutter build apk --debug
flutter install
```

### Method 2: Manual Installation via ADB

1. **Enable USB Debugging on your device:**
   - Settings → About Phone → Tap "Build Number" 7 times
   - Settings → Developer Options → Enable "USB Debugging"

2. **Connect device and check:**
   ```bash
   flutter devices
   ```

3. **Uninstall existing app (if any):**
   ```bash
   adb uninstall com.example.campaign_connect
   ```

4. **Build and install:**
   ```bash
   flutter build apk --debug
   adb install -r build/app/outputs/flutter-apk/app-debug.apk
   ```

### Method 3: Enable Unknown Sources on Device

**For Android 8.0+:**
1. When you try to install, tap **Settings** in the prompt
2. Enable **Allow from this source**

**OR manually:**
1. Settings → Apps → Special app access → Install unknown apps
2. Select your file manager/browser
3. Enable **Allow from this source**

### Method 4: Fix Common Errors

**Error: "App not installed"**
- Uninstall existing version first
- Free up storage space (need 100MB+)
- Restart device

**Error: "Package appears to be corrupt"**
- Rebuild APK: `flutter clean && flutter build apk --debug`
- Check file size (should be 20-50MB)

**Error: "Installation blocked"**
- Enable "Install Unknown Apps" (see Method 3)
- Disable Play Protect temporarily

**Error: "Signature verification failed"**
- Uninstall existing app completely
- Rebuild APK
- Install fresh APK

### Method 5: Device-Specific Fixes

**Samsung:**
- Settings → Biometrics and security → Install unknown apps
- Enable for your file manager

**Xiaomi/MIUI:**
- Settings → Additional settings → Privacy → Unknown sources
- Enable "Unknown sources"
- Also enable: Settings → Apps → Manage apps → Special permissions → Install via USB

**Huawei/EMUI:**
- Settings → Security → Unknown sources
- Enable "Unknown sources"

**OnePlus/OxygenOS:**
- Settings → Apps → Special app access → Install unknown apps
- Enable for your file manager

### Method 6: Complete Clean Install

```bash
# 1. Clean everything
flutter clean
cd android
gradlew clean
cd ..

# 2. Remove old APK
del /f build\app\outputs\flutter-apk\app-debug.apk

# 3. Get dependencies
flutter pub get

# 4. Build fresh APK
flutter build apk --debug

# 5. Uninstall from device
adb uninstall com.example.campaign_connect

# 6. Install new APK
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

## What I Fixed in the Code

1. **Lowered Target SDK** from 36 to 34 (more compatible)
2. **Set Min SDK** to 21 (Android 5.0+)
3. **Added proper signing config** for debug builds
4. **Added manifest attributes** for better compatibility

## Still Having Issues?

1. **Check device compatibility:**
   - Minimum: Android 5.0 (API 21)
   - Recommended: Android 8.0+ (API 26+)

2. **Check storage:**
   - Need at least 100MB free space

3. **Try release build:**
   ```bash
   flutter build apk --release
   adb install -r build/app/outputs/flutter-apk/app-release.apk
   ```

4. **Check ADB connection:**
   ```bash
   adb devices
   # Should show your device
   ```

5. **Restart everything:**
   - Restart device
   - Restart ADB: `adb kill-server && adb start-server`
   - Rebuild APK

## Alternative: Use Android Studio

1. Open project in Android Studio
2. Connect device
3. Click "Run" button
4. Select your device
5. App will install automatically

