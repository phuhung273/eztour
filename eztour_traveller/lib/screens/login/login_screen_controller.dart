import 'dart:convert';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/remote/auth_service.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/auth/basic_auth_credential.dart';
import 'package:eztour_traveller/schema/auth/basic_login_request.dart';
import 'package:eztour_traveller/schema/auth/credential_login_request.dart';
import 'package:eztour_traveller/schema/auth/login_response.dart';
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

  Future qrLogin(String qrResult) async {
    try{
      final request = CredentialLoginRequest(
          credential: qrResult,
          device: _localStorage.getDeviceName() ?? 'test'
      );

      final response = await _service.credentialLogin(request);

      _processLoginResponse(response);

    } catch(e){
      barcodeResult.value = 'Unexpected error';
      debugPrint(e.toString());
    }
  }

  Future login() async {

    try{
      final request = BasicLoginRequest(
          username: _credential.username,
          password: _credential.password,
          device: _localStorage.getDeviceName() ?? 'test'
      );

      final response = await _service.basicLogin(request);

      _processLoginResponse(response);

    } catch(e){
      barcodeResult.value = 'Unexpected error';
      debugPrint(e.toString());
    }

  }

  void _processLoginResponse(LoginResponse response){
    if(response.success()){
      _localStorage.saveUserID(response.userID!);
      _localStorage.saveUsername(response.username!);
      _localStorage.saveCredential(response.credential!);
      _localStorage.saveAccessToken(response.accessToken!);

      Get.offAndToNamed(ROUTE_MAIN);
    } else {
      barcodeResult.value = response.message ?? 'Unexpected error';
    }
  }
}