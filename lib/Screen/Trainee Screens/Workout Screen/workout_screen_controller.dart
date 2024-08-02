import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/exercise_repository.dart';
import 'package:fitness_storm/Data/Repositories/workout_repository.dart';
import 'package:fitness_storm/Model/plan_workout.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/features/plans/data/response/plan_workout_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../router/app_router.dart';
import '../User Training/user_training_controller.dart';

class WorkoutScreenController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<PlanWorkout> _workouts = <PlanWorkout>[].obs;
  final RxInt _selectedIndex = (-1).obs;

  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  late final List<GlobalKey> keys;
  final List<Widget> workoutWidgets = [];

  bool get isLoading => _isLoading.value;

  int get selectedIndex => _selectedIndex.value;

  List<PlanWorkout> get workouts => _workouts;

  set isLoading(value) => _isLoading.value = value;

  set workouts(value) => _workouts.value = value;

  set selectedIndex(value) => _selectedIndex.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    workouts.addAll(await _workoutRepository.getCurrentPlanWorkout());
    keys = List.generate(workouts.length, (i) => GlobalKey());
    createWorkoutWidget();
    isLoading = false;
  }

  // startTraining(int i) async {
  //   final workout = workouts[i];
  //   Utils.openLoadingDialog();
  //   ApiResult apiResult =
  //       await _exerciseRepository.startDay(workout.id.toString());
  //   if (apiResult.type == ApiResultType.success ||
  //       apiResult.statusCode == 402) {
  //     Get.back();
  //     Get.back();
  //     // Get.delete<UserTrainingController>();
  //     startTrainingPage(workout, apiResult.statusCode == 402);
  //
  //     // Get.toNamed(AppRoutes.userTraining, arguments: [
  //     //   i + 1,
  //     //   workout.name,
  //     //   workout.workoutId,
  //     //   workout.id!,
  //     //   (workout.type == 'Loop All') ? true : false,
  //     //   workout.type!,
  //     //   workout.count,
  //     //   workout.break_after_set,
  //     //   apiResult.statusCode == 402
  //     // ]);
  //   } else {
  //     Get.back();
  //     Utils.openSnackBar(title: apiResult.message!);
  //   }
  // }

  createWorkoutWidget() {
    return;
    // for (int i = 0; i < workouts.length; i++) {
    //   workoutWidgets.add(
    //     GestureDetector(
    //       onTap: () => startTraining(i),
    //       child: DayWidget(
    //         key: keys[i],
    //         imageUrl: workout.image!,
    //         dayNumber: (i + 1).toString(),
    //         totalMinutes: workout.totalMinutes!,
    //         exercises: workout.exercises!,
    //         type: workout.type!,
    //       ),
    //     ),
    //   );
    // }
  }
}
