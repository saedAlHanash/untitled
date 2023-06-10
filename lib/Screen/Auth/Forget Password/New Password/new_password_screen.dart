import 'package:fitness_storm/Screen/Auth/Forget%20Password/New%20Password/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_text_field.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  const NewPasswordScreen({Key? key}) : super(key: key);

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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Get.width / 20,
                  right: Get.width / 20,
                  top: Get.height / 70,
                ),
                child: Obx(
                  () => Column(
                    children: [
                      SizedBox(height: Get.height / 20),
                      Image.asset('asset/Images/white_logo.png',
                          width: Get.width / 4),
                      SizedBox(height: Get.height / 20),
                      Text('reset_password'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 26)),
                      SizedBox(height: Get.height / 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'set_new_pass'.tr + ':',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            controller.email,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 10),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: Get.height / 120),
                        child: Text(
                          'password'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      CustomTextField(
                        "",
                        hint: "enter_new_password".tr,
                        style: const TextStyle(color: Colors.white),
                        textController: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        controller:
                            AppTextFieldController(controller.isPasswordScure),
                        suffixIcon: controller.isPasswordScure
                            ? IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isPasswordScure = false;
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.visibility_off,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isPasswordScure = true;
                                },
                              ),
                      ),
                      SizedBox(height: Get.height / 50),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: Get.height / 120),
                        child: Text(
                          're_enter_pass'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      CustomTextField(
                        "",
                        style: const TextStyle(color: Colors.white),
                        hint: "re_enter_pass".tr,
                        textController: controller.confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        controller: AppTextFieldController(
                            controller.isConfirmPasswordScure),
                        suffixIcon: controller.isConfirmPasswordScure
                            ? IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isConfirmPasswordScure = false;
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.visibility_off,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isConfirmPasswordScure = true;
                                },
                              ),
                      ),
                      SizedBox(height: Get.height / 10),
                      CustomButton(
                        radius: 30,
                        width: Get.width / 2.6,
                        height: Get.height / 20,
                        margin: 0,
                        padding: 0,
                        onTapFunction: () => controller.confirm(),
                        text: 'reset'.tr,
                        textColor: Colors.white,
                        fontSize: 16,
                      ),
                      SizedBox(height: Get.height / 30),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
