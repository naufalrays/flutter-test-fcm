import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_fcm/local_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    //Ketika notifikasi diklik dan keadannya on Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.data);
        print(message.notification!.title);
      }
    });

    //Ketika notifikasi diklik dan keadaannya on background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});

    //Ketika on foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
          print(
              'Message also contained a notification: ${message.notification!.title}');
        }
        LocalNotificationServices.createNotification(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Flutter FCM"),
      ),
      body: const Center(
        child: Text(
          "Flutter FCM",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
