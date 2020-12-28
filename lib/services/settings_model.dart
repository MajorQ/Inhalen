import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';

class SettingsModel extends ChangeNotifier {
  SQFliteHelper sqfliteHelper;
  String _username;

  String get username => _username;

  set username(String newName) {
    _username = newName;
    Map<String, dynamic> map = {'name': '$newName'};
    sqfliteHelper.updateSettings(map);
    notifyListeners();
  }

  Future<void> fetch() async {
    List<Map> maps = await sqfliteHelper.readSettings();
    _username = maps[0]['name'];
    notifyListeners();
  }
}
