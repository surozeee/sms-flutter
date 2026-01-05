# SMS App - Flutter

A Flutter application to read contacts from SIM card, group them by carrier (NTC, Ncell, Smart), and send bulk SMS messages.

## Features

- 📱 Read contacts from device/SIM
- 🏷️ Group contacts by carrier (NTC, Ncell, Smart)
- ✅ Select contacts individually or by carrier
- 💬 Compose and send bulk SMS messages
- 📊 View sending status with count

## Requirements

- Flutter SDK 3.0.0 or higher
- Android device with SIM card
- Permissions: Contacts, SMS

## Installation

1. Clone or download this project
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Connect your Android device or start an emulator
5. Run `flutter run` to launch the app

## Permissions

The app requires the following permissions:
- **READ_CONTACTS**: To read contacts from the device
- **SEND_SMS**: To send SMS messages
- **READ_PHONE_STATE**: To access SIM information

These permissions will be requested when you first launch the app.

## Usage

1. **Grant Permissions**: When you first open the app, grant Contacts and SMS permissions
2. **Load Contacts**: Tap "Load Contacts" to read contacts from your device
3. **Select Contacts**: 
   - View contacts grouped by carrier (NTC, Ncell, Smart)
   - Select individual contacts or entire carrier groups
   - See the count of selected contacts
4. **Compose SMS**: 
   - Tap "Send SMS" button
   - Enter your message in the text box
   - View character count
5. **Send**: Tap "Send SMS" to send messages to all selected contacts
6. **View Status**: See sending status with success/failure count

## Carrier Detection

The app detects carriers based on phone number prefixes:
- **NTC**: Various prefixes starting with 980, 981, 982, 984, 985, 986
- **Ncell**: Various prefixes starting with 980, 981, 982, 984, 985, 986
- **Smart**: Various prefixes starting with 980, 981, 982, 984, 985, 986
- **Unknown**: Numbers that don't match known patterns

## Dependencies

- `permission_handler`: Handle app permissions
- `contacts_service`: Read contacts from device
- `flutter_sms`: Send SMS messages
- `sim_data`: Access SIM card information

## Notes

- SMS sending requires actual SMS permissions and may incur charges
- Carrier detection is based on common prefixes and may not be 100% accurate
- The app reads contacts from the device, not directly from SIM (Android limitation)

## License

This project is provided as-is for educational purposes.

