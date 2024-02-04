import '../../Model/trainer.dart';

class BookedAppointments {
  BookedAppointments({
    required this.data,
  });

  final List<Appointments> data;

  factory BookedAppointments.fromJson(Map<String, dynamic> json) {
    return BookedAppointments(
      data: json["data"] == null
          ? []
          : List<Appointments>.from(json["data"]!.map((x) => Appointments.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Appointments {
  Appointments({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.videoCallToken,
    required this.status,
    required this.trainer,
  });

  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String videoCallToken;
  final String status;
  final TrainerModel trainer;

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      id: json["id"] ?? 0,
      startTime: DateTime.tryParse(json["start_time"] ?? "")?? DateTime(2030),
      endTime: DateTime.tryParse(json["end_time"] ?? "")?? DateTime(2030),
      videoCallToken: json["video_call_token"] ?? "",
      status: json["status"] ?? "",
      trainer:  TrainerModel.fromJson(json["trainer"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "video_call_token": videoCallToken,
        "status": status,
        "trainer": trainer?.toJson(),
      };
}
