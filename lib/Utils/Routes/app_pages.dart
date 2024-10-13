
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_bindings.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_screen.dart';

import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_binding.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_screen.dart';
import 'package:fitness_storm/features/home/ui/pages/home_page.dart';
import 'package:fitness_storm/features/intro_and_splash/ui/pages/splash_page.dart';
import 'package:fitness_storm/features/payments/ui/pages/my_payment_page.dart';
import 'package:fitness_storm/features/plans/ui/pages/free_plans_page.dart';
import 'package:fitness_storm/features/profile/ui/pages/profile_trainer_page.dart';
import 'package:get/get.dart';

import '../../Screen/Trainer Screens/Trainer Wallet/trainer_wallet_controller.dart';
import '../../core/injection/injection_container.dart';
import '../../core/util/firebase_analytics_service.dart';
import '../../features/fire_chat/rooms_screen.dart';
import '../../features/home/ui/pages/trainer/trainer_home_page.dart';

part './app_routes.dart';

class AppPages {
  List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () {
          sl<AnalyticService>().screenView(name: 'splash');
          return SplashPage();
        },
      ),
      GetPage(
          name: AppRoutes.mainHome,
          page: () {
            sl<AnalyticService>().screenView(name: 'main_home');
            return HomePage();
          },
        ),
      // GetPage(
      //     name: AppRoutes.planOverview,
      //     page: () {
      //
      //       return const PlanOverviewScreen();
      //     },
      //     binding: PlanOverviewBinding()),

      GetPage(
        name: AppRoutes.trendingPlanScreen,
        page: () {
          sl<AnalyticService>().screenView(name: 'free_plan');
          return const TrendingPlansScreen();
        },
      ),
      // GetPage(
      //     name: AppRoutes.featuredPlamScreen,
      //     page: () {
      //       sl<AnalyticService>()
      //           .screenView(name: 'featured_plan_creen');
      //       return const FeaturedPlanScreen();
      //     },
      //     binding: FeaturedPlanBinding()),
      // GetPage(
      //     name: AppRoutes.yourTrainerScreen,
      //     page: () {
      //       sl<FirebaseAnalyticService>().screenView(name: 'your_trainer');
      //       return const YourTrainersScreen();
      //     },
      //     binding: YourTrainerBinding()),

      // GetPage(
      //     name: AppRoutes.training,
      //     page: () {
      //       sl<FirebaseAnalyticService>().screenView(name: 'training');
      //       return const TrainingScreen();
      //     },
      //     binding: TrainingBinding()),
      // GetPage(
      //     name: AppRoutes.userTraining,
      //     page: () {
      //       sl<AnalyticService>().screenView(name: 'user_training');
      //       return const UserTrainingScreen();
      //     },
      //     binding: UserTrainingBinding()),
      // GetPage(
      //     name: AppRoutes.loadingStartTrainginScreen,
      //     page: () {
      //       sl<FirebaseAnalyticService>()
      //           .screenView(name: 'loading_start_training');
      //       return const LoadingStartTrainginScreen();
      //     },
      //     binding: LoadingStartTraingingBinding()),
      // GetPage(
      //     name: AppRoutes.filterScreen,
      //     page: () {
      //       sl<FirebaseAnalyticService>().screenView(name: 'filter');
      //       return const FilterPageScreen();
      //     },
      //     binding: FilterPageBinding()),
      // GetPage(
      //     name: AppRoutes.filterResult,
      //     page: () {
      //       sl<FirebaseAnalyticService>().screenView(name: 'filter_result');
      //       return const FilterResultScreen();
      //     },
      //     binding: FilterPageBinding()),
      GetPage(
          name: AppRoutes.subscriptionScreen,
          page: () {
            sl<AnalyticService>().screenView(name: 'subscription');
            return const SubscriptionScreen();
          },
          binding: SubscriptionBinding()),
      // GetPage(
      //     name: AppRoutes.searchResultSceen,
      //     page: () {
      //       sl<AnalyticService>().screenView(name: 'searchResult');
      //       return const SearchResultScreen();
      //     },
      //     binding: SearchResultBinding()),
      // GetPage(
      //   name: AppRoutes.traineeProfileInfo,
      //   page: () {
      //     sl<FirebaseAnalyticService>()
      //         .screenView(name: 'trainee_profile_info');
      //     return const TraineeProfileInfoScreen();
      //   },
      // ),

      GetPage(
          name: AppRoutes.myPaymentScreen,
          page: () {
            sl<AnalyticService>().screenView(name: 'my_payment');
            return const MyPaymentScreen();
          },
          ),
      GetPage(
        name: AppRoutes.chatScreen,
        page: () {
          sl<AnalyticService>().screenView(name: 'chat');
          return const RoomsScreen();
        },
      ),
      GetPage(
          name: AppRoutes.trainerHomePage,
          page: () {
            sl<AnalyticService>().screenView(name: 'trainer_home_page');
            return TrainerHomePage();
          },
          binding: TrainerWalletBinding()),
      GetPage(
        name: AppRoutes.trainerProfileOverview,
        page: () {
          sl<AnalyticService>().screenView(name: 'trainer_profile_overview');
          return const ProfileTrainerPage();
        },
      ),

      GetPage(
          name: AppRoutes.trainerWallet,
          page: () {
            sl<AnalyticService>().screenView(name: 'trainer_wallet');
            return const TrainerWalletScreen();
          },
          binding: TrainerWalletBinding()),
      GetPage(
          name: AppRoutes.trainerSearchResultSceen,
          page: () {
            sl<AnalyticService>().screenView(name: 'trainer_search_result');
            return const TrainerSearchResultScreen();
          },
          binding: TrainerSearchResultBinding()),

    ];
  }
}
