import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderData {
  TimeOfDay time;
  String label;
  String days;
  bool switchON;
  Color cardColor;
  List<bool> daySelection;
  SlidingCardController controller;

  ReminderData({
    this.time,
    this.label,
    this.days,
    this.switchON,
    this.cardColor,
    this.daySelection,
  }) : controller = new SlidingCardController();

  void getDays() {
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
  }

  void fromMap(Map map) {
    this.time = TimeOfDay(hour: map['hour'], minute: map['minute']);
    this.label = map['label'] ?? 'label';
    this.switchON = (map['switchON'] == 1);
    this.cardColor = Color(map['cardColor']);
  }

  Map<String, dynamic> toMap(int index) => {
        'id': index,
        'hour': this.time.hour,
        'minute': this.time.minute,
        'label': this.label,
        'switchON': (this.switchON) ? 1 : 0,
        'cardColor': this.cardColor.value
      };
}
