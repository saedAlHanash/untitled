import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/filter_app_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/level_filter.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/location_filter.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/type_filter.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPageScreen extends GetView<FilterPageController> {
  const FilterPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 30, vertical: Get.height / 30),
              child: Column(
                children: [
                  const FilterAppBar(),
                  const LocationFilter(),
                  const LevelFilter(),
                  const TypeFilter(),
                  SizedBox(
                    height: Get.height / 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: CustomButton(
                  onTapFunction: () => controller.result(),
                  text: 'see_result'.tr,
                  width: Get.width,
                  margin: 0,
                  radius: 0,
                  padding: 0,
                ),
              ))
        ],
      ),
    );
  }
}
