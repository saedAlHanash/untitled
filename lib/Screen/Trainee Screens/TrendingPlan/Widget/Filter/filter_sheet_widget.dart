import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filtness_level_filter_widget.dart';
import 'location_filter_widget.dart';
import 'training_type_filter_widget.dart';

class FilterSheetWidget extends GetWidget<TrendingPlanController> {
  final Function onTap;
  final Function resetFilters;

  const FilterSheetWidget(
      {super.key, required this.onTap, required this.resetFilters});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.28,
      padding: EdgeInsets.only(
          top: Get.height / 20.3,
          left: Get.width / 12.5,
          right: Get.width / 12.5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LocationFilterWidget(),
          const FitnessLevelFilterWidget(),
          const TrainingTypeFilterWidget(),
          TextButton(
            onPressed: () => resetFilters(),
            child: Text(
              'reset_filters'.tr,
              style: TextStyle(color: Get.theme.colorScheme.secondary),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTapFunction: onTap,
                buttonColor: Get.theme.primaryColor,
                text: 'Apply',
                textColor: Colors.white,
                fontSize: 13,
                width: Get.width / 3,
                padding: 0,
              ),
              CustomButton(
                onTapFunction: () {
                  Get.back();
                },
                buttonColor: const Color(0xFFA0A0A0),
                text: 'cancel'.tr,
                textColor: Colors.white,
                fontSize: 13,
                width: Get.width / 3,
                padding: 0,
              )
            ],
          )
        ],
      ),
    );
  }
}
