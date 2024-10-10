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
