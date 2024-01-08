import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotofications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    final token = _firebaseMessaging.getToken();
    print("Device token $token");
  }
}
