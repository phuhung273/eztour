import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/discovery/discovery_list_request.dart';
import 'package:eztour_traveller/schema/discovery/discovery_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'discovery_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/discoveries")
abstract class DiscoveryService {
  factory DiscoveryService(Dio dio, {String baseUrl}) = _DiscoveryService;

  @GET("/")
  Future<DiscoveryListResponse> getDiscoveries(@Body() DiscoveryListRequest request);
}