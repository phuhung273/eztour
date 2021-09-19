import 'package:eztour_traveller/datasource/local/user_announcement_db.dart';
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

  final UserAnnouncementDB _userAnnouncementDB = Get.find();

  final _announcementListRequest = Get.put(AnnouncementListRequest());

  final announcements = List<Announcement>.empty().obs;

  final myAnnouncements = List<Announcement>.empty().obs;

  // final announcements = [
  //   announcement(id: 1, message: "Design"),
  //   announcement(id: 2, message: "Code"),
  //   announcement(id: 3, message: "Review"),
  // ].obs;

  // final myAnnouncements = [
  //   announcement(id: 1, message: "Design"),
  //   announcement(id: 2, message: "Code"),
  //   announcement(id: 3, message: "Review"),
  //   announcement(id: 3, message: "await handler(true) : Means that you will await the animation to complete(you should call setState after it so that you will get an animation)"),
  //   announcement(id: 3, message: "await handler(true) : Means that you will await the animation to complete(you should call setState after it so that you will get an animation)"),
  //   announcement(id: 3, message: "await handler(true) : Means that you will await the animation to complete(you should call setState after it so that you will get an animation)"),
  //   announcement(id: 3, message: "await handler(true) : Means that you will await the animation to complete(you should call setState after it so that you will get an animation)"),
  // ].obs;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getAnnouncementList(_announcementListRequest);
    announcements.value = response.announcements;
    myAnnouncements.value = await _userAnnouncementDB.getAll();
  }

  Future add(String value) async {
    final id = await _userAnnouncementDB.add(value);

    if(id > 0){
      myAnnouncements.add(Announcement(id: id, message: value));
    }
  }

  Future removeAt(int index) async {
    final result = await _userAnnouncementDB.delete(myAnnouncements[index].id);

    if(result > 0){
      myAnnouncements.removeAt(index);
    }
  }

  Future updateAt(int index, String value) async {
    final announcement = myAnnouncements[index];
    announcement.message = value;
    final result = await _userAnnouncementDB.update(announcement);

    if(result > 0){
      myAnnouncements[index].message = value;
    }
  }
}