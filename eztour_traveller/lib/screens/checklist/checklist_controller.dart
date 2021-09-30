
import 'package:collection/collection.dart';
import 'package:eztour_traveller/datasource/local/checklist_db.dart';
import 'package:eztour_traveller/datasource/local/my_checklist_db.dart';
import 'package:eztour_traveller/datasource/remote/checklist_service.dart';
import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:get/get.dart';

class ChecklistScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChecklistScreenController());
  }
}

class ChecklistScreenController extends GetxController {

  final _service = Get.put(ChecklistService(Get.find()));

  final _checklistRequest = Get.put(ChecklistRequest());

  final ChecklistDB _checklistDB = Get.find();

  final MyChecklistDB _userChecklistDB = Get.find();

  final categories = <String, List<Todo>>{}.obs;

  final myCategories = <String, List<Todo>>{}.obs;

  late List<String> _titles;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getChecklist(_checklistRequest);

    for(final todo in response.todos){
      todo.done = 0;
    }

    await _checklistDB.batchInsert(response.todos);

    final todos = await _checklistDB.getAll();

    categories.value = groupBy(todos, (Todo item) => item.category!);

    final myTodos = await _userChecklistDB.getAll();

    myCategories.value = groupBy(myTodos, (Todo item) => item.category!);
    _titles = myCategories.keys.toList();
  }

  Future toggle(Todo item) async {
    final result = await _checklistDB.toggle(item);

    if(result > 0){
      categories.forEach((key, category) {
        for(final todo in category){
          if(todo.id == item.id){
            todo.toggle();
            categories.refresh();
            return;
          }
        }
      });
    }
  }

  void add(String category, Todo item){
    myCategories[category]?.add(item);
    myCategories.refresh();
  }

  void delete(String category, String id) {
    myCategories[category]?.removeWhere((element) => element.id == id);
    myCategories.refresh();
  }

  void updateItem(String category, Todo item) {
    final index = myCategories[category]?.indexOf(item);
    if(index != null && index > 0){
      myCategories[category]?[index] = item;
      myCategories.refresh();
    }
  }

  void removeCategory(String category){
    myCategories.remove(category);
  }

  void addCategory(String category, List<Todo> items){
    myCategories[category] = items;
    _titles.add(category);
  }
  
  void updateChangeCategoryName(String lastCategory, String category, List<Todo> items){
    myCategories.value = myCategories.map((key, value)
      => key == lastCategory
          ? MapEntry(category, items)
          : MapEntry(key, value)
    );
    _titles.remove(lastCategory);
    _titles.add(category);
  }

  bool isTitleExist(String value){
    return _titles.contains(value);
  }
}