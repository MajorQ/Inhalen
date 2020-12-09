import 'package:sqflite/sqflite.dart';

// Reminder table
final String tableReminder = 'reminder';
final String tableSettings = 'settings';

// Attributes of reminder table
final String columnId = 'id';
final String columnTimeHour = 'hour';
final String columnTimeMinute = 'minute';
final String columnLabel = 'label';
final String columnSwitchON = 'switchON';
final String columnCardColor = 'cardColor';

// Day Selection
final String columnDayMonday = 'monday';
final String columnDayTuesday = 'tuesday';
final String columnDayWednesday = 'wednesday';
final String columnDayThursday = 'thursday';
final String columnDayFriday = 'friday';
final String columnDaySaturday = 'saturday';
final String columnDaySunday = 'sunday';

// Preferences
final String columnName = 'name';

// Dev NOTE: try to decrease number of columns, or create a new table in the future
class DatabaseHelper {
  // The database instance inside of DatabaseHelper
  static Database _db;

  // Open database
  Future<void> initializeDatabase() async {
    String path;

    // Check whether parent path exists
    try {
      path = await getDatabasesPath() + 'database.db';
    } catch (_) {
      print('Parent path does not exist');
      return -1;
    }

    if (_db == null) {
      _db = await openDatabase(path, version: 2,
          onCreate: (Database db, int version) async {
        // Create the settings table then insert initial values
        await db.execute('''
          CREATE TABLE $tableSettings (
            $columnName text NOT NULL
          );''');
        await db.insert(tableSettings, {'$columnName': 'User'});

        // Create the reminder table on first run
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

  // This function can be used when table is lost or dropped
  Future<void> createTables() async {
    // Settings table
    await _db.execute('''
          CREATE TABLE $tableSettings (
            $columnName text NOT NULL
          );''');
    await _db.insert(tableSettings, {'$columnName': 'User'});

    // Reminders table
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

  // This function can be used to clear the database in case of an error
  Future<void> dropTables() async {
    await _db.execute('''DROP TABLE $tableReminder;''');
    // await _db.execute('''DROP TABLE $tableSettings;''');
  }

  Future close() async => _db.close();
}
