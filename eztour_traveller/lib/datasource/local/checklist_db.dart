
import 'dart:core';

import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'checklists';
const COLUMN_ID = 'id';
const COLUMN_MESSAGE = 'message';
const COLUMN_CATEGORY = 'category';
const COLUMN_DONE = 'done';

class ChecklistDB{
  static final ChecklistDB instance = ChecklistDB._init();

  static Database? _database;

  ChecklistDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('$DB_NAME.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
        CREATE TABLE $DB_NAME ( 
          $COLUMN_ID $integerType UNIQUE,
          $COLUMN_MESSAGE $textType,
          $COLUMN_CATEGORY $textType,
          $COLUMN_DONE $integerType
        )
     ''');
  }

  Future batchInsert(List<Todo> items) async {
    final db = await instance.database;

    final Batch batch = db.batch();

    for(final Todo item in items){
      batch.insert(DB_NAME, item.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
    }

    await batch.commit();
  }

  Future<int> toggle(Todo todo) async {
    final db = await instance.database;

    return db.update(DB_NAME,
        {
          COLUMN_DONE: todo.done == 1 ? 0 : 1
        },
        where: '$COLUMN_ID = ?',
        whereArgs: [todo.id]
    );
  }

  Future<List<Todo>> getAll() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(DB_NAME);

    return List.generate(maps.length, (i) => Todo.fromJson(maps[i]));
  }

  Future clear() async {
    final db = await instance.database;

    db.delete(DB_NAME);
  }
}