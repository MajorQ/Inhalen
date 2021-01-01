import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';
import 'package:inhalen/services/colors.dart';

class ReminderData {
  TimeOfDay time;
  String label;
  bool isEnabled;
  List<bool> daySelection;
  SlidingCardController controller;

  ReminderData({
    this.time,
    this.label,
    this.isEnabled,
    this.daySelection,
  }) : controller = SlidingCardController();

  /// Get text about days (every day/select day) from [daySelection]
  String getDays(
      {@required List<String> dayList,
      String emptyMsg = 'Select day',
      String weekdayMsg = 'Weekday',
      String weekendMsg = 'Weekend',
      String fullMsg = 'Every day'}) {
    String days = '';
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
      if (listEquals(
          daySelection, [true, true, true, true, true, false, false])) {
        days = weekdayMsg;
      } else if (listEquals(
          daySelection, [false, false, false, false, false, true, true])) {
        days = weekendMsg;
      }
    } else {
      if (daySelection.contains(true)) {
        days = fullMsg;
      } else {
        days = emptyMsg;
      }
    }
    return days;
  }

  /// Get color of [ReminderCard] based on [isEnabled] value
  Color get cardColor {
    if (isEnabled)
      return CustomColors.yellow;
    else
      return CustomColors.lightGray;
  }

  /// Set variables on [ReminderData] instance based on map
  ReminderData.fromMap(Map map) {
    time = TimeOfDay(hour: map['hour'], minute: map['minute']);
    label = map['label'] ?? 'label';
    isEnabled = (map['isEnabled'] == 1);

    /// Get [daySelection] from map
    daySelection = [
      (map['monday'] == 1),
      (map['tuesday'] == 1),
      (map['wednesday'] == 1),
      (map['thursday'] == 1),
      (map['friday'] == 1),
      (map['saturday'] == 1),
      (map['sunday'] == 1),
    ];

    controller = SlidingCardController();
  }

  /// Convert from [ReminderData] instance to a map
  Map<String, dynamic> toMap(int index) {
    return {
      'id': index,
      'hour': time.hour,
      'minute': time.minute,
      'label': label,
      'isEnabled': (isEnabled) ? 1 : 0,

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
}
