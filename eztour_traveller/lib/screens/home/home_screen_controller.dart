import 'dart:math';

import 'package:eztour_traveller/datasource/remote/home_service.dart';
import 'package:eztour_traveller/helpers/time_helpers.dart';
import 'package:eztour_traveller/schema/announcement/announcement_category.dart';
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

  final HomeService _service = Get.find();

  final HomeIndexRequest _homeIndexRequest = Get.find();

  var initialPage = 0.obs;
  var greeting = ''.obs;
  final todoCategories = List<TodoCategory>.empty().obs;
  final announcementCategories = List<AnnouncementCategory>.empty().obs;
  final locations = List<Location>.empty().obs;
  final image = ''.obs;

  @override
  Future onInit() async {
    super.onInit();

    _homeIndexRequest.localTime = DateFormat.Hms().format(DateTime.now());
    final response = await _service.getHomeInfo(_homeIndexRequest);
    final dayDifference = dayDifferenceFromNow(DateTime.parse(response.tour.startDate));
    initialPage.value = min(dayDifference, response.tour.maxDay - 1);

    greeting.value = response.greeting;
    todoCategories.value = response.tour.todoCategories;
    announcementCategories.value = response.tour.announcementCategories;
    locations.value = response.tour.locations;
    image.value = response.tour.image;
  }
}