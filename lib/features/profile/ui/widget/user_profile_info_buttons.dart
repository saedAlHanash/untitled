import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../generated/l10n.dart';

class UserProfileInfoButtons extends StatelessWidget {
  const UserProfileInfoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _Item(type: ProfileButtonType.about)),
            15.0.horizontalSpace,
            Expanded(child: _Item(type: ProfileButtonType.privacy)),
          ],
        ),
        10.0.verticalSpace,
        Row(
          children: [
            Expanded(child: _Item(type: ProfileButtonType.faq)),
            15.0.horizontalSpace,
            Expanded(flex: 2, child: _Item(type: ProfileButtonType.terms)),
          ],
        ),
      ],
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({required this.type});

  final ProfileButtonType type;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late final ButtonStyle style;

  late final String name;

  late final Function onTap;

  @override
  void initState() {
    switch (widget.type) {
      case ProfileButtonType.about:
        name = S().aboutUs;
        onTap = () {
          Get.toNamed(AppRoutes.aboutAs);
        };
        break;
      case ProfileButtonType.privacy:
        name = S().privacyPolicy;
        onTap = () {
          Get.toNamed(AppRoutes.privacyPolicy);
        };
        break;
      case ProfileButtonType.faq:
        name = S().faq;
        onTap = () {
          Get.toNamed(AppRoutes.FAQs);
        };
        break;
      case ProfileButtonType.terms:
        name = S().termAndCondition;
        onTap = () {
          Get.toNamed(AppRoutes.termsAndCondition);
        };
        break;
    }
    style = ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(AppColorManager.f6),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.r),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: () => onTap.call(),
      child: DrawableText(
        text: name,
        color: Colors.black54,
      ),
    );
  }
}
