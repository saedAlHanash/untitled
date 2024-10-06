import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/ContinueTraining/continue_training_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'package:fitness_storm/core/app/app_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../../../features/plans/ui/widget/plans_list_widget.dart';
import '../../../generated/l10n.dart';
import '../../Trainer Screens/Trainer HomeScreen/HomeSreenWidget/list_header.dart';
import 'HomeSreenWidget/FeaturedPlanWidget/featured_plan_widget.dart';
import 'HomeSreenWidget/TrendingPlanWidget/trending_plan_widget.dart';
import 'HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox(
              height: Get.height,
              child: const Center(child: CircularProgressIndicator.adaptive()))
          : RefreshWidget(
              isLoading: controller.isLoading.value,
              onRefresh: () async {

                controller.isLoading.value = true;
                await controller.fillContinueTrainingPlans();

                Get.back();
                controller.trendingPlans.value =
                    await controller.planRepository.getTrendingPlan({});
                controller.yourTrainer.value =
                    await controller.trainerRepository.getYourTrainer(1);

                controller.isLoading.value = false;
              },
              child: BlocListener<RefreshHomePlanCubit, RefreshHomePlanState>(
                listener: (context, state) {
                  controller.reInitial();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ContinueTrainingWidget(),
                      TrendingPlanWidget(),
                      ListHeader(
                        headerTitle: S.of(context).ourPlans,
                        seeAllFunction: () => startPlansPage(),
                      ),
                      PlansListWidget(),
                      YourTrainersWidget(),
                      .1.sh.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
