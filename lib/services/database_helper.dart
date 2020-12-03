import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// Reminder table
final String tableReminder = 'reminder';

// Attributes of reminder table
final String columnTime = 'time';
final String columnLabel = 'label';
final String columnSwitchON = 'switchON';
final String columnCardColor = 'cardColor';
final String columnDaySelection = 'daySelection';

class Storage {
  Database _db;
}
