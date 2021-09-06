import 'dart:math';

import 'package:collection/collection.dart';
import 'package:eztour_traveller/datasource/remote/schedule_service.dart';
import 'package:eztour_traveller/helpers/time_helpers.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleScreenController());
  }
}

class ScheduleScreenController extends GetxController {

  final _service = Get.put(ScheduleService(Get.find()));
  final _listRequest = Get.put(ScheduleListRequest());

  final pageController = PageController();
  final _pageTurnDuration = const Duration(milliseconds: 500);
  final _pageTurnCurve = Curves.ease;

  // final locations = List<Location>.empty().obs;

  var locationMap = <int, List<Location>>{}.obs;

  final _testLocations = [
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, description: 'Sáng: Ăn sáng tại khách sạn. Xe đưa Quý khách tham quan Bảo tàng Louvre – nơi trưng bày các kiệt tác của nhân loại về hội họa, điêu khắc, bức tranh Mona Lisa nổi tiếng.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline2.jpg", day: 1, description: 'Chiều: Ăn trưa, chụp ảnh lưu niệm bên ngoài khu vực Notre Dame de Paris “Nhà thờ Đức Bà Paris” – nổi tiếng trong tác phẩm bất hủ “Thằng gù Nhà Thờ Đức Bà” của đại văn hào Victor Hugo, điện Invalides – nơi chôn cất Napoleon và các danh tướng Pháp, chụp hình lưu niệm với Tháp Eiffel (bên ngoài) – biểu tượng và cũng là niềm tự hào của người dân Pháp để ngắm toàn cảnh Paris tráng lệ. Trải nghiệm cảm giác thú vị khi du thuyền trên dòng sông Seine thơ mộng. Tự do mua sắm tại các khu thương mại nổi tiếng như: Lafayet, Printemps.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline3.jpg", day: 1, description: 'Ăn tối. Về khách sạn nghỉ ngơi.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 2, description: 'Sáng: Ăn sáng và trả phòng khách sạn. Khởi hành đến Colmar - Thủ phủ vùng Alsace - là một trong những thành phố đẹp nhất nước Pháp được lấy bối cảnh cho bộ phim Người đẹp và quái vật “ Beauty and the Beast” nổi tiếng, và ngôi làng duy nhất không bị chiến tranh tàn phá vì quá đẹp.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 2, description: 'Chiều: Ăn trưa, tham quan một vòng thành phố cổ - Điểm ấn tượng nhất là xen lẫn giữa các kiến trúc hiện đại với nhiều mảng tường đầy sắc màu là những căn nhà gỗ mái ngói nâu đỏ cổ kính vẫn được bảo toàn nguyên vẹn sau hàng trăm năm. Rất duyên dáng những ô cửa sổ vuông vức, đều tăm tắp. Quảng trường Place de L’Ancienne Douane với đài phun nước do chính Bartholdi thiết kế, Krutenau được gọi là "tiểu Venice" do khu vực nhà này nằm trên bờ kênh Lauch, nơi tụ tập nhiều thuyền nhỏ để chở du khách đi thưởng ngoạn cảnh đẹp.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline2.jpg", day: 2, description: 'Ăn tối. Về khách sạn nghỉ ngơi.',from: '6:00 AM', to: '9:00 AM', tour_id: 1),
  ].obs;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getScheduleList(1, _listRequest);

    // locationMap.value = groupBy(_testLocations, (Location item) => item.day);
    locationMap.value = groupBy(response.locations, (Location item) => item.day);
    update();

    final dayDifference = dayDifferenceFromNow(DateTime.parse(response.startDate));
    pageController.animateToPage(dayDifference, duration: _pageTurnDuration, curve: _pageTurnCurve);
  }

  void next(){
    pageController.nextPage(duration: _pageTurnDuration, curve: _pageTurnCurve);
  }

  void back(){
    pageController.previousPage(duration: _pageTurnDuration, curve: _pageTurnCurve);
  }
}