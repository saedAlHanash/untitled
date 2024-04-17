import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/subscribed_plan.dart';
import '../list_header.dart';
import 'continue_training_item.dart';

class ContinueTrainingWidget extends GetView<HomeScreenController> {
  const ContinueTrainingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildContinueTrainingPlanHeader(
            plans: controller.continueTrainingPlans),
        _buildContinueTrainingPlanList(
            plans: controller.continueTrainingPlans
                .getRange(
                    0,
                    controller.continueTrainingPlans.length > 3
                        ? 3
                        : controller.continueTrainingPlans.length)
                .toList())
      ],
    );
  }

  Widget _buildContinueTrainingPlanHeader(
      {required List<SubscribedPlan> plans}) {
    return ListHeader(
        headerTitle: 'continue_training'.tr,
        seeAllFunction: () => Get.toNamed(AppRoutes.continueTrainingPlanScreen,
            arguments: controller.continueTrainingPlans));
  }

  Widget _buildContinueTrainingPlanList({required List<SubscribedPlan> plans}) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      height: MediaQuery.of(Get.context!).size.height / 3,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        itemBuilder: (context1, index) {
          return GestureDetector(
            onTap: () =>
                Get.toNamed(AppRoutes.planOverview, arguments: plans[index].id),
            child: ContinueTrainingItem(
              planImageUrl: plans[index].image!,
              planName: plans[index].name!,
              planProgress: plans[index].userProgress!,
              nextDayNumber: _getNextDay(plans[index].days!),
              // trainerName: plans[index].trainer!.name!,
            ),
          );
        },
      ),
    );
  }

  int _getNextDay(List<Days> days) {
    for (var element in days) {
      if (!element.completed!) {
        return element.dayNumber!;
      }
    }
    return 1;
  }
}
