import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Model/private_session.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';

import '../../../core/models/plan_model.dart';

class TrainerTrainerRepository {
  Future<List<TrainerModel>> getYourTrainer(int pageNumber) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: TRAINERURLS.getYourTrainer, options: option, data: {'page': pageNumber});
    if (result.type == ApiResultType.success) {
      List<TrainerModel> trainers = [];
      for (var element in result.data) {
        trainers.add(TrainerModel.fromJson(element));
      }
      return trainers;
    } else {
      throw result.message!;
    }
  }

  Future<List<Wallet>> getTrainerPrivateSession(int pageNumber) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: TRAINERURLS.getTrainerPrivateSession,
        options: option,
        data: {'page': pageNumber});
    if (result.type == ApiResultType.success) {
      List<Wallet> sessions = [];
      for (var element in result.data) {
        sessions.add(Wallet.fromJson(element));
      }
      return sessions;
    } else {
      throw result.message!;
    }
  }

  Future<ApiResult> getSearchTrainer(Map<String, dynamic>? queryParameters) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url: TRAINERURLS.getYourTrainer, options: option, data: queryParameters);
  }

  Future<List<PlanModel>> getTrainerPlans() async {
    final option = Utils.getOptions(withToken: true, all: true);
    final result = await Methods.get(url: TRAINERURLS.trainerPlans, options: option);

    if (result.type == ApiResultType.success) {
      List<PlanModel> plans = [];
      for (var element in result.data) {
        plans.add(PlanModel.fromJson(element));
      }
      return plans;
    } else {
      throw result.message!;
    }
  }
}
