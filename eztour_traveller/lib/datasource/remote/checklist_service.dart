import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/checklist/checklist_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'checklist_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/todos")
abstract class ChecklistService {
  factory ChecklistService(Dio dio, {String baseUrl}) = _ChecklistService;

  @GET("/")
  Future<ChecklistResponse> getChecklist(@Body() ChecklistRequest request);
}