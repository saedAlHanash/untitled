import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../Model/plan.dart';
import '../../../../../Utils/Routes/app_pages.dart';
import '../list_header.dart';
import 'featured_plan_item.dart';

class FeaturedPlanWidget extends GetWidget<HomeScreenController> {
  const FeaturedPlanWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListHeader(
          headerTitle: 'our_plans'.tr,
          seeAllFunction: () => Get.toNamed(AppRoutes.featuredPlamScreen,
              arguments: controller.featuredPlans),
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
}
