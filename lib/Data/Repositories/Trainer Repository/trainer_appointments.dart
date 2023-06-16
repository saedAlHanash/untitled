import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';

class TrainerAppointmentsRepository {
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

  Future<dynamic> getTrainerAvailableTimes() async {
    Options options = Utils.getOptions(withToken: true, all: true);
    final data = {
      'is_booked': true,
      'timeZone': DateTime.now().timeZoneName,
    };
    ApiResult result = await Methods.get(
        url: TRAINERURLS.trainerAvailableTime, options: options, data: data);
    if (result.type == ApiResultType.success) {
      if (result.data.isEmpty) {
        return {};
      }
      return result.data;
    } else {
      return {};
    }
  }

  Future<dynamic> coachMakeVideoCall() async {
    final options = Utils.getOptions(withToken: true, all: true);
    final result =
        await Methods.get(url: TRAINEEURLS.bookedAppointments, options: options);

    if (result.type == ApiResultType.success) {
      if (result.data.isEmpty) {
        return [];
      }
      return result.data;
    } else {
      return [];
    }
  }

  Future<dynamic> traineeMakeVideoCall() async {
    Options options = Utils.getOptions(withToken: true, all: true);
    ApiResult result =
        await Methods.get(url: TRAINEEURLS.bookedAppointments, options: options);
    if (result.type == ApiResultType.success) {
      if (result.data.isEmpty) {
        return {};
      }
      return result.data;
    } else {
      return {};
    }
  }
}
