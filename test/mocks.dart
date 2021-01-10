import 'package:inhalen/services/notification_plugin.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'package:mockito/mockito.dart';
import 'package:inhalen/services/database_helper.dart';

class SQFliteHelperMock extends Mock implements SQFliteHelper {
  @override
  Future<int> createReminder(Map map) async {
    Future.delayed(Duration(seconds: 2));
    print('Successfully inserted new reminder to DB!');
    return 1;
  }

  @override
  Future<int> updateReminder(int id, Map map) async {
    Future.delayed(Duration(seconds: 2));
    print('Database was called!');
    return 1;
  }
}

class NotificationPluginMock extends Mock implements NotificationPlugin {
  @override
  Future<void> scheduleNotification(
      ReminderData data, int index, String notificationMsg) async {
    Future.delayed(Duration(seconds: 2));
    print('Notification was updated!');
    return 1;
  }
}
