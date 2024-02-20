import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
                ontap: () async => await languagesController.setLanguage('ar',
                    fromAuthPage: widget.fromAuthPage),
              ),
            ),
            LangWidget(
              title: 'English',
              ontap: () async => await languagesController.setLanguage('en',
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
    required this.ontap,
  });

  final String title;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap.call();
        Get.back();
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColorManager.cardColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                Assets.imagesLanguage,
                color: const Color(0xFF565C63),
                height: 30,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
