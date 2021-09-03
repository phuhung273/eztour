import 'package:eztour_traveller/datasource/remote/announcement_service.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_request.dart';
import 'package:get/get.dart';

class AnnouncementScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementScreenController());
  }
}

class AnnouncementScreenController extends GetxController {

  final _service = Get.put(AnnouncementService(Get.find()));

  final _announcementListRequest = Get.put(AnnouncementListRequest());

  final announcements = List<Announcement>.empty().obs ;

  // final announcements = [
  //   Announcement(id: 1, message: "Design"),
  //   Announcement(id: 2, message: "Code"),
  //   Announcement(id: 3, message: "Review"),
  // ].obs;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getAnnouncementList(_announcementListRequest);

    announcements.value = response.announcements;
    update();
  }
}