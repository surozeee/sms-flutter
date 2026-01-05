# Android Studio Setup Guide

## Issue: No Run Option in Android Studio

If you don't see the run option in Android Studio, follow these steps:

### 1. Check Flutter Plugin Installation
- Open Android Studio
- Go to **File → Settings** (or **Android Studio → Preferences** on Mac)
- Navigate to **Plugins**
- Search for "Flutter" and ensure it's installed
- Also install "Dart" plugin (required for Flutter)

### 2. Open Flutter Project Correctly
- In Android Studio, go to **File → Open**
- Select the project root folder (D:\Android\SMS)
- Wait for Android Studio to index the project
- You should see "Flutter" in the toolbar

### 3. Connect an Android Device or Emulator

#### Option A: Connect Physical Device
1. Enable **Developer Options** on your Android phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable **USB Debugging**:
   - Go to Settings → Developer Options
   - Enable "USB Debugging"
3. Connect phone via USB
4. Accept the USB debugging prompt on your phone

#### Option B: Create/Start Android Emulator
1. In Android Studio, click **Device Manager** (phone icon in toolbar)
2. Click **Create Device**
3. Select a device (e.g., Pixel 5)
4. Download a system image (e.g., API 33 or 34)
5. Click **Finish**
6. Click the **Play** button next to the emulator to start it

### 4. Verify Device Connection
Run in terminal:
```bash
flutter devices
```

You should see your device/emulator listed.

### 5. Run the App
Once a device is connected:
- Click the device selector dropdown (top toolbar)
- Select your device/emulator
- Click the **Run** button (green play icon) or press **Shift+F10**

### Alternative: Run from Terminal
```bash
flutter run
```

This will automatically detect and use the connected device/emulator.

