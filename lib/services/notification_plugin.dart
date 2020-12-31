// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var tempReminder = ReminderData();

  initializeNotificationPlugin() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('inhalen_notif');
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
    });
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    String timeZoneName;
    try {
      timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (error) {
      print(error);
    }
  }

  tz.TZDateTime _scheduleTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledReminder =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledReminder.isBefore(now)) {
      scheduledReminder = scheduledReminder.add(const Duration(days: 1));
    }
    return scheduledReminder;
  }

  tz.TZDateTime _scheduleReminder(ReminderData reminder) {
    tz.TZDateTime scheduledReminder = _scheduleTime(reminder.time.hour, reminder.time.minute);
    if (!reminder.daySelection[scheduledReminder.weekday-1]) {
      scheduledReminder = scheduledReminder.add(const Duration(days: 1));
    }
    return scheduledReminder;
  }

  Future<void> scheduleNotification(ReminderModel reminderModel, int index) async {
    List<ReminderData> reminders = reminderModel.list;
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'INHALEN_ID',
      'INHALEN',
      'INHALEN_APP',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      sound: RawResourceAndroidNotificationSound('medical_system'),
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics); 

    if (!reminders[index].isEnabled) {
      _cancelNotification(index);
    }
    else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          index,
          'Reminder ${reminders[index].label}',
          'Saatnya menggunakan obat anda!',
          _scheduleReminder(reminders[index]),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    print(await getPendingNotificationCount());
  }

  Future<void> updateNotifications(ReminderModel reminderModel) async {
    int countReminder = reminderModel.length;
    print(countReminder);
    await flutterLocalNotificationsPlugin.cancelAll();
    print(await getPendingNotificationCount());

    for(int i=0; i < countReminder; i++) {
      await scheduleNotification(reminderModel, i);
    }
  }

  void _cancelNotification(int index) async {
    await flutterLocalNotificationsPlugin.cancel(index);
  }

  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }
}
