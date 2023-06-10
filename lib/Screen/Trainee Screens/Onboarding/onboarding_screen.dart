import 'dart:ui';

import 'package:fitness_storm/Screen/Trainee%20Screens/Onboarding/onboarding_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/Images/background1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: _buildPageView(context),
          ),
        ),
      ),
    );
  }

  Container _buildPageView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
      child: Stack(
        children: [
          Obx(
            () => PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.key,
              onPageChanged: controller.onPageChanged,
              children: controller.pages,
            ),
          ),
          _buildNextButton(),
          _buildSkipButton(),
          _buildPageIndicator()
        ],
      ),
    );
  }

  Positioned _buildPageIndicator() {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Row(
        children: controller.indicators,
      ),
    );
  }

  Positioned _buildSkipButton() {
    return Positioned(
      top: MediaQuery.of(Get.context!).size.height / 20,
      right: 10,
      child: TextButton(
        onPressed: () async {
          await controller.key.animateToPage(
            controller.pages.length,
            duration: Duration(milliseconds: 300 * controller.pages.length),
            curve: Curves.easeInOut,
          );
          controller.index = 0;
          for (int i = 0; i < controller.pages.length; i++) {
            controller.changeIndicatorLocation(
                controller.index, controller.index + 1);
            controller.index++;
            Duration(milliseconds: 300 * controller.pages.length);
          }

          // controller.onSkipPages();
        },
        child: Text('skip'.tr,
            style: TextStyle(color: Colors.grey[200], fontSize: 20)),
      ),
    );
  }

  Positioned _buildNextButton() {
    return Positioned(
      bottom: 50,
      left: MediaQuery.of(Get.context!).size.width / 3,
      right: MediaQuery.of(Get.context!).size.width / 3,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            height: MediaQuery.of(Get.context!).size.height / 15),
        child: ElevatedButton(
          onPressed: () {
            if (controller.isFinish) {
              Get.offNamed(AppRoutes.authScreen);
            }
            controller.key.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            controller.changeIndicatorLocation(
                controller.index, controller.index + 1);
            // controller.index++;
          },
          child: Text(controller.isFinish ? "finish".tr : 'NEXT'.tr,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
