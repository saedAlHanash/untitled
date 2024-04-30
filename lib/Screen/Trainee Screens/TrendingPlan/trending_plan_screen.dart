import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/plan_time_freqency.dart';
import '../../../Widgets/see_all_list_item.dart';
import '../../../core/models/plan_model.dart';

class TrendingPlansScreen extends GetView<TrendingPlanController> {
  const TrendingPlansScreen({Key? key}) : super(key: key);

  Widget _buildTrendsPlansList(List<PlanModel> plans) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return SeeAllListItem(
                plan: controller.plans[index],
                isPressed: controller.addPlanToFavorite,
                index: index,
                subTitle: PlanTimeFrequency(
                  totalWeeks: plans[index].totalWeeks,
                  workoutFrequency: plans[index].workoutFrequency,
                  color: Colors.grey,
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('trending_plan'.tr),
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // centerTitle: true,
        ),
        body: Column(
          children: [
            // FilterRow(selectedIndex: controller.selectedIndex),
            Expanded(child: _buildTrendsPlansList(controller.plans)),
          ],
        ),
      ),
    );
  }
}
