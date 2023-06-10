import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';

import '../../Utils/utils.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class AuthRepository {
  Future<ApiResult> traineeSignup(
      String email, String password, String name) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {
      "email": email,
      "password": password,
      "name": name,
    };
    return await Methods.post(
        url: TRAINEEURLS.traineeSignup, options: option, data: data);
  }

  Future<ApiResult> traineeLogin(String email, String password) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {"email": email, "password": password};
    return await Methods.post(
        url: TRAINEEURLS.traineeLogin, options: option, data: data);
  }

  Future<ApiResult> traineeTakeAuthenticationByGoogleAccount(
      String email, String username, String providerId) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {
      "email": email,
      "provider_id": providerId,
      "name": username,
    };
    return await Methods.post(
        url: TRAINEEURLS.traineeAuthenticationByGoogleAccount,
        options: option,
        data: data);
  }

  Future<ApiResult> submitUserOTP(String otpNumber) async {
    Options option = Utils.getOptions(accept: true, withToken: true);
    Map<String, String> data = {
      "confirmation_code": otpNumber,
    };
    return await Methods.post(
        url: TRAINEEURLS.submitUserOTP, options: option, data: data);
  }

  Future<ApiResult> resendOTP() async {
    Options option = Utils.getOptions(accept: true, withToken: true);

    return await Methods.post(url: TRAINEEURLS.submitUserOTP, options: option);
  }

  Future<ApiResult> refreshUserToken() async {
    Options option = Utils.getOptions(accept: true, withRefreshToken: true);
    return await Methods.post(
        url: TRAINEEURLS.refeshUserToken, options: option);
  }

  Future<ApiResult> refreshTrainerToken() async {
    Options option = Utils.getOptions(accept: true, withRefreshToken: true);
    return await Methods.post(
        url: TRAINERURLS.refreshTrainerToken, options: option);
  }

  Future<ApiResult> traineeLogout() async {
    Options option = Utils.getOptions(accept: true, withRefreshToken: true);
    return await Methods.post(url: TRAINEEURLS.traineeLogout, options: option);
  }

  Future<ApiResult> forgetPassword(String email) async {
    Options option = Utils.getOptions(accept: true);
    Map<String, String> data = {"email": email};
    return await Methods.post(
        url: TRAINEEURLS.forgetPassword, options: option, data: data);
  }

  Future<ApiResult> submitForgetPasswordOTP(
      String email, String otpNumber) async {
    Options option = Utils.getOptions(accept: true, withToken: true);
    Map<String, String> data = {
      'email': email,
      "code": otpNumber,
    };
    return await Methods.post(
        url: TRAINEEURLS.submitForgetPasswordOtp, options: option, data: data);
  }

  Future<ApiResult> setNewPassword(String password, String token) async {
    Options option = Utils.getOptions(accept: true, customToken: token);
    Map<String, String> data = {
      'password': password,
    };
    var c = await Methods.post(
        url: TRAINEEURLS.setNewPassword, options: option, data: data);
    return c;
  }

  Future<ApiResult> submitUserSurvey(
    String weight,
    String height,
    String trainingGoal,
    String workoutLocation,
    String trainingLevel,
    String weeklyExercise,
    String dailtExercise,
    String gender,
  ) async {
    Options option = Utils.getOptions(accept: true, withToken: true);
    Map<String, String> data = {
      'weight': weight,
      'height': height,
      'training_goal': trainingGoal,
      'preferred_workout_location': workoutLocation,
      'training_level': trainingLevel,
      'weekly_exercise': weeklyExercise,
      'daily_exercise': dailtExercise,
      "gender": gender,
    };
    return await Methods.post(
        url: TRAINEEURLS.survey, options: option, data: data);
  }

  Future<ApiResult> saveFCM(String token) async {
    Options option = Utils.getOptions(accept: true, withToken: true);
    Map<String, String> map = {'device_token': token};
    return await Methods.post(
        url: TRAINEEURLS.saveFcm, options: option, data: map);
  }
}
