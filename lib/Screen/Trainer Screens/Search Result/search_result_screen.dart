import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/Widget/search_filter_row.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/Widget/search_number_of_result.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/Widget/search_plan_list_view.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/Widget/search_trainer_list_view.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerSearchResultScreen extends GetView<TrainerSearchResultController> {
  const TrainerSearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('search_results'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: Obx(
        () => Column(
          children: [
            const TrainerSearchFilterRow(),
            const TrainerSearchNumberOfResult(),
            controller.selectedIndex == 0
                ? const TrainerSearchTrainerListView()
                : const TrainerSearchPlanListView()
          ],
        ),
      ),
    );
  }
}
