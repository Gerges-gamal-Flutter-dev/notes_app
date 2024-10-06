// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter_sqflite_app.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  //onUpgrade
  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  //onCreate
  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "notes" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "title" TEXT NOT NULL,
      "note" TEXT NOT NULL,
      "color" TEXT NOT NULL
    )
    ''');
  }

  //read data
  readData(String s) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(s);
    return response;
  }
//insert data
  insertData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql);
  }
//update data
  updateData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql);
  }
//delete data
  deleteData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql);
  }
  mydeleteDatabese() {}
}
