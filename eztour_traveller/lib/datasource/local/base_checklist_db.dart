
import 'package:eztour_traveller/datasource/local/base_db.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:sqflite/sqflite.dart';


const COLUMN_ID = FIELD_ID;
const COLUMN_MESSAGE = FIELD_MESSAGE;
const COLUMN_CATEGORY = FIELD_CATEGORY;
const COLUMN_DONE = FIELD_DONE;

abstract class BaseChecklistDB extends BaseDB{

  final columnID = COLUMN_ID;
  final columnMessage = COLUMN_MESSAGE;
  final columnCategory = COLUMN_CATEGORY;
  final columnDone = COLUMN_DONE;

  @override
  Future? onConfigure(Database db) {
  }

  Future<int> toggle(Todo todo);
  Future<List<Todo>> getAll();
}

extension ChecklistDatabase on Database{
  Future<int> toggle(String table, Todo todo) async {

    return update(table,
        {
          COLUMN_DONE: todo.isDone() ? 0 : 1
        },
        where: '$COLUMN_ID = ?',
        whereArgs: [todo.id]
    );
  }

  Future<List<Todo>> getAll(String table) async {

    final List<Map<String, dynamic>> maps = await query(table);

    return List.generate(maps.length, (i) => Todo.fromJson(maps[i]));
  }
}