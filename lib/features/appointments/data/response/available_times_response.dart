import '../../../../core/models/booked_appointments.dart';

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

  final List<Appointment> thursday;
  final List<Appointment> friday;
  final List<Appointment> saturday;
  final List<Appointment> sunday;
  final List<Appointment> monday;
  final List<Appointment> tuesday;
  final List<Appointment> wednesday;

  List<Appointment> get getAllTimes {
    final List<Appointment> list = [];

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
          : List<Appointment>.from(
              json["Thursday"]!.map((x) => Appointment.fromJson(x))),
      friday: json["Friday"] == null
          ? []
          : List<Appointment>.from(
              json["Friday"]!.map((x) => Appointment.fromJson(x))),
      saturday: json["Saturday"] == null
          ? []
          : List<Appointment>.from(
              json["Saturday"]!.map((x) => Appointment.fromJson(x))),
      sunday: json["Sunday"] == null
          ? []
          : List<Appointment>.from(
              json["Sunday"]!.map((x) => Appointment.fromJson(x))),
      monday: json["Monday"] == null
          ? []
          : List<Appointment>.from(
              json["Monday"]!.map((x) => Appointment.fromJson(x))),
      tuesday: json["Tuesday"] == null
          ? []
          : List<Appointment>.from(
              json["Tuesday"]!.map((x) => Appointment.fromJson(x))),
      wednesday: json["Wednesday"] == null
          ? []
          : List<Appointment>.from(
              json["Wednesday"]!.map((x) => Appointment.fromJson(x))),
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

class AvailableTimesResponseList {
  AvailableTimesResponseList({
    required this.data,
  });

  final List<Appointment> data;

  factory AvailableTimesResponseList.fromJson(Map<String, dynamic> json) {
    return AvailableTimesResponseList(
      data: json["data"] == null
          ? []
          : List<Appointment>.from(json["data"]!.map((x) => Appointment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };
}
