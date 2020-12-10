import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/reminder_data.dart';

class ReminderModel extends ChangeNotifier {
  /// List of ReminderData and a DatabaseHelper instance
  static List<ReminderData> _reminders = List();
  DatabaseHelper _localStorage = DatabaseHelper();

  /// Returns the list of reminders
  List<ReminderData> get getList => _reminders;

  /// Returns length of reminders list
  int get length => _reminders.length;

  /// Opens a database on a ReminderHelper instance and reads from the database
  ///
  /// Read operation returns a list of maps, then the map is converted to [ReminderData]
  /// and added to the [_reminders] list
  Future<void> fetchListFromStorage() async {
    List<Map> maps = await _localStorage.readReminders();
    if (maps != null) {
      maps.forEach((element) {
        ReminderData newReminder =
            ReminderData(daySelection: List.generate(7, (index) => false));
        newReminder.fromMap(element);
        _reminders.add(newReminder);
      });
    } else {
      _reminders = [];
    }
    notifyListeners();
  }

  /// Returns the time TimeOfDay instance from a specific index
  TimeOfDay getTimeFromIndex(int index) => _reminders[index].time;

  /// Add a new reminder to the list then perform an insert operation on the database
  /// using a Map created by the [ReminderData] instance
  void addReminder() {
    ReminderData newReminder = ReminderData(
      time: TimeOfDay.now(),
      label: 'Label',
      switchON: true,
    );
    _reminders.add(newReminder);
    _localStorage.createReminder(newReminder.toMap(_reminders.length - 1));
    notifyListeners();
  }

  /// Delete a reminder from a specific index, then perform the operation
  /// on the database
  void deleteReminder(int index) {
    _reminders.removeAt(index);
    _localStorage.deleteReminder(index);
    notifyListeners();
  }

  /// Changes the state of the reminder from being turned on/off
  /// then updates the database
  void changeSwitchOnIndex(bool state, int index) {
    _reminders[index].switchON = state;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change [daySelection] based on user toggle then updates the database
  void toggleDays(dynamic day, int index) {
    _reminders[index].daySelection[day] = !_reminders[index].daySelection[day];
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [time] for a specific index then updates the database
  void changeTimeOnIndex(int index, TimeOfDay time) {
    _reminders[index].time = time;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  /// Change the [label] value from a specific index then updates the databasee
  void changeLabelOnIndex(int index, String value) {
    value = (value == '' ? 'Label' : value);
    _reminders[index].label = value;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }
}
