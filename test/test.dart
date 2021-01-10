import 'package:flutter/material.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('Reminder Model Testing', () {
    // ARRANGE
    final reminderModel = ReminderModel();
    test(
        'WHEN a new reminder is added and time is null THEN its not inserted to list',
        () {
      // ACT
      reminderModel.add(null);

      // ASSERT
      expect(reminderModel.list, []);
    });

    test(
        'WHEN a reminder is created or changed THEN database and notification are updated',
        () {
      // INJECT
      reminderModel.sqfliteHelper = SQFliteHelperMock();
      reminderModel.notificationPlugin = NotificationPluginMock();

      // ACT
      reminderModel.add(TimeOfDay.now());
      reminderModel.changeLabelAt(0, 'new label');

      // ASSERT
      expect(reminderModel.list[0].label, 'new label');
    });
  });
}
