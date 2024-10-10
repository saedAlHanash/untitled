import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    required this.text,
    this.size,
  });

  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              Assets.lottiesSadFace,
              height: size ?? 200.0.spMin,
              width: size ?? 200.0.spMin,
            ),
            DrawableText(
              text: text,
              fontFamily: FontManager.bold.name,
              color: AppColorManager.mainColorDark,
              size: 24.0.spMin,
            )
          ],
        ),
      ),
    );
  }
}
