import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //database name
  static const String _databaseName = "todo_db";
  //database version
  static const int _databaseVersion = 1;
  //table name
  static const todoTable = "todo";

  //constructor for the class
  DatabaseHelper._privateConstructor();

  //static instance for the database helper
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //database instance
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //initializing the database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //creating a database
  _onCreate(Database db, int version) async {
    await db.execute(
      '''
    CREATE TABLE $todoTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title VARCHAR,
      description TEXT,
      color INTEGER
    )
    ''',
    );
  }
}


  // phone VARCHAR(15)
  //     email VARCHAR(255)