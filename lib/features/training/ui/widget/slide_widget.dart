import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/temp_cubit/training_cubit.dart';

class SlidWidget extends StatefulWidget {
  final num setNumber;
  final num repetationNumber;

  const SlidWidget({
    required this.setNumber,
    required this.repetationNumber,
    super.key,
  });

  @override
  State<SlidWidget> createState() => _SlidWidgetState();
}

class _SlidWidgetState extends State<SlidWidget> {
  TrainingCubit get cubit => context.read<TrainingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingInitial>(
      builder: (context, state) {
        return Container(
          height: Get.height / 8,
          alignment: Alignment.bottomCenter,
          color: Get.theme.colorScheme.secondary,
          child: Dismissible(
            key: UniqueKey(),

            onDismissed: (direction) {
              cubit.startRestTimer(cubit.currentExercise.secondBased);
            },

            //cubit.isRest = true,
            direction: DismissDirection.horizontal,
            child: Container(
              color: Get.theme.colorScheme.secondary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        '${'set'.tr} ${cubit.currentSet}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'repeat_this_exercise'.tr,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            _getRepeatText(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  !cubit.currentExercise.secondBased
                      ? Text('slide_to_start_the_next_set'.tr,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white))
                      : Text('slide_to_start_the_timer_for_this_set'.tr,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getRepeatText() {
    String reps = cubit.currentExercise.repetitions[cubit.currentSet - 1].count
        .toString();
    if (cubit.currentExercise.secondBased) {
      if (int.parse(reps) > 3 && int.parse(reps) < 9) {
        reps += " ${'seconds'.tr}";
      } else {
        reps += 'second'.tr;
      }
    } else {
      if (int.parse(reps) > 3 && int.parse(reps) < 9) {
        reps += " ${'times'.tr}";
      } else {
        reps += 'time'.tr;
      }
    }
    return reps;
  }
}
