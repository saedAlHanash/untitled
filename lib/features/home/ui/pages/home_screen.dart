import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/home/ui/widget/app_bar_home.dart';
import 'package:fitness_storm/features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../../plans/bloc/free_plans_cubit/free_plans_cubit.dart';
import '../../../plans/bloc/plans_cubit/plans_cubit.dart';
import '../widget/home_screen/continue_training.dart';
import '../widget/home_screen/free_plans.dart';
import '../widget/home_screen/paid_plans.dart';
import '../widget/home_screen/your_trainers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.lightGray,
      appBar: appBarHome,
      body: RefreshWidget(
        isLoading: context.watch<ActivePlansCubit>().state.loading,
        onRefresh: () async {
          context.read<TrainersCubit>().getTrainers(newData: true);
          context.read<ActivePlansCubit>().getActivePlans(newData: true);
          context.read<PlansCubit>().getPlans(newData: true);
          context.read<FreePlansCubit>().getTrendingPlans(newData: true);
          context.read<NotificationsCubit>().getNotifications(newData: true);
        },
        child: ListView(
          children: [
            if (!AppProvider.isGuest) ContinueTrainingWidget(),
            if (!AppProvider.isGuest) Divider(),
            PaidPlans(),
            Divider(),
            FreePlans(),
            Divider(),
            YourTrainers(),
            .1.sh.verticalSpace,
          ],
        ),
      ),
    );
  }
}


