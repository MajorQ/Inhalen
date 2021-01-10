import 'package:sqflite/sqflite.dart';

const db_name = 'database.db';
const String reminderTable = 'reminder';
const String settingsTable = 'settings';

// TODO: change to implementation instead of concrete class
// TODO: use ReminderData instead of maps
class SQFliteHelper {
  /// The database instance inside of DatabaseHelper
  Database _database;

  /// Open the database or run [onCreate] function
  Future<void> initialize() async {
    try {
      _database = await openDatabase(db_name,
          version: 5, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (e) {
      print('Open Database error -> $e');
    }
  }

  /// Creates the [settingsTable] and [reminderTable]. then insert intital values
  /// for [settingsTable]
  _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $settingsTable (
          name TEXT,
          newlyInstalled INT
        )
      ''');
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

    await db.insert(settingsTable, {'name': 'User', 'newlyInstalled': 1});
  }

  /// Drops databases then re-runs the [_onCreate] function
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''DROP TABLE $reminderTable;''');
    await db.execute('''DROP TABLE $settingsTable;''');
    await _onCreate(db, newVersion);
    print('Database upgraded to version $newVersion');
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
    int rowsDeleted =
        await _database.delete(reminderTable, where: 'id=?', whereArgs: [id]);

    await _database
        .rawUpdate('UPDATE $reminderTable SET id=id-1 WHERE id>?', [id]);

    return rowsDeleted;
  }
}
