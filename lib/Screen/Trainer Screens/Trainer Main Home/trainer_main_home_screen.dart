// ignore_for_file: must_be_immutable

import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/search_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/trainer_main_home_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../features/fire_chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../features/profile/ui/pages/profile_trainer_screen.dart';
import '../../../features/trainer/ui/pages/calender_screen.dart';
import 'Widget/trainer_navigation_bar_widget.dart';

class TrainerMainHomeScreen extends GetView<TrainerMainHomeController> {
  TrainerMainHomeScreen({super.key});

  List<Widget> tabs = [
    const TrainerHomeScreen(),
    const TrainerWalletScreen(),
    const TrainerSearchScreen(),
    const CalenderScreen(),
    // const TrainerCalenderSceen(),
    const ProfileTrainerScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    var scaffoldKey = GlobalKey<ScaffoldState>();
    // Check if the current locale is English
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        appBar: controller.navController.index == 4
            ? null
            : controller.navController.index == 3
                ? AppBar(
          //saedsaed
                    title: Text('my_calender'.tr,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)))
                : AppBar(
                    leadingWidth: Get.width / 8,
                    // leading: Padding(
                    //   padding: isEnglish
                    //       ? EdgeInsets.only(left: Get.width / 20)
                    //       : EdgeInsets.only(right: Get.width / 20),
                    //   child: GestureDetector(
                    //     onTap: () => Get.toNamed(AppRoutes.subscriptionScreen),
                    //     child: Image.asset(
                    //       'asset/Images/logo_light.png',
                    //       height: 5,
                    //     ),
                    //   ),
                    // ),
                    actions: [
                      IconButton(
                          onPressed: () => Get.toNamed(AppRoutes.chatScreen),
                          icon: BlocBuilder<RoomsCubit, RoomsInitial>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  SvgPicture.asset(
                                    'asset/Images/chatSVG.svg',
                                    color: Get.theme.scaffoldBackgroundColor,
                                  ),
                                  if (state.noReadMessages)
                                    Container(
                                      height: 7.0,
                                      width: 7.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                ],
                              );
                            },
                          )),
                      Builder(builder: (context) {
                        return IconButton(
                          onPressed: () => Get.toNamed(
                              AppRoutes.notificationScreen,
                              arguments: [true]),
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                          icon: SvgPicture.asset(
                            'asset/Images/notificationSVG.svg',
                            color: Get.theme.scaffoldBackgroundColor,
                          ),
                        );
                      }),
                    ],
                  ),
        body: tabs[controller.navController.index],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black38, blurRadius: 20)
            ],
          ),
          child: TrainerAppNavigationBar(controller: controller.navController),
        ),
      ),
    );
  }
}
