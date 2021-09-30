
import 'dart:core';

import 'package:eztour_traveller/datasource/local/base_db.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'my_announcements';
const COLUMN_ID = FIELD_ID;
const COLUMN_MESSAGE = FIELD_MESSAGE;
const COLUMN_CATEGORY = FIELD_CATEGORY;

class MyAnnouncementDB extends BaseDB{

  @override
  String tableName = DB_NAME;

  final columnID = COLUMN_ID;
  final columnMessage = COLUMN_MESSAGE;
  final columnCategory = COLUMN_CATEGORY;

  static final MyAnnouncementDB instance = MyAnnouncementDB._init();

  MyAnnouncementDB._init();

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
          $columnID $textType,
          $columnMessage $textType,
          $columnCategory $textType
        )
    ''');
  }

  @override
  Future? onConfigure(Database db) {
  }

  Future<List<Announcement>> getAll() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) => Announcement.fromJson(maps[i]));
  }

  Future<int> insert(Announcement announcement) async {
    final db = await instance.database;

    return db.insert(tableName, announcement.toJson());
  }

  Future<int> update(Announcement item) async {
    final db = await instance.database;

    return db.update(tableName, item.toJsonWithoutId(), where: '$columnID = ?', whereArgs: [item.id]);
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return db.delete(tableName, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> updateCategory(String from, String to) async {
    final db = await instance.database;

    return db.update(tableName,
        {
          columnCategory: to,
        },
        where: '$columnCategory = ?',
        whereArgs: [from]
    );
  }

  Future<int> deleteCategory(String category) async {
    final db = await instance.database;

    return db.delete(tableName, where: '$columnCategory = ?', whereArgs: [category]);
  }

  Future clear() async {
    final db = await instance.database;

    db.delete(tableName);
  }

}