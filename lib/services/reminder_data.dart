import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';

import 'package:inhalen/services/colors.dart';

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
  }) : controller = SlidingCardController();

  /// Get text about days (every day/select day) from [daySelection]
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

  /// Get color of [ReminderCard] based on [switchON] value
  Color get cardColor {
    if (switchON)
      return CustomColors.yellow;
    else
      return CustomColors.lightGray;
  }

  /// Set variables on [ReminderData] instance based on map
  void fromMap(Map map) {
    /// Set variables from map
    time = TimeOfDay(hour: map['hour'], minute: map['minute']);
    label = map['label'] ?? 'label';
    switchON = (map['switchON'] == 1);

    /// Get [daySelection] from map
    daySelection[0] = (map['monday'] == 1);
    daySelection[1] = (map['tuesday'] == 1);
    daySelection[2] = (map['wednesday'] == 1);
    daySelection[3] = (map['thursday'] == 1);
    daySelection[4] = (map['friday'] == 1);
    daySelection[5] = (map['saturday'] == 1);
    daySelection[6] = (map['sunday'] == 1);
  }

  /// Convert from [ReminderData] instance to a map
  Map<String, dynamic> toMap(int index) => {
        'id': index,
        'hour': time.hour,
        'minute': time.minute,
        'label': label,
        'switchON': (switchON) ? 1 : 0,

        /// Set [daySelection] to map value
        'monday': (daySelection[0]) ? 1 : 0,
        'tuesday': (daySelection[1]) ? 1 : 0,
        'wednesday': (daySelection[2]) ? 1 : 0,
        'thursday': (daySelection[3]) ? 1 : 0,
        'friday': (daySelection[4]) ? 1 : 0,
        'saturday': (daySelection[5]) ? 1 : 0,
        'sunday': (daySelection[6]) ? 1 : 0,
      };
}
