 

import 'package:fitness_storm/Model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TraineeProfileInfoController extends GetxController {
  final RxBool _isMale = false.obs;
  final RxBool _isFemale = false.obs;
  final RxBool _isHome = false.obs;
  final RxBool _isGym = false.obs;
  final RxBool _isBeginner = false.obs;
  final RxBool _isIntermediate = false.obs;
  final RxBool _isProfessional = false.obs;
  final RxBool _isLoseWeight = false.obs;
  final RxBool _isBuildMuscle = false.obs;
  final RxBool _isStayFit = false.obs;

  bool get isMale => _isMale.value;

  bool get isFemale => _isFemale.value;

  bool get isHome => _isHome.value;

  bool get isGym => _isGym.value;

  bool get isBeginner => _isBeginner.value;

  bool get isIntermediate => _isIntermediate.value;

  bool get isProfessional => _isProfessional.value;

  bool get isLoseWeight => _isLoseWeight.value;

  bool get isBuildMuscle => _isBuildMuscle.value;

  bool get isStayFit => _isStayFit.value;

  set isMale(value) => _isMale.value = value;

  set isFemale(value) => _isFemale.value = value;

  set isHome(value) => _isHome.value = value;

  set isGym(value) => _isGym.value = value;

  set isBeginner(value) => _isBeginner.value = value;

  set isIntermediate(value) => _isIntermediate.value = value;

  set isProfessional(value) => _isProfessional.value = value;

  set isLoseWeight(value) => _isLoseWeight.value = value;

  set isBuildMuscle(value) => _isBuildMuscle.value = value;

  set isStayFit(value) => _isStayFit.value = value;

  late final UserProfile userProfile;
  String? userGender;
  String? userWorkoutLocation;
  String? trainingLevel;
  String? trainingGoal;
  TextEditingController dateinput =
      TextEditingController(text: 'DD / MM / YYYY');

  @override
  void onInit() {
    userProfile = Get.arguments;
   //log(userProfile.gender!);
   //log(userProfile.fitnessSurvey!.preferredWorkoutLocationId!);
    initUserGender();
    initPreferredWorkoutLocation();
    initTrainingLevel();
    initTrainingGoal();
    super.onInit();
  }

  initUserGender() {
    if (userProfile.gender == 'male' ||
        userProfile.gender == '' ||
        userProfile.gender == null) {
      isMale = true;
      userGender = 'male';
    } else {
      isFemale = true;
      userGender = 'female';
    }
  }

  initPreferredWorkoutLocation() {
    if (userProfile.fitnessSurvey == null ||
        userProfile.fitnessSurvey!.preferredWorkoutLocationId == 'gym') {
      isGym = true;
      userWorkoutLocation = 'gym';
    } else {
      isHome = true;
      userWorkoutLocation = 'home';
    }
  }

  initTrainingLevel() {
    if (userProfile.fitnessSurvey == null ||
        userProfile.fitnessSurvey!.trainingLevelId == 'Beginner') {
      isBeginner = true;
      trainingLevel = 'Beginner';
    } else if (userProfile.fitnessSurvey!.trainingLevelId == 'Intermediate') {
      isIntermediate = true;
      trainingLevel = 'Intermediate';
    } else {
      isProfessional = true;
      trainingLevel = 'Advanced';
    }
  }

  initTrainingGoal() {
    if (userProfile.fitnessSurvey == null ||
        userProfile.fitnessSurvey!.trainingGoal == 'Lose Weight') {
      isLoseWeight = true;
      trainingGoal = 'Lose Weight';
    } else if (userProfile.fitnessSurvey!.trainingGoal == 'Build muscle') {
      isBuildMuscle = true;
      trainingGoal = 'Build muscle';
    } else {
      isStayFit = true;
      trainingGoal = 'Stay fit';
    }
  }

  onDatePickerTap() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
     //log(pickedDate.toString());
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
     //log(formattedDate);
      dateinput.text = formattedDate;
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
