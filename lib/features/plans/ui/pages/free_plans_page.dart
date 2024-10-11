import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/free_plans_cubit/free_plans_cubit.dart';
import '../widget/item_plan.dart';

class TrendingPlansScreen extends StatelessWidget {
  const TrendingPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).freePlans),
      body: BlocBuilder<FreePlansCubit, FreePlansInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () {
              context.read<FreePlansCubit>().getTrendingPlans(newData: true);
            },
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, i) => Divider(),
              itemCount: state.result.length,
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
              itemBuilder: (_, i) => ItemPlan(plan: state.result[i]),
            ),
          );
        },
      ),
    );
  }
}
