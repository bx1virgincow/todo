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

  //android initialization
  // final AndroidInitializationSettings _androidInitializationSettings =
  //     AndroidInitializationSettings("app_icon");

  //initialize function
  static void initialize() async {
    InitializationSettings initializationSettingsAndroid =
        InitializationSettings(android: AndroidInitializationSettings('app_icon'));

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettingsAndroid,
    );
  }

  //show simple notification
  static Future<void> showNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails _notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails,
    );
  }

  //schedule notification
  static Future scheduleNotification({
    var id = 1,
    required String title,
    required String body,
    var payload,
  }) async {
    //android notification
    final AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      playSound: true,
      priority: Priority.high,
    );

    //notification details
    NotificationDetails _notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);

    //call show function
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      _notificationDetails,
    );
  }
}
