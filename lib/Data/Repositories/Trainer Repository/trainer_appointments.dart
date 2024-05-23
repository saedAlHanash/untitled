import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';

import '../../../core/models/booked_appointments.dart';

class TrainerAppointmentsRepository {
  Future<dynamic> getTrainerAvailableTimes() async {
    Options options = Utils.getOptions(withToken: true, all: true);
    final data = {
      'is_booked': true,
      'timeZone': DateTime.now().timeZoneName,
    };
    final result = await Methods.get(
        url: TRAINERURLS.trainerAvailableTime, options: options, data: data);

    print(result);
    if (result.type == ApiResultType.success) {
      if (result.data.isEmpty) {
        return {};
      }
      return result.data;
    } else {
      return {};
    }
  }

  Future<List<Appointment>> coachMakeVideoCall() async {
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

  final List<Appointment> data;

  factory BookedAppointments.fromJson(Map<String, dynamic> json) {
    return BookedAppointments(
      data: json["data"] == null
          ? []
          : List<Appointment>.from(
              json["data"]!.map((x) => Appointment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}
