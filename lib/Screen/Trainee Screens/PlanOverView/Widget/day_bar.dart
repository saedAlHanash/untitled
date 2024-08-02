import 'dart:io';

import 'package:fitness_storm/features/plans/bloc/plan_workout_cubit/plan_workout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'day_bar_widget.dart';

class DayBar extends StatelessWidget {
  const DayBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanWorkoutsCubit, PlanWorkoutsInitial>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: Get.height / 30),
          width: Get.width,
          height: Platform.isAndroid ? Get.height / 8 : Get.height / 9,
          color: Get.theme.primaryColor,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.result.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                    onTap: () {
                      if (state.result[i].key.currentState?.context == null) {
                        return;
                      }
                      Scrollable.ensureVisible(
                        (state.result[i].key.currentState?.context)!,
                        duration: const Duration(seconds: 1),
                      );
                    },
                    child: DayBarWidget(i));
              }),
        );
      },
    );
  }
}
