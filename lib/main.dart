import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_fcm/firebase_options.dart';
import 'package:flutter_test_fcm/local_services.dart';
import 'package:flutter_test_fcm/view_models/home_view_model.dart';
import 'package:flutter_test_fcm/views/home_view.dart';
import 'package:provider/provider.dart';

Future<void> _handleBackgroundNotification(RemoteMessage message) async {
  print("Background Notification Listening");
  print("Handling a backgronud message: ${message.notification}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await requestPermission();
  LocalNotificationServices.initialize();
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotification);

  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const MyApp(),
    ),
  );
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
