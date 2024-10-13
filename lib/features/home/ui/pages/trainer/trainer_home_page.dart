import 'package:fitness_storm/features/home/ui/pages/trainer/trainer_home_screen.dart';
import 'package:fitness_storm/features/profile/ui/pages/guest_profile_page.dart';
import 'package:fitness_storm/features/search/ui/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Screen/Trainer Screens/Trainer Wallet/trainer_wallet_screen.dart';
import '../../../../../core/app/app_provider.dart';
import '../../../../profile/ui/pages/profile_page.dart';
import '../../../../profile/ui/pages/profile_trainer_screen.dart';
import '../../../../welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../../widget/bottom_nav_widget.dart';

class TrainerHomePage extends StatefulWidget {
  const TrainerHomePage({super.key});

  @override
  State<TrainerHomePage> createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
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
    return BlocListener<WelcomeMessagesCubit, WelcomeMessagesInitial>(
      listener: (context, state) {},
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const TrainerHomeScreen(),
                const SearchScreen(),
                const TrainerWalletScreen(),
                const ProfileTrainerScreen(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Navbar(
                isTrainer: true,
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
