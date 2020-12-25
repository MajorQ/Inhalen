import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz; 
import 'reminder_data.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettings;

  NotificationPlugin._(){
    initializeNotificationPlugin();
  }

  initializeNotificationPlugin() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
    intializePlatformAndroid();
  }  

  // Initialize notification settings for Android platform
  intializePlatformAndroid() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('inhalen');
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  }

   setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }
  
   // Function for scheduling reminder notification
  Future<void> scheduleNotification(ReminderData reminder, int index) async {
    // List<Day> days = ;
    // var notificationTime = Time(reminder.time.hour, reminder.time.minute);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_INHALEN',
      'INHALEN',
      'INHALEN REMINDER',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('medical_system'),
      ledOnMs: 1000,
      ledOffMs: 500,
      playSound: true,
      enableLights: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      index,  // Notification ID
      'INHALEN', 
      reminder.label,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: null,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,      
      payload: 'New Payload', 
    );
  }

  // Function for delete or cancel pending notification
  Future<void> cancelNotification(int index) async {
    await flutterLocalNotificationsPlugin.cancel(index);
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();
