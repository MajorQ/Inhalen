import 'package:sqflite/sqflite.dart';

const db_name = 'database.db';
const String reminderTable = 'reminder';
const String settingsTable = 'settings';

/// Dev NOTE: try to decrease number of columns, or create a new table in the future
class SQFliteHelper {
  /// The database instance inside of DatabaseHelper
  Database _database;

  /// Open the database or run [onCreate] function
  Future<void> initialize() async {
    try {
      _database = await openDatabase(db_name,
          version: 2, onCreate: _onCreate, onUpgrade: _onUpdate);
    } catch (e) {
      print('Open Database error -> $e');
    }
  }

  _onCreate(Database db, int version) async {
    /// Create the settings table then insert initial values
    await db.execute('''
        CREATE TABLE $settingsTable (
          name text
        )
      ''');
    await db.insert(settingsTable, {'name': 'User'});

    /// Create the reminder table on first run
    await db.execute('''
        CREATE TABLE $reminderTable (
          id INT PRIMARY KEY,
          hour INT,
          minute INT,
          label TEXT,
          isEnabled INT,
          monday INT,
          tuesday INT,
          wednesday INT,
          thursday INT,
          friday INT,
          saturday INT,
          sunday INT
        )
      ''');
  }

  _onUpdate(Database db, int oldVersion, int newVersion) async {
    await _database.execute('''DROP TABLE $reminderTable;''');
    await _database.execute('''DROP TABLE $settingsTable;''');
    _onCreate(db, newVersion);
  }

  Future<List<Map>> readSettings() async {
    List<Map> maps = [];

    try {
      List<Map> result = await _database.query(settingsTable);
      if (result != null) {
        maps = result;
      }
    } catch (e) {
      print('Fetch error -> $e');
    }

    return maps;
  }

  Future<void> updateSettings(Map map) async =>
      await _database.update(settingsTable, map);

  Future<int> createReminder(Map map) async =>
      await _database.insert(reminderTable, map);

  Future<List<Map>> readReminders() async {
    List<Map> maps = [];

    try {
      List<Map> result = await _database.query(reminderTable, orderBy: 'id');
      if (result != null) {
        maps = result;
      }
    } catch (e) {
      print('Fetch error -> $e');
    }

    return maps;
  }

  Future<int> updateReminder(int id, Map map) async => await _database
      .update(reminderTable, map, where: 'id=?', whereArgs: [id]);

  Future<int> deleteReminder(int id) async {
    try {
      int rowsDeleted =
          await _database.delete(reminderTable, where: 'id=?', whereArgs: [id]);

      await _database
          .rawUpdate('UPDATE $reminderTable SET id=id-1 WHERE id>?', [id]);

      return rowsDeleted;
    } catch (e) {
      throw e;
    }
  }
}
