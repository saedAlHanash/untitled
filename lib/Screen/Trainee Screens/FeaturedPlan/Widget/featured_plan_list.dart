import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
import 'package:fitness_storm/features/bookmarked/ui/widget/see_all_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeaturedPlanList extends GetWidget<FeaturedPlanController> {
  const FeaturedPlanList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SmartRefresher(
              controller: controller.refreshController.value,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: controller.onLoading,
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull_up_load".tr);
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("load_failed!click_retry!".tr);
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release_to_load_more".tr);
                  } else {
                    body = Text("no_more_data".tr);
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: ListView.builder(
                itemCount: controller.plans.length,
                itemBuilder: (context, index) {
                  return SeeAllListItem(
                    plan: controller.plans[index],
                  );
                },
              ),
            ),
    );
  }
}
