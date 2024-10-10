import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Main Home/main_home_controller.dart';

class EmptySearchResult extends GetWidget<SearchResultController> {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          controller.selectedIndex == 0
              ? 'there_are_no_TRAINERS'.tr
              : 'there_are_no_workout'.tr,
          style: const TextStyle(color: Color(0xFF565C63), fontSize: 14),
          textAlign: TextAlign.center,
        ),

      ]),
    );
  }
}
