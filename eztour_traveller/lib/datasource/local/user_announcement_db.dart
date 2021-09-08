
import 'dart:core';

import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const TABLE_NAME = 'user_announcements';
const COLUMN_ID = 'id';
const COLUMN_MESSAGE = 'message';

class UserAnnouncementDB{
  static final UserAnnouncementDB instance = UserAnnouncementDB._init();

  static Database? _database;

  UserAnnouncementDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('$TABLE_NAME.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
        CREATE TABLE $TABLE_NAME ( 
          $COLUMN_ID $idType,
          $COLUMN_MESSAGE $textType
        )
     ''');
  }

  Future<List<Announcement>> getAll() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return List.generate(maps.length, (i) => Announcement.fromJson(maps[i]));
  }

  Future<int> add(String message) async {
    final db = await instance.database;

    return db.insert(TABLE_NAME, {COLUMN_MESSAGE: message});
  }

  Future<int> update(Announcement announcement) async {
    final db = await instance.database;

    return db.update(TABLE_NAME,
        announcement.toJson(),
        where: '$COLUMN_ID = ?',
        whereArgs: [announcement.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(TABLE_NAME, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future clear() async {
    final db = await instance.database;

    db.delete(TABLE_NAME);
  }
}