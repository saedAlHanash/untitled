import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/exercise_repository.dart';
import 'package:fitness_storm/Data/Repositories/workout_repository.dart';
import 'package:fitness_storm/Model/plan_workout.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/Widgets/Exercise/day_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../User Training/user_training_controller.dart';

class WorkoutScreenController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<WorkoutModel> _workouts = <WorkoutModel>[].obs;
  final RxInt _selectedIndex = (-1).obs;

  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  late final List<GlobalKey> keys;
  final List<Widget> workoutWidgets = [];

  bool get isLoading => _isLoading.value;

  int get selectedIndex => _selectedIndex.value;

  List<WorkoutModel> get workouts => _workouts;

  set isLoading(value) => _isLoading.value = value;

  set workouts(value) => _workouts.value = value;

  set selectedIndex(value) => _selectedIndex.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    workouts.addAll(await _workoutRepository.getCurrentPlanWorkout());
    keys = List.generate(workouts.length, (index) => GlobalKey());
    createWorkoutWidget();
    isLoading = false;
  }

  startTraining(int index) async {
    Utils.openLoadingDialog();
    ApiResult apiResult = await _exerciseRepository.startDay(workouts[index].id!);
    if (apiResult.type == ApiResultType.success || apiResult.statusCode == 402) {

      Get.back();
      Get.back();
      Get.delete<UserTrainingController>();
      Get.toNamed(AppRoutes.userTraining, arguments: [
        index + 1,
        workouts[index].name,
        workouts[index].workoutId,
        workouts[index].id!,
        (workouts[index].type == 'Loop All') ? true : false,
        workouts[index].type!,
        workouts[index].count,
        workouts[index].break_after_set,
        apiResult.statusCode == 402
      ]);
    } else {
      Get.back();
      Utils.openSnackBar(title: apiResult.message!);
    }
  }

  createWorkoutWidget() {
    for (int i = 0; i < workouts.length; i++) {
      workoutWidgets.add(
        GestureDetector(
          onTap: () => startTraining(i),
          child: DayWidget(
            key: keys[i],
            imageUrl: workouts[i].image!,
            dayNumber: (i + 1).toString(),
            totalMinutes: workouts[i].totalMinutes!,
            exercises: workouts[i].exercises!,
            type: workouts[i].type!,
          ),
        ),
      );
    }
  }
}
