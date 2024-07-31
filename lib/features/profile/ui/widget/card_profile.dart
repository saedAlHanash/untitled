import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, required this.type});

  final ProfileCardType type;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late final String image;
  late final String name;
  late final Function onTap;

  @override
  void initState() {
    switch (widget.type) {
      case ProfileCardType.profile:
        image = Assets.imagesProfileInfo;
        name = S().profileInfo;
        onTap = () {
          if (AppProvider.isTrainer) {
            Get.toNamed(AppRoutes.trainerProfileOverview);
            return;
          }
          startUpdateProfile();
        };
        break;
      case ProfileCardType.fav:
        image = Assets.imagesBookmark;
        name = S().bookmarked;
        onTap = () {
          startBookMarked();
        };
        break;
      case ProfileCardType.payment:
        image = Assets.imagesPayment;
        name = S().myPayments;
        onTap = () {
          Get.toNamed(AppRoutes.myPaymentScreen);
        };
        break;
      case ProfileCardType.lang:
        image = Assets.imagesLanguage;
        name = S().language;
        onTap = () {
          BottomSheets.languageBottomSheet(const LanguageBoardWidget());
        };
        break;

      case ProfileCardType.appointment:
        image = Assets.imagesVCall;
        name = S().privateSession;
        onTap = () {
          startAppointment();
        };

      case ProfileCardType.files:
        image = Assets.imagesFiles;
        name = S().files;
        onTap = () {
          startTrainerFiles();
        };

        break;
      // case ProfileCardType.welcome:
      //   image = Assets.imagesWelcomeMessage;
      //   name = S().welcomeMessage;
      //   onTap = () {
      //     startWelcomePage();
      //   };
      //   break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        width: 1.0.sw,
        height: 80.0.h,
        padding: const EdgeInsets.all(12.0).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: const Color(0xFFF5F5F5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageMultiType(
              url: image,
              height: 25.0.r,
              width: 25.0.r,
            ),
            DrawableText(
              text: name,
              color: AppColorManager.darkBluGry,
              fontFamily: FontManager.cairoBold.name,
              size: 18.0.sp,
            )
          ],
        ),
      ),
    );
  }
}
