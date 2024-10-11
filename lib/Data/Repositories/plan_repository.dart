import 'package:dio/dio.dart';

import '../../Utils/utils.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class PlanRepository {

  Future<ApiResult> getSearchPlans(
      int pageNumber, Map<String, dynamic> queryParameters) async {
    Options options = Utils.getOptions(withToken: true, all: true);
    return await Methods.get(
        url: '${TRAINEEURLS.plans}$pageNumber',
        options: options,
        data: queryParameters);
  }


}
