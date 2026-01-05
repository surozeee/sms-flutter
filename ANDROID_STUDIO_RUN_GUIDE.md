# How to Run Flutter App in Android Studio

## Quick Fix Steps:

### 1. **Start an Android Emulator**
I've started an emulator for you. Wait 30-60 seconds for it to boot up.

**Or manually:**
- In Android Studio: Click **Device Manager** icon (phone icon in toolbar)
- Click the **Play** button next to an emulator
- Wait for it to start

### 2. **Verify Flutter Plugin in Android Studio**
- Open Android Studio
- Go to **File → Settings** (Windows) or **Android Studio → Preferences** (Mac)
- Go to **Plugins**
- Search for "Flutter" - make sure it's **installed and enabled**
- Also check "Dart" plugin is installed
- Click **Apply** and restart Android Studio if needed

### 3. **Open Project as Flutter Project**
- In Android Studio: **File → Open**
- Select the folder: `D:\Android\SMS`
- Wait for Android Studio to sync and index
- You should see "Flutter" in the top toolbar

### 4. **Check Device Connection**
After emulator starts:
- Look at the top toolbar in Android Studio
- You should see a device dropdown (shows "No devices" if none connected)
- Once emulator boots, it should appear in the dropdown

### 5. **Run the App**
- Select your emulator from the device dropdown
- Click the **Run** button (green play icon) or press **Shift+F10**
- Or right-click on `lib/main.dart` → **Run 'main.dart'**

### Alternative: Run from Terminal
```bash
# Check if device is connected
flutter devices

# Run the app
flutter run
```

### Troubleshooting:
- **No devices showing?** 
  - Wait for emulator to fully boot (can take 1-2 minutes)
  - Check if emulator is running in Android Studio Device Manager
  
- **No Run button?**
  - Make sure Flutter plugin is installed
  - Restart Android Studio
  - File → Invalidate Caches → Restart

- **Project not recognized?**
  - Close Android Studio
  - Delete `.idea` folder in project root
  - Reopen project in Android Studio

