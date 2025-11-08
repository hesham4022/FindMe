import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _registerChannel();
      _initialized = true;
    }
  }

  Future<void> _registerChannel() async {
    const channelID = 'high_importance_channel';
    const channelName = 'Sellity notifications';
    const channelDescription =
        'This channel is used for Sellity notifications.';

    // Create a notification channel. This is required for Android notifications.
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
      channelID,
      channelName,
      description: channelDescription,
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );

    // Request permissions on Android. for (android 13.0 and above)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }
}
