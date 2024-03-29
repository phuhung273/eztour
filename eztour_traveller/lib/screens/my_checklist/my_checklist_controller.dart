import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/datasource/local/my_checklist_db.dart';
import 'package:eztour_traveller/enum.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/screens/checklist/checklist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MyChecklistScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyChecklistScreenController());
  }
}

class MyChecklistScreenController extends GetxController {

  final MyChecklistDB _myDB = Get.find();

  final ChecklistScreenController _mainController = Get.find();

  final TextEditingController titleController = TextEditingController();

  final uuid = const Uuid();

  String category = '';
  final items = List<Todo>.empty().obs;
  late Mode? mode;
  String? lastCategory;

  @override
  void onInit() {
    super.onInit();

    mode = EnumToString.fromString(Mode.values, Get.parameters[modeParams] ?? '');
    final passedCategory = Get.parameters[categoryParams];

    if(passedCategory != null && mode == Mode.Edit){
      category = passedCategory;
      lastCategory = passedCategory;

      items.assignAll(_mainController.myCategories[category]!);

      titleController.value = TextEditingValue(text: category);
    }
  }

  Future<bool> submit() async {
    if(category.isEmpty){
      return false;
    }

    if(mode == Mode.Add){
      if(_mainController.isTitleExist(category)){
        return false;
      }

      _mainController.addCategory(category, items);

    } else if(mode == Mode.Edit && lastCategory != null){

      final result = await _myDB.updateCategory(lastCategory!, category);
      if(result > 0){
        _mainController.updateChangeCategoryName(lastCategory!, category, items);
      }
    }
    return true;
  }

  Future toggle(int index) async {
    final result = await _myDB.toggle(items[index]);

    if(result > 0){
      items[index].toggle();
      items.refresh();
      _mainController.myCategories.refresh();
    }
  }

  Future add(String message) async {
    final item = Todo(id: uuid.v4() , message: message, done: 0, category: category);
    final result = await _myDB.insert(item);

    if(result > 0){
      items.add(item);
      _mainController.add(category, item);
    }
  }

  Future deleteAt(int index) async {
    final id = items[index].id;

    final result = await _myDB.delete(id);

    if(result > 0){
      items.removeAt(index);
      _mainController.delete(category, id);
    }
  }

  Future updateAt(int index, String message) async {
    final todo = items[index]..message = message;

    final result = await _myDB.update(todo);

    if(result > 0){
      items[index] = todo;
      _mainController.updateItem(category, todo);
    }
  }

  void deleteCategory() {
    if(mode == Mode.Edit && lastCategory != null){
      _myDB.deleteCategory(lastCategory!);
      _mainController.removeCategory(lastCategory!);
    }
  }
}