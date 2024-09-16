class Strings {
  // hive boxes
  static const String appBox = 'app_box';
  static const String notificationBox = 'notification_box';

  // bottom sheet texts
  static const String sendConfirmation = '''
Please make sure you have set up the push notification settings properly before sending the notification.
      
✨ Check Server key.
✨ Check Topic Name.
✨ Check Device id.

Active internet connection is required!''';

  /// Hint texts
  static const String fcmTypeV1Hint = """
JSON private key (Service Account) *


Generate and copy the entire JSON key -

https://console.firebase.google.com/project/_/settings/serviceaccounts/adminsdk""";

  static const String fcmTypeLegacyHint = """
Server Key *


You can get it from -

https://console.firebase.google.com/project/_/settings/cloudmessaging""";
}
