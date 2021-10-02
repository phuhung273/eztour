
import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/datasource/remote/auth_service.dart';
import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/auth/credential_login_request.dart';
import 'package:eztour_traveller/screens/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SplashScreenBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }

}

class SplashScreenController extends GetxController{

  final AuthService _service = Get.find();

  final BehaviorSubject<String?> _selectNotificationSubject = Get.find();

  final Socket socket = Get.find();

  final LocalStorage _localStorage = Get.find();

  @override
  void onInit() {
    super.onInit();

    _configureDevice();

    initNotification();

    _listenNotifications();

    Future.microtask(() => _loadData());
  }



  void _onClickedNotification(String? payload) {
    Get.off(() => MainScreen(payload: payload));
  }

  void _listenNotifications() => _selectNotificationSubject.stream.listen(_onClickedNotification);

  Future<Timer> _loadData() async {
    return Timer(const Duration(seconds: 1), _onDoneLoading);
  }

  Future _onDoneLoading() async {
    if(_isEnoughInfo()){

      try{
        final request = CredentialLoginRequest(
            credential: _localStorage.getCredential()!,
            device: _localStorage.getDeviceName() ?? 'test'
        );

        final response = await _service.credentialLogin(request);

        if(response.success()){
          _localStorage.saveAccessToken(response.accessToken!);
          _localStorage.saveCredential(response.credential!);
          Get.offAndToNamed(ROUTE_MAIN);
        } else {
          _localStorage.removeCredentials();
          Get.offAndToNamed(ROUTE_LOGIN);
        }
      } catch (e){
        _localStorage.removeCredentials();
        Get.offAndToNamed(ROUTE_LOGIN);
      }

    } else {
      Get.offAndToNamed(ROUTE_LOGIN);
    }
  }

  Future _configureDevice() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(_localStorage.getDeviceName() == null){

      if(Platform.isIOS){
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _localStorage.saveDeviceName(iosInfo.utsname.machine!);
      } else {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _localStorage.saveDeviceName(androidInfo.model!);
      }
    }

  }

  bool _isEnoughInfo(){
    return _localStorage.getCredential() != null;
  }
}