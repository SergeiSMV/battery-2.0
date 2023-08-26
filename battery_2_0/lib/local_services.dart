
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {

  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    notificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: ((details){}),
    );
    // ignore: avoid_print
    FirebaseMessaging.instance.getToken().then((String? token) { print(token); });
  }




  static void createNotification(RemoteMessage message) async {
    try{
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'pushnotification', 
          'pushnotificationchannel',
          importance: Importance.max,
          priority: Priority.high
        )
      );
      await notificationsPlugin.show(id, message.notification!.title, message.notification!.body, notificationDetails);
    } on Exception catch (_) { null; }
  }

}