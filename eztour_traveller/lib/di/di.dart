
import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/checklist_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/local/my_announcement_db.dart';
import 'package:eztour_traveller/datasource/local/my_checklist_db.dart';
import 'package:eztour_traveller/datasource/remote/announcement_service.dart';
import 'package:eztour_traveller/datasource/remote/auth_service.dart';
import 'package:eztour_traveller/datasource/remote/checklist_service.dart';
import 'package:eztour_traveller/datasource/remote/discovery_service.dart';
import 'package:eztour_traveller/datasource/remote/home_service.dart';
import 'package:eztour_traveller/datasource/remote/schedule_service.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_request.dart';
import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/discovery/discovery_list_request.dart';
import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

Future configureDependencies() async {
  await GetStorage.init();

  Get.put(BehaviorSubject<String?>());

  Get.put(LocalStorage());

  _configureApiClient();

  final Socket socket = io(CHAT_HOST_URL,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build()
  );
  Get.put(socket);

  Get.put(ChatUserDB.instance);

  Get.put(MyAnnouncementDB.instance);

  Get.put(ChecklistDB.instance);

  Get.put(MyChecklistDB.instance);

  Get.put(AuthService(Get.find()));

  Get.put(DiscoveryListRequest());
  Get.put(ScheduleListRequest());
  Get.put(AnnouncementListRequest());
  Get.put(ChecklistRequest());
  Get.put(ScheduleListRequest());
  Get.put(HomeIndexRequest());

  Get.put(HomeService(Get.find()));
  Get.put(ScheduleService(Get.find()));
  Get.put(DiscoveryService(Get.find()));
  Get.put(ChecklistService(Get.find()));
  Get.put(AnnouncementService(Get.find()));
  Get.put(AuthService(Get.find()));

}

void _configureApiClient(){
  final dio = Dio(BaseOptions(
    contentType: "application/json",
    connectTimeout: 5000,
  ));

  dio.interceptors.addAll([
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {

        final LocalStorage localStorage = Get.find();

        final accessToken = localStorage.getAccessToken() ?? '';
        // Do something before request is sent
        options.headers["Authorization"] = "Bearer $accessToken";
        options.headers["Accept"] = "application/json";
        return handler.next(options);
      }
    ),
  ]);

  Get.put(dio);
}