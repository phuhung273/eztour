
import 'dart:core';

import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'base_checklist_db.dart';
import 'base_db.dart';

const DB_NAME = 'checklists';

class ChecklistDB extends BaseChecklistDB{

  @override
  String tableName = DB_NAME;

  static final ChecklistDB instance = ChecklistDB._init();

  ChecklistDB._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('$tableName.db');
    return _database!;
  }

  @override
  Future createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableName ( 
          $columnID $integerType UNIQUE,
          $columnMessage $textType,
          $columnCategory $textType,
          $columnDone $integerType
        )
    ''');
  }

  Future batchInsert(List<Todo> items) async {
    final db = await instance.database;

    final Batch batch = db.batch();

    for(final Todo item in items){
      batch.insert(tableName, item.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
    }

    await batch.commit();
  }

  @override
  Future<int> toggle(Todo todo) async {
    final db = await instance.database;

    return db.toggle(tableName, todo);
  }

  @override
  Future<List<Todo>> getAll() async {
    final db = await instance.database;

    return db.getAll(tableName);
  }

  Future clear() async {
    final db = await instance.database;

    db.delete(tableName);
  }
}