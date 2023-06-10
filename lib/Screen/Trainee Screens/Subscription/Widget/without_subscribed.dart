import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithoutSubscribed extends StatelessWidget {
  const WithoutSubscribed({super.key, required this.isSubscirbe});

  final bool isSubscirbe;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: Get.width / 4.1,
        height: Get.height / 11.7,
        child: Image.asset("asset/Images/white_logo.png"),
      ),
      SizedBox(height: Get.height / 16.24),
      Text(
        isSubscirbe ? 'successfully_subscribed'.tr : 'why_to_subscribe?'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      SizedBox(height: Get.height / 40.6),
      Text(
        isSubscirbe
            ? 'enjoy_your_fitness_storm.'.tr
            : 'join_fitnessStorm_for_personalized'.tr,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ]);
  }
}
