import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_container.dart';

class TypeFilter extends GetWidget<FilterPageController> {
  const TypeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TRAINING_TYPE'.tr,
            ),
            SizedBox(height: Get.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(0),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[0],
                      widget: Center(
                          child: Text(
                        'weightlifting'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(1),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[1],
                      widget: Center(
                          child: Text(
                        'bodyWeight'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(2),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[2],
                      widget: Center(
                          child: Text(
                        'hiit_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(3),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[3],
                      widget: Center(
                          child: Text(
                        'strength_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(4),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[4],
                      widget: Center(
                          child: Text(
                        'functional_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(5),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[5],
                      widget: Center(
                          child: Text(
                        'mobility_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(6),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[6],
                      widget: Center(
                          child: Text(
                        'sports_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(7),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[7],
                      widget: Center(
                          child: Text(
                        'dynamic_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(8),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[8],
                      widget: Center(
                          child: Text(
                        'follo_along'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(9),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[9],
                      widget: Center(
                          child: Text(
                        'bodybuilding'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(10),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[10],
                      widget: Center(
                          child: Text(
                        'prenatal_training'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(11),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[11],
                      widget: Center(
                          child: Text(
                        'hands_free'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleTrainingType(12),
                  child: FilterContainer(
                      check: controller.trainingTypesControllers[12],
                      widget: Center(
                          child: Text(
                        'pilates'.tr,
                      )),
                      width: Get.width / 2.5,
                      height: Get.height / 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
