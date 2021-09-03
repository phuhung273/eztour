
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eztour_traveller/chat/chat_api.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
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

}

void _configureApiClient(){
  final dio = Dio(BaseOptions(contentType: "application/json"));

  dio.interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {

        final LocalStorage localStorage = Get.find();

        final accessToken = localStorage.getAccessToken() ?? '';
        // Do something before request is sent
        options.headers["Authorization"] = "Bearer $accessToken";
        return handler.next(options);
      }
    ),
  ]);

  Get.put(dio);
}