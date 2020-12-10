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

// The application
class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  // This function will:
  // a. Initialize all models and the database instance
  // b. Fetch settings from the local storage to the settings model
  // c. Fetch list from the local storage to the reminder model
  void initState() {
    // set temporary variables
    DatabaseHelper databaseHelper = DatabaseHelper();
    ReminderModel reminderModel = ReminderModel();
    SettingsModel settingsModel = SettingsModel();

    // initialize models
    reminderModel = Provider.of<ReminderModel>(context, listen: false);
    settingsModel = Provider.of<SettingsModel>(context, listen: false);

    // initialize database and load to the models
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
