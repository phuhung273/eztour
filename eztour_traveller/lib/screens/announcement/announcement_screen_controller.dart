import 'package:collection/collection.dart';
import 'package:eztour_traveller/datasource/local/my_announcement_db.dart';
import 'package:eztour_traveller/datasource/remote/announcement_service.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_request.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


class AnnouncementScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementScreenController());
  }
}

class AnnouncementScreenController extends GetxController {

  final _service = Get.put(AnnouncementService(Get.find()));

  final MyAnnouncementDB _userAnnouncementDB = Get.find();

  final _announcementListRequest = Get.put(AnnouncementListRequest());

  final categories = <String, List<Announcement>>{}.obs;

  final myCategories = <String, List<Announcement>>{}.obs;

  final uuid = const Uuid();

  late List<String> _titles;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getAnnouncementList(_announcementListRequest);
    categories.value = groupBy(response.announcements, (Announcement item) => item.category!);

    final myAnnouncements = await _userAnnouncementDB.getAll();
    myCategories.value = groupBy(myAnnouncements, (Announcement item) => item.category!);
    _titles = myCategories.keys.toList();
  }

  Future add(String category, Announcement item) async {
    myCategories[category]?.add(item);
    myCategories.refresh();
  }

  void delete(String category, String id) {
    myCategories[category]?.removeWhere((element) => element.id == id);
    myCategories.refresh();
  }

  void updateItem(String category, Announcement item) {
    final index = myCategories[category]?.indexOf(item);
    if(index != null && index > 0){
      myCategories[category]?[index] = item;
      myCategories.refresh();
    }
  }

  void removeCategory(String category){
    myCategories.remove(category);
  }

  void addCategory(String category, List<Announcement> items){
    myCategories[category] = items;
    _titles.add(category);
  }

  void updateChangeCategoryName(String lastCategory, String category, List<Announcement> items){
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