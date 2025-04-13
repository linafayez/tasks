import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

const String tasksTable = 'tasks';

class SqfliteDBHelper {
  static SqfliteDBHelper? _instance;
  final Database _dbInstance;
  SqfliteDBHelper._(this._dbInstance);

  static Future<SqfliteDBHelper> getInstanceOfTasksDB() async {
    try {
      final dbPath = await getDatabasesPath();

      final db = await openDatabase(
        path.join(dbPath, 'tasks.db'),
        onCreate: (db, version) async {
          return await db.execute(
              'CREATE TABLE  $tasksTable(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,description TEXT NOT NULL,taskData TEXT, updatedDate TEXT, startTime TEXT, endTime TEXT,isCompleted bool )');
        },
        version: 1,
      );
      _instance ??= SqfliteDBHelper._(db);
      log("created db");
      return _instance!;
    } catch (e) {
      log('error creating sqlite db');
      rethrow;
    }
  }

  Future<int> insert(Map<String, Object?> data) async {
    try {
      var res = await _dbInstance.insert(tasksTable, data, conflictAlgorithm: ConflictAlgorithm.replace);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> getAllTasks() async {
    try {
      return await _dbInstance.query(tasksTable);
    } catch (_) {
      return [];
    }
  }

  Future<List<Map<String, Object?>>> queryData(DateTime date) async {
    return await _dbInstance.rawQuery('SELECT * FROM $tasksTable WHERE taskData = ?', [date.toIso8601String()]);
  }

  Future<int> deleteData({String? where}) async {
    return await _dbInstance.delete(tasksTable, where: where, whereArgs: null);
  }

  Future<int> updateData(Map<String, Object?> values) async {
    return await _dbInstance.update(tasksTable, values, where: "id = ?", whereArgs: [values["id"]]);
  }
}
