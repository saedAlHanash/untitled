import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Constants/custome_app_theme.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/subscribed_plan.dart';
import 'continue_training_item.dart';

class ContinueTrainingWidget extends GetView<HomeScreenController> {
  const ContinueTrainingWidget({Key? key}) : super(key: key);

  Widget _buildContinueTrainingPlanHeader(context,
      {required List<SubscribedPlan> plans}) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.025,
          right: MediaQuery.of(context).size.width * 0.02,
          top: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'continue_training'.tr,
            style: CustomeAppTheme.textStyleTitleInHomePage,
          ),
        ],
      ),
    );
  }

  Widget _buildContinueTrainingPlanList(context,
      {required List<SubscribedPlan> plans}) {
    return plans.isNotEmpty
        ? SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.6,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: plans.length,
              itemBuilder: (context1, index) {
                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.planOverview,
                      arguments: plans[index].id),
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
          )
        : SizedBox.fromSize();
  }

  int _getNextDay(List<Days> days) {
    for (var element in days) {
      if (!element.completed!) {
        return element.dayNumber!;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildContinueTrainingPlanHeader(context,
            plans: controller.continueTrainingPlans),
        _buildContinueTrainingPlanList(
          context,
          plans: controller.continueTrainingPlans.isNotEmpty
              ? controller.continueTrainingPlans
                  .getRange(
                      0,
                      controller.continueTrainingPlans.length > 3
                          ? 3
                          : controller.continueTrainingPlans.length)
                  .toList()
              : [],
        )
      ],
    );
  }
}
