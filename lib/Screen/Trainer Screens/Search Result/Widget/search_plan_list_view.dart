import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../features/plans/ui/widget/item_plan.dart';
import '../search_result_controller.dart';
import 'empty_search_result.dart';

class TrainerSearchPlanListView
    extends GetWidget<TrainerSearchResultController> {
  const TrainerSearchPlanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.isLoadingPlans
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.plans.isEmpty
                ? const TrainerEmptySearchResult()
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
                          final  plan = controller.plans[index];
                          return ItemPlan(
                            plan: plan,
                          );
                        }),
                  ),
      ),
    );
  }
}
