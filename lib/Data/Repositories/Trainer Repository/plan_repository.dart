 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Model/plan.dart';
import 'package:fitness_storm/Utils/utils.dart';

class TrainerPlanRepository {
  Future<List<Plan>> getTrendingPlan(
      Map<String, dynamic>? queryParameter) async {
   //log(queryParameter.toString());
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: TRAINERURLS.getTrendingPlns,
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
      throw error;
    }
  }

  Future<List<Plan>> getFeaturedgPlan(int pageNumber) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: '${TRAINERURLS.getOurPlans}?page=$pageNumber', options: option);
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

  Future<ApiResult> getSearchPlans(Map<String, dynamic> queryParameters) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url: TRAINERURLS.plans, options: options, data: queryParameters);
  }
}
