
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/plan_cubit/plan_cubit.dart';

class VideoTailWidget extends StatelessWidget {
  const VideoTailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanInitial>(
      builder: (context, state) {
        return Container(
          width: Get.width,
          color: Get.theme.colorScheme.secondary,
          padding: EdgeInsets.all(Get.height / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${state.result.workoutFrequency} ${'days/week'.tr}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                '${state.result.totalWeeks}${state.result
                    .totalWeeks > 1 &&
                    state.result.totalWeeks < 10
                    ? ' ${'weeks'.tr}'
                    : ' ${'week'.tr}'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}