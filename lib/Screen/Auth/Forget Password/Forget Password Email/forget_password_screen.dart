import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_text_field.dart';
import 'forget_password_controller.dart';

class ForgetPasswordEmailScreen extends GetView<ForgetPasswordEmailController> {
  const ForgetPasswordEmailScreen({super.key});

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
              padding: EdgeInsets.only(
                  left: Get.width / 20,
                  right: Get.width / 20,
                  top: Get.height / 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height / 10),
                    Image.asset('asset/Images/white_logo.png',
                        width: Get.width / 4),
                    SizedBox(height: Get.height / 14),
                    Text('forget_password'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 26)),
                    SizedBox(height: Get.height / 14),
                    Text('pls_enter_email'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    SizedBox(height: Get.height / 14),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: Get.height / 120),
                      child: Text(
                        'email'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    CustomTextField(
                      "",
                      hint: "enter_email_address".tr,
                      style: const TextStyle(color: Colors.white),
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      controller: AppTextFieldController(false),
                    ),
                    SizedBox(height: Get.height / 30),
                    SizedBox(height: Get.height / 60),
                    SizedBox(height: Get.height / 15),
                    CustomButton(
                        radius: 30,
                        width: Get.width / 2.6,
                        height: Get.height / 20,
                        margin: 0,
                        padding: 0,
                        onTapFunction: () => controller.reset(),
                        text: 'reset'.tr,
                        textColor: Colors.white,
                        fontSize: 16),
                    SizedBox(height: Get.height / 40),
                    CustomButton(
                        radius: 30,
                        width: Get.width / 2.6,
                        height: Get.height / 20,
                        buttonColor: Colors.grey,
                        margin: 0,
                        padding: 0,
                        onTapFunction: () => Get.back(),
                        text: 'cancel'.tr,
                        textColor: Colors.white,
                        fontSize: 16),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
