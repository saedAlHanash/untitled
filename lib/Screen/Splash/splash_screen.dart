import 'package:fitness_storm/Screen/Splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool canRecording = false;

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ////log(controller.title);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Get.theme.primaryColor,
            Get.theme.colorScheme.secondary,
          ],
        )),
        child: GestureDetector(
          onDoubleTap: () {
            canRecording = true;
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Get.width / 7),
              child: Image.asset(
                "asset/Images/white_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
