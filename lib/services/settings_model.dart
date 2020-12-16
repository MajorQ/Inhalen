import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';

class SettingsModel extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  String _username;

  String get username => _username;

  Future<void> fetch() async {
    List<Map> maps = await _databaseHelper.readSettings();
    if (maps != null) {
      _username = maps[0]['name'];
    } else {
      _username = 'User';
    }
    notifyListeners();
  }

  set username(String newName) {
    _username = newName;
    notifyListeners();
  }
}
