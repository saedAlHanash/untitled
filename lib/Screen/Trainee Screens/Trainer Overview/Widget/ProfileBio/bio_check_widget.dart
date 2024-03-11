import 'package:awesome_icons/awesome_icons.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class BioCheckWidget extends StatelessWidget {
  const BioCheckWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 7.0.w,
        leading: ImageMultiType(
          color: Colors.white,
          url: Icons.check_circle_outline_sharp,
          height: 35.0.r,
          width: 35.0.r,
        ),
        title: DrawableText(
          text: title,
          color: Colors.white54,
          size: 8.0.sp,
        ),
        subtitle: DrawableText(
          text: value,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 25.0.sp,
        ),
      ),
    );
  }
}
