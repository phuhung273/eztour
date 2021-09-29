
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'background.dart';
import 'login_screen_controller.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';

class LoginScreen extends StatelessWidget {

  final LoginScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Background(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: _scanQR,
                child: Icon(
                  Icons.qr_code_scanner,
                  size: context.height * 0.2,
                ),
              ),
              Text(_controller.barcodeResult.value, style: theme.textTheme.subtitle1),
              const SizedBox(height: defaultSpacing * 5),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) => _controller.id = value,
              ),
              RoundedPasswordField(
                onChanged: (value) => _controller.password = value,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultSpacing),
                width: context.width * 0.8,
                child: ElevatedButton(
                  onPressed: _controller.login,
                  style: ElevatedButton.styleFrom(
                    shape: pillShape,
                    padding: const EdgeInsets.all(defaultPadding * 2),
                  ),
                  child: Text(
                    'LOGIN',
                    style: theme.textTheme.button!.copyWith(
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
