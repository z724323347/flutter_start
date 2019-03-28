import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/test_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableNote = 'note11Table';
  final String pointID = 'pointid';
  final String image = 'image';
  final String contractId = 'contractId';
  final String publicationId = 'publicationId';
  final String pointLat = 'pointLat';
  final String pointLng = 'pointLng';
  
  static Database _db;
  DatabaseHelper.internal();
  
  Future<Database> get db async {
    if (_db !=null) {
      return _db;
    }

    _db =await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path =join(databasesPath, 'note_test.db');
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  

  void _onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE $tableNote($pointID TEXT PRIMARY KEY, $image TEXT, $contractId TEXT, $publicationId TEXT, $pointLng TEXT, $pointLat TEXT)');
  }



}
