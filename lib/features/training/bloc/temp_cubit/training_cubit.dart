import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Utils/utils.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../plans/data/response/plan_workout_response.dart';
import '../../data/response/exercises_response.dart';
import '../exercise_cubit/exercise_cubit.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingInitial> {
  TrainingCubit() : super(TrainingInitial.initial());

  double totalTimeToSetOrBreak = 0;

  num startTime = 0;
  int currentIndex = 0;
  int currentSet = 1;
  bool complete = false;
  bool isRest = false;
  bool isBreak = false;
  List<Exercise> exercises = [];
  List<bool> completedExercises = [];
  List<int> trainingSets = [];

  get isZumba => state.result.type.toLowerCase() == 'zumba';
  int countLoop = 1;

  Exercise currentExercise = Exercise.fromJson({});

  void initial(PlanWorkout planWorkout, bool complete) async {
    this.complete = complete;
    emit(state.copyWith(result: planWorkout, statuses: CubitStatuses.loading));

    exercises = await ctx!
        .read<ExercisesCubit>()
        .getExercisesAsync(id: planWorkout.workoutId);

    completedExercises = List.generate(exercises.length, (index) => false);

    initSetsList();

    currentIndex = 0;
    try {
      currentExercise = exercises[currentIndex];
    } catch (e) {
      loggerObject.e(e);
    }

    emit(state.copyWith(statuses: CubitStatuses.done));
  }

  Future<Pair<bool?, String?>> _completeDay() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.completeDay,
      body: {"day_based_workout_id": state.result.id, 'started': false},
    );

    if (response.statusCode.success) {
      Utils.openSnackBar(title: S.of(ctx!).congrats, textColor: Colors.white);
      return Pair(true, null);
    } else {
      final error = response.getPairError;
      Utils.openSnackBar(title: error.second);
      return error;
    }
  }

  bool get canPop => complete || AppProvider.isTrainer;

  void onPop(bool didPop) async {
    if (didPop) return;
    NoteMessage.showCheckDialog(
      ctx!,
      text: S.of(ctx!).didYouFinishYourTraining,
      textButton: S.of(ctx!).done,
      textCancelButton: S.of(ctx!).iLlComeBackLater,
      image: '',
      onConfirm: (b) {
        if (b) _completeDay();
        Future(() => Navigator.pop(ctx!));
      },
    );
  }

  double getPercentage() {
    return totalTimeToSetOrBreak == 0
        ? 0
        : (totalTimeToSetOrBreak - startTime) / totalTimeToSetOrBreak;
  }

  void startRestTimer(bool isSecondBased) async {
    isRest = true;
    if (isSecondBased) {
      isBreak = false;
      startTimer(currentExercise.repetitions[currentSet - 1].count, () async {
        if (state.result.type == "Loop Exercise") {
          isBreak = true;
          startTimer(currentExercise.repetitions[currentSet - 1].restSeconds);
        } else {
          if (state.result.type != "Zumba") {
            if (currentIndex < 0 || (currentIndex + 1 == exercises.length)) {
              completedExercises[currentIndex] = true;
              countLoop++;

              if (isEnd()) {
                await _completeDay();
              } else {
                isBreak = true;
                currentSet++;
                startTimer(state.result.workoutBreak, () {
                  currentIndex = 0;

                  currentExercise = exercises[currentIndex];
                  completedExercises =
                      List.generate(exercises.length, (index) => false);
                  isRest = false;
                  // startNextExercise();
                });
              }
            } else {
              startNextExercise();
            }
          }
        }
      });
    } else {
      if (state.result.type == "Loop Exercise") {
        isBreak = true;
        startTimer(currentExercise.repetitions[currentSet - 1].restSeconds);
      } else {
        if (state.result.type != "Zumba") {
          if (currentIndex < 0 || (currentIndex + 1 == exercises.length)) {
            completedExercises[currentIndex] = true;
            countLoop++;
            if (isEnd()) {
              await _completeDay();
            } else {
              isBreak = true;
              currentSet++;
              startTimer(state.result.workoutBreak, () {
                currentIndex = 0;
                currentExercise = exercises[currentIndex];
                completedExercises =
                    List.generate(exercises.length, (index) => false);
                isRest = false;
                // startNextExercise();
              });
            }
          } else {
            startNextExercise();
          }
        }
      }
    }
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  bool checkLoopExercise() {
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i].setCount != trainingSets[i]) {
        return false;
      }
    }
    return true;
  }

  bool checkLoopAll() {
    if (countLoop <= state.result.count) {
      return false;
    }
    return true;
  }

  bool isEnd() {
    switch (state.result.type) {
      case "Loop Exercise":
        {
          return checkLoopExercise();
        }
      case "Loop All":
        {
          return checkLoopAll();
        }
      default:
        {
          return false;
        }
    }
  }

  Future<void> startNextCircularExercise() async {
    if (isEnd()) {
      await _completeDay();
    } else {
      completedExercises[currentIndex] = true;
      if (isEnd()) {
        await _completeDay();
      }
      currentIndex++;
      if (currentIndex <= completedExercises.length - 1) {
        if (!completedExercises[currentIndex]) {
          currentExercise = exercises[currentIndex];
        } else {
          currentIndex =
              completedExercises.indexWhere((element) => element == false);
          currentExercise = exercises[currentIndex];
        }
      } else {
        currentIndex =
            completedExercises.indexWhere((element) => element == false);
        if (currentIndex != -1) {
          currentExercise = exercises[currentIndex];
        }
      }
    }
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  Future<void> startNextDefaultExercise() async {
    if (completedExercises.indexWhere((element) => element == false) == -1) {
      await _completeDay();
    }
    if (currentSet == currentExercise.setCount) {
      completedExercises[currentIndex] = true;
      if (completedExercises.indexWhere((element) => element == false) == -1) {
        await _completeDay();
      }
      currentIndex++;
      if (currentIndex < completedExercises.length) {
        if (!completedExercises[currentIndex]) {
          currentExercise = exercises[currentIndex];
        } else {
          currentIndex =
              completedExercises.indexWhere((element) => element == false);
          currentExercise = exercises[currentIndex];
        }
      } else {
        currentIndex =
            completedExercises.indexWhere((element) => element == false);
        currentExercise = exercises[currentIndex];
      }
      currentSet = 1;

      isRest = false;
    } else {
      currentSet++;
    }
    isRest = false;
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  changeExercise(int index) async {
    currentExercise = exercises[index];
    currentIndex = index;
    startTime = 0;
    isRest = false;
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  void startNextExercise() {
    if (state.result.type == 'Loop All') {
      startNextCircularExercise();
    } else {
      startNextDefaultExercise();
    }
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  void startTimer(num seconds, [VoidCallback? callback]) {
    startTime = seconds;
    totalTimeToSetOrBreak = seconds.toDouble();
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTime == 0) {
          timer.cancel();
          if (callback != null) {
            callback();
          } else {
            startNextExercise();
          }
        } else {
          startTime--;
        }
      },
    );
    emit(state.copyWith(changeModifier: state.changeModifier + 1));
  }

  initSetsList() {
    for (int i = 0; i < exercises.length; i++) {
      trainingSets.add(0);
    }
  }
}
