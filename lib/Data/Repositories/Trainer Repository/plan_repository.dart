import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';

class TrainerPlanRepository {
  Future<ApiResult> getSearchPlans(Map<String, dynamic> queryParameters) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url: TRAINERURLS.plans, options: options, data: queryParameters);
  }
}
