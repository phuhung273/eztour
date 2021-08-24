import 'package:eztour_traveller/schema/announcement/todo_list_request.dart';
import 'package:eztour_traveller/schema/announcement/todo_list_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'announcement_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/todos")
abstract class AnnouncementService {
  factory AnnouncementService(Dio dio, {String baseUrl}) = _AnnouncementService;

  @GET('/')
  Future<TodoListResponse> getTodoList(@Body() TodoListRequest request);
}