 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Model/plan_workout.dart';

import '../../Utils/utils.dart';
import '../../core/api_manager/api_url.dart';
import '../../core/app/app_provider.dart';
import '../../features/plans/data/response/plan_workout_response.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class WorkoutRepository {
  Future<List<PlanWorkout>> getPlanWorkout(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    String url = '';
    if ( AppProvider.isTrainer) {
      url = '${TRAINERURLS.getWorkoutsByPlanId}$id/workouts';
    } else {
      url = '${TRAINEEURLS.getWorkoutsByPlanId}$id/workouts';
    }
    ApiResult result = await Methods.get(url: url, options: option);
   //log('ressss');
   //log(result.data.toString());
    if (result.type == ApiResultType.success) {
      List<PlanWorkout> workouts = [];
      result.data.forEach((element) {
        workouts.add(PlanWorkout.fromJson(element));
      });
      return workouts;
    } else {
      throw result.message!;
    }
  }

  Future<List<PlanWorkout>> getCurrentPlanWorkout() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: 'https://$baseUrl/mobile/user/currentWorkout',
        options: option);

   //log(result.data.toString());
    if (result.type == ApiResultType.success) {
      List<PlanWorkout> workouts = [];
      if (result.data != null && result.data.length != 0) {
        result.data.forEach((element) {
          workouts.add(PlanWorkout.fromJson(element));
        });
      }

      return workouts;
    } else {
      // Utils.openSnackBar(message: result.message!);
      return [];
    }
  }
}
