import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../Utils/Routes/app_pages.dart';
import '../../../../plans/bloc/free_plans_cubit/free_plans_cubit.dart';
import '../../../../plans/ui/widget/trending_plan_item.dart';
import '../../widget/list_header.dart';

class FreePlans extends StatelessWidget {
  const FreePlans({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreePlansCubit, FreePlansInitial>(
      builder: (context, state) {
        if (state.result.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            ListHeader(
              headerTitle: S.of(context).freePlans,
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
