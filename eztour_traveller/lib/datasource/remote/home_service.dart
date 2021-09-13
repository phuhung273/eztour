import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/home/home_index_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/home")
abstract class HomeService {
  factory HomeService(Dio dio, {String baseUrl}) = _HomeService;

  @POST("/{tourId}")
  Future<HomeIndexResponse> getHomeInfo(
    @Path() int tourId,
    @Body() HomeIndexRequest request
  );
}