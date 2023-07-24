import 'dart:developer';

import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Model/exercise.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Data/Repositories/exercise_repository.dart';

class TrainingController extends GetxController {
  late String dayId;
  final ScrollController scrollController = ScrollController();

  final RxMap<int, dynamic> _checkboxController = <int, dynamic>{}.obs;
  final RxList<bool> _currentChecks = <bool>[].obs;
  final RxInt _currentIndex = 0.obs;
  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  final RxList<Exercises> _exercises = <Exercises>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _videoId = ''.obs;

  @override
  Future<void> onInit() async {
    dayId = Get.arguments[0];
    //TODO Remove Unused parameter
    // String workoutId = Get.arguments[1];
    exercises = Get.arguments[2];
    currentChecks = List.filled(50, false, growable: true);
    for (int i = 0; i < exercises.length; i++) {
      checkboxController[i] =
          List.filled(exercises[i].setCount!, false, growable: true);
    }
    super.onInit();
  }

  List<Exercises> get exercises => _exercises;

  bool get isLoading => _isLoading.value;

  int get currentIndex => _currentIndex.value;

  Map<int, dynamic> get checkboxController => _checkboxController;

  List<bool> get currentChecks => _currentChecks;

  set exercises(value) => _exercises.value = value;

  set isLoading(value) => _isLoading.value = value;

  set currentIndex(value) => _currentIndex.value = value;

  set videoId(value) => _videoId.value = value;

  set checkboxController(value) => _checkboxController.value = value;

  set currentChecks(value) => _currentChecks.value = value;

  onItemFocused(int index) {
    currentIndex = index;
    update();
  }

  double? getPercentage(int set) {
    int number = 0;
    for (int i = 0; i < set; i++) {
      if (currentChecks[i]) number++;
    }
    if (number == 0) return 0;
    return number / exercises[currentIndex].setCount!;
  }

  onChangeChecks(bool? value, int index) {
   //log(value.toString());
    if (index == 0) {
      currentChecks[index] = true;
      return;
    }
    if (currentChecks[index - 1]) currentChecks[index] = true;
    update();
  }

  changePage(int sets) async {
   //log('changes');
    // int cnt = currentChecks.where((item) => item == true).length;
    int cnt = 0;
    for (int i = 0; i < sets; i++) {
      if (currentChecks[i]) cnt++;
    }
    if (cnt == sets) {
      if (currentIndex + 1 == exercises.length) {
       //log('ssssssss');
        Utils.openLoadingDialog();
        ApiResult apiResult = await _exerciseRepository.completeDay(dayId);
        if (apiResult.type == ApiResultType.success) {
          Get.back();
          Get.back();
          Utils.openSnackBar(
            title: 'Congrats'.tr,
          );
        } else {
          Get.back();
          Utils.openSnackBar(title: apiResult.message!);
        }
      } else {
        scrollController.animateTo((currentIndex + 1) * Get.width,
            duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
        currentChecks = List.filled(
            exercises[currentIndex + 1].setCount!, false,
            growable: true);
        currentIndex++;
      }
    }
  }

// @override
// void onClose() {
//   scrollController.dispose();
//   super.onClose();
// }
}
