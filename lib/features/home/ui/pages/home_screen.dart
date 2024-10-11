import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/home/ui/widget/app_bar_home.dart';
import 'package:fitness_storm/features/trainer/ui/widget/your_trainer_item.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../../plans/bloc/trending_plans_cubit/trending_plans_cubit.dart';
import '../../../plans/ui/widget/plans_list_widget.dart';
import '../../../plans/ui/widget/trending_plan_item.dart';
import '../widget/list_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome,
      body: RefreshWidget(
        isLoading: false,
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ContinueTrainingWidget(),
              _YourTrainers(),
              PlansListWidget(),
              _TrendingPlanWidget(),
              .1.sh.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _YourTrainers extends StatelessWidget {
  const _YourTrainers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListHeader(
          headerTitle: S.of(context).privateSessions,
          seeAllFunction: () => startTrainersPage(),
        ),
        SizedBox(
          height: .3.sh,
          child: BlocBuilder<TrainersCubit, TrainersInitial>(
            builder: (context, state) {
              final list =
                  state.result.where((e) => e.numberOfPrivateHours > 0).take(4).toList();
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => startTrainerPage(context, list[i].id),
                    child: YourTrainersItem(trainer: list[i]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ContinueTrainingWidget extends StatelessWidget {
  const _ContinueTrainingWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivePlansCubit, ActivePlansInitial>(
      builder: (context, state) {
        final plans = state.result;
        if (plans.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            DrawableText(
              text: S.of(context).continueTraining,
              color: AppColorManager.mainColor,
              matchParent: true,
              padding: const EdgeInsets.all(10.0).r,
              size: 18.0.sp,
            ),
            SizedBox(
              width: 1.0.sw,
              height: 0.2.sh,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                itemBuilder: (_, i) {
                  final item = plans[i];
                  return InkWell(
                    onTap: () {
                      startPlanPage(item.id.toString());
                    },
                    child: SizedBox(
                      width: 1.0.sw,
                      height: 0.2.sh,
                      child: Stack(
                        children: [
                          ImageMultiType(
                            url: item.image,
                            fit: BoxFit.cover,
                            width: 1.0.sw,
                          ),
                          Positioned(
                            top: 10.0.h,
                            left: 10.0.w,
                            child: item.progressWidget,
                          ),
                          Positioned(
                            top: 45.0.h,
                            left: 10.0.w,
                            child: item.dayWidget,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TrendingPlanWidget extends StatelessWidget {
  const _TrendingPlanWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingPlansCubit, TrendingPlansInitial>(
      builder: (context, state) {
        if (state.result.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            ListHeader(
              headerTitle: S.of(context).trendingPlan,
              seeAllFunction: () {
                Get.toNamed(AppRoutes.trendingPlanScreen, arguments: state.result);
              },
            ),
            SizedBox(
              width: 1.0.sw,
              height: 0.3.sh,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.result.length,
                itemBuilder: (_, i) {
                  final plan = state.result[i];
                  return GestureDetector(
                    onTap: () => startPlanPage(plan.id.toString()),
                    child: TrendingPlanItem(plan: state.result[i]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
