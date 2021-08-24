import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'schedule_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/locations")
abstract class ScheduleService {
  factory ScheduleService(Dio dio, {String baseUrl}) = _ScheduleService;

  @GET('/')
  Future<ScheduleListResponse> getScheduleList(@Body() ScheduleListRequest request);
}