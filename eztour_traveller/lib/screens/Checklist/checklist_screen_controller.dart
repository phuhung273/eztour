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

  final _checklistDB = Get.put(ChecklistDB.instance);

  final todos = List<Todo>.empty().obs;
  
  // var _todos = [
  //     Todo(id: 1, message: "Design", done: true),
  //     Todo(id: 2, message: "Code", done: false),
  //     Todo(id: 3, message: "Review", done: false),
  // ].obs;


  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getChecklist(_checklistRequest);

    for(final todo in response.todos){
      todo.done = 0;
    }

    await _checklistDB.batchInsert(response.todos);

    todos.value = await _checklistDB.getAll();
    update();
  }

  Future toggleTodo(int index) async {
    final todo = todos[index];
    final result = await _checklistDB.toggle(todo);
    if(result > 0){
      todo.done = todo.isDone() ? 0 : 1;
      todos[index] = todo;
      update();
    }
  }

}