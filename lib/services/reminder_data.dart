import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:sliding_card/sliding_card.dart';

// Reminder card data
class ReminderData {
  TimeOfDay time;
  String label;
  bool switchON;
  List<bool> daySelection;
  SlidingCardController controller;

  ReminderData({
    this.time,
    this.label,
    this.switchON,
    this.daySelection,
  }) : controller = new SlidingCardController();

  // Getter for the list of days reminder selection
  String get getDays {
    String days = '';
    List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    bool first = true;

    if (daySelection.contains(true) && daySelection.contains(false)) {
      for (int day = 0; day < dayList.length; day++) {
        if (daySelection[day] == true) {
          if (first) {
            days = dayList[day];
            first = false;
          } else {
            days = days + ', ' + dayList[day];
          }
        }
      }
    } else {
      if (daySelection.contains(true)) {
        days = 'Every day';
      } else {
        days = 'Select day';
      }
    }
    return days;
  }

  // Getter for card color depends on reminder card switch
  Color get cardColor {
    if (switchON)
      return CustomColors.yellow;
    else
      return CustomColors.lightGray;
  }

  void fromMap(Map map) {
    this.time = TimeOfDay(hour: map['hour'], minute: map['minute']);
    this.label = map['label'] ?? 'label';
    this.switchON = (map['switchON'] == 1);
    // Get daySelection
    this.daySelection[0] = (map['monday'] == 1);
    this.daySelection[1] = (map['tuesday'] == 1);
    this.daySelection[2] = (map['wednesday'] == 1);
    this.daySelection[3] = (map['thursday'] == 1);
    this.daySelection[4] = (map['friday'] == 1);
    this.daySelection[5] = (map['saturday'] == 1);
    this.daySelection[6] = (map['sunday'] == 1);
  }

  Map<String, dynamic> toMap(int index) => {
        'id': index,
        'hour': this.time.hour,
        'minute': this.time.minute,
        'label': this.label,
        'switchON': (this.switchON) ? 1 : 0,
        // Set daySelection
        'monday': (this.daySelection[0]) ? 1 : 0,
        'tuesday': (this.daySelection[1]) ? 1 : 0,
        'wednesday': (this.daySelection[2]) ? 1 : 0,
        'thursday': (this.daySelection[3]) ? 1 : 0,
        'friday': (this.daySelection[4]) ? 1 : 0,
        'saturday': (this.daySelection[5]) ? 1 : 0,
        'sunday': (this.daySelection[6]) ? 1 : 0,
      };
}
