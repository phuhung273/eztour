
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:eztour_traveller/schema/auth/basic_auth_credential.dart';
import 'package:eztour_traveller/screens/Main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eztour_traveller/Screens/Login/components/background.dart';
import 'package:eztour_traveller/components/rounded_button.dart';
import 'package:eztour_traveller/components/rounded_input_field.dart';
import 'package:eztour_traveller/components/rounded_password_field.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _id = '';
  String _password = '';

  String _result = "Please scan the QR code or Barcode";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          InkWell(
            onTap: _scanQR,
            child: Icon(
              Icons.qr_code_scanner,
              size: size.height * 0.2,
            ),
          ),
          Text(_result),
          SizedBox(height: size.height * 0.1),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {
              setState(() {
                _id = value;
              });
            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          RoundedButton(
            text: "LOGIN",
            press:() {
              _login(BasicAuthCredential(username: _id, password: _password));
            }
          ),
        ],
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

      final credential = BasicAuthCredential.fromJson(jsonDecode(qrResult.rawContent));
      _login(credential);

    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          _result = "Camera permission was denied";
        });
      } else {
        setState(() {
          _result = "Unknown Platform Error $ex";
        });
      }
    }
  }

  Future _login(BasicAuthCredential credential) async {
    if(credential.username == "admin@gmail.com" && credential.password == "admin123") {
      Get.off(const MainScreen());
    }

    setState(() {
      _result = 'Invalid credential, try again';
    });
  }
}
