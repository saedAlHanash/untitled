import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../bookmarked/ui/widget/see_all_list_item.dart';
import '../bloc/trending_plans_cubit/trending_plans_cubit.dart';

class TrendingPlansScreen extends StatelessWidget {
  const TrendingPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).trendingPlan,
        // centerTitle: true,
      ),
      body: BlocBuilder<TrendingPlansCubit, TrendingPlansInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () {
              context.read<TrendingPlansCubit>().getTrendingPlans(newData: true);
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.length,
              itemBuilder: (_, i) => SeeAllListItem(plan: state.result[i]),
            ),
          );
        },
      ),
    );
  }
}
