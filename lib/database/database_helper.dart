import 'package:lumoz/models/comment.dart';
import 'package:lumoz/models/reminder.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = "reminders";
  static final String _tableNameTvShow = "tvshows";
  static final String _tableNameComment = "comments";

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'lumoz3.db';
      _database = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              "CREATE TABLE $_tableNameTvShow("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "channel STRING, title STRING, image STRING, "
                  "description TEXT, season String, "
                  "isOngoing INTEGER)",
            );
            db.execute(
              "CREATE TABLE $_tableName("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "tvShow STRING, note TEXT, date STRING, "
                  "startTime STRING, endTime STRING, "
                  "reminder INTEGER, repeat STRING, "
                  "color INTEGER, "
                  "isCompleted INTEGER)",
            );
            db.execute(
              "CREATE TABLE $_tableNameComment("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "comment TEXT, tvShowId INTEGER)",
            );
          }
      );
    } catch (e) {
      print(e);
    }
  }


  static Future <int> createReminder(Reminder? reminder) async {
    print("create reminder function called");
    return await _database?.insert(_tableName, reminder!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> query() async {
    print("reminder query function called");
    return await _database!.query(_tableName);
  }

  static delete(Reminder reminder) async {
    return await _database?.delete(
        _tableName, where: 'id=?', whereArgs: [reminder.id]);
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

  static Future <int> createTvShow(TvShow? tvShow) async {
    print("create tv show function called");
    return await _database?.insert(_tableNameTvShow, tvShow!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryTvShow() async {
    print("reminder query function called");
    return await _database!.query(_tableNameTvShow);
  }

  static deleteTvShow(TvShow tvShow) async {
    return await _database?.delete(_tableNameTvShow, where: 'id=?', whereArgs: [tvShow.id]);
  }

  static updateTvShow(int id) async {
    return await _database!.rawUpdate(
        '''
             UPDATE tvshows
             SET isOngoing = ?
             WHERE id =?
             ''', [1, id]
    );
  }

  static Future <int> createComment(Comment? comment) async {
    print("create comment function called");
    return await _database?.insert(_tableNameComment, comment!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryComments() async {
    print("comment query function called");
    return await _database!.query(_tableNameComment);
  }

  static deleteComment(Comment comment) async{
    return await _database?.delete(_tableNameComment, where: 'id=?', whereArgs: [comment.id]);
  }

  static updateComment(int id, String comment) async{
    return await _database!.rawUpdate(
        '''
             UPDATE comments
             SET comment = ?
             WHERE id =?
             ''', [comment, id]
    );
  }


}