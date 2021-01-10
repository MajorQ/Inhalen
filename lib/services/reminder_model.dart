import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/notification_plugin.dart';
import 'package:inhalen/services/reminder_data.dart';

class ReminderModel extends ChangeNotifier {
  SQFliteHelper sqfliteHelper;
  NotificationPlugin notificationPlugin;
  List<ReminderData> _reminders = [];
  String notificationMsg = '';

  List<ReminderData> get list => _reminders;

  int get length => _reminders.length;

  int get lastIndex => (_reminders.length - 1 >= 0) ? _reminders.length - 1 : 0;

  TimeOfDay getTimeFrom(int index) => _reminders[index].time;

  String getLabelFrom(int index) => _reminders[index].label;

  /// Read from database and returns a list of maps, then the map is converted
  /// to [ReminderData] and added to the [_reminders] list
  Future<void> fetch() async {
    List<Map> maps = await sqfliteHelper.readReminders();
    for (var map in maps) {
      var newReminder = ReminderData.fromMap(map);
      _reminders.add(newReminder);
    }
    notifyListeners();
  }

  /// Add a new reminder to the list then perform an insert operation on the database
  /// using a Map created by the [ReminderData] instance
  void add(TimeOfDay time) {
    if (time == null) return;
    var newReminder = ReminderData(
      time: time,
      label: 'Label',
      isEnabled: true,
      daySelection: List.generate(7, (index) => true, growable: false),
    );
    _reminders.add(newReminder);
    notificationPlugin.scheduleNotification(
        newReminder, lastIndex, notificationMsg);
    sqfliteHelper.createReminder(newReminder.toMap(lastIndex));
    notifyListeners();
  }

  /// Delete a reminder from a specific index, then perform the operation
  /// on the database
  void delete(int index) {
    _reminders.removeAt(index);
    notificationPlugin.updateNotifications(_reminders, notificationMsg);
    sqfliteHelper.deleteReminder(index);
    notifyListeners();
  }

  /// Changes the state of the reminder from being turned on/off
  /// then updates the database
  void changeStateAt(bool state, int index) {
    _reminders[index].isEnabled = state;
    _reminders[index].daySelection[DateTime.now().weekday - 1] = true;
    notificationPlugin.scheduleNotification(
        _reminders[index], lastIndex, notificationMsg);
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change [daySelection] based on user toggle then updates the database
  void toggleDaysAt(dynamic day, int index) {
    _reminders[index].daySelection[day] = !_reminders[index].daySelection[day];
    if (!_reminders[index].daySelection.contains(true)) {
      _reminders[index].isEnabled = false;
    } else {
      _reminders[index].isEnabled = true;
    }
    notificationPlugin.scheduleNotification(
        _reminders[index], lastIndex, notificationMsg);
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [time] for a specific index then updates the database
  void changeTimeAt(int index, TimeOfDay time) {
    if (time == null) return;
    if (_reminders[index].time == time) return;
    _reminders[index].time = time;
    notificationPlugin.scheduleNotification(
        _reminders[index], lastIndex, notificationMsg);
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [label] value from a specific index then updates the databasee
  void changeLabelAt(int index, String value) {
    if (value == null || value == '') return;
    if (_reminders[index].label == value) return;
    _reminders[index].label = value;
    notificationPlugin.scheduleNotification(
        _reminders[index], lastIndex, notificationMsg);
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  void tapCardAt(int index) {
    if (_reminders[index].controller.isCardSeparated == true) {
      _reminders[index].controller.collapseCard();
    } else {
      _reminders[index].controller.expandCard();
      for (int index2 = 0; index2 < length; ++index2) {
        if (index2 == index) {
          continue;
        } else {
          _reminders[index2].controller.collapseCard();
        }
      }
    }
  }

  void changeNotificationMsg(String value) {
    if (notificationMsg == value) return;
    notificationMsg = value;
    notificationPlugin.updateNotifications(_reminders, notificationMsg);
  }
}
