import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../your_trainer_controller.dart';
import 'filter_button.dart';

class FilterRow extends GetWidget<YourTrainerController> {
  final int selectedIndex;
  final bool aboutTrainer;

  const FilterRow(
      {super.key, required this.selectedIndex, required this.aboutTrainer});

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
            onTap: () => controller.searchBottomSheet(aboutTrainer),
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
