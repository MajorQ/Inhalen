import 'package:flutter/material.dart';

import 'package:inhalen/services/database_helper.dart';

class SettingsModel extends ChangeNotifier {
  SQFliteHelper sqfliteHelper;
  Map<String, dynamic> map = {
    'name': '',
    'newlyInstalled': 1,
  };

  String get name => map['name'];

  set name(String newName) {
    map['name'] = newName;
    sqfliteHelper.updateSettings(map);
    notifyListeners();
  }

  set newlyInstalled(bool state) {
    map['newlyInstalled'] = (state) ? 1 : 0;
    sqfliteHelper.updateSettings(map);
  }

  Future<void> fetch() async {
    List<Map> maps = await sqfliteHelper.readSettings();
    map['name'] = maps[0]['name'];
    map['newlyInstalled'] = (maps[0]['newlyInstalled'] == 1);
    notifyListeners();
  }
}
