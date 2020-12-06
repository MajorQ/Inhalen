import 'package:sqflite/sqflite.dart';

// Reminder table
final String tableReminder = 'reminder';

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

// NOTE: try to decrease number of columns, or create a new table in the future

class DatabaseHelper {
  // A database instance
  Database _db;

  // Open database
  Future open() async {
    if (_db == null) {
      String path = await getDatabasesPath() + 'database.db';
      _db = await openDatabase(path, version: 2,
          onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableReminder (
            $columnId int NOT NULL,
            $columnTimeHour int NOT NULL,
            $columnTimeMinute int NOT NULL,
            $columnLabel text,
            $columnSwitchON int NOT NULL,
            $columnCardColor int NOT NULL
          );
      ''');
      });
    }
  }

  Future<void> createReminder(Map map) async {
    await _db.insert('$tableReminder', map);
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
  Future<void> createTable() async {
    await _db.execute('''
      CREATE TABLE $tableReminder (
        $columnId int NOT NULL,
        $columnTimeHour int NOT NULL,
        $columnTimeMinute int NOT NULL,
        $columnLabel text,
        $columnSwitchON int NOT NULL,
        $columnCardColor int NOT NULL
      );''');
  }

  // This function can be used to clear the database in case of an error
  Future<void> deleteALL() async {
    await _db.rawDelete('''DELETE FROM $tableReminder;''');
    await deleteDatabase(await getDatabasesPath() + 'database.db');
  }

  Future close() async => _db.close();
}

// Unused at the moment

// $columnDayMonday int,
// $columnDayTuesday int,
// $columnDayWednesday int,
// $columnDayThursday int,
// $columnDayFriday int,
// $columnDaySaturday int,
// $columnDaySunday int,

// columnDayMonday,
// columnDayTuesday,
// columnDayWednesday,
// columnDayThursday,
// columnDayFriday,
// columnDaySaturday,
// columnDaySunday
