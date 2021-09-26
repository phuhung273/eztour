
import 'dart:core';

import 'package:eztour_traveller/datasource/local/base_db.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'user_announcements';
const COLUMN_ID = 'id';
const COLUMN_MESSAGE = 'message';

class UserAnnouncementDB extends BaseDB{
  @override
  String tableName = DB_NAME;

  static final UserAnnouncementDB instance = UserAnnouncementDB._init();

  UserAnnouncementDB._init();

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
          $COLUMN_ID $textType,
          $COLUMN_MESSAGE $textType
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

  Future<int> add(Announcement announcement) async {
    final db = await instance.database;

    return db.insert(tableName, announcement.toJson());
  }

  Future<int> update(Announcement announcement) async {
    final db = await instance.database;

    return db.update(tableName,
        announcement.toJson(),
        where: '$COLUMN_ID = ?',
        whereArgs: [announcement.id]
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return db.delete(tableName, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future clear() async {
    final db = await instance.database;

    db.delete(tableName);
  }

}