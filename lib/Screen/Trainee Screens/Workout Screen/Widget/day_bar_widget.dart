import 'package:fitness_storm/Screen/Trainee%20Screens/Workout%20Screen/workout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayBarWidget extends GetWidget<WorkoutScreenController> {
  final int index;

  const DayBarWidget(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width / 8,
        height: Get.height / 25,
        margin: EdgeInsets.only(
            top: Get.height / 70,
            bottom: Get.height / 70,
            left: Get.width / 20),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: controller.selectedIndex == index
                ? Get.theme.primaryColor
                : Colors.white,
            border: Border.all(color: Get.theme.primaryColor)),
        child: Column(
          children: [
            Text(
              'day'.tr,
              style: TextStyle(
                  color: controller.selectedIndex == index
                      ? Colors.white
                      : Get.theme.primaryColor,
                  fontSize: 14),
            ),
            Text(
              '${index + 1}',
              style: TextStyle(
                  color: controller.selectedIndex == index
                      ? Colors.white
                      : Get.theme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
