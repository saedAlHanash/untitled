import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWithDote extends StatelessWidget {
  const TitleWithDote(
      {super.key, required this.text, this.color = AppColorManager.mainColor});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      drawableStart: Container(
        width: 15.0.w,
        height: 25.0.h,
        color: color,
      ),
      drawablePadding: 30.0.w,
      text: text,
      matchParent: true,
      color: color,
      fontWeight: FontWeight.bold,
      size: 18.0.sp,
    );
  }
}
