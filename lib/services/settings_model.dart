import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';

class SettingsModel extends ChangeNotifier {
  SQFliteHelper _databaseHelper;
  String _username;

  SettingsModel(SQFliteHelper sqfliteHelper) {
    _databaseHelper = sqfliteHelper;
  }

  String get username => _username;

  set username(String newName) {
    _username = newName;
    notifyListeners();
  }

  Future<void> fetch() async {
    List<Map> maps = await _databaseHelper.readSettings();
    _username = maps[0]['name'];
    notifyListeners();
  }
}
