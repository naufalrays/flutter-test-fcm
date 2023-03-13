import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  //Create an instance
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //Set initialize method
  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      //Setting the notification icon of our icon
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  //
  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotification",
          "pushnotificationchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
