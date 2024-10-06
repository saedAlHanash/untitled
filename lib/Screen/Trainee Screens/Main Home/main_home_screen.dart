import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/profile/ui/pages/guest_profile_page.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../core/app/app_provider.dart';
import '../../../features/fire_chat/rooms_bloc/rooms_cubit.dart';
import '../../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../../features/profile/ui/pages/profile_page.dart';
import '../../../features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../../../generated/assets.dart';
import '../HomeScreen/home_screen.dart';
import 'Widget/bottom_nav_widget.dart';
import 'Widget/navigation_bar_widget.dart';

  List<Widget> tabs = [
    const HomeScreen(),
    // if (!AppProvider.isGuest) const WorkoutScreen(),
    const SearchScreen(),
    // if (!AppProvider.isGuest) const ProgressScreen(),
    if (AppProvider.isGuest) const GuestProfilePage() else const ProfilePage(),
  ];
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
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

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<WelcomeMessagesCubit, WelcomeMessagesInitial>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBarWidget(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            child: GestureDetector(
              onTap: () {
                if (AppControl.isAppleAccount) return;
                Get.toNamed(AppRoutes.subscriptionScreen);
              },
              child: ImageMultiType(url: Assets.imagesLogoLight),
            ),
          ),
          actions: [
            if (!AppProvider.isGuest)
              IconButton(
                  onPressed: () => Get.toNamed(AppRoutes.chatScreen),
                  icon: BlocBuilder<RoomsCubit, RoomsInitial>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          ImageMultiType(
                            url: Assets.imagesChatSVG,
                            color: Get.theme.scaffoldBackgroundColor,
                          ),
                          if (state.notRead)
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
            BlocBuilder<NotificationsCubit, NotificationsInitial>(
              builder: (context, state) {
                return Stack(
                  alignment: Get.locale?.languageCode == 'en'
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  children: [
                    IconButton(
                        onPressed: () {
                          startNotificationsPage();
                        },
                        icon: const Icon(
                          Icons.notifications,
                          size: 30,
                        )),
                    (state.result.numberOfResults - state.numOfRead) != 0
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
                        (state.result.numberOfResults - state.numOfRead) > 9
                            ? "+9"
                            : (state.result.numberOfResults - state.numOfRead)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : const SizedBox.shrink()
                  ],
                );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                const HomeScreen(),
                const SearchScreen(),
                if (AppProvider.isGuest) const GuestProfilePage() else const ProfilePage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Navbar(
                onChange: (index) {
                  pageIndex = index;
                  setState(() => _pageController.jumpToPage(index));
                },
                controller: _pageController,
              ),
            ),
          ],
        ),
     ),
    );
  }
}
