import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';

import '../../../core/app/app_provider.dart';
import '../../../core/models/plan_model.dart';

class TrainerPlanRepository {
  Future<List<PlanModel>> getTrendingPlan(Map<String, dynamic>? queryParameter) async {
    //log(queryParameter.toString());
    final  option = Utils.getOptions(withToken: true, all: true);
    //loggerObject.w(AppProvider.token);
    try {
      ApiResult result = await Methods.get(
        url: TRAINERURLS.getTrendingPlns,
        options: option,
        data: queryParameter,
      );
      if (result.type == ApiResultType.success) {
        List<PlanModel> plans = [];
        for (var element in result.data) {
          plans.add(PlanModel.fromJson(element));
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

  Future<List<PlanModel>> getFeaturedgPlan(int pageNumber) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: '${TRAINERURLS.getOurPlans}?page=$pageNumber', options: option);
      if (result.type == ApiResultType.success) {
        List<PlanModel> plans = [];
        for (var element in result.data) {
          plans.add(PlanModel.fromJson(element));
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
