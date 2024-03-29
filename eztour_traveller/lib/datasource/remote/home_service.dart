import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/home/home_index_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/home")
abstract class HomeService {
  factory HomeService(Dio dio, {String baseUrl}) = _HomeService;

  @POST("/")
  Future<HomeIndexResponse> getHomeInfo(
    @Body() HomeIndexRequest request
  );
}