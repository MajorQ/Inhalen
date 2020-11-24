import 'package:flutter/material.dart';

class ReminderData {

  TimeOfDay time;
  String label;
  bool switchON;
  List<String> days;

  ReminderData({
    this.time, 
    this.label,
    this.switchON,
    this.days,
  });


}