import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

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
        DrawableText(
          text: isSubscirbe
              ? S.of(context).successfullySubscribed
              : S.of(context).whyToSubscribe,
          color: Colors.white,
          size: 20.0,
          fontWeight: FontWeight.w700,
          fontFamily: FontManager.bold.name,
        ),
        20.0.verticalSpace,
        DrawableText(
          text: isSubscirbe
              ? S.of(context).enjoyYourFitnessStorm
              : S.of(context).joinFitnessStormForPersonalized,
          color: Colors.white,
          textAlign: TextAlign.center,

        ),
      ],
    );
  }
}
