
import 'dart:core';

import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const TABLE_NAME = 'chat_users';
const COLUMN_USERID = 'userID';
const COLUMN_USERNAME = 'username';
const COLUMN_CONNECTED = 'connected';

class ChatUserDB{
   static final ChatUserDB instance = ChatUserDB._init();

   static Database? _database;

   ChatUserDB._init();

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
     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
     const textType = 'TEXT NOT NULL';
     const integerType = 'INTEGER NOT NULL';

     await db.execute('''
        CREATE TABLE $TABLE_NAME ( 
          $COLUMN_USERID $textType UNIQUE,
          $COLUMN_USERNAME $textType,
          $COLUMN_CONNECTED $integerType
        )
     ''');
   }

  Future batchInsert(List<ChatSocketUser> users) async {
    final db = await instance.database;

    final Batch batch = db.batch();

    for(final ChatSocketUser user in users){
      batch.insert(TABLE_NAME, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<List<ChatSocketUser>> getAll() async {
     final db = await instance.database;

     final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

     return List.generate(maps.length, (i) => ChatSocketUser.fromJson(maps[i]));
  }

  Future<int> disconnect(String id) async {
    final db = await instance.database;
    final userMaps = await db.query(TABLE_NAME, where: '$COLUMN_USERID = ?', whereArgs: [id], limit: 1);
    final selectedUser = ChatSocketUser.fromJson(userMaps.first);
    selectedUser.connected = 0;

    return db.update(TABLE_NAME, selectedUser.toJson(), where: '$COLUMN_USERID = ?', whereArgs: [id]);
  }

   Future clear() async {
     final db = await instance.database;

     db.delete(TABLE_NAME);
   }
}