import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../Model/plan.dart';
import '../../../../../Utils/Routes/app_pages.dart';
import '../list_header.dart';
import 'featured_plan_item.dart';

class FeaturedPlanWidget extends GetWidget<TrainerHomeScreenController> {
  const FeaturedPlanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListHeader(
          headerTitle: 'our_plans'.tr,
          seeAllFunction: () => Get.toNamed(AppRoutes.featuredPlamScreen,
              arguments: controller.trendingPlans),
        ),
        _buildFeaturedPlanItemWidget(
            controller: PageController(),
            plans: controller.featuredPlans
                .getRange(
                    0,
                    controller.featuredPlans.length > 3
                        ? 3
                        : controller.featuredPlans.length)
                .toList())
      ],
    );
  }

  // Function _pushFeaturedPlanScreen({required List<Plan> plans}) {
  //   return () {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => FeaturedPlanScreen(plans: plans),
  //     //   ),
  //     // );
  //   };
  // }

  Widget _buildFeaturedPlanItemWidget(
      {required PageController controller, required List<Plan> plans}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height / 2,
          child: PageView.builder(
            controller: controller,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.planOverview,
                    arguments: plans[index].id),
                child: FeaturedPlanItem(
                  planImageUrl: plans[index].image!,
                  planName: plans[index].name!,
                  totalWeeks: plans[index].totalWeeks!,
                  workoutFrequency: plans[index].workoutFrequency!,
                  trainerName: plans[index].trainer!.name!,
                  trainerProfileImageUrl: plans[index].trainer!.profilePic!,
                  // trainingType: plans[index].trainingType!,
                ),
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: plans.length,
          effect: ExpandingDotsEffect(
            spacing: 8,
            radius: 16,
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Get.theme.colorScheme.secondary,
            dotColor: Get.theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
