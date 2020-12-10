import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inhalen/screen.dart';
import 'package:inhalen/services/database_helper.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/settings_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ReminderModel()),
      ChangeNotifierProvider(create: (context) => SettingsModel()),
    ],
    child: Application(),
  ));
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  /// Initialize app
  void initState() {
    /// Set temporary variables for database and provider models
    DatabaseHelper databaseHelper = DatabaseHelper();
    ReminderModel reminderModel = ReminderModel();
    SettingsModel settingsModel = SettingsModel();

    /// Initialize models
    reminderModel = Provider.of<ReminderModel>(context, listen: false);
    settingsModel = Provider.of<SettingsModel>(context, listen: false);

    /// Initialize database then load data to the models
    databaseHelper.initializeDatabase().then((_) {
      settingsModel.fetchSettingsFromStorage();
      reminderModel.fetchListFromStorage();
    });

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
