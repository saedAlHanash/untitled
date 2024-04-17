import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_result_controller.dart';
import 'search_filter_button.dart';

class SearchFilterRow extends GetWidget<SearchResultController> {
  const SearchFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 12.5, vertical: Get.height / 51),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: SearchFilterButton(
                  text: 'trainers'.tr,
                  index: 0,
                  onTap: controller.onTrainerSearch)),
          const Expanded(flex: 1, child: SizedBox.shrink()),
          Expanded(
              flex: 5,
              child: SearchFilterButton(
                  text: 'WORKOUT_PLANS'.tr,
                  index: 1,
                  onTap: controller.onPlanSearch))
        ],
      ),
    );
  }
}
