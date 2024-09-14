// ignore_for_file: must_be_immutable

import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../generated/l10n.dart';
import 'navigation_bar_controller.dart';

class AppNavigationBar extends StatelessWidget {
  AppNavigationBar({super.key, required this.controller});

  AppNavigationBarController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.white,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: AppColorManager.mainColor,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(bodySmall: const TextStyle(color: Colors.yellow)),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Get.theme.primaryColor,
          elevation: 100,
          // type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/Images/homeSVG.svg'),
              backgroundColor: Colors.white,
              label: 'home'.tr,
            ),
            // if (!AppProvider.isGuest)
            //   BottomNavigationBarItem(
            //       icon: SvgPicture.asset('asset/Images/dambleSVG.svg'),
            //       backgroundColor: Colors.white,
            //       label: 'workout'.tr),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('asset/Images/searchSVG.svg'),
                backgroundColor: Colors.white,
                label: 'Search_small'.tr),
            // if (!AppProvider.isGuest)
            //   BottomNavigationBarItem(
            //       icon: SvgPicture.asset('asset/Images/scoreSVG.svg'),
            //       backgroundColor: Colors.white,
            //       label: 'progress'.tr),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/Images/drawerSVG.svg'),
              backgroundColor: Colors.white,
              label: S.of(context).settings,
              // activeIcon: Container(
              //     width: double.infinity,
              //     color: Get.theme.primaryColor,
              //     height: kBottomNavigationBarHeight,
              //     margin: EdgeInsets.zero,
              //     padding: const EdgeInsets.symmetric(vertical: 20),
              //     child: SvgPicture.asset('asset/Images/cancel.svg')),
            ),
          ],
          currentIndex: controller.index,
          onTap: (value) => controller.index = value,
          // selectedItemColor: Get.theme.primaryColor,
          selectedFontSize: controller.index == 4 ? 0 : 14,
          // iconSize: 24,
        ),
      ),
    );
  }
}
