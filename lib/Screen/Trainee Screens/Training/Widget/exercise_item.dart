import 'dart:developer';

import 'package:fitness_storm/Screen/Trainee%20Screens/Training/training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseItem extends GetWidget<TrainingController> {
  final int sets;
  final int reps;

  const ExerciseItem({
    Key? key,
    required this.sets,
    required this.reps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //log('sssssssssssssssssssaaaaaaaa');

   //log(sets.toString());
   //log(reps.toString());
    return Obx(
      () => CheckboxListTile(
        value: controller.currentChecks[sets],
        onChanged: (value) => controller.onChangeChecks(value, sets),
        checkboxShape:
            CircleBorder(side: BorderSide(color: Get.theme.primaryColor)),
        activeColor: Get.theme.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  sets.toString(),
                  style: TextStyle(
                      color: controller.currentChecks[sets]
                          ? Get.theme.primaryColor
                          : Colors.grey),
                ),
                Text(
                  'sets'.tr,
                  style: TextStyle(
                      color: controller.currentChecks[sets]
                          ? Colors.white
                          : Colors.grey),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  reps.toString(),
                  style: TextStyle(
                      color: controller.currentChecks[sets]
                          ? Get.theme.primaryColor
                          : Colors.grey),
                ),
                Text(
                  'reps'.tr,
                  style: TextStyle(
                      color: controller.currentChecks[sets]
                          ? Colors.white
                          : Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
