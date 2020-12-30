import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/reminder_data.dart';

class ReminderModel extends ChangeNotifier {
  /// List of ReminderData and a DatabaseHelper instance
  SQFliteHelper sqfliteHelper;
  List<ReminderData> _reminders = [];
  

  /// Returns the list of reminders
  List<ReminderData> get list => _reminders;

  /// Returns length of reminders list
  int get length => _reminders.length;

  /// Returns the time TimeOfDay instance from a specific index
  TimeOfDay getTimeFrom(int index) => _reminders[index].time;

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
  void add() {
    var newReminder = ReminderData(
      time: TimeOfDay.now(),
      label: 'Label',
      isEnabled: true,
      daySelection: List.generate(7, (index) => false, growable: false),
    );
    _reminders.add(newReminder);
    sqfliteHelper.createReminder(newReminder.toMap(_reminders.length - 1));
    notifyListeners();
  }

  /// Delete a reminder from a specific index, then perform the operation
  /// on the database
  void delete(int index) {
    _reminders.removeAt(index);
    sqfliteHelper.deleteReminder(index);
    notifyListeners();
  }

  /// Changes the state of the reminder from being turned on/off
  /// then updates the database
  void changeStateAt(bool state, int index) {
    _reminders[index].isEnabled = state;
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change [daySelection] based on user toggle then updates the database
  void toggleDaysAt(dynamic day, int index) {
    _reminders[index].daySelection[day] = !_reminders[index].daySelection[day];
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [time] for a specific index then updates the database
  void changeTimeAt(int index, TimeOfDay time) {
    _reminders[index].time = time;
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [label] value from a specific index then updates the databasee
  void changeLabelAt(int index, String value) {
    value = (value == '' ? 'Label' : value);
    _reminders[index].label = value;
    sqfliteHelper.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }
}
