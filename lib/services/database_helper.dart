import 'package:sqflite/sqflite.dart';

/// Reminder table
const String tableReminder = 'reminder';
const String tableSettings = 'settings';

/// Attributes of reminder table
const String columnId = 'id';
const String columnTimeHour = 'hour';
const String columnTimeMinute = 'minute';
const String columnLabel = 'label';
const String columnSwitchON = 'switchON';

/// Day Selection
const String columnDayMonday = 'monday';
const String columnDayTuesday = 'tuesday';
const String columnDayWednesday = 'wednesday';
const String columnDayThursday = 'thursday';
const String columnDayFriday = 'friday';
const String columnDaySaturday = 'saturday';
const String columnDaySunday = 'sunday';

/// Preferences
const String columnName = 'name';

/// Dev NOTE: try to decrease number of columns, or create a new table in the future
class DatabaseHelper {
  /// The database instance inside of DatabaseHelper
  static Database _database;

  /// Open the database or run [onCreate] function
  Future<void> initializeDatabase() async {
    String path;

    // Check whether parent path exists
    try {
      path = await getDatabasesPath() + 'database.db';
    } catch (e) {
      print('Path error: $e');
    }

    try {
      if (_database == null) {
        _database = await openDatabase(path, version: 2,
            onCreate: (Database db, int version) async {
          /// Create the settings table then insert initial values
          await db.execute('''
          CREATE TABLE $tableSettings (
            $columnName text NOT NULL
          );''');
          await db.insert(tableSettings, {'$columnName': 'User'});

          /// Create the reminder table on first run
          await db.execute('''
          CREATE TABLE $tableReminder (
            $columnId int NOT NULL,
            $columnTimeHour int NOT NULL,
            $columnTimeMinute int NOT NULL,
            $columnLabel text,
            $columnSwitchON int NOT NULL,
            $columnDayMonday int NOT NULL,
            $columnDayTuesday int NOT NULL,
            $columnDayWednesday int NOT NULL,
            $columnDayThursday int NOT NULL,
            $columnDayFriday int NOT NULL,
            $columnDaySaturday int NOT NULL,
            $columnDaySunday int NOT NULL
          );''');
        });
      }
    } catch (e) {
      print('Create table error: e');
    }
  }

  Future<List<Map>> readSettings() async {
    try {
      List<Map> maps =
          await _database.rawQuery('''SELECT * FROM $tableSettings;''');
      if (maps != null) {
        if (maps.length > 0) {
          return maps;
        }
      }
      return null;
    } catch (e) {
      print('Fetch error: e');
      return null;
    }
  }

  Future<void> updateSettings(Map map) async {}

  Future<void> createReminder(Map map) async {
    try {
      await _database.insert(tableReminder, map);
    } catch (e) {
      print('Create error: e');
    }
  }

  Future<List<Map>> readReminders() async {
    try {
      List<Map> maps = await _database
          .rawQuery('''SELECT * FROM $tableReminder ORDER BY $columnId;''');
      if (maps != null) {
        if (maps.length > 0) {
          return maps;
        }
      }
      return null;
    } catch (e) {
      print('Fetch error: e');
      return null;
    }
  }

  Future<int> updateReminder(int id, Map map) async {
    try {
      int rowsUpdated = await _database
          .update(tableReminder, map, where: '$columnId=?', whereArgs: [id]);
      return rowsUpdated;
    } catch (e) {
      print('Create error: e');
      return null;
    }
  }

  Future<int> deleteReminder(int id) async {
    try {
      int rowsDeleted = await _database
          .delete(tableReminder, where: '$columnId=?', whereArgs: [id]);
      await _database.rawUpdate('''
      UPDATE $tableReminder SET $columnId=$columnId-1
      WHERE $columnId>?;
    ''', [id]);
      return rowsDeleted;
    } catch (e) {
      print('Delete error: e');
      return null;
    }
  }

  /// Create all the tables when tables are lost or dropped
  Future<void> createTables() async {
    try {
      /// Create the settings table
      await _database.execute('''
          CREATE TABLE $tableSettings (
            $columnName text NOT NULL
          );''');
      await _database.insert(tableSettings, {'$columnName': 'User'});

      /// Create the reminders table
      await _database.execute('''
      CREATE TABLE $tableReminder (
        $columnId int NOT NULL,
        $columnTimeHour int NOT NULL,
        $columnTimeMinute int NOT NULL,
        $columnLabel text,
        $columnSwitchON int NOT NULL,
        $columnDayMonday int NOT NULL,
        $columnDayTuesday int NOT NULL,
        $columnDayWednesday int NOT NULL,
        $columnDayThursday int NOT NULL,
        $columnDayFriday int NOT NULL,
        $columnDaySaturday int NOT NULL,
        $columnDaySunday int NOT NULL
      );''');
    } catch (e) {
      print('Create error: $e');
    }
  }

  /// Drop all the tables
  Future<void> dropTables() async {
    try {
      await _database.execute('''DROP TABLE $tableReminder;''');
      await _database.execute('''DROP TABLE $tableSettings;''');
    } catch (e) {
      print('Drop error: $e');
    }
  }

  Future close() async => _database.close();
}
