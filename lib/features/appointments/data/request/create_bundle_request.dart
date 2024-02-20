import 'package:fitness_storm/features/appointments/data/response/available_times_response.dart';

class CreateBundleRequest {
  CreateBundleRequest({
    this.bundleId,
  });

  num? bundleId;
  final List<AvailableTime> timeIds = [];

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
