import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../widget/item_plan.dart';
import '../../bloc/plans_cubit/plans_cubit.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S
          .of(context)
          .ourPlans),
      body: BlocBuilder<PlansCubit, PlansInitial>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: RefreshWidget(
                  isLoading: state.loading,
                  onRefresh: () {
                    context.read<PlansCubit>().getPlans(newData: true);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                        .r,
                    itemCount: state.result.length,
                    itemBuilder: (context, i) {
                      return ItemPlan(
                        plan: state.result[i],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
