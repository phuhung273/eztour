
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:eztour_traveller/components/rounded_button.dart';
import 'package:eztour_traveller/components/rounded_input_field.dart';
import 'package:eztour_traveller/components/rounded_password_field.dart';
import 'package:eztour_traveller/screens/Login/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components/background.dart';

class LoginScreen extends StatelessWidget {

  final LoginScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Background(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: context.height * 0.03),
            InkWell(
              onTap: _scanQR,
              child: Icon(
                Icons.qr_code_scanner,
                size: context.height * 0.2,
              ),
            ),
            Text(_controller.barcodeResult.value),
            SizedBox(height: context.height * 0.1),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) => _controller.id = value,
            ),
            RoundedPasswordField(
              onChanged: (value) => _controller.password = value,
            ),
            RoundedButton(
                text: "LOGIN",
                press: _controller.login
            ),
          ],
        ),
      ),
    );
  }

  Future _scanQR() async {
    try {
      final qrResult = await BarcodeScanner.scan(
          options: const ScanOptions(
            restrictFormat: [BarcodeFormat.qr],
          )
      );

      _controller.qrLogin(qrResult.rawContent);

    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        _controller.barcodeResult.value = "Camera permission was denied";
      } else {
        _controller.barcodeResult.value = "Unknown Platform Error $ex";
      }
    }
  }
}
