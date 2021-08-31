
import 'package:get/get.dart';
import 'package:dio/dio.dart';

void configureDependencies(){
  Get.put(Dio(BaseOptions(contentType: "application/json")));

}