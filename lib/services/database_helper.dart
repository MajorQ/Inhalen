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
  static Database _db;

  /// Open the database or run [onCreate] function
  Future<void> initializeDatabase() async {
    String path;

    // Check whether parent path exists
    try {
      path = await getDatabasesPath() + 'database.db';
    } catch (_) {
      throw 'Parent path does not exist';
    }

    if (_db == null) {
      _db = await openDatabase(path, version: 2,
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
  }

  Future<List<Map>> readSettings() async {
    List<Map> maps = await _db.rawQuery('''SELECT * FROM $tableSettings;''');
    if (maps != null) {
      if (maps.length > 0) {
        return maps;
      }
    }
    return null;
  }

  Future<void> updateSettings(Map map) async {}

  Future<void> createReminder(Map map) async {
    await _db.insert(tableReminder, map);
  }

  Future<List<Map>> readReminders() async {
    List<Map> maps = await _db
        .rawQuery('''SELECT * FROM $tableReminder ORDER BY $columnId;''');
    if (maps != null) {
      if (maps.length > 0) {
        return maps;
      }
    }
    return null;
  }

  Future<int> updateReminder(int id, Map map) async {
    int rowsUpdated = await _db
        .update(tableReminder, map, where: '$columnId=?', whereArgs: [id]);
    return rowsUpdated;
  }

  Future<int> deleteReminder(int id) async {
    int rowsDeleted =
        await _db.delete(tableReminder, where: '$columnId=?', whereArgs: [id]);
    await _db.rawUpdate('''
      UPDATE $tableReminder SET $columnId=$columnId-1
      WHERE $columnId>?;
    ''', [id]);
    return rowsDeleted;
  }

  /// Use this function when table is lost or dropped
  Future<void> createTables() async {
    /// Create the settings table
    await _db.execute('''
          CREATE TABLE $tableSettings (
            $columnName text NOT NULL
          );''');
    await _db.insert(tableSettings, {'$columnName': 'User'});

    /// Create the reminders table
    await _db.execute('''
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
  }

  /// Use this function to clear the database in case of an error
  Future<void> dropTables() async {
    await _db.execute('''DROP TABLE $tableReminder;''');
    await _db.execute('''DROP TABLE $tableSettings;''');
  }

  Future close() async => _db.close();
}
