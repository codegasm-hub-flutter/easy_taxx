import 'dart:io';
import 'package:easy_taxx/datamodels/dbModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  //db info
  static final _dbName = 'easyTaxx.db';
  static final _dbVersion = 1;
  static final _tableName = 'userInput';
  static final _imagetableName = 'userImage';

  //table columns
  static final columnImageId = 'image_id';
  static final columnImage = 'image_name';

  //table columns
  static final columnId = '_id';
  static final columnQuestion = 'question';
  static final columnAnswer = 'answer';
  static final columnStatus = 'status';

  //making it singleton class
  DbHelper._privateConstructor();
  static final DbHelper insatance = DbHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
        CREATE TABLE $_tableName (
          $columnId INTEGER PRIMARY KEY,
          $columnQuestion TEXT,
          $columnAnswer TEXT,
          $columnStatus TEXT
        )

      ''');

    db.execute('''
        CREATE TABLE $_imagetableName (
          $columnImageId INTEGER PRIMARY KEY,
          $columnImage TEXT,
          
        )

      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await insatance.database;
    await db.insert(_tableName, row);
  }

  Future<int> insertImage(Map<String, dynamic> row) async {
    Database db = await insatance.database;
    await db.insert(_imagetableName, row);
  }

  Future<int> deleteImage(int id) async {
    Database db = await insatance.database;
    return await db
        .delete(_imagetableName, where: '$columnImageId=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await insatance.database;
    return await db.query(_tableName);
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<DbModel>> getData() async {
    // Get a reference to the database.
    final Database db = await insatance.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('userInput');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return DbModel(
        id: maps[i]['_id'],
        question: maps[i]['question'],
        answer: maps[i]['answer'],
        status: maps[i]['status'],
      );
    });
  }

// Now, use the method above to retrieve all the dogs.
// Prints a list that include Fido.

  Future<List<Map<String, dynamic>>> skipAll() async {
    Database db = await insatance.database;
    return await db.query(_tableName, where: "$columnStatus='skip' ");
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await insatance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await insatance.database;
    return await db.delete(_tableName, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> deleteWithStatus(String status) async {
    Database db = await insatance.database;
    return await db
        .delete(_tableName, where: '$columnStatus=?', whereArgs: [status]);
  }

  Future<int> deleteWithquestion(String qstn) async {
    Database db = await insatance.database;
    return await db
        .delete(_tableName, where: '$columnQuestion=?', whereArgs: [qstn]);
  }
}
