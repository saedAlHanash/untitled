import 'package:fitness_storm/Model/specialties_model.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../Screen/Trainer Screens/Trainer Calender/appointments.dart';
import '../core/models/booked_appointments.dart';

class TrainerModel {
  TrainerModel({
    required this.id,
    required this.image,
    required this.name,
    required this.bio,
    required this.introductionVideo,
    required this.numberOfPlans,
    required this.numberOfPrivateHours,
    required this.numberOfSubscribers,
    required this.specialties,
    required this.privateSessionPrice,
    required this.appointment,
  });

  final int id;
  final String image;
  final String name;
  final String bio;
  final String introductionVideo;
  final num numberOfPlans;
  final num numberOfPrivateHours;
  final num numberOfSubscribers;
  final List<Specialty> specialties;
  final num privateSessionPrice;
  final Appointment? appointment;

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      id: json["id"].toString().tryParseOrZeroInt,
      image: json["image"] ?? "",
      name: json["name"] ?? "",
      bio: json["bio"] ?? "",
      introductionVideo: json["introduction_video"] ?? "",
      numberOfPlans: json["number_of_plans"].toString().tryParseOrZero,
      numberOfPrivateHours: json["number_of_private_hours"].toString().tryParseOrZero,
      numberOfSubscribers: json["number_of_subscribers"].toString().tryParseOrZero,
      specialties: json["specialties"] == null
          ? []
          : List<Specialty>.from(json["specialties"]!.map((x) => Specialty.fromJson(x))),
      privateSessionPrice: json["private_session_price"].toString().tryParseOrZero,
      appointment:
          json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "bio": bio,
        "introduction_video": introductionVideo,
        "number_of_plans": numberOfPlans,
        "number_of_private_hours": numberOfPrivateHours,
        "number_of_subscribers": numberOfSubscribers,
        "specialties": specialties.map((x) => x.toJson()).toList(),
        "private_session_price": privateSessionPrice,
        "appointment": appointment?.toJson(),
      };
}


