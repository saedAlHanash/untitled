 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';

import '../../Utils/utils.dart';
import '../Api/api_result.dart';

class ExerciseRepository {



  Future<ApiResult> startDay(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    Map<String, dynamic> data = {"day_based_workout_id": id, 'started': true};
    ApiResult apiResult = await Methods.post(
        url: TRAINEEURLS.completeDay, options: option, data: data);
    return apiResult;
  }
}
