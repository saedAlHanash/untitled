import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../generated/assets.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.name,
    this.showLanguageButton = false,
  });

  final String name;
  final bool showLanguageButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        if (showLanguageButton)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  BottomSheets.languageBottomSheet(
                    const LanguageBoardWidget(fromAuthPage: true),
                  );
                },
                child: ImageMultiType(
                  url: Assets.imagesLanguage,
                  width: 35.0.r,
                  height: 35.0.r,
                  color: Colors.white,
                ),
              ),
              ImageMultiType(
                url: Assets.imagesWhiteLogo,
                width: 0.3.sw,
              ),
              55.0.horizontalSpace,
            ],
          )
        else
          ImageMultiType(
            url: Assets.imagesWhiteLogo,
            width: 0.3.sw,
          ),
        20.0.verticalSpace,
        DrawableText(
          text: name,
          size: 26.0.sp,
          color: Colors.white,
          fontFamily: FontManager.bold.name,
        ),
        40.0.verticalSpace,
      ],
    );
  }
}
