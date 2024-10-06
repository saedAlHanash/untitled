  import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import 'package:smooth_page_indicator/smooth_page_indicator.dart';

  import '../../../../../Utils/Routes/app_pages.dart';
  import '../../../../../core/models/plan_model.dart';
  import '../../../../../router/app_router.dart';
  import '../../../../Trainer Screens/Trainer HomeScreen/HomeSreenWidget/FeaturedPlanWidget/featured_plan_item.dart';
  import '../list_header.dart';

  class FeaturedPlanWidget extends GetWidget<HomeScreenController> {
    const FeaturedPlanWidget({super.key});

    Widget _buildFeaturedPlanItemWidget(
        {required PageController controller, required List<Plan> plans}) {
      return Column(
        children: [
          SizedBox(
            height: 0.2.sh,
            child: PageView.builder(
              controller: controller,
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    startPlanPage(plans[index].id.toString());
                  },
                  child: FeaturedPlanItem(
                    plan: plans[index]
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
            headerTitle: 'our_plan'.tr,
            seeAllFunction: () {
              // return Get.toNamed(AppRoutes.featuredPlamScreen,
              //   arguments: controller.featuredPlans);
            },
          ),
          // _buildFeaturedPlanItemWidget(
          //     controller: PageController(),
          //     plans: controller.featuredPlans
          //         .getRange(
          //             0,
          //             controller.featuredPlans.length > 3
          //                 ? 3
          //                 : controller.featuredPlans.length)
          //         .toList())
        ],
      );
    }
  }
