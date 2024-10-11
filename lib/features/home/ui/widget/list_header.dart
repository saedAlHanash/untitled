import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/enum_manager.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({super.key, required this.headerTitle,  this.seeAllFunction});

  final String headerTitle;
  final Function()? seeAllFunction;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: headerTitle,
      color: Get.theme.primaryColor,
      size: 18.sp,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
      fontFamily: FontManager.bold.name,
      matchParent: true,
      drawableEnd: seeAllFunction != null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0).r,
              decoration: BoxDecoration(
                color: AppColorManager.mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: InkWell(
                onTap: seeAllFunction,
                child: DrawableText(
                  text: 'see_all'.tr,
                  size: 12.0.sp,
                  fontFamily: FontManager.bold.name,
                  drawableAlin: DrawableAlin.withText,
                  color: Get.theme.primaryColor,
                  drawableEnd: ImageMultiType(
                    url: Icons.arrow_forward_ios,
                    color: AppColorManager.mainColor,
                    height: 12.0.sp,
                    width: 12.0.sp,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
