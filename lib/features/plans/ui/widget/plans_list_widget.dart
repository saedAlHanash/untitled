import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/widgets/card_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Screen/Trainer Screens/Trainer HomeScreen/HomeSreenWidget/FeaturedPlanWidget/featured_plan_item.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/plans_cubit/plans_cubit.dart';

class PlansListWidget extends StatefulWidget {
  const PlansListWidget({super.key});

  @override
  State<PlansListWidget> createState() => _PlansListWidgetState();
}

class _PlansListWidgetState extends State<PlansListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlansCubit, PlansInitial>(
      builder: (context, state) {
        if (state.loading) return MyStyle.loadingWidget();
        return CardSlider(
          height: 0.4.sh,
          images: state.result.take(3).map((e) => FeaturedPlanItem(plan: e)).toList(),
        );

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return FeaturedPlanItem(plan: state.result[i]);
          },
          itemCount: state.result.length,
        );
      },
    );
  }
}
