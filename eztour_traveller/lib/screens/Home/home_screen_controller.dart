import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/remote/home_service.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}

class HomeScreenController extends GetxController {

  final LocalStorage _localStorage = Get.find();

  final _service = Get.put(HomeService(Get.find()));

  final _homeIndexRequest = Get.put(HomeIndexRequest());

  var greeting = ''.obs;
  final todos = List<Todo>.empty().obs;
  final announcements = List<Announcement>.empty().obs;
  final locations = [
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
  ].obs;

  @override
  Future onInit() async {
    super.onInit();

    _homeIndexRequest.local_time = DateFormat.Hms().format(DateTime.now());
    final response = await _service.getHomeInfo(_homeIndexRequest);
    greeting.value = response.greeting;
    todos.value = response.todos;
    announcements.value = response.announcements;
    update();
  }

  void logOut(){
    _localStorage.removeAccessToken();
    Get.offAndToNamed(ROUTE_LOGIN);
  }
}