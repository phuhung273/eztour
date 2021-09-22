
import 'package:eztour_traveller/datasource/local/base_checklist_db.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:sqflite_common/sqlite_api.dart';

const DB_NAME = 'my_checklists';

class MyChecklistDB extends BaseChecklistDB{

  @override
  String tableName = DB_NAME;

  static final MyChecklistDB instance = MyChecklistDB._init();

  MyChecklistDB._init();

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
          $columnID $idType,
          $columnMessage $textType,
          $columnCategory $textType,
          $columnDone $integerType
        )
    ''');
  }

  Future<int> insert(Todo item) async {
    final db = await instance.database;

    return db.insert(tableName, item.toJsonWithoutId());
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

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(tableName, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(tableName, todo.toJsonWithoutId(), where: '$columnID = ?', whereArgs: [todo.id]);
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
}