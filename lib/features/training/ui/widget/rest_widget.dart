
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../bloc/temp_cubit/training_cubit.dart';

class RestWidget extends StatefulWidget {
  final num seconds;
  final bool isBreak;

  const RestWidget({required this.seconds, required this.isBreak, super.key});

  @override
  State<RestWidget> createState() => _RestWidgetState();
}

class _RestWidgetState extends State<RestWidget> {
  TrainingCubit get cubit => context.read<TrainingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingInitial>(
      builder: (context, state) {
        return SizedBox(
          height: Get.height / 8,
          child: LinearPercentIndicator(
            percent: cubit.getPercentage(),
            lineHeight: double.infinity,
            backgroundColor: !widget.isBreak
                ? Get.theme.colorScheme.secondary
                : Get.theme.primaryColor,
            progressColor: widget.isBreak
                ? const Color(0xFF9F86C1)
                : Get.theme.colorScheme.secondary.withOpacity(0.4),
            padding: const EdgeInsets.all(0),
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                const SizedBox(),
                !cubit.isBreak
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "let's_go".tr,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'you_can_do_it_this_set'.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'great_job!'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'take_a_break'.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cubit.state.result.type == "Loop Exercise"
                          ? 'before_the_next_exercise'.tr
                          : 'before_the_next_set'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  formatTimePerSeconds(cubit.startTime),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatTimePerSeconds(num seconds) {
    return '${(Duration(seconds: seconds.toInt()))}'.split('.')[0].padLeft(8, '0');
  }

  String formatTimePerMinutes(num minutes) {
    return '${(Duration(minutes: minutes.toInt()))}'.split('.')[0].padLeft(8, '0');
  }
}
