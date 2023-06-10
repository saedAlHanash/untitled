import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_result_controller.dart';

class SearchFilterButton extends GetWidget<SearchResultController> {
  final String text;
  final int index;
  final Function onTap;

  const SearchFilterButton(
      {super.key,
      required this.text,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: Get.height / 21,
        width: Get.width / 3.4,
        // margin: EdgeInsets.symmetric(vertical: Get.height / 40),
        decoration: BoxDecoration(
          border: Border.all(color: Get.theme.primaryColor),
          color: controller.selectedIndex == index
              ? Get.theme.primaryColor
              : Colors.white,
        ),
        child: InkWell(
          onTap: () => onTap(), //() => controller.selectedIndex = index,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
