import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';

import '../../../Model/trainer.dart';

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

  Future<List<AppointmentModel>> coachMakeVideoCall() async {
    final options = Utils.getOptions(withToken: true, all: true);
    final result =
        await Methods.getJson(url: TRAINEEURLS.bookedAppointments, options: options);

    if (result == null) return [];
    if (result.statusCode == 200) {
      return BookedAppointments.fromJson(result.data).data;
    }
    return [];

    // if (result.type == ApiResultType.success) {
    //   if (result.data.isEmpty) {
    //     return [];
    //   }
    //   return result.data;
    // } else {
    //   return [];
    // }
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

class BookedAppointments {
  BookedAppointments({
    required this.data,
  });

  final List<AppointmentModel> data;

  factory BookedAppointments.fromJson(Map<String, dynamic> json) {
    return BookedAppointments(
      data: json["data"] == null
          ? []
          : List<AppointmentModel>.from(
              json["data"]!.map((x) => AppointmentModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class AppointmentModel {
  AppointmentModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.videoCallToken,
    required this.status,
    required this.price,
    required this.trainer,
  });

  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String videoCallToken;
  final String status;
  final dynamic price;
  final TrainerAppointments trainer;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json["id"] ?? 0,
      startTime: DateTime.tryParse(json["start_time"] ?? "") ?? DateTime(2030),
      endTime: DateTime.tryParse(json["end_time"] ?? "") ?? DateTime(2030),
      videoCallToken: json["video_call_token"] ?? "",
      status: json["status"] ?? "",
      price: json["price"],
      trainer: TrainerAppointments.fromJson(json["trainer"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "video_call_token": videoCallToken,
        "status": status,
        "price": price,
        "trainer": trainer.toJson(),
      };
}
class TrainerAppointments {
  TrainerAppointments({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TrainerAppointments.fromJson(Map<String, dynamic> json) {
    return TrainerAppointments(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

