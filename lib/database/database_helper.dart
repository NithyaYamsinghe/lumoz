import 'package:lumoz/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = "reminders";

  static Future<void> initDatabase()async{
    if(_database != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'lumoz.db';
      _database = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("creating new databse");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "tvShow STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "reminder INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
          );
        }
      );
    }catch(e){
      print(e);
    }
  }

  static Future <int> createReminder (Reminder? reminder) async{
    print("create reminder function called");
    return await _database?.insert(_tableName, reminder!.toJson())??1;
  }

  static Future <List<Map<String, dynamic>>> query() async{
    print("reminder query function called");
    return await _database!.query(_tableName);
  }
    static delete(Reminder reminder) async {
      return await _database?.delete(_tableName, where: 'id=?', whereArgs: [reminder.id]);
  }

  static updateReminder(int id) async {
         return await _database!.rawUpdate(
             '''
             UPDATE reminders
             SET isCompleted = ?
             WHERE id =?
             ''', [1, id]
           );
  }
 }