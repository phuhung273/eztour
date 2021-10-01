
import 'package:eztour_traveller/chat/chat_api.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/checklist_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/local/my_announcement_db.dart';
import 'package:eztour_traveller/datasource/local/my_checklist_db.dart';
import 'package:eztour_traveller/datasource/remote/auth_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

Future configureDependencies() async {
  await GetStorage.init();

  Get.put(BehaviorSubject<String?>());

  Get.put(LocalStorage());

  _configureApiClient();

  Get.put(socket);

  Get.put(ChatUserDB.instance);

  Get.put(MyAnnouncementDB.instance);

  Get.put(ChecklistDB.instance);

  Get.put(MyChecklistDB.instance);

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