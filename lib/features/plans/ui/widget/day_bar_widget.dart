import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class DayBarWidget extends StatelessWidget {
  const DayBarWidget(this.index, {super.key, required this.isFinish});

  final int index;
  final bool isFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 5.5,
      height: Get.height / 26,
      margin: EdgeInsets.only(
        top: Get.height / 70,
        bottom: Get.height / 50,
        left: Get.width / 30,
        right: Get.width / 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isFinish ? AppColorManager.secondColor : Colors.white,
      ),
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
                color: Get.theme.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (isFinish)
            DrawableText(
              text: S.of(context).finish,
              color: AppColorManager.mainColor,
              size: 12.0.sp,
            ),
        ],
      ),
    );
  }
}
