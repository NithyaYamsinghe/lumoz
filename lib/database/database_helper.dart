import 'package:lumoz/models/channel.dart';
import 'package:lumoz/models/comment.dart';
import 'package:lumoz/models/home.dart';
import 'package:lumoz/models/reminder.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/models/user.dart';
import 'package:sqflite/sqflite.dart';

import '../models/admin_management.dart';
import '../models/user_management.dart';

class DatabaseHelper {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = "reminders";
  static final String _tableNameTvShow = "tvshows";
  static final String _tableNameComment = "comments";
  static final String _tableNameUser= "users";
  static final String _tableNameChannel= "channels";
  static final String _tableNameHome =  "homes";
  static final String _tableNameAdminManagement =  "adminManagements";
  static final String _tableNameUserManagement =  "userManagements";

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'lumoz6.db';
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
            db.execute(
              "CREATE TABLE $_tableNameUser("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "userName STRING, firstName STRING, "
                  "lastName STRING, email STRING, "
                  "password STRING, mobile STRING, "
                  "age INTEGER)",
            );
            db.execute(
              "CREATE TABLE $_tableNameChannel("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "channel STRING, image STRING, "
                  "description TEXT)",
            );
            db.execute(
              "CREATE TABLE $_tableNameHome("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "text STRING, image STRING, "
                  "link STRING)",
            );
            db.execute(
              "CREATE TABLE $_tableNameUserManagement("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "text STRING, image STRING, "
                  "link STRING)",
            );
            db.execute(
              "CREATE TABLE $_tableNameAdminManagement("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "text STRING, image STRING, "
                  "link STRING)",
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
    return await _database!.query(_tableNameTvShow);
  }

  static Future <List<Map<String, dynamic>>> querySelectedTvShow(String channel) async {
    return await _database!.query(
        _tableNameTvShow,
        where: 'channel = ?', whereArgs: [channel]
    );
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

  static Future <int> createUser(User? user) async {
    return await _database?.insert(_tableNameUser, user!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> queryUser(String email) async {
    return await _database!.query(
      _tableNameUser,
      where: 'email = ?', whereArgs: [email]
    );
  }

  static Future <List<Map<String, dynamic>>> queryUsers() async {
    return await _database!.query(_tableNameUser);
  }

  static deleteUser(User user) async{
    return await _database?.delete(_tableNameUser, where: 'id=?', whereArgs: [user.id]);
  }

  static updateUser(int id, String password) async{
    return await _database!.rawUpdate(
        '''
             UPDATE users
             SET password = ?
             WHERE id =?
             ''', [password, id]
    );
  }

  static Future <int> createChannel(Channel? channel) async {
    return await _database?.insert(_tableNameChannel, channel!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryChannel() async {
    return await _database!.query(_tableNameChannel);
  }

  static deleteChannel(Channel channel) async{
    return await _database?.delete(_tableNameChannel, where: 'id=?', whereArgs: [channel.id]);
  }

  static updateChannel(int id, String description) async{
    return await _database!.rawUpdate(
        '''
             UPDATE channels
             SET description = ?
             WHERE id =?
             ''', [description, id]
    );
  }

  static Future <int> createHome(Home? home) async {
    return await _database?.insert(_tableNameHome, home!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryHomes() async {
    return await _database!.query(_tableNameHome);
  }

  static deleteHome(Home home) async{
    return await _database?.delete(_tableNameHome, where: 'id=?', whereArgs: [home.id]);
  }

  static updateHome(int id, String text) async{
    return await _database!.rawUpdate(
        '''
             UPDATE homes
             SET text = ?
             WHERE id =?
             ''', [text, id]
    );
  }

  static Future <int> createAdminManagement(AdminManagement? adminManagement) async {
    return await _database?.insert(_tableNameAdminManagement, adminManagement!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryAdminManagements() async {
    return await _database!.query(_tableNameAdminManagement);
  }

  static deleteAdminManagement(AdminManagement adminManagement) async{
    return await _database?.delete(_tableNameAdminManagement, where: 'id=?', whereArgs: [adminManagement.id]);
  }

  static updateAdminManagement(int id, String text) async{
    return await _database!.rawUpdate(
        '''
             UPDATE adminManagements
             SET text = ?
             WHERE id =?
             ''', [text, id]
    );
  }

  static Future <int> createUserManagement(UserManagement? userManagement) async {
    return await _database?.insert(_tableNameUserManagement, userManagement!.toJson()) ?? 1;
  }

  static Future <List<Map<String, dynamic>>> queryUserManagements() async {
    return await _database!.query(_tableNameUserManagement);
  }

  static deleteUserManagement(UserManagement userManagement) async{
    return await _database?.delete(_tableNameUserManagement, where: 'id=?', whereArgs: [userManagement.id]);
  }

  static updateUserManagement(int id, String text) async{
    return await _database!.rawUpdate(
        '''
             UPDATE userManagements
             SET text = ?
             WHERE id =?
             ''', [text, id]
    );
  }
}