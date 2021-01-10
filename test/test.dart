import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inhalen/services/reminder_model.dart';

void main() {
  test(
      'WHEN a new reminder is added and time is null THEN its not inserted to list',
      () {
    // ARRANGE
    final reminderModel = ReminderModel();

    // ACT
    reminderModel.add(null);

    // ASSERT
    expect(reminderModel.list, []);
  });
}
