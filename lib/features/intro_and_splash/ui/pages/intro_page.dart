import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/card_slider_widget.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final key = GlobalKey<IndicatorSliderWidgetState>();
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (i) {
            setState(() => pageIndex = i);
            key.currentState?.changePage(i);
          },
          children: [
            const _P1(),
            const _P2(),
            const _P3(),
          ],
        ),
        Positioned(
          bottom: 0.0,
          right: 0,
          left: 0,
          child: Column(
            children: [
              70.0.verticalSpace,
              IndicatorSliderWidget(
                key: key,
                length: 3,
              ),
              30.0.verticalSpace,
              Center(
                child: MyButton(
                  onTap: () {
                    if (pageIndex == 2) {
                      startLogin();
                      AppSharedPreference.cashShowIntro();
                    } else {
                      _pageController.animateToPage(
                        (pageIndex + 1),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }
                  },
                  text: pageIndex == 2 ? S.of(context).start : S.of(context).next,
                  color: AppColorManager.secondColor,
                  width: 210.0.w,
                  height: 40.0.h,
                ),
              ),
              10.0.verticalSpace,
              if (pageIndex != 2)
                TextButton(
                  onPressed: () {
                    AppSharedPreference.cashShowIntro();
                    startLogin();
                  },
                  child: DrawableText(
                    text: S.of(context).skip,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                    matchParent: true,
                  ),
                ),
              20.0.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}

class _P1 extends StatelessWidget {
  const _P1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: Assets.imagesIntro1,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        ImageMultiType(
          url: Assets.imagesIntro1Back,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(30.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.verticalSpace,
                InkWell(
                  onTap: () {
                    BottomSheets.languageBottomSheet(
                      const LanguageBoardWidget(),
                    );
                  },
                  child: ImageMultiType(
                    url: Assets.imagesLanguage,
                    color: Colors.white,
                    width: 35.0.r,
                    height: 35.0.r,
                  ),
                ),
                0.5.sh.verticalSpace,
                DrawableText(
                  matchParent: true,
                  text: S.of(context).welcomeTo,
                  color: Colors.white,
                  size: 18.0.sp,
                  fontWeight: FontWeight.w600,
                ),
                4.0.verticalSpace,
                DrawableText(
                  text: S.of(context).fitnessStorm,
                  color: AppColorManager.secondColor,
                  size: 40.0.sp,
                  fontWeight: FontWeight.w600,
                ),
                4.0.verticalSpace,
                DrawableText(
                  text: S.of(context).yourPersonalFitnessCompanion,
                  color: Colors.white,
                  size: 18.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _P2 extends StatelessWidget {
  const _P2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: Assets.imagesIntro3,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        ImageMultiType(
          url: Assets.imagesIntro3Back,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(30.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.5.sh.verticalSpace,
                DrawableText(
                  matchParent: true,
                  maxLines: 2,
                  text: S.of(context).getUnlimitedAccessToAllFitnessnPrograms,
                  color: Colors.white,
                  size: 18.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _P3 extends StatelessWidget {
  const _P3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: Assets.imagesIntro2,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        ImageMultiType(
          url: Assets.imagesIntro1Back,
          height: 1.0.sh,
          width: 1.0.sw,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(30.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.5.sh.verticalSpace,
                DrawableText(
                  matchParent: true,
                  maxLines: 5,
                  text: S
                      .of(context)
                      .getFitAnytimeAnywherentrackYourProgressEffortlesslynaccessPersonalizedWorkouts,
                  color: Colors.white,
                  size: 18.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
