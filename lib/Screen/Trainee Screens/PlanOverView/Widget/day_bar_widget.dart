import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayBarWidget extends StatelessWidget {
  final int index;

  const DayBarWidget(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 5.5,
      height: Get.height / 26,
      margin: EdgeInsets.only(
          top: Get.height / 70,
          bottom: Get.height / 50,
          left: Get.width / 30,
          right: Get.width / 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Platform.isIOS ? 10 : 5,
          ),
          Text(
            'day'.tr,
            style: TextStyle(color: Get.theme.primaryColor, fontSize: 14),
          ),
          Text(
            '${index + 1}',
            style: TextStyle(
                color: Get.theme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
