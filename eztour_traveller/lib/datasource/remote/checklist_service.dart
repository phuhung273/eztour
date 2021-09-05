import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/checklist/checklist_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'checklist_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/todos")
abstract class ChecklistService {
  factory ChecklistService(Dio dio, {String baseUrl}) = _ChecklistService;

  @GET("/")
  Future<ChecklistResponse> getChecklist(@Body() ChecklistRequest request);
}