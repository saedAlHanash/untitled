import 'package:fitness_storm/features/appointments/data/response/available_times_response.dart';

import '../../../../core/models/booked_appointments.dart';

class CreateBundleRequest {
  CreateBundleRequest({
    this.bundleId,
  });

  num? bundleId;
  final List<Appointment> timeIds = [];

  factory CreateBundleRequest.fromJson(Map<String, dynamic> json) {
    return CreateBundleRequest(
      bundleId: json["bundleId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "bundleId": bundleId,
        "timeIds": timeIds.map((x) => x.id).toList(),
      };
}
