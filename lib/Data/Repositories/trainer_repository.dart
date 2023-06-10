import 'dart:developer';

import 'package:dio/dio.dart';

import '../../Model/plan.dart';
import '../../Model/trainer.dart';
import '../../Utils/Constants/constants.dart';
import '../../Utils/utils.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class TrainerRepository {
  Future<List<Trainer>> getYourTrainer(int pageNumber) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: '${TRAINEEURLS.getYourTrainer}$pageNumber', options: option);
    if (result.type == ApiResultType.success) {
      List<Trainer> trainers = [];
      for (var element in result.data) {
        Trainer trainer = Trainer.fromJson(element);
        if (int.parse(trainer.numberOfPrivateHours!) > 0) {
          trainers.add(trainer);
        }
      }
      return trainers;
    } else {
      throw result.message!;
    }
  }

  Future<ApiResult> getSearchTrainer(
      int pageNumber, Map<String, dynamic>? queryParameters) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    var j = await Methods.get(
        url: '${Constants.userBaseUrl}/trainers?fitness_level[0]=intermediate',
        options: option,
        data: queryParameters);
    int y;
    return j;
  }

  Future<Trainer> getTrainerById(String id) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: '${TRAINEEURLS.getTrainerById}$id', options: option);
    if (result.type == ApiResultType.success) {
      log('sssss');
      log(result.data.toString());
      return Trainer.fromJson(result.data);
    } else {
      Utils.openSnackBar(message: "Work on authentication problem");
      return Trainer();
    }
  }

  Future<List<Plan>> getTrainerPlans(String id) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    ApiResult result = await Methods.get(
        url: TRAINEEURLS.getTrainerPlans(id), options: options);
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

  Future<Map<String, dynamic>> getTrainerAvailableTimes(
      String trainerId, int year, int month, int firstDay, int lastDay) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    final data = {
      'year': year,
      'month': month,
      'first_day': firstDay,
      'last_day': lastDay,
    };
    ApiResult result = await Methods.get(
        url: TRAINEEURLS.getTrainerAvailableTime(trainerId),
        options: options,
        data: data);
    if (result.type == ApiResultType.success) {
      if (result.data.isEmpty) {
        return {};
      }
      return result.data;
    } else {
      throw result.message!;
    }
  }

  Future<ApiResult> bookPrivateSession(
      String trainerTimeId, String paymentId) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    var data = {};
    if (paymentId != "") {
      data = {
        "trainer_time_id": trainerTimeId,
        "payment_id": paymentId,
      };
    } else {
      data = {
        "trainer_time_id": trainerTimeId,
      };
    }

    ApiResult result = await Methods.post(
        url: TRAINEEURLS.bookedAppointments, data: data, options: options);
    return result;
  }
}
