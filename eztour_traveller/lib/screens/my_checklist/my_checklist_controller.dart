import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/datasource/local/my_checklist_db.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/screens/checklist/checklist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyChecklistScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyChecklistScreenController());
  }
}

const checklistModeParams = 'mode';
const checklistCategoryParams = 'category';

enum ChecklistMode {
  Edit,
  Add,
}

class MyChecklistScreenController extends GetxController {

  final MyChecklistDB _myChecklistDB = Get.find();

  final ChecklistScreenController _checklistController = Get.find();

  final TextEditingController titleController = TextEditingController();

  String category = '';
  final todos = List<Todo>.empty().obs;
  late ChecklistMode? mode;
  String? lastCategory;

  @override
  void onInit() {
    super.onInit();

    mode = EnumToString.fromString(ChecklistMode.values, Get.parameters[checklistModeParams] ?? '');
    final passedCategory = Get.parameters[checklistCategoryParams];

    if(passedCategory != null && mode == ChecklistMode.Edit){
      category = passedCategory;
      lastCategory = passedCategory;

      todos.assignAll(_checklistController.myCategories[category]!);

      titleController.value = TextEditingValue(text: category);
    }
  }

  Future submit() async {
    if(mode == ChecklistMode.Add){

      _checklistController.assignCategory(category, todos);

    } else if(mode == ChecklistMode.Edit && lastCategory != null){

      final result = await _myChecklistDB.updateCategory(lastCategory!, category);
      if(result > 0){
        _checklistController.assignChangeCategoryName(lastCategory!, category, todos);
      }

    }
  }

  Future toggle(int index) async {
    final result = await _myChecklistDB.toggle(todos[index]);

    if(result > 0){
      todos[index].toggle();
      todos.refresh();
      _checklistController.myCategories.refresh();
    }
  }

  Future addTodo(String message) async {
    final todo = Todo(message: message, done: 0, category: category);
    todo.id = await _myChecklistDB.insert(todo);

    if(todo.id! > 0){
      todos.add(todo);
      _checklistController.add(category, todo);
    }
  }

  Future deleteAt(int index) async {
    final id = todos[index].id;

    if(id != null){
      final result = await _myChecklistDB.delete(id);

      if(result > 0){
        todos.removeAt(index);
        _checklistController.delete(category, id);
      }
    }
  }

  Future updateAt(int index, String message) async {
    final todo = todos[index]..message = message;

    final result = await _myChecklistDB.update(todo);

    if(result > 0){
      todos[index] = todo;
      _checklistController.updateItem(category, todo);
    }
  }
}