import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../search_result_controller.dart';

class TrainerSearchNumberOfResult
    extends GetWidget<TrainerSearchResultController> {
  const TrainerSearchNumberOfResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width / 12.5, vertical: Get.height / 51),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            controller.selectedIndex == 0
                ? '${controller.trainersNumberOfResults}  ${'result'.tr}'
                : '${controller.plansNumberOfResults}  ${'result'.tr}',
            style: const TextStyle(color: Color(0xFFA0A0A0)),
          ),
          GestureDetector(
            onTap: controller.onSort,
            child: Container(
              decoration: BoxDecoration(
                  color: controller.selectedIndex == 0
                      ? controller.isTrainerSort
                          ? Get.theme.primaryColor
                          : Colors.white.withOpacity(1)
                      : controller.isPlanSort
                          ? Get.theme.primaryColor
                          : Colors.white.withOpacity(1),
                  border: Border.all(
                    color: controller.selectedIndex == 0
                        ? controller.isTrainerSort
                            ? Get.theme.primaryColor
                            : const Color(0xFFA0A0A0)
                        : controller.isPlanSort
                            ? Get.theme.primaryColor
                            : const Color(0xFFA0A0A0),
                  ),
                  borderRadius: BorderRadius.circular(500)),
              child: Container(
                width: Get.width / 6,
                padding: EdgeInsets.symmetric(vertical: Get.height / 110),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageMultiType(url:
                      'assets/images/sort.svg',
                      color: Colors.grey,
                    ),
                    Text(
                      'sort'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.selectedIndex == 0
                            ? controller.isTrainerSort
                                ? Colors.white
                                : const Color(0xFFA0A0A0)
                            : controller.isPlanSort
                                ? Colors.white
                                : const Color(0xFFA0A0A0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
