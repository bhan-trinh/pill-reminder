import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print("Notification Permission Granted");
  } else {
    print("Notification Permission Denied");
  }
}


  NotificationDetails notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
  

  Future<void> showNotification({
      int id = 0,
      String? title,
      String? body,
    }) async {
      if (!_isInitialized) {
        await requestNotificationPermission();
        await initNotification(); // Ensure initialization is completed before showing the notification.
      }

      // Pass the correct NotificationDetails to the show method.
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(), // Pass the notificationDetails() that includes AndroidNotificationDetails
      );
    }

  Future<void> showNotificationWithDelay({
    int id = 0,
    String? title,
    String? body,
  }) async {

      if (!_isInitialized) {
        await requestNotificationPermission();
        await initNotification(); // Ensure initialization is completed before showing the notification.
      }

      // Pass the correct NotificationDetails to the show method.
      await Future.delayed(Duration(minutes: 1)); // Wait for 1 minute
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(), // Pass the notificationDetails() that includes AndroidNotificationDetails
      );
  }
}