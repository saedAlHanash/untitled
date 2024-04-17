 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Model/about_us.dart';
import 'package:fitness_storm/Model/progress_model.dart';

import '../../Utils/Constants/constants.dart';
import '../../Utils/utils.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class TraineeRepository {
  Future<ApiResult> subscribePlan({required String planId}) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    Map<String, String> data = {
      "plan_id": planId,
    };
    return await Methods.post(
        url: TRAINEEURLS.subscribeToPlan, options: option, data: data);
  }

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

  Future<ApiResult> changePassword(String newPassword) async {
    Options options = Utils.getOptions(withToken: true, all: true);

    try {
      return await Methods.post(
        url: TRAINEEURLS.setNewPassword,
        options: options,
        data: {'password': newPassword},
      );
    } catch (error) {
     //log('\x1B[31merror');
      rethrow;
    }
  }

  Future<ApiResult> deleteAccount() async {
    Options options = Utils.getOptions(withToken: true, all: false);
    try {
      return await Methods.delete(
        url: "${Constants.userBaseUrl}/profile",
        options: options,
      );
    } catch (error) {
     //log('\x1B[31merror');
      rethrow;
    }
  }

  Future<ApiResult> editProfile(Map<String, dynamic> json) async {
    Options options = Utils.getOptions(withToken: true, all: false);
    try {
      return await Methods.post(
        url: "${Constants.userBaseUrl}/profile",
        data: json,
        options: options,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ProgressModel>> getTraineeProgress(String from,
      {String? to}) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      String url = '';
      if (to == null) {
        url = '${TRAINEEURLS.getTraineeProgress}?from=$from';
      } else {
        url = '${TRAINEEURLS.getTraineeProgress}?from=$from&to=$to';
      }
      ApiResult result = await Methods.get(options: option, url: url);
      if (result.type == ApiResultType.success) {
        List<ProgressModel> progress = [];

        var uu = result.data;

        for (var element in uu.values.toList()) {
          String key = element.keys.elementAt(0);

          ProgressModel progressModel =
              ProgressModel(type: key, logUser: LogUser.fromJson(element[key]));
          progress.add(progressModel);
        }
        return progress;
      }
    } catch (error) {
      
    }
    return [];
  }

  Future<AboutUsModel> about_us() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.get(
          url: TRAINEEURLS.getTraineeProgress, options: option);
      if (result.type == ApiResultType.success) {
        AboutUsModel aboutUsModel = AboutUsModel(text: result.data);
        return aboutUsModel;
      }
    } catch (error) {
      
    }
    return AboutUsModel();
  }
}
