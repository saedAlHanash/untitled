import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen.dart';
import 'package:fitness_storm/features/profile/ui/pages/guest_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_provider.dart';
import '../../../profile/ui/pages/profile_page.dart';
import '../../../welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../widget/bottom_nav_widget.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
