import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../helper/cache_helper.dart';
import 'Widget/custom_pinput.dart';
import 'otp_controller.dart';

class OTPScreen extends GetView<OTPController> {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'asset/Images/auth1.png',
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Container(
          height: Get.height,
          color: Colors.black.withOpacity(0.6),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height / 10),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 20),
                    child:
                        Image.asset('asset/Images/white_logo.png', width: Get.width / 4),
                  ),
                  SizedBox(height: Get.height / 20),
                  Text(
                    ('email_verification').tr,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  SizedBox(height: Get.height / 30),
                  Text(
                    '${'sent_6_digit'.tr}:',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 25,
                      ),
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          CacheHelper.saveData(key: 'sticky_otp', value: false);
                          Get.offAllNamed(AppRoutes.signIn);
                        },
                        child: Text(
                           ('change_email').tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                  CustomPinput(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 25,
                    ),
                    alignment: Alignment.topRight,
                    child:true?SizedBox(): TextButton(
                      onPressed: () {
                        controller.resendOTP();
                      },
                      child: Text(
                        'resend_code'.tr,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                  CustomButton(
                    radius: 30,
                    width: Get.width / 2.6,
                    height: Get.height / 20,
                    margin: 10,
                    padding: 0,
                    fontSize: 13,
                    onTapFunction: () => controller.isReset
                        ? controller.submitForgetPassword()
                        : controller.submit(),
                    text: 'Verify'.tr,
                    textColor: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          CacheHelper.saveData(key: 'sticky_otp', value: false);
                          Get.toNamed(AppRoutes.signIn);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.bottomCenter),
                        child: Text(
                          'sign_in'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
