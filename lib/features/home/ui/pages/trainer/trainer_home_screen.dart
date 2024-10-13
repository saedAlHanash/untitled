import 'package:fitness_storm/features/plans/bloc/trainer_my_plans_cubit/trainer_my_plans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/widgets/not_found_widget.dart';
import '../../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../plans/ui/widget/item_plan.dart';
import '../../widget/app_bar_home.dart';

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.lightGray,
      appBar: appBarHome,
      body: BlocBuilder<TrainerMyPlansCubit, TrainerMyPlansInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () async {
              context.read<TrainerMyPlansCubit>().getTrainerMyPlans(newData: true);
            },
            child: state.result.isEmpty
                ? NotFoundWidget()
                : ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, i) {
                      return ItemPlan(plan: state.result[i]);
                    },
                  ),
          );
        },
      ),
    );
  }
}
