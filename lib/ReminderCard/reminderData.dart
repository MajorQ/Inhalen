import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderData {

  TimeOfDay time;
  String label;
  bool switchON;
  Color cardColor;
  List<bool> daySelection;
  SlidingCardController controller;

  ReminderData({
    this.time, 
    this.label,
    this.switchON,
    this.cardColor,
    this.daySelection,
  }): controller = SlidingCardController();

}