import 'package:fitness_storm/features/appointments/data/response/available_times_response.dart';

import '../../../../core/models/booked_appointments.dart';
import '../response/bundles_response.dart';

class CreateBundleRequest {
  CreateBundleRequest({
    this.bundle,
  });

  Bundle? bundle;
  String? code;
  final List<Appointment> timeIds = [];


  Map<String, dynamic> toJson() => {
        "bundleId": bundle?.id,
        "code": code,
        "timeIds": timeIds.map((x) => x.id).toList(),
      };
}
