import 'package:eztour_traveller/datasource/remote/schedule_service.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:get/get.dart';

class ScheduleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleScreenController());
  }
}

class ScheduleScreenController extends GetxController {

  final _service = Get.put(ScheduleService(Get.find()));
  final _scheduleListRequest = Get.put(ScheduleListRequest());

  var locations = [].obs;

  // var locations = [
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 2, tour_id: 1),
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 3, tour_id: 1),
  //   Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 4, tour_id: 1),
  // ].obs;

  var max_day = 0.obs;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getScheduleList(_scheduleListRequest);
    locations.value = response.locations;
    max_day.value = response.max_day;
    update();
  }
}