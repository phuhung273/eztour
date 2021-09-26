import 'dart:convert';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/remote/auth_service.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/auth/basic_auth_credential.dart';
import 'package:eztour_traveller/schema/auth/login_request.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
  }
}

class LoginScreenController extends GetxController {

  final AuthService _service = Get.find();

  final LocalStorage _localStorage = Get.find();

  var _credential = BasicAuthCredential(username: '', password: '');

  var barcodeResult = "Scan your QR".obs;

  set id(String value){
    _credential.username = value;
  }

  set password(String value){
    _credential.password = value;
  }

  void qrLogin(String qrResult) {
    _credential = BasicAuthCredential.fromJson(jsonDecode(qrResult) as Map<String, dynamic>);
    login();
  }

  Future login() async {

    try{
      final request = LoginRequest(
          username: _credential.username,
          password: _credential.password,
          device: _localStorage.getDeviceName() ?? 'test'
      );

      final response = await _service.login(request);

      if(response.success()){
        _localStorage.saveUserID(response.userID!);
        _localStorage.saveUsername(response.username!);
        _localStorage.savePassword(_credential.password);
        _localStorage.saveAccessToken(response.accessToken!);

        Get.offAndToNamed(ROUTE_MAIN);
      } else {
        barcodeResult.value = response.message ?? 'Unexpected error';
      }

    } catch(e){
      barcodeResult.value = 'Unexpected error';
      debugPrint(e.toString());
    }

  }
}