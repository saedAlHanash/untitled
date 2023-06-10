import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class TrainerBio extends GetWidget<PlanOverviewController> {
  final String aboutTrainer;

  const TrainerBio(this.aboutTrainer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width / 1.2,
        padding: EdgeInsets.only(
            top: Get.height / 30,
            left: Get.width / 20,
            right: Get.width / 20,
            bottom: Get.height / 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Get.theme.primaryColor.withOpacity(0.05)),
        child: ReadMoreText(
          aboutTrainer + ". ",
          style: const TextStyle(color: Color(0xFF565C63)),
          trimMode: TrimMode.Line,
          trimLines: 2,
          lessStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
          moreStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
        ));
  }
}
