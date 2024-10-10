import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../your_trainer_controller.dart';

class FilterButton extends GetWidget<YourTrainerController> {
  final String icon;
  final String text;
  final int index;
  final Function onTap;

  const FilterButton({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: Get.height / 21,
        width: Get.width / 3.4,
        margin: EdgeInsets.symmetric(vertical: Get.height / 40),
        decoration: BoxDecoration(
          border: Border.all(color: Get.theme.primaryColor),
          color: controller.selectedIndex == index
              ? Get.theme.primaryColor
              : Colors.white,
        ),
        child: InkWell(
          onTap: () => onTap(), //() => controller.selectedIndex = index,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: Get.width / 27.7,
              height: Get.width / 27.7,
              child: ImageMultiType(url:
                icon,
                color: controller.selectedIndex == index
                    ? Colors.white
                    : Get.theme.primaryColor,
              ),
            ),
            SizedBox(width: Get.width / 50),
            Text(
              text,
              style: TextStyle(
                color: controller.selectedIndex == index
                    ? Colors.white
                    : Get.theme.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
