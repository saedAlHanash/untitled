import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterAppBar extends GetWidget<FilterPageController> {
  const FilterAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.cancel)),
        Text(
          'filter'.tr,
          style: TextStyle(fontSize: 25),
        ),
        TextButton(
            onPressed: () => controller.resetAllFilter(),
            child: Text(
              'reset'.tr,
              style: TextStyle(
                color: Get.theme.primaryColor,
              ),
            )),
      ],
    );
  }
}
