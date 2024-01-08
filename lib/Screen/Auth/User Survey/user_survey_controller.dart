import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserSurveyController extends GetxController {
  Rx<TextEditingController> weightController = TextEditingController().obs;
  TextEditingController hightController = TextEditingController();
  TextEditingController daysPerWeekController = TextEditingController();
  TextEditingController hoursPerDayController = TextEditingController();
  final RxBool _isGym = false.obs;
  final RxBool _isHome = false.obs;
  final RxBool _isBeginner = false.obs;
  final RxBool _isIntermediate = false.obs;
  final RxBool _isProfessional = false.obs;
  final RxBool _isLoseweight = false.obs;
  final RxBool _isBuildMuscle = false.obs;
  final RxBool _isStayFit = false.obs;
  final RxString _workoutLocation = ''.obs;
  final RxString _trainingGoal = ''.obs;
  final RxString _trainingLevel = ''.obs;
  final RxBool _isMale = false.obs;
  final RxBool _isFemale = false.obs;

  bool get isGym => _isGym.value;

  bool get isMale => _isMale.value;

  bool get isFemale => _isFemale.value;

  set isMale(value) => _isMale.value = value;

  set isFemale(value) => _isFemale.value = value;

  bool get isHome => _isHome.value;

  bool get isBeginner => _isBeginner.value;

  bool get isIntermediate => _isIntermediate.value;

  bool get isProfessional => _isProfessional.value;

  bool get isLoseweight => _isLoseweight.value;

  bool get isBuildMuscle => _isBuildMuscle.value;

  bool get isStayFit => _isStayFit.value;

  String get workoutLocation => _workoutLocation.value;

  String get trainingGoal => _trainingGoal.value;

  String get trainingLevel => _trainingLevel.value;

  set isGym(value) => _isGym.value = value;

  set isHome(value) => _isHome.value = value;

  set isBeginner(value) => _isBeginner.value = value;

  set isIntermediate(value) => _isIntermediate.value = value;

  set isProfessional(value) => _isProfessional.value = value;

  set isLoseweight(value) => _isLoseweight.value = value;

  set isBuildMuscle(value) => _isBuildMuscle.value = value;

  set isStayFit(value) => _isStayFit.value = value;

  set workoutLocation(value) => _workoutLocation.value = value;

  set trainingGoal(value) => _trainingGoal.value = value;

  set trainingLevel(value) => _trainingLevel.value = value;

  onSkip() {
    Get.toNamed(AppRoutes.mainHome);
  }

  onSubmit() async {
    final authRepository = AuthRepository();
    if (weightController.value.text.isEmpty) {
      Utils.openSnackBar(title: 'weight_field_is_require'.tr);
      return;
    } else if (hightController.text.isEmpty) {
      Utils.openSnackBar(title: 'hight_field_is_require'.tr);
      return;
    } else if (daysPerWeekController.text.isEmpty) {
      Utils.openSnackBar(title: 'how_many_you_training_field_is_require'.tr);
      return;
    } else if (hoursPerDayController.text.isEmpty) {
      Utils.openSnackBar(title: 'how_many_you_training_field_is_require'.tr);
      return;
    } else if (workoutLocation.isEmpty) {
      Utils.openSnackBar(title: 'workout_location_field_is_require'.tr);
      return;
    } else if (trainingLevel.isEmpty) {
      Utils.openSnackBar(title: 'training_level_field_is_require'.tr);
      return;
    } else if (trainingGoal.isEmpty) {
      Utils.openSnackBar(title: 'training_goal_field_is_require'.tr);
      return;
    }
    String gender = '';
    if (isMale) {
      gender = 'male';
    } else if (isFemale) {
      gender = 'female';
    }
    Utils.openLoadingDialog();
    ApiResult result = await authRepository.submitUserSurvey(
      weightController.value.text,
      hightController.text,
      trainingGoal,
      workoutLocation,
      trainingLevel,
      daysPerWeekController.text,
      hoursPerDayController.text,
      gender,
    );
      Utils.closeDialog();
      Get.offAllNamed(AppRoutes.mainHome);
    // if (result.type == ApiResultType.success) {
    // } else {
    //   Utils.closeDialog();
    //   Utils.openSnackBar(title: result.message!);
    // }
  }
}
