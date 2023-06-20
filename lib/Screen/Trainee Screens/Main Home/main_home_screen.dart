// ignore_for_file: must_be_immutable
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Progress%20Screen/progress_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Workout%20Screen/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../HomeScreen/home_screen.dart';
import 'Widget/navigation_bar_widget.dart';

class MainHomeScreen extends GetView<MainHomeController> {
  MainHomeScreen({super.key});

  List<Widget> tabs = [
    const HomeScreen(),
    const WorkoutScreen(),
    const SearchScreen(),
    const ProgressScreen(),
    const TraineeProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    // Check if the current locale is English
    // bool isArabic = Get.locale?.languageCode == 'ar';
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        appBar: controller.navController.index == 4
            ? null
            : AppBar(
                leadingWidth: Get.width / 8,
                leading: Padding(
                  padding: isEnglish
                      ? EdgeInsets.only(left: Get.width / 20)
                      : EdgeInsets.only(right: Get.width / 20),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.subscriptionScreen),
                    child: Image.asset(
                      'asset/Images/logo_light.png',
                      height: 5,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () => Get.toNamed(AppRoutes.chatScreen),
                      icon: SvgPicture.asset(
                        'asset/Images/chatSVG.svg',
                        color: Get.theme.scaffoldBackgroundColor,
                      )),
                  Stack(
                    alignment: isEnglish ? Alignment.topRight : Alignment.topLeft,
                    children: [
                      IconButton(
                          onPressed: () => Get.toNamed(AppRoutes.notificationScreen,
                                  arguments: [false])!
                              .then((value) => controller.numberOfNotification = 0),
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                          )),
                      controller.numberOfNotification != 0
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 15,
                                minHeight: 15,
                              ),
                              child: Text(
                                controller.numberOfNotification > 9
                                    ? "+9"
                                    : controller.numberOfNotification.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
        body: tabs[controller.navController.index],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black38, blurRadius: 20),
            ],
          ),
          child: AppNavigationBar(
            controller: controller.navController,
          ),
        ),
      ),
    );
  }
}
