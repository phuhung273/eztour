import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/datasource/local/my_announcement_db.dart';
import 'package:eztour_traveller/enum.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/screens/announcement/announcement_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MyAnnouncementScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAnnouncementScreenController());
  }
}

class MyAnnouncementScreenController extends GetxController {

  final MyAnnouncementDB _myDB = Get.find();

  final AnnouncementScreenController _mainController = Get.find();

  final TextEditingController titleController = TextEditingController();

  final uuid = const Uuid();

  String category = '';
  final items = List<Announcement>.empty().obs;
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

  Future add(String message) async {
    final item = Announcement(id: uuid.v4() , message: message, category: category);
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