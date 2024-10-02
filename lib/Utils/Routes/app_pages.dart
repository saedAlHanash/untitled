import 'package:fitness_storm/Screen/Splash/splash_binding.dart';
import 'package:fitness_storm/Screen/Splash/splash_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_bindings.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_bindings.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/trainer_main_home_binding.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/trainer_main_home_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Overview/trainer_overview_binding.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Overview/trainer_overview_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Plans/trainer_plans_binding.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Plans/trainer_plans_screen.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_binding.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_screen.dart';
import 'package:fitness_storm/features/profile/ui/pages/profile_trainer_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/injection/injection_container.dart';
import '../../core/util/firebase_analytics_service.dart';
import '../../features/fire_chat/rooms_bloc/rooms_cubit.dart';
import '../../features/fire_chat/rooms_screen.dart';

part './app_routes.dart';

class AppPages {
  List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () {
          sl<AnalyticService>().screenView(name: 'splash');
          return const Splash();
        },
        binding: SplashBinding(),
      ),
      GetPage(
          name: AppRoutes.mainHome,
          page: () {
            sl<AnalyticService>().screenView(name: 'main_home');
            return MainHomeScreen();
          },
          binding: MainHomeBinding()),
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
            sl<AnalyticService>().screenView(name: 'trending_plan');
            return const TrendingPlansScreen();
          },
          binding: TrendingPlanBinding()),
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
      GetPage(
          name: AppRoutes.searchResultSceen,
          page: () {
            sl<AnalyticService>().screenView(name: 'searchResult');
            return const SearchResultScreen();
          },
          binding: SearchResultBinding()),
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
          binding: MyPaymentBinding()),
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
            return TrainerMainHomeScreen();
          },
          binding: TrainerMainHomeBinding()),
      GetPage(
        name: AppRoutes.trainerProfileOverview,
        page: () {
          sl<AnalyticService>()
              .screenView(name: 'trainer_profile_overview');
          return const ProfileTrainerPage();
        },
      ),
      GetPage(
          name: AppRoutes.trainerPlans,
          page: () {
            sl<AnalyticService>().screenView(name: 'trainer_plans');
            return const TrainerPlansScreen();
          },
          binding: TrainerPlansBinding()),
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
            sl<AnalyticService>()
                .screenView(name: 'trainer_search_result');
            return const TrainerSearchResultScreen();
          },
          binding: TrainerSearchResultBinding()),
      GetPage(
          name: AppRoutes.trainerTrainerOverviewScreen,
          page: () {
            sl<AnalyticService>()
                .screenView(name: 'trainer_trainer_overview');
            return const TrainerTrainerOverviewScreen();
          },
          binding: TrainerTrainerOverviewBinding()),
    ];
  }
}
