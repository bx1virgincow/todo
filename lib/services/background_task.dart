import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

class BackgroundTasks {
  static void initialize() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
      "1",
      "weeklyNotification",
      frequency: Duration(seconds: 60),
      initialDelay: Duration(seconds: 10), // For testing purpose, change to appropriate duration
    );
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case "weeklyNotification":
          LocalNotifications.showNotification(
            title: 'Weekly Reminder',
            body: 'Don\'t forget to put down some notes!',
          );
          break;
      }
      return Future.value(true);
    });
  }
}
