import 'package:eztour_traveller/datasource/remote/discovery_service.dart';
import 'package:eztour_traveller/schema/discovery/discovery.dart';
import 'package:eztour_traveller/schema/discovery/discovery_list_request.dart';
import 'package:get/get.dart';

class DiscoveryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryScreenController());
  }
}


const urlPrefix =
    'https://flutter.dev/docs/cookbook/img-files/effects/parallax';
final locations = [
  Discovery(
    id: 'abc',
    title: 'Mount Rushmore',
    place: 'U.S.A',
    image: '$urlPrefix/01-mount-rushmore.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Gardens By The Bay',
    place: 'Singapore',
    image: '$urlPrefix/02-singapore.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Machu Picchu',
    place: 'Peru',
    image: '$urlPrefix/03-machu-picchu.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Vitznau',
    place: 'Switzerland',
    image: '$urlPrefix/04-vitznau.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Bali',
    place: 'Indonesia',
    image: '$urlPrefix/05-bali.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Mexico City',
    place: 'Mexico',
    image: '$urlPrefix/06-mexico-city.jpg',
  ),
  Discovery(
    id: 'abc',
    title: 'Cairo',
    place: 'Egypt',
    image: '$urlPrefix/07-cairo.jpg',
  ),
];

class DiscoveryScreenController extends GetxController {

  final DiscoveryService _service = Get.find();

  final DiscoveryListRequest _request = Get.find();

  final discoveries = List<Discovery>.empty().obs;

  @override
  Future onInit() async {
    super.onInit();

    final response = await _service.getDiscoveries(_request);

    discoveries.assignAll(response.discoveries);
  }

  Discovery findByTag(String tag){
    return discoveries.firstWhere((element) => element.title == tag);
  }
}