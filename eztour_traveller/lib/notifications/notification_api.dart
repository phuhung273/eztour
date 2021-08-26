import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi{
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final BehaviorSubject<String?> selectNotificationSubject =
  BehaviorSubject<String?>();

  static final sound = 'rooster_2.wav';

  static final platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      'your channel id 2',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      enableVibration: true,
      ticker: 'Ticker',
      playSound: true,
      icon: '@mipmap/ic_launcher',
    ),
    iOS: IOSNotificationDetails(
      sound: sound,
    ),
  );

  static final channel = AndroidNotificationChannel(
      'your channel id',
      'your channel name',
      'your channel description',
  );

  static Future init() async {

    await _configureLocalTimeZone();

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
    );

    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    // Get payload even when app is closed
    final details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp) {
      selectNotificationSubject.add(details.payload);
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          selectNotificationSubject.add(payload);
        }
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time time,
  }) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(time),
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
    );
  }

  static _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  static tz.TZDateTime _scheduleDaily(Time time){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
      ? scheduledDate.add(const Duration(days: 1))
      : scheduledDate;
  }
}