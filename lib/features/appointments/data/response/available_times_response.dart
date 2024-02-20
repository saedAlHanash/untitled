import 'package:fitness_storm/core/extensions/extensions.dart';

class AvailableTimesResponse {
  AvailableTimesResponse({
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
  });

  final List<AvailableTime> thursday;
  final List<AvailableTime> friday;
  final List<AvailableTime> saturday;
  final List<AvailableTime> sunday;
  final List<AvailableTime> monday;
  final List<AvailableTime> tuesday;
  final List<AvailableTime> wednesday;

  List<AvailableTime> get getAllTimes {
    final List<AvailableTime> list = [];

    for (var e in thursday) {
      list.add(e);
    }
    for (var e in friday) {
      list.add(e);
    }
    for (var e in saturday) {
      list.add(e);
    }
    for (var e in sunday) {
      list.add(e);
    }
    for (var e in monday) {
      list.add(e);
    }
    for (var e in tuesday) {
      list.add(e);
    }
    for (var e in wednesday) {
      list.add(e);
    }

    return list;
  }

  factory AvailableTimesResponse.fromJson(Map<String, dynamic> json) {
    return AvailableTimesResponse(
      thursday: json["Thursday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Thursday"]!.map((x) => AvailableTime.fromJson(x))),
      friday: json["Friday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Friday"]!.map((x) => AvailableTime.fromJson(x))),
      saturday: json["Saturday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Saturday"]!.map((x) => AvailableTime.fromJson(x))),
      sunday: json["Sunday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Sunday"]!.map((x) => AvailableTime.fromJson(x))),
      monday: json["Monday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Monday"]!.map((x) => AvailableTime.fromJson(x))),
      tuesday: json["Tuesday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Tuesday"]!.map((x) => AvailableTime.fromJson(x))),
      wednesday: json["Wednesday"] == null
          ? []
          : List<AvailableTime>.from(
              json["Wednesday"]!.map((x) => AvailableTime.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Thursday": thursday.map((x) => x.toJson()).toList(),
        "Friday": friday.map((x) => x.toJson()).toList(),
        "Saturday": saturday.map((x) => x.toJson()).toList(),
        "Sunday": sunday.map((x) => x.toJson()).toList(),
        "Monday": monday.map((x) => x.toJson()).toList(),
        "Tuesday": tuesday.map((x) => x.toJson()).toList(),
        "Wednesday": wednesday.map((x) => x.toJson()).toList(),
      };
}

class AvailableTime {
  AvailableTime({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  final int id;
  final DateTime? startTime;
  final DateTime? endTime;

  factory AvailableTime.fromJson(Map<String, dynamic> json) {
    return AvailableTime(
      id: (json["id"] ?? "").toString().tryParseOrZeroInt,
      startTime: DateTime.tryParse(json["start_time"] ?? "")?.fixTimeZone,
      endTime: DateTime.tryParse(json["end_time"] ?? "")?.fixTimeZone,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
      };
}
