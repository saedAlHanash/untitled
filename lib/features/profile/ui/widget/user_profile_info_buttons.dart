import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/profile/ui/pages/pdf_viewer_page.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../helper/lang_helper.dart';

class UserProfileInfoButtons extends StatelessWidget {
  const UserProfileInfoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: _Item(type: ProfileButtonType.about)),
            15.0.horizontalSpace,
            const Expanded(child: _Item(type: ProfileButtonType.privacy)),
          ],
        ),
        10.0.verticalSpace,
        Row(
          children: [
            const Expanded(child: _Item(type: ProfileButtonType.faq)),
            15.0.horizontalSpace,
            const Expanded(flex: 2, child: _Item(type: ProfileButtonType.terms)),
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
          startPdf(AppProvider.systemParams.about, name);
        };
        break;
      case ProfileButtonType.privacy:
        name = S().privacyPolicy;
        onTap = () {
          startPdf(AppProvider.systemParams.policy, name);
        };
        break;
      case ProfileButtonType.faq:
        name = S().faq;
        onTap = () {
          startPdf(AppProvider.systemParams.faq, name);
        };
        break;
      case ProfileButtonType.terms:
        name = S().termAndCondition;
        onTap = () {
          startPdf(AppProvider.systemParams.terms, name);
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
