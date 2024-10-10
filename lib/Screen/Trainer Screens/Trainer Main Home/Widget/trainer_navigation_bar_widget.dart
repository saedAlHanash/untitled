// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import 'trainer_navigation_bar_controller.dart';

class TrainerAppNavigationBar extends StatelessWidget {
  TrainerAppNavigationBarController controller;

  TrainerAppNavigationBar({    super.key, required this.controller})
      ;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        selectedItemColor: Get.theme.primaryColor,
        // unselectedItemColor: Colors.white,
        // elevation: 100,
        // type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.white,
        // fixedColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: ImageMultiType(url:'assets/images/homeSVG.svg'),
            backgroundColor: Colors.white,
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
              icon: ImageMultiType(url:'assets/images/wallet.svg'),
              backgroundColor: Colors.white,
              label: 'Wallet'.tr),
          BottomNavigationBarItem(
              icon: ImageMultiType(url:'assets/images/searchSVG.svg'),
              backgroundColor: Colors.white,
              label: 'Search_small'.tr),
          BottomNavigationBarItem(
              icon: ImageMultiType(url:'assets/images/calender.svg'),
              backgroundColor: Colors.white,
              label: 'calender'.tr),
          BottomNavigationBarItem(
            icon: ImageMultiType(url:'assets/images/drawerSVG.svg'),
            backgroundColor: Colors.white,
            label: '',
            // activeIcon: Container(
            //     width: double.infinity,
            //     color: Get.theme.primaryColor,
            //     height: kBottomNavigationBarHeight,
            //     margin: EdgeInsets.zero,
            //     padding: const EdgeInsets.symmetric(vertical: 20),
            //     child: ImageMultiType(url:'asset/Images/cancel.svg')),
          ),
        ],
        currentIndex: controller.index,
        onTap: (value) => controller.index = value,

        selectedFontSize: controller.index == 4 ? 0 : 14,
        // iconSize: 24,
      ),
    );
  }
}
