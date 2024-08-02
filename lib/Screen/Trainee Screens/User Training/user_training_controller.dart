// import 'dart:async';
//
// import 'package:fitness_storm/Data/Api/api_result.dart';
// import 'package:fitness_storm/Data/Repositories/exercise_repository.dart';
// import 'package:fitness_storm/Model/exercise.dart';
// import 'package:fitness_storm/Utils/utils.dart';
// import 'package:fitness_storm/features/training/data/response/exercises_response.dart';
// import 'package:fitness_storm/features/training/data/response/exercises_response.dart';
// import 'package:fitness_storm/features/training/data/response/exercises_response.dart';
// import 'package:fitness_storm/features/training/data/response/exercises_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// import '../../../Utils/protact_screen_service.dart';
// import 'change_video_cubit/change_video_cubit.dart';
//
// class UserTrainingController extends GetxController {
//   late int break_for_set = 0;
//   late int count = 0;
//   late int countLoop = 1;
//   late String dayId;
//
//   late bool isCircular;
//   late String nameWorkout;
//   late double totalTimeToSetOrBreak = 0;
//   late String type = "zumba";
//   late String workoutId;
//   bool complete = false;
//
//   bool get isZumba => type.toLowerCase() == 'zumba';
//
//   final RxList<bool> _completedExercises = <bool>[].obs;
//   final Rx<Exercise> _currentExercise = Exercises().obs;
//   final RxInt _currentIndex = 0.obs;
//   final RxInt _currentSet = 1.obs;
//   final ExerciseRepository _exerciseRepository = ExerciseRepository();
//   final RxList<Exercise> _exercises = <Exercise>[].obs;
//   final RxBool _isBreak = false.obs;
//   final RxBool _isLoading = false.obs;
//
//   final RxBool _isRest = false.obs;
//   late final RxDouble _progress = 0.0.obs;
//   final RxInt _start = 0.obs;
//   final RxList<int> _trainingSets = <int>[].obs;
//
//   @override
//   void onClose() async {
//     ProtectScreenService().stopProtect();
//     super.onClose();
//   }
//
//   @override
//   Future<void> onInit() async {
//     nameWorkout = Get.arguments[1];
//     workoutId = Get.arguments[2];
//     dayId = Get.arguments[3];
//     isCircular = Get.arguments[4];
//     type = Get.arguments[5];
//     count = Get.arguments[6];
//     break_for_set = Get.arguments[7];
//     complete = Get.arguments[8];
//
//     isLoading = true;
//     exercises = await _exerciseRepository.getExercise(workoutId);
//     completedExercises = List.generate(exercises.length, (index) => false);
//     _initSetsList();
//     currentIndex = 0;
//     currentExercise = exercises[currentIndex];
//     isLoading = false;
//
//     ProtectScreenService().startProtect(Get.context);
//
//     super.onInit();
//   }
//
//   List<Exercise> get exercises => _exercises;
//
//   // PodPlayerController get videoController => _videoController.value;
//
//   bool get isLoading => _isLoading.value;
//
//   int get currentIndex => _currentIndex.value;
//
//   int get currentSet => _currentSet.value;
//
//   bool get isRest => _isRest.value;
//
//   double get progress => _progress.value;
//
//   bool get isBreak => _isBreak.value;
//
//   Exercises get currentExercise => _currentExercise.value;
//
//   int get startTime => _start.value;
//
//   List<int> get trainingSets => _trainingSets;
//
//   List<bool> get completedExercises => _completedExercises.value;
//
//   set exercises(value) => _exercises.value = value;
//
//   set progress(value) => _progress.value = value;
//
//   set isLoading(value) => _isLoading.value = value;
//
//
//
//   set currentIndex(value) => _currentIndex.value = value;
//
//   set currentSet(value) => _currentSet.value = value;
//
//   set isRest(value) => _isRest.value = value;
//
//   set isBreak(value) => _isBreak.value = value;
//
//   set currentExercise(value) {
//     Get.context!.read<ChangeVideoCubit>().changeVideo();
//     _currentExercise.value = value;
//   }
//
//   set startTime(value) => _start.value = value;
//
//   set trainingSets(value) => _trainingSets.value = value;
//
//   set completedExercises(value) => _completedExercises.value = value;
//
//   double getPercentage() {
//     return totalTimeToSetOrBreak == 0
//         ? 0
//         : (totalTimeToSetOrBreak - startTime) / totalTimeToSetOrBreak;
//   }
//
//   void startRestTimer(bool isSecondBased) async {
//     isRest = true;
//     if (isSecondBased) {
//       isBreak = false;
//       startTimer(currentExercise.repetitions![currentSet - 1].count!, () async {
//         if (type == "Loop Exercise") {
//           isBreak = true;
//           startTimer(currentExercise.repetitions![currentSet - 1].restSeconds!);
//         } else {
//           if (type != "Zumba") {
//             if (currentIndex < 0 || (currentIndex + 1 == exercises.length)) {
//               completedExercises[currentIndex] = true;
//               countLoop++;
//
//               if (isEnd()) {
//                 await completeDay();
//               } else {
//                 isBreak = true;
//                 currentSet++;
//                 startTimer(break_for_set, () {
//                   _exercises.refresh();
//                   // _currentSet.refresh();
//                   _currentExercise.refresh();
//                   _currentIndex.refresh();
//                   currentIndex = 0;
//
//                   currentExercise = exercises[currentIndex];
//                   completedExercises =
//                       List.generate(exercises.length, (index) => false);
//                   isRest = false;
//                   // startNextExercise();
//                 });
//               }
//             } else {
//               startNextExercise();
//             }
//           }
//         }
//       });
//     } else {
//       if (type == "Loop Exercise") {
//         isBreak = true;
//         startTimer(currentExercise.repetitions![currentSet - 1].restSeconds!);
//       } else {
//         if (type != "Zumba") {
//           if (currentIndex < 0 || (currentIndex + 1 == exercises.length)) {
//             completedExercises[currentIndex] = true;
//             countLoop++;
//             if (isEnd()) {
//               await completeDay();
//             } else {
//               isBreak = true;
//               currentSet++;
//               startTimer(break_for_set, () {
//                 _exercises.refresh();
//                 // _currentSet.refresh();
//                 _currentExercise.refresh();
//                 _currentIndex.refresh();
//                 currentIndex = 0;
//                 currentExercise = exercises[currentIndex];
//                 completedExercises =
//                     List.generate(exercises.length, (index) => false);
//                 isRest = false;
//                 // startNextExercise();
//               });
//             }
//           } else {
//             startNextExercise();
//           }
//         }
//       }
//     }
//   }
//
//   bool checkLoopExercise() {
//     for (int i = 0; i < exercises.length; i++) {
//       if (exercises[i].setCount != trainingSets[i]) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   bool checkLoopAll() {
//     if (countLoop <= count) {
//       return false;
//     }
//     return true;
//   }
//
//   bool isEnd() {
//     switch (type) {
//       case "Loop Exercise":
//         {
//           return checkLoopExercise();
//         }
//       case "Loop All":
//         {
//           return checkLoopAll();
//         }
//       default:
//         {
//           return false;
//         }
//     }
//   }
//
//   Future<void> startNextCircularExercise() async {
//     if (isEnd()) {
//       await completeDay();
//     } else {
//       completedExercises[currentIndex] = true;
//       if (isEnd()) {
//         await completeDay();
//       }
//       currentIndex++;
//       if (currentIndex <= completedExercises.length - 1) {
//         if (!completedExercises[currentIndex]) {
//           currentExercise = exercises[currentIndex];
//         } else {
//           currentIndex =
//               completedExercises.indexWhere((element) => element == false);
//           currentExercise = exercises[currentIndex];
//         }
//       } else {
//         currentIndex =
//             completedExercises.indexWhere((element) => element == false);
//         if (currentIndex != -1) {
//           currentExercise = exercises[currentIndex];
//         }
//       }
//       _exercises.refresh();
//       _currentExercise.refresh();
//       _currentIndex.refresh();
//       _currentExercise.refresh();
//     }
//   }
//
//   Future<void> startNextDefaultExercise() async {
//     if (completedExercises.indexWhere((element) => element == false) == -1) {
//       await completeDay();
//     }
//     if (currentSet == currentExercise.setCount) {
//       completedExercises[currentIndex] = true;
//       if (completedExercises.indexWhere((element) => element == false) == -1) {
//         await completeDay();
//       }
//       currentIndex++;
//       if (currentIndex < completedExercises.length) {
//         if (!completedExercises[currentIndex]) {
//           currentExercise = exercises[currentIndex];
//         } else {
//           currentIndex =
//               completedExercises.indexWhere((element) => element == false);
//           currentExercise = exercises[currentIndex];
//         }
//       } else {
//         currentIndex =
//             completedExercises.indexWhere((element) => element == false);
//         currentExercise = exercises[currentIndex];
//       }
//       currentSet = 1;
//       _exercises.refresh();
//       _currentSet.refresh();
//       _currentExercise.refresh();
//       _currentIndex.refresh();
//       isRest = false;
//     } else {
//       currentSet++;
//     }
//     _currentExercise.refresh();
//     isRest = false;
//   }
//
//   changeExercise(int index) async {
//  Get.context!.read<ChangeVideoCubit>().changeVideo();
//     update();
//     _currentExercise.value = exercises[index];
//     _currentIndex.value = index;
//     _currentSet.refresh();
//     _currentExercise.refresh();
//     _currentIndex.refresh();
//     _exercises.refresh();
//     startTime = 0;
//     isRest = false;
//
//   }
//
//   void startNextExercise() {
//     if (isCircular) {
//       startNextCircularExercise();
//     } else {
//       startNextDefaultExercise();
//     }
//   }
//
//   void startTimer(int seconds, [VoidCallback? callback]) {
//     startTime = seconds;
//     totalTimeToSetOrBreak = seconds.toDouble();
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (startTime == 0) {
//           timer.cancel();
//           if (callback != null) {
//             callback();
//           } else {
//             startNextExercise();
//           }
//         } else {
//           startTime--;
//         }
//       },
//     ).obs;
//   }
//
//   completeDay() async {
//     Utils.openLoadingDialog();
//     ApiResult apiResult = await _exerciseRepository.completeDay(dayId);
//     if (apiResult.type == ApiResultType.success) {
//       Get.back();
//       Get.back();
//       Utils.openSnackBar(title: 'Congrats'.tr, textColor: Colors.white);
//     } else {
//       Get.back();
//       Utils.openSnackBar(title: apiResult.message!);
//     }
//   }
//
//   _initSetsList() {
//     for (int i = 0; i < exercises.length; i++) {
//       _trainingSets.add(0);
//     }
//   }
// }
