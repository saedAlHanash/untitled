import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';

import '../../Model/exercise.dart';
import '../../Utils/storage_controller.dart';
import '../../Utils/utils.dart';
import '../Api/api_result.dart';

class ExerciseRepository {
  Future<List<Exercises>> getExercise(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    List<Exercises> exercise = [];
    String url = '';
    if ((StorageController().userType == 'trainer')) {
      url = '${TRAINERURLS.getExerciesByWorkoutId}$id/exercises';
    } else {
      url = '${TRAINEEURLS.getExerciesByWorkoutId}$id/exercises';
    }
    ApiResult response = await Methods.get(url: url, options: option);
   //log(response.data.toString());
    response.data.forEach((element) {
      exercise.add(Exercises.fromJson(element));
    });
    return exercise;
  }

  Future<ApiResult> completeDay(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    Map<String, dynamic> data = {"day_based_workout_id": id, 'started': false};
    return await Methods.post(
        url: TRAINEEURLS.completeDay, options: option, data: data);
  }

  Future<ApiResult> startDay(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    Map<String, dynamic> data = {"day_based_workout_id": id, 'started': true};
    ApiResult apiResult = await Methods.post(
        url: TRAINEEURLS.completeDay, options: option, data: data);
    return apiResult;
  }
}
