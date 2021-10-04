
import 'dart:core';

import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'chat';

const TABLE_USER_NAME = 'users';
const TABLE_MESSAGES_NAME = 'messages';

const COLUMN_USER_ID = FIELD_USERID;
const COLUMN_USER_USERNAME = FIELD_USERNAME;
const COLUMN_USER_CONNECTED = FIELD_CONNECTED;

const COLUMN_MESSAGE_ID = FIELD_ID;
const COLUMN_MESSAGE_CONTENT = FIELD_CONTENT;
const COLUMN_MESSAGE_FROMID = FIELD_FROM;
const COLUMN_MESSAGE_TOID = FIELD_TO;
const COLUMN_MESSAGE_TYPE = FIELD_TYPE;

class ChatUserDB {
   static final ChatUserDB instance = ChatUserDB._init();

   static Database? _database;

   ChatUserDB._init();

   Future<Database> get database async {
     if (_database != null) return _database!;

     _database = await _initDB('$DB_NAME.db');
     return _database!;
   }
   Future<Database> _initDB(String filePath) async {
     final dbPath = await getDatabasesPath();
     final path = join(dbPath, filePath);

     return openDatabase(path, version: 1, onCreate: _createDB, onConfigure: _onConfigure);
   }

   Future _onConfigure(Database db) async {
     await db.execute('PRAGMA foreign_keys = ON');
   }

   Future _createDB(Database db, int version) async {
     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
     const textType = 'TEXT NOT NULL';
     const integerType = 'INTEGER NOT NULL';

     await db.execute('''
        CREATE TABLE $TABLE_USER_NAME ( 
          $COLUMN_USER_ID $textType UNIQUE,
          $COLUMN_USER_USERNAME $textType,
          $COLUMN_USER_CONNECTED $integerType
        )
     ''');

     await db.execute('''
        CREATE TABLE $TABLE_MESSAGES_NAME (
          $COLUMN_MESSAGE_ID $textType UNIQUE,
          $COLUMN_MESSAGE_CONTENT $textType,
          $COLUMN_MESSAGE_FROMID $textType,
          $COLUMN_MESSAGE_TOID $textType,
          $COLUMN_MESSAGE_TYPE $textType
        )
     ''');
   }

  Future batchInsert(List<ChatSocketUser> users) async {
    final db = await instance.database;

    final Batch batch = db.batch();

    for(final ChatSocketUser user in users){
      batch.insert(TABLE_USER_NAME, user.toJsonWithoutMessages(), conflictAlgorithm: ConflictAlgorithm.replace);

      for(final ChatSocketMessage message in user.messages!){
        batch.insert(TABLE_MESSAGES_NAME, message.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    }

    await batch.commit(noResult: true);
  }

  Future<List<ChatSocketUser>> getUsers() async {
     final db = await instance.database;

     final List<Map<String, dynamic>> maps = await db.query(TABLE_USER_NAME);

     return List.generate(maps.length, (i) => ChatSocketUser.fromJson(maps[i]));
  }

   Future<List<ChatSocketMessage>> getMessagesByPartnerID(String id) async {
     final db = await instance.database;

     final List<Map<String, dynamic>> maps = await db.query(
       TABLE_MESSAGES_NAME,
       where: '$COLUMN_MESSAGE_FROMID = ? OR $COLUMN_MESSAGE_TOID = ?',
       whereArgs: [id, id]
     );

     return List.generate(maps.length, (i) => ChatSocketMessage.fromJson(maps[i]));
   }

   Future<int> addMessage(ChatSocketMessage message) async {
     final db = await instance.database;

     return db.insert(TABLE_MESSAGES_NAME, message.toJson());
   }

  Future<int> disconnect(String id) async {
    final db = await instance.database;
    final userMaps = await db.query(TABLE_USER_NAME, where: '$COLUMN_USER_ID = ?', whereArgs: [id], limit: 1);
    final selectedUser = ChatSocketUser.fromJson(userMaps.first);
    selectedUser.connected = 0;

    return db.update(TABLE_USER_NAME, selectedUser.toJson(), where: '$COLUMN_USER_ID = ?', whereArgs: [id]);
  }

   Future clear() async {
     final db = await instance.database;

     db.delete(TABLE_USER_NAME);
     db.delete(TABLE_MESSAGES_NAME);
   }
}