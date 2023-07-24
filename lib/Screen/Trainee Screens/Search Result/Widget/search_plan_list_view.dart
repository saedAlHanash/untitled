import 'package:fitness_storm/Model/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../Widgets/plan_time_freqency.dart';
import '../../../../Widgets/see_all_list_item.dart';
import '../search_result_controller.dart';
import 'empty_search_result.dart';

class SearchPlanListView extends GetWidget<SearchResultController> {
  const SearchPlanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.isLoadingPlans
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.plans.isEmpty
                ? const EmptySearchResult()
                : SmartRefresher(
                    controller: controller.planRefreshController,
                    enablePullUp: true,
                    enablePullDown: false,
                    onLoading: controller.onLoadingPlan,
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
                        shrinkWrap: true,
                        itemCount: controller.plans.length,
                        itemBuilder: (context, index) {
                          Plan plan = controller.plans[index];
                          return SeeAllListItem(
                            plan: plan,
                            index: index,
                            isPressed: controller.addPlanToFavorite,
                            subTitle: PlanTimeFrequency(
                              totalWeeks: plan.totalWeeks!,
                              workoutFrequency: plan.workoutFrequency!,
                              color: Colors.grey,
                            ),
                          );
                        }),
                  ),
      ),
    );
  }
}
