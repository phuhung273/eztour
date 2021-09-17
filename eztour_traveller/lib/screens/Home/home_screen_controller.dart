import 'dart:math';

import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/remote/home_service.dart';
import 'package:eztour_traveller/helpers/time_helpers.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/checklist/todo_category.dart';
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

  final _service = Get.put(HomeService(Get.find()));

  final _homeIndexRequest = Get.put(HomeIndexRequest());

  var initialPage = 0.obs;
  var greeting = ''.obs;
  final todoCategories = List<TodoCategory>.empty().obs;
  final announcements = List<Announcement>.empty().obs;
  final locations = [
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tourId: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tourId: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tourId: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tourId: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'test',from: '6:00 AM', to: '9:00 AM', tourId: 1),
  ].obs;

  @override
  Future onInit() async {
    super.onInit();

    _homeIndexRequest.localTime = DateFormat.Hms().format(DateTime.now());
    final response = await _service.getHomeInfo(1, _homeIndexRequest);
    final dayDifference = dayDifferenceFromNow(DateTime.parse(response.startDate));
    initialPage.value = min(dayDifference, response.maxDay - 1);

    greeting.value = response.greeting;
    todoCategories.value = response.todoCategories;
    announcements.value = response.announcements;
  }
}