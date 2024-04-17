import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/Widget/featured_plan_list.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/Widget/filter_row.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedPlanScreen extends GetView<FeaturedPlanController> {
  const FeaturedPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('our_workout'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          FilterRow(selectedIndex: controller.selectedIndex),
          Expanded(child: FeaturedPlanList()),
        ],
      ),
    );
  }
}
