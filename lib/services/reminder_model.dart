import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/reminder_data.dart';

class ReminderModel extends ChangeNotifier {
  // List of ReminderData and a DatabaseHelper instance
  static List<ReminderData> _reminders = List();
  DatabaseHelper _localStorage = DatabaseHelper();

  // Getter function that returns the list of reminders
  List<ReminderData> get getList => _reminders;

  int get length => _reminders.length;

  // Opens a database on a ReminderHelper instance and reads from the database
  //
  // Read operation returns a list of maps, then the map is converted to ReminderData
  // and added to the reminders list
  Future<void> fetchListFromStorage() async {
    List<Map> maps = await _localStorage.readReminders();
    if (maps != null) {
      for (int index = 0; index < maps.length; index++) {
        ReminderData newReminder =
            ReminderData(daySelection: List.generate(7, (index) => false));
        newReminder.fromMap(maps[index]);
        _reminders.add(newReminder);
      }
    } else {
      _reminders = [];
    }
    notifyListeners();
  }

  // Returns the time TimeOfDay instance from a specific index
  TimeOfDay getTimeFromIndex(int index) => _reminders[index].time;

  // Add a new reminder to the list, and perform a create operation on the database
  // using a Map created by the ReminderData instance
  void addReminder() {
    ReminderData newReminder = ReminderData(
      time: TimeOfDay.now(),
      label: 'Label',
      switchON: true,
      daySelection: List.generate(7, (index) => false),
    );
    _reminders.add(newReminder);
    _localStorage.createReminder(newReminder.toMap(_reminders.length - 1));
    notifyListeners();
  }

  // Delete a reminder from a specific index, then perform the delete operation
  // on the database
  void deleteReminder(int index) {
    _reminders.removeAt(index);
    _localStorage.deleteReminder(index);
    notifyListeners();
  }

  // Changes the state of the reminder from being turned on/off then updates
  // its color.
  //
  // Performs an update operation on the database
  void changeSwitchOnIndex(bool state, int index) {
    _reminders[index].switchON = state;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  void toggleDays(dynamic day, int index) {
    _reminders[index].daySelection[day] = !_reminders[index].daySelection[day];
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  // Change the TimeOfDay value from a specific index, then performs an update
  void changeTimeOnIndex(int index, TimeOfDay time) {
    _reminders[index].time = time;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }

  // Change the reminder label value from a specific index, then performs an update
  void changeLabelOnIndex(int index, String value) {
    value = (value == '' ? 'Label' : value);
    _reminders[index].label = value;
    _localStorage.updateReminder(index, _reminders[index].toMap(index));
    notifyListeners();
  }
}
