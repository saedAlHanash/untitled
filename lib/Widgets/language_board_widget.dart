import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../generated/assets.dart';

class LanguageBoardWidget extends StatefulWidget {
  const LanguageBoardWidget({super.key, this.fromAuthPage = false});

  final bool fromAuthPage;

  @override
  State<LanguageBoardWidget> createState() => _LanguageBoardWidgetState();
}

class _LanguageBoardWidgetState extends State<LanguageBoardWidget> {
  LanguagesController languagesController = Get.find<LanguagesController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30).r,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8).r,
              child: LangWidget(
                title: 'عربي',
                isSelect: Get.locale?.languageCode == 'ar',
                onTap: () async => await languagesController.setLanguage('ar',
                    fromAuthPage: widget.fromAuthPage),
              ),
            ),
            LangWidget(
              title: 'English',
              isSelect: Get.locale?.languageCode == 'en',
              onTap: () async => await languagesController.setLanguage('en',
                  fromAuthPage: widget.fromAuthPage),
            ),
          ],
        ),
      ),
    );
  }
}

class LangWidget extends StatelessWidget {
  const LangWidget({
    super.key,
    required this.title,
    this.isSelect = false,
    required this.onTap,
  });

  final String title;
  final bool isSelect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
        Get.back();
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelect
              ? AppColorManager.mainColor.withOpacity(0.3)
              : AppColorManager.cardColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
        child: DrawableText(
          text: title,
          matchParent: true,
          drawableEnd: ImageMultiType(
            url: Assets.imagesLanguage,
            color: isSelect ? AppColorManager.mainColor : Colors.grey,
            height: 30,
          ),
        ),
      ),
    );
  }
}
