import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  // static Future localInit() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('defaultIcon');
  // }
}
