import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_request.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'announcement_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/announcements")
abstract class AnnouncementService {
  factory AnnouncementService(Dio dio, {String baseUrl}) = _AnnouncementService;

  @GET('/')
  Future<AnnouncementListResponse> getAnnouncementList(@Body() AnnouncementListRequest request);
}