import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Get.theme.primaryColor,
      elevation: 100,
      // type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('asset/Images/homeSVG.svg'),
          backgroundColor: Colors.white,
          label: 'home'.tr,
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('asset/Images/dambleSVG.svg'),
            backgroundColor: Colors.white,
            label: 'workout'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('asset/Images/searchSVG.svg'),
            backgroundColor: Colors.white,
            label: 'Search_small'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('asset/Images/scoreSVG.svg'),
            backgroundColor: Colors.white,
            label: 'progress'.tr),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('asset/Images/drawerSVG.svg'),
          backgroundColor: Colors.white,
          label: '',
          // activeIcon: Container(
          //     width: double.infinity,
          //     color: Get.theme.primaryColor,
          //     height: kBottomNavigationBarHeight,
          //     margin: EdgeInsets.zero,
          //     padding: const EdgeInsets.symmetric(vertical: 20),
          //     child: SvgPicture.asset('asset/Images/cancel.svg')),
        ),
      ],
      currentIndex: index,
      onTap: (value) => index = value,
      // selectedItemColor: Get.theme.primaryColor,
      selectedFontSize: index == 4 ? 0 : 14,
      // iconSize: 24,
    );
  }
}
