 

import 'package:dio/dio.dart';

import '../../Utils/utils.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class TraineeRepository {

  Future<ApiResult> getUserProfile() async {
    Options options = Utils.getOptions(withToken: true, all: true);

    try {
      return await Methods.get(
          url: TRAINEEURLS.getUserProfile, options: options);
    } catch (error) {
     //log('\x1B[31merror');
      rethrow;
    }
  }




}
