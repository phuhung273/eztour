import 'package:eztour_traveller/datasource/remote/checklist_service.dart';
import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/checklist/checklist_response.dart';
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

  final todos = [].obs;
  // var _todos = [
  //     Todo(id: 1, message: "Design", done: true),
  //     Todo(id: 2, message: "Code", done: false),
  //     Todo(id: 3, message: "Review", done: false),
  // ].obs;


  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getChecklist(_checklistRequest);
    todos.value = response.todos;
    update();
  }

  void toggleTodo(int index){
    final todo = todos[index] as Todo;
    todo.done = !todo.done;
    todos[index] = todo;
    update();
  }

}