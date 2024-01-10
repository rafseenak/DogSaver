// ignore_for_file: constant_identifier_names

import 'package:dog_catcher/screens/message_screen.dart';
import 'package:dog_catcher/screens/splash_screen.dart';
import 'package:dog_catcher/services/push_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';
const ANONIMOUS_KEY = 'Anonimous';
final navigatorKey = GlobalKey<NavigatorState>();
Future _firebaseBackgroundMessaging(RemoteMessage message) async {
  if (message.notification != null) {
    print('Notification Recieved');
  } else {
    print('No Notification Recieved');
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Notification Tapped');
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    } else {
      print('No Notification Tapped');
    }
  });
  PushNotofications.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessaging);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      home: const SplashScreen(),
      routes: {
        '/message': (context) => const MessageScreen(),
      },
    );
  }
}
