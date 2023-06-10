import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/filter_container.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelFilter extends GetWidget<FilterPageController> {
  const LevelFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LEVEL'.tr),
            SizedBox(height: Get.height / 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.toggleBeginner,
                  child: FilterContainer(
                      check: controller.beginnerController,
                      widget: const Center(child: Text('Beginner')),
                      width: Get.width,
                      height: Get.height / 15),
                ),
                SizedBox(height: Get.height / 50),
                GestureDetector(
                  onTap: controller.toggleIntermediate,
                  child: FilterContainer(
                      check: controller.intermediateController,
                      widget: Center(
                          child: Text(
                        'intermediate'.tr,
                      )),
                      width: Get.width,
                      height: Get.height / 15),
                ),
                SizedBox(height: Get.height / 50),
                GestureDetector(
                  onTap: controller.toggleAdvanced,
                  child: FilterContainer(
                      check: controller.advancedController,
                      widget: Center(
                          child: Text(
                        'advanced'.tr,
                      )),
                      width: Get.width,
                      height: Get.height / 15),
                ),
                SizedBox(height: Get.height / 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}
