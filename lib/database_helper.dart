import 'dart:async';
import 'dart:io';
import 'package:flutter_sqflite/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String users = "users";
  final String id = "id";
  final String username = "username";
  final String password = "password";

  //
  static final DataBaseHelper _instance = new DataBaseHelper.internal();
  DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "maindb.db");
    var OurDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return OurDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $users($id INTEGER PRIMARY KEY, $username TEXT, $password TEXT)");
  }

  // CRUD function

  Future<int> createUser(User user) async {
    var dbClient = await db;
    int result = await dbClient.insert(users, user.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $users");
    return result.toList();
  }

  Future<User> getUser(int userID) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $users WHERE $id=$userID");
    if (result.length == 0) return null;
    return User.fromMap(result.first);
  }

  Future<int> deleteUser(int userID) async {
    var dbClient = await db;
    return await dbClient.delete(users, where: "id = ?", whereArgs: [userID]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient
        .update(users, user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
