import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  //notification singleton
  static final LocalNotifications _localNotifications =
      LocalNotifications._internal();

  LocalNotifications._internal();

  //factory
  factory LocalNotifications() {
    return _localNotifications;
  }

  //instance of the notification
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static get flutterLocalNotificationPlugin => _flutterLocalNotificationsPlugin;

  //initialize function
  static void initialize() async {
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettingsAndroid,
    );
  }

  static Future showNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin flp,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    final notification = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flp.show(id, title, body, notification);
  }
}
