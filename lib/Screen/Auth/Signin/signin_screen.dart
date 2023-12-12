import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Auth/Signin/signin_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_text_field.dart';
import '../../../Widgets/language_board_widget.dart';
import '../../../common/assets.gen.dart';
import '../../../common/bottom_sheets.dart';
import '../../Trainee Screens/Trainee_Profile/Widget/profile_card.dart';

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({Key? key}) : super(key: key);

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
                    SizedBox(height: Get.height / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            BottomSheets.languageBottomSheet(
                              const LanguageBoardWidget(fromAuthPage: true),
                            );
                          },
                          child: ImageMultiType(
                            url: Assets.images.language,
                            width: Get.width / 15,
                          ),
                        ),
                        Image.asset(
                          'asset/Images/white_logo.png',
                          width: Get.width / 4,
                        ),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: Get.height / 20),
                    Center(
                      child: Text('sign_in'.tr,
                          style: const TextStyle(color: Colors.white, fontSize: 26)),
                    ),

                    SizedBox(height: Get.height / 50),
                    Text(
                      controller.message.value,
                      style: const TextStyle(color: Colors.red),
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
                      hint: "enter_email_address".tr,
                      style: const TextStyle(color: Colors.white),
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      controller: AppTextFieldController(false),
                    ),
                    SizedBox(height: Get.height / 30),
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
                      textController: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      controller: AppTextFieldController(controller.isScure.value),
                      suffixIcon: controller.isScure.value
                          ? IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Get.theme.colorScheme.secondary,
                        ),
                        onPressed: () {
                          controller.isScure.value = false;
                        },
                      )
                          : IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Get.theme.colorScheme.secondary,
                        ),
                        onPressed: () {
                          controller.isScure.value = true;
                        },
                      ),
                    ),

                    SizedBox(height: Get.height / 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: controller.isTrainer,
                              onChanged: (value) {
                                controller.isTrainer = value;
                              },
                              fillColor: MaterialStateProperty.all(Colors.white),
                              checkColor: Get.theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                            Text(
                              'sign_in_Trainer'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
                            child: FittedBox(
                              child: Text(
                                'forgot_password_?'.tr,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // CheckboxListTile(
                    //     title: const Text('sdsdsdsdsd',
                    //         style: TextStyle(color: Colors.white)),
                    //     value: controller.isTrainer,
                    //     onChanged: (value) {
                    //       controller.isTrainer = value;
                    //     }),
                    SizedBox(height: Get.height / 15),
                    Center(
                      child: CustomButton(
                        radius: 30,
                        width: Get.width / 2.6,
                        height: Get.height / 15,
                        margin: 0,
                        padding: 0,
                        onTapFunction: () => controller.login(),
                        text: 'sign_in'.tr,
                        textColor: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    // CustomButton(
                    //   radius: 30,
                    //   width: Get.width / 2.6,
                    //   height: Get.height / 15,
                    //   margin: 0,
                    //   padding: 0,
                    //   onTapFunction: () => Get.toNamed(AppRoutes.video),
                    //   text: 'Go Live',
                    //   textColor: Colors.white,
                    //   fontSize: 16,
                    // ),
                    SizedBox(height: Get.height / 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // MaterialButton(
                        //   onPressed: () => controller.sign_out(),
                        //   child: Container(
                        //       width: Get.width / 8.5,
                        //       height: Get.width / 8.5,
                        //       padding: const EdgeInsets.all(7),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           color: Colors.white),
                        //       child: SvgPicture.asset(
                        //           'asset/Images/facebookSVG1.svg')),
                        // ),
                        // Image.asset('asset/Images/facebookSVG.svg'),
                        // SizedBox(width: Get.width / 6),
                        //TODO: google button
                        if (DateTime.now().isAfter(DateTime(2023, 12, 15)))
                          GestureDetector(
                            onTap: () => controller.signInGoogle(),
                            child: Container(
                                width: Get.width / 8.5,
                                height: Get.width / 8.5,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: SvgPicture.asset('asset/Images/googleSVG.svg')),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'not_member_?'.tr,
                          style: const TextStyle(color: Color(0xFFC5C5C5), fontSize: 16),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.bottomCenter),
                          onPressed: () => Get.toNamed(AppRoutes.signUp),
                          child: Text(
                            'sign_up'.tr,
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
        ),
      ],
    );
  }
}
