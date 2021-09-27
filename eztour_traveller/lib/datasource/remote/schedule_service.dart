import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/locations")
abstract class ScheduleService {
  factory ScheduleService(Dio dio, {String baseUrl}) = _ScheduleService;

  @GET('/')
  Future<ScheduleListResponse> getScheduleList(
    @Body() ScheduleListRequest request,
  );
}