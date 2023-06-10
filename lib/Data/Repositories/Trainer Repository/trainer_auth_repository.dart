import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';

class TrainerAuthRepository {
  Future<ApiResult> trainerSignup(
      String email, String password, String name, String gender) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {
      "email": email,
      "password": password,
      "name": name,
      "gender": gender
    };
    return await Methods.post(
        url: TRAINERURLS.trainerSignup, options: option, data: data);
  }

  Future<ApiResult> trainerLogin(String email, String password) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {"email": email, "password": password};
    return await Methods.post(
        url: TRAINERURLS.trainerLogin, options: option, data: data);
  }

  Future<ApiResult> refreshTrainerToken() async {
    Options option = Utils.getOptions(accept: true, withRefreshToken: true);
    return await Methods.post(
        url: TRAINERURLS.refreshTrainerToken, options: option);
  }

  Future<ApiResult> trainerLogout() async {
    Options option = Utils.getOptions(accept: true, withRefreshToken: true);
    return await Methods.post(url: TRAINERURLS.logout, options: option);
  }

  Future<ApiResult> getTrainerProfile() async {
    Options options = Utils.getOptions(accept: true, withToken: true);
    return await Methods.get(url: TRAINERURLS.trainerPorile, options: options);
  }
}
