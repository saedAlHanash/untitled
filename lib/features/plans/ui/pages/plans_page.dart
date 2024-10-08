import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/Widget/featured_plan_list.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/day_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/trainer_bio.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/video_tail_widget.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/Widgets/read_more_text_widget.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../Widgets/Exercise/day_widget.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../generated/l10n.dart';
import '../../../bookmarked/ui/widget/see_all_list_item.dart';
import '../../../vimeo/ui/pages/vimeo_player.dart';
import '../../bloc/plan_cubit/plan_cubit.dart';
import '../../bloc/plan_workout_cubit/plan_workout_cubit.dart';
import '../../bloc/plans_cubit/plans_cubit.dart';
import '../../bloc/subscribe_plan_cubit/subscribe_plan_cubit.dart';

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
                      return SeeAllListItem(
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
