import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';

class WithoutSubscribed extends StatelessWidget {
  const WithoutSubscribed({super.key, required this.isSubscirbe});

  final bool isSubscirbe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackBtnWidget(appBarColor: AppColorManager.mainColor),
            ImageMultiType(
              url: Assets.imagesWhiteLogo,
              width: 0.5.sw,
            ),
            50.0.horizontalSpace,
          ],
        ),
        Text(
          isSubscirbe ? 'successfully_subscribed'.tr : 'why_to_subscribe'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Get.height / 40.6),
        Text(
          isSubscirbe
              ? 'enjoy_your_fitness_storm.'.tr
              : 'join_fitnessStorm_for_personalized'.tr,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
