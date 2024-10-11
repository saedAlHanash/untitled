import 'package:fitness_storm/core/widgets/card_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../router/app_router.dart';
import '../list_header.dart';
import '../../../../plans/bloc/plans_cubit/plans_cubit.dart';
import '../../../../plans/ui/widget/featured_plan_item.dart';

class PaidPlans extends StatefulWidget {
  const PaidPlans({super.key});

  @override
  State<PaidPlans> createState() => _PaidPlansState();
}

class _PaidPlansState extends State<PaidPlans> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlansCubit, PlansInitial>(
      builder: (context, state) {
        return Column(
          children: [
            ListHeader(
              headerTitle: S.of(context).paidPlans,
              seeAllFunction: () => startPlansPage(),
            ),
            CardSlider(
              height: 0.4.sh,
              images: state.result.take(3).map((e) => FeaturedPlanItem(plan: e)).toList(),
            ),
          ],
        );
      },
    );
  }
}
