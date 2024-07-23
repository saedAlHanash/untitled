 

import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/TrendingPlanWidget/trending_plan_item.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/models/plan_model.dart';
import '../list_header.dart';

class TrendingPlanWidget extends GetView<TrainerHomeScreenController> {
  const TrendingPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
   //log(controller.trendingPlans.toString());
    return Column(
      children: [
        _buildTrendingPlanHeader(plans: controller.trendingPlans),
        _buildTrendsPlanList(
            plans: controller.trendingPlans
                .getRange(
                    0,
                    controller.trendingPlans.length > 3
                        ? 3
                        : controller.trendingPlans.length)
                .toList())
      ],
    );
  }

  Widget _buildTrendingPlanHeader({required List<Plan> plans}) {
    return ListHeader(
        headerTitle: 'trending_plan'.tr,
        seeAllFunction: () => Get.toNamed(AppRoutes.trendingPlanScreen,
            arguments: controller.trendingPlans));
  }

  Widget _buildTrendsPlanList({required List<Plan> plans}) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      height: MediaQuery.of(Get.context!).size.height / 4,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        itemBuilder: (context1, index) {
          return GestureDetector(
            onTap: () =>
                Get.toNamed(AppRoutes.trainerPlans, arguments: plans[index].id),
            child: TrendingPlanItem(
              planImageUrl: plans[index].image,
              planName: plans[index].name,
              trainerName: plans[index].trainer.name,
            ),
          );
        },
      ),
    );
  }
}
