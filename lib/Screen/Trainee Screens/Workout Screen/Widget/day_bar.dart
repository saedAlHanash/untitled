import 'dart:io';

import 'package:fitness_storm/Screen/Trainee%20Screens/Workout%20Screen/workout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'day_bar_widget.dart';

class DayBar extends GetWidget<WorkoutScreenController> {
  const DayBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: Get.width,
          height: Platform.isAndroid ? Get.height / 9 : Get.height / 9,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.workouts.length,
            // padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () async {
                    controller.selectedIndex = index;
                    await Scrollable.ensureVisible(
                        controller.keys[index].currentContext!,
                        duration: const Duration(seconds: 1));
                  },
                  child: DayBarWidget(index));
            },
          ),
        ),
      ),
    );
  }
}
