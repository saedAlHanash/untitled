import 'package:fitness_storm/Data/Repositories/exercise_repository.dart';
import 'package:fitness_storm/Model/exercise.dart';
import 'package:get/get.dart';

import '../../../Data/Api/api_result.dart';
import '../../../Utils/Routes/app_pages.dart';
import '../../../Utils/utils.dart';

class DayOverviewController extends GetxController {
  late String dayId;
  final RxList<Exercises> exercises = <Exercises>[].obs;
  RxBool isLoading = false.obs;
  late String workoutId;

  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  final RxBool _isActivated = false.obs;
  final RxInt _totalMinut = 0.obs;
  final RxString _videoPreview = ''.obs;
  final RxString _workoutName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    workoutId = Get.arguments[0];
    workoutName = Get.arguments[1];
    videoPreview = Get.arguments[2];
    totalMinut = Get.arguments[3];
    dayId = Get.arguments[4];
    isActivated = Get.arguments[5];

    exercises.value = await _exerciseRepository.getExercise(workoutId);
    // for (var element in exercises) {
    //   ////   print(element.repetitions);
    // }
    isLoading.value = false;
  }

  String get videoPreview => _videoPreview.value;

  String get workoutName => _workoutName.value;

  int get totalMinut => _totalMinut.value;

  bool get isActivated => _isActivated.value;

  set videoPreview(value) => _videoPreview.value = value;

  set workoutName(value) => _workoutName.value = value;

  set totalMinut(value) => _totalMinut.value = value;

  set isActivated(value) => _isActivated.value = value;

  startTraining() async {
    Utils.openLoadingDialog();
    ApiResult apiResult = await _exerciseRepository.startDay(dayId);
    if (apiResult.type == ApiResultType.success) {
      Get.back();
      Get.toNamed(AppRoutes.loadingStartTrainginScreen,
          arguments: [dayId, workoutId, exercises]);
    } else {
      Get.back();
      Utils.openSnackBar(title: apiResult.message!);
    }
  }
}
