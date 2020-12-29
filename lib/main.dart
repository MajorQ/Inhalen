import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inhalen/screen.dart';
import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/notification_plugin.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/settings_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => NotificationPlugin()),
      Provider(create: (context) => SQFliteHelper()),
      ChangeNotifierProxyProvider<SQFliteHelper, SettingsModel>(
          create: (context) => SettingsModel(),
          update: (context, sqfliteHelper, settingModel) =>
              settingModel..sqfliteHelper = sqfliteHelper),
      ChangeNotifierProxyProvider<SQFliteHelper, ReminderModel>(
          create: (context) => ReminderModel(),
          update: (context, sqfliteHelper, reminderModel) =>
              reminderModel..sqfliteHelper = sqfliteHelper),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Initialize app
  void initState() {
    /// Set temporary variables for database and provider models
    var notificationPlugin =
        Provider.of<NotificationPlugin>(context, listen: false);
    var sqfliteHelper = Provider.of<SQFliteHelper>(context, listen: false);
    var reminderModel = Provider.of<ReminderModel>(context, listen: false);
    var settingsModel = Provider.of<SettingsModel>(context, listen: false);

    /// Initialize database then load data to the models
    sqfliteHelper.initialize().then((_) {
      settingsModel.fetch();
      reminderModel.fetch();
    });

    /// Initialie notification plugin
    notificationPlugin.configureLocalTimeZone();
    notificationPlugin.initializeNotificationPlugin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Screen());
  }
}
