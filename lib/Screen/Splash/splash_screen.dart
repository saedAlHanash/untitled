import 'package:fitness_storm/Screen/Splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';

bool canRecording = false;

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.0.sh,
        width: 1.0.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Get.theme.primaryColor,
              Get.theme.colorScheme.secondary,
            ],
          ),
        ),
        child: GestureDetector(
          onDoubleTap: () {
            canRecording = true;
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0).r,
              child: Lottie.asset(
                Assets.lottiesFitnessstormLogoAnimationWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
