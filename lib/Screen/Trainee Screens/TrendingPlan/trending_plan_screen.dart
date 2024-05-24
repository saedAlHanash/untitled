import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/plan_model.dart';
import '../../../features/bookmarked/ui/widget/see_all_list_item.dart';

class TrendingPlansScreen extends GetView<TrendingPlanController> {
  const TrendingPlansScreen({super.key});

  Widget _buildTrendsPlansList(List<PlanModel> plans) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return SeeAllListItem(
                plan: controller.plans[index],
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
