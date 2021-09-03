import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const _sound = 'rooster_2.wav';

NotificationDetails _platformChannelSpecifics = NotificationDetails(
  android: AndroidNotificationDetails(
    'your channel id 2',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound(_sound.split('.').first),
    ticker: 'Ticker',
    icon: '@mipmap/ic_launcher',
  ),
  iOS: const IOSNotificationDetails(
    sound: _sound,
  ),
);

Future initNotification() async {

  final BehaviorSubject<String?> selectNotificationSubject = Get.find();

  await _configureLocalTimeZone();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

  const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );

  // Get payload even when app is closed
  final details = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if(details != null && details.didNotificationLaunchApp) {
    selectNotificationSubject.add(details.payload);
  }

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        selectNotificationSubject.add(payload);
      }
  );
}

Future showNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
}) async {
  _flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    _platformChannelSpecifics,
    payload: payload,
  );
}

Future showScheduledNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
  required Time time,
}) async {
  _flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    _scheduleDaily(time),
    _platformChannelSpecifics,
    payload: payload,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time
  );
}

Future _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

tz.TZDateTime _scheduleDaily(Time time){
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  final tz.TZDateTime scheduledDate =
  tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);

  return scheduledDate.isBefore(now)
    ? scheduledDate.add(const Duration(days: 1))
    : scheduledDate;
}
