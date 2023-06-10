import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../otp_controller.dart';

class CustomPinput extends GetWidget<OTPController> {
  CustomPinput({Key? key}) : super(key: key);

  final defaultPinTheme = PinTheme(
    width: Get.width / 9.375,
    height: Get.height / 14.7,
    margin: EdgeInsets.all(Get.width / 50),
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        // border: Border.all(color: Get.theme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF777988).withOpacity(0.39)),
  );

  final submittedPinTheme = PinTheme(
    width: Get.width / 9.375,
    height: Get.height / 14.7,
    margin: EdgeInsets.all(Get.width / 50),
    textStyle: TextStyle(
        fontSize: 20,
        color: Get.theme.scaffoldBackgroundColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
      // color: Get.theme.primaryColor,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.center,
      length: 5,
      controller: controller.otpController,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      defaultPinTheme: defaultPinTheme,
      // submittedPinTheme: submittedPinTheme,
      errorPinTheme: submittedPinTheme,
    );
  }
}
