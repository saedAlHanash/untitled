import 'package:dio/dio.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';

import '../../Model/subscribed_plan.dart';
import '../../Utils/utils.dart';
import '../../core/app/app_provider.dart';
import '../../core/injection/injection_container.dart';
import '../../core/models/plan_model.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class PlanRepository {
  // Future<void> getThumbnail() async {
  //   Options option = Utils.getOptions(all: true);
  //   ApiResult result = await Methods.get(
  //       url: 'http://vimeo.com/api/v2/video/739932290.xml', options: option);
  // }

  Future<ApiResult> addToBookmark(String id) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    sl<AnalyticService>().addToWishlist(id: id);
    return await Methods.post(
        url: TRAINEEURLS.addToBookmark(id), options: options);
  }

  Future<ApiResult> getMyPlans() async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.post(url: TRAINERURLS.getMyPlans, options: options);
  }

  Future<ApiResult> removeFromBookmark(String id) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.post(
        url: TRAINEEURLS.removeFromBookMarked(id), options: options);
  }

  Future<List<Plan>> getAllBookmarked() async {
    Options options = Utils.getOptions(withToken: true, all: true);
    ApiResult result =
        await Methods.get(url: TRAINEEURLS.getBookmarkPlan, options: options);
    if (result.type == ApiResultType.success) {
      List<Plan> plans = [];
      for (var element in result.data) {
        plans.add(Plan.fromJson(element));
      }
      return plans;
    } else {
      throw result.message!;
    }
  }

  Future<ApiResult> getSearchPlans(
      int pageNumber, Map<String, dynamic> queryParameters) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url: '${TRAINEEURLS.plans}$pageNumber',
        options: options,
        data: queryParameters);
  }

  Future<List<SubscribedPlan>> getContinueTrainingPlan() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: TRAINEEURLS.getUserSubscribedPlans, options: option);

      if (result.type == ApiResultType.success) {
        List<SubscribedPlan> plans = [];
        for (var element in result.data) {
          plans.add(SubscribedPlan.fromJson(element));
        }
        return plans;
      } else {
        Utils.openSnackBar(message: result.message!);
        return [];
      }
    } catch (error) {
      Utils.openSnackBar(message: error.toString());
      return [];
    }
  }

  Future<List<Plan>> getTrendingPlan(
      Map<String, dynamic>? queryParameter) async {
    //log(queryParameter.toString());
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: TRAINEEURLS.getTrendingPlns,
          options: option,
          data: queryParameter);

      if (result.type == ApiResultType.success) {
        //log(result.data.toString());
        List<Plan> plans = [];
        for (var element in result.data) {
          plans.add(Plan.fromJson(element));
        }
        return plans;
      } else {
        Utils.openSnackBar(message: result.message!);
        throw result.message!;
      }
    } catch (error) {
      Utils.openSnackBar(message: error.toString());
      // throw error;
      return [];
    }
  }

  Future<List<Plan>> getFeaturedgPlan(int pageNumber,
      {Map<String, dynamic>? queryParameter}) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: '${TRAINEEURLS.getOurPlans}?page=$pageNumber',
          options: option,
          data: queryParameter);
      if (result.type == ApiResultType.success) {
        List<Plan> plans = [];
        for (var element in result.data) {
          plans.add(Plan.fromJson(element));
        }
        return plans;
      } else {
        Utils.openSnackBar(message: result.message!);
        return [];
      }
    } catch (error) {
      Utils.openSnackBar(message: error.toString());
      return [];
      // throw error;
    }
  }

  Future<Plan> getPlanOverview(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    String url = '';
    if (AppProvider.isTrainer) {
      url = '${TRAINERURLS.getPlanById}$id';
    } else {
      url = '${TRAINEEURLS.getPlanById}$id';
    }

    ApiResult result = await Methods.get(url: url, options: option);

    var x = Plan.fromJson(result.data);

    return x;
  }

  Future<ApiResult> filterPlans(String trainingLocationType,
      String trainingType, String trainingLevel) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url:
            '${TRAINEEURLS.filter}?training_location_type=$trainingLocationType&training_type=$trainingType&training_level=$trainingLevel',
        options: option);
  }

  Future<List<Plan>> searchPlans(String query) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    List<Plan> plans = [];
    final response = await Methods.get(
        url: '${TRAINEEURLS.filter}?name=$query', options: option);
    if (response.type == ApiResultType.success) {
      response.data.forEach((elemant) {
        plans.add(Plan.fromJson(elemant));
      });
    }
    return plans;
  }

  Future<List<TrainingType>> getAllTrainingType() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    List<TrainingType> types = [];
    final response =
        await Methods.get(url: TRAINEEURLS.getTrainingType, options: option);
    if (response.type == ApiResultType.success) {
      response.data.forEach((elemant) {
        types.add(TrainingType.fromJson(elemant));
      });
    }
    return types;
  }

// Future<> getPlanExercise(String id) async {
//   Options option = Utils.getOptions(all: true);

//  //log('sssssssssssssssssssssss');
//   ////log(result.data);
//   ApiResult result = await Methods.get(
//       url: '${URLS.getExerciesByWorkoutId}$id/exercises', options: option);
//   if (result.type == ApiResultType.success) {
//     List<Exercise> exercises = [];
//     for (var element in result.data) {
//       exercises.add(Exercise.fromJson(element));
//     }
//     return exercises;
//   } else {
//     throw result.message!;
//   }
// }
}
