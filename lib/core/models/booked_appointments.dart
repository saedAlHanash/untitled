import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

class BookedAppointments {
  BookedAppointments({required this.data});

  final List<Appointment> data;

  factory BookedAppointments.fromJson(Map<String, dynamic> json) {
    return BookedAppointments(
      data: json["data"] == null
          ? []
          : List<Appointment>.from(json["data"]!.map((x) => Appointment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Appointment {
  Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.videoCallToken,
    required this.channelId,
    required this.status,
    required this.user,
  });

  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String videoCallToken;
  final String channelId;
  final String status;
  final User user;

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["id"].toString().tryParseOrZeroInt,
      startTime:
          DateTime.tryParse(json["startAt"] ?? json["start_time"] ?? "")?.fixTimeZone ??
              DateTime(2030),
      endTime: DateTime.tryParse(json["endAt"] ?? json["end_time"] ?? "")?.fixTimeZone ??
          DateTime(2030),
      videoCallToken: json["video_call_token"] ?? "",
      channelId: json["channelId"] ?? AppProvider.isTrainer
          ? '${AppProvider.myId}'
          : '${User.fromJson(json["trainer"] ?? json["user"] ?? {}).id}',
      status: json["status"] ?? "",
      user: User.fromJson(json["trainer"] ?? json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "video_call_token": videoCallToken,
        "channelId": channelId,
        "status": status,
      };
}

class User {
  User({
    required this.id,
    required this.image,
    required this.name,
  });

  final int id;
  final String image;
  final String name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"].toString().tryParseOrZeroInt,
      image: (json["image"] ?? "").toString().fixAvatarImage,
      name: json["name"] ?? "",
    );
  }
}