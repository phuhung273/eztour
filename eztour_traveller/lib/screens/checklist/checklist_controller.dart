import 'package:collection/collection.dart';
import 'package:eztour_traveller/datasource/local/checklist_db.dart';
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

  final categories = <String, List<Todo>>{}.obs;

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

}