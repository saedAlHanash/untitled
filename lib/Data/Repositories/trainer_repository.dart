import 'package:dio/dio.dart';

import '../../Utils/dependency_injection.dart';
import '../../Utils/utils.dart';
import '../../core/models/plan_model.dart';
import '../../features/trainer/data/response/trainer.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class TrainerRepository {
  Future<List<TrainerModel>> getYourTrainer(int pageNumber) async {

    Options option = Utils.getOptions(withToken: true, all: true);

    ApiResult result = await Methods.get(url: TRAINEEURLS.getYourTrainer, options: option);

    if (result.type == ApiResultType.success) {
      List<TrainerModel> trainers = [];
      for (var element in result.data) {
        TrainerModel trainer = TrainerModel.fromJson(element);
        if (trainer.numberOfPrivateHours > 0) {
          trainers.add(trainer);
        }
      }
      return trainers;
    } else {
      return [];
      // throw result.message!;
    }
  }

  Future<ApiResult> getSearchTrainer(
      int pageNumber, Map<String, dynamic>? queryParameters) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    var j = await Methods.get(
        url: '$userBaseUrl/trainers?fitness_level[0]=intermediate',
        options: option,
        data: queryParameters);

    return j;
  }

  Future<TrainerModel> getTrainerById(String id) async {
    Options option = Utils.getOptions(
      withToken: true,
      all: true,
    );
    ApiResult result = await Methods.get(
        url: '${TRAINEEURLS.getTrainerById}$id', options: option);
    if (result.type == ApiResultType.success) {
      //log(result.data.toString());
      return TrainerModel.fromJson(result.data);
    } else {
      Utils.openSnackBar(message: "Work on authentication problem");
      return TrainerModel.fromJson({});
    }
  }

  Future<List<PlanModel>> getTrainerPlans(String id) async {
    Options options = Utils.getOptions(withToken: true, all: true);

    ApiResult result = await Methods.get(
        url: TRAINEEURLS.getTrainerPlans(id), options: options);
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

  Future<ApiResult> bookPrivateSession(
      String trainerTimeId, String paymentId) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    var data = <String, dynamic>{};
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
