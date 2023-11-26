import 'package:fitness_storm/Screen/Auth/Signup/signup_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_text_field.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

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
                top: Get.height / 20,
              ),
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height / 40),
                      Center(
                        child: Image.asset('asset/Images/white_logo.png',
                            width: Get.width / 4),
                      ),
                      SizedBox(height: Get.height / 40),
                      Center(
                        child: Text('sign_up'.tr,
                            style: const TextStyle(color: Colors.white, fontSize: 26)),
                      ),
                      SizedBox(height: Get.height / 50),
                      Container(
                        padding: EdgeInsets.only(bottom: Get.height / 120),
                        child: Text(
                          'name'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      CustomTextField(
                        "",
                        hint: "enter_your_name".tr,
                        style: const TextStyle(color: Colors.white),
                        textController: controller.nameEditingController,
                        keyboardType: TextInputType.name,
                        controller: AppTextFieldController(false),
                      ),
                      SizedBox(height: Get.height / 50),
                      Container(
                        padding: EdgeInsets.only(bottom: Get.height / 120),
                        child: Text(
                          'email'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      CustomTextField(
                        "",
                        style: const TextStyle(color: Colors.white),
                        hint: "enter_email_address".tr,
                        textController: controller.emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        controller: AppTextFieldController(false),
                      ),
                      SizedBox(height: Get.height / 50),
                      Container(
                        padding: EdgeInsets.only(bottom: Get.height / 120),
                        child: Text(
                          'password'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      CustomTextField(
                        "",
                        hint: "enter_password".tr,
                        style: const TextStyle(color: Colors.white),
                        textController: controller.passwordEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        controller: AppTextFieldController(controller.isScure),
                        suffixIcon: controller.isScure
                            ? IconButton(
                                icon: Icon(
                                  Icons.visibility_off,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isScure = false;
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  controller.isScure = true;
                                },
                              ),
                      ),

                      SizedBox(height: Get.height / 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'by_singing_up_you_are_agreeing_to_our'.tr,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    _launchUrl(
                                      'https://www.fitnessstorm.org/TermsAndConditions',
                                    );
                                  },
                                  child: Text(
                                    'terms_of_conditions'.tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                              Text('and'.tr, style: const TextStyle(color: Colors.grey)),
                              TextButton(
                                  onPressed: () => _launchUrl(
                                        'https://www.fitnessstorm.org/PrivacyPolicy',
                                      ),
                                  child: Text(
                                    'privacy-policy'.tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: Get.height / 100),
                      Center(
                        child: CustomButton(
                          radius: 30,
                          width: Get.width / 2.6,
                          height: Get.height / 15,
                          margin: 0,
                          padding: 0,
                          onTapFunction: () => controller.signup(),
                          text: 'sign_up'.tr,
                          textColor: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
                      //TODO: google button
                      if (DateTime.now().isAfter(DateTime(2023, 10, 23)))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () => controller.signInGoogle(),
                              child: Container(
                                  width: Get.width / 8.5,
                                  height: Get.width / 8.5,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white),
                                  child: SvgPicture.asset('asset/Images/googleSVG.svg')),
                            )
                          ],
                        ),
                      SizedBox(height: Get.height / 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'already_a_member_?'.tr,
                            style:
                                const TextStyle(color: Color(0xFFC5C5C5), fontSize: 16),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.bottomCenter),
                            onPressed: () => Get.toNamed(AppRoutes.signIn),
                            child: Text(
                              'login'.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
