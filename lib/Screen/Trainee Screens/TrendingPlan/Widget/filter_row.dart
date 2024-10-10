import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/Widget/filter_button.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterRow extends GetWidget<TrendingPlanController> {
  final int selectedIndex;

  const FilterRow({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 23.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilterButton(
            icon: 'assets/images/search_bar.svg',
            text: 'SEARCH'.tr,
            index: 0,
            onTap: () => controller.searchBottomSheet(),
          ),
          FilterButton(
            icon: 'assets/images/filter.svg',
            text: 'filter'.tr,
            index: 1,
            onTap: () => controller.filterBottomSheet(),
          ),
          FilterButton(
            icon: 'assets/images/sort.svg',
            text: 'sort'.tr,
            index: 2,
            onTap: () => controller.sortBottomSheet(),
          )
        ],
      ),
    );
  }
}
