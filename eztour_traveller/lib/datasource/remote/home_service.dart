import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/home/home_index_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/home")
abstract class HomeService {
  factory HomeService(Dio dio, {String baseUrl}) = _HomeService;

  @POST("/")
  Future<HomeIndexResponse> getHomeInfo(@Body() HomeIndexRequest request);
}