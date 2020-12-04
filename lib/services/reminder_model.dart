import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_data.dart';

class ReminderModel extends ChangeNotifier {
  List<ReminderData> _reminders = [];

  List<ReminderData> get getList => _reminders;

  TimeOfDay getTime(int index) => _reminders[index].time;

  void add() {
    _reminders.add(ReminderData(
      time: TimeOfDay.now(),
      label: 'Label',
      switchON: true,
      days: 'Select day',
      cardColor: CustomColors.yellow,
      daySelection: List.generate(7, (index) => false),
    ));
    // notifyListeners();
  }

  void delete(int index) {
    _reminders.removeAt(index);
    notifyListeners();
  }

  void changeSwitch(bool state, int index) {
    _reminders[index].switchON = state;

    if (_reminders[index].switchON == true) {
      _reminders[index].cardColor = CustomColors.yellow;
    } else {
      _reminders[index].cardColor = CustomColors.lightGray;
    }
    notifyListeners();
  }

  void toggleDays(int day, int index) {
    _reminders[index].daySelection[day] = !_reminders[index].daySelection[day];
    _reminders[index].getDays();
    notifyListeners();
  }

  void pickTime(int index, TimeOfDay time) {
    // time = TimeOfDay.fromDateTime(time)
    _reminders[index].time = time;
    notifyListeners();
  }

  void pickLabel(int index, String value) {
    value = value == '' ? 'Label' : value;
    _reminders[index].label = value;
    notifyListeners();
  }
}
