import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/training_exercise_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ExerciseListView extends GetWidget<UserTrainingController> {
  ExerciseListView({super.key});

  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.exercises.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async => await controller.changeExercise(index),
              child: GestureDetector(
                onTap: () async => await controller.changeExercise(index),
                child: TrainingExerciseWidget(
                  isSecondsBased: controller.exercises[index].secondsBased!,
                  reps: controller.exercises[index].repetitions!,
                  sets: controller.exercises[index].setCount!,
                  title: controller.exercises[index].name!,
                  isFinished: controller.completedExercises[index] ||
                      index == controller.currentIndex,
                  //index <= controller.currentIndex,
                  isPlaying: index ==
                      (controller.currentIndex < 0
                          ? 0
                          : controller.currentIndex),
                ),
              ),
            ),
          ),
        ));
  }
}
