import 'package:fitness_storm/Screen/Splash/splash_binding.dart';
import 'package:fitness_storm/Screen/Splash/splash_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_bindings.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/YourTrainer/your_trainer_binding.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/YourTrainer/your_trainer_screen.dart';
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
import 'package:get/get.dart';

import '../../core/injection/injection_container.dart';
import '../../core/util/firebase_analytics_service.dart';
import '../../features/fire_chat/rooms_screen.dart';

part './app_routes.dart';

class AppPages {
  List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () {
          sl<FirebaseAnalyticService>().screenView(name: 'splash');
          return const Splash();
        },
        binding: SplashBinding(),
      ),
      GetPage(
          name: AppRoutes.mainHome,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'main_home');
            return MainHomeScreen();
          },
          binding: MainHomeBinding()),
      GetPage(
          name: AppRoutes.planOverview,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'plan_overview');
            return const PlanOverviewScreen();
          },
          binding: PlanOverviewBinding()),

      GetPage(
          name: AppRoutes.trendingPlanScreen,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'trending_plan');
            return const TrendingPlansScreen();
          },
          binding: TrendingPlanBinding()),
      GetPage(
          name: AppRoutes.featuredPlamScreen,
          page: () {
            sl<FirebaseAnalyticService>()
                .screenView(name: 'featured_plan_creen');
            return const FeaturedPlanScreen();
          },
          binding: FeaturedPlanBinding()),
      GetPage(
          name: AppRoutes.yourTrainerScreen,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'your_trainer');
            return const YourTrainersScreen();
          },
          binding: YourTrainerBinding()),

      // GetPage(
      //     name: AppRoutes.training,
      //     page: () {
      //       sl<FirebaseAnalyticService>().screenView(name: 'training');
      //       return const TrainingScreen();
      //     },
      //     binding: TrainingBinding()),
      GetPage(
          name: AppRoutes.userTraining,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'user_training');
            return const UserTrainingScreen();
          },
          binding: UserTrainingBinding()),
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
            sl<FirebaseAnalyticService>().screenView(name: 'subscription');
            return const SubscriptionScreen();
          },
          binding: SubscriptionBinding()),
      GetPage(
          name: AppRoutes.searchResultSceen,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'searchResult');
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
            sl<FirebaseAnalyticService>().screenView(name: 'my_payment');
            return MyPaymentScreen();
          },
          binding: MyPaymentBinding()),
      GetPage(
        name: AppRoutes.chatScreen,
        page: () {
          sl<FirebaseAnalyticService>().screenView(name: 'chat');
          return const RoomsScreen();
        },
      ),
      GetPage(
          name: AppRoutes.trainerHomePage,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'trainer_home_page');
            return TrainerMainHomeScreen();
          },
          binding: TrainerMainHomeBinding()),
      GetPage(
        name: AppRoutes.trainerProfileOverview,
        page: () {
          sl<FirebaseAnalyticService>()
              .screenView(name: 'trainer_profile_overview');
          return const ProfileTrainerPage();
        },
      ),
      GetPage(
          name: AppRoutes.trainerPlans,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'trainer_plans');
            return const TrainerPlansScreen();
          },
          binding: TrainerPlansBinding()),
      GetPage(
          name: AppRoutes.trainerWallet,
          page: () {
            sl<FirebaseAnalyticService>().screenView(name: 'trainer_wallet');
            return const TrainerWalletScreen();
          },
          binding: TrainerWalletBinding()),
      GetPage(
          name: AppRoutes.trainerSearchResultSceen,
          page: () {
            sl<FirebaseAnalyticService>()
                .screenView(name: 'trainer_search_result');
            return const TrainerSearchResultScreen();
          },
          binding: TrainerSearchResultBinding()),
      GetPage(
          name: AppRoutes.trainerTrainerOverviewScreen,
          page: () {
            sl<FirebaseAnalyticService>()
                .screenView(name: 'trainer_trainer_overview');
            return const TrainerTrainerOverviewScreen();
          },
          binding: TrainerTrainerOverviewBinding()),




    ];
  }


}
