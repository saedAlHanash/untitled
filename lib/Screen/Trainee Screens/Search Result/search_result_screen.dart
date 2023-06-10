import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/search_filter_row.dart';
import 'Widget/search_number_of_result.dart';
import 'Widget/search_plan_list_view.dart';
import 'Widget/search_trainer_list_view.dart';

class SearchResultScreen extends GetView<SearchResultController> {
  const SearchResultScreen({super.key});

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
            const SearchFilterRow(),
            const SearchNumberOfResult(),
            controller.selectedIndex == 0
                ? const SearchTrainerListView()
                : const SearchPlanListView()
          ],
        ),
      ),
    );
  }
}
