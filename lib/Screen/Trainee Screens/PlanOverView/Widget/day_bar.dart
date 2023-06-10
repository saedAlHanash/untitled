import 'dart:io';

import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'day_bar_widget.dart';

class DayBar extends GetWidget<PlanOverviewController> {
  const DayBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Get.height / 30),
      width: Get.width,
      height: Platform.isAndroid ? Get.height / 8 : Get.height / 9,
      color: Get.theme.primaryColor,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.planWorkouts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () async {
                  await Scrollable.ensureVisible(
                      controller.keys[index].currentContext!,
                      duration: const Duration(seconds: 1));
                },
                child: DayBarWidget(index));
          }),
    );
  }
}
