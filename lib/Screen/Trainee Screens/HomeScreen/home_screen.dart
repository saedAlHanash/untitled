import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/ContinueTraining/continue_training_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../core/app/app_provider.dart';
import '../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../features/fire_chat/rooms_bloc/rooms_cubit.dart';
import '../../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../../features/plans/ui/widget/plans_list_widget.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../Trainer Screens/Trainer HomeScreen/HomeSreenWidget/list_header.dart';
import 'HomeSreenWidget/TrendingPlanWidget/trending_plan_widget.dart';
import 'HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 0,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? SizedBox(
                height: Get.height,
                child: const Center(child: CircularProgressIndicator.adaptive()),
              )
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
                        YourTrainersWidget(),
                        PlansListWidget(),
                        TrendingPlanWidget(),
                        .1.sh.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
