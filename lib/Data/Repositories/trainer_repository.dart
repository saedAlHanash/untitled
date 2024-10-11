import 'package:dio/dio.dart';

import '../../Utils/dependency_injection.dart';
import '../../Utils/utils.dart';
import '../../core/models/plan_model.dart';
import '../../features/trainer/data/response/trainer.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class TrainerRepository {

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

}
