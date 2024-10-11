import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

class Trainers {
  Trainers({
    required this.data,
  });

  final List<TrainerModel> data;

  factory Trainers.fromJson(Map<String, dynamic> json) {
    return Trainers(
      data: json["data"] == null
          ? []
          : List<TrainerModel>.from(
              json["data"]!.map((x) => TrainerModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TrainerModel {
  TrainerModel({
    required this.id,
    required this.image,
    required this.name,
    required this.bio,
    required this.agreement,
    required this.introductionVideo,
    required this.numberOfPlans,
    required this.rating,
    required this.numberOfPrivateHours,
    required this.numberOfSubscribers,
    required this.specialties,
    required this.privateSessionPrice,
  });

  final int id;
  final String image;
  final String name;
  final String bio;
  final String agreement;
  final String introductionVideo;
  final num numberOfPlans;
  final num rating;
  final num numberOfPrivateHours;
  final num numberOfSubscribers;
  final List<Specialty> specialties;
  final num privateSessionPrice;

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    final rating = json["rating"].toString().tryParseOrZero;
    return TrainerModel(
      id: json["id"].toString().tryParseOrZeroInt,
      image: (json["image"] ?? "").toString().fixAvatarImage,
      name: json["name"] ?? "",
      bio: json["bio"] ?? "",
      agreement: (json["agreement"] ?? "").toString().fixAvatarImage,
      introductionVideo: json["introduction_video"] ?? "",
      numberOfPlans: json["number_of_plans"].toString().tryParseOrZero,
      rating: rating == 0 ? 4 : rating,
      numberOfPrivateHours:
          json["number_of_private_hours"].toString().tryParseOrZero,
      numberOfSubscribers:
          json["number_of_subscribers"].toString().tryParseOrZero,
      specialties: json["specialties"] == null
          ? []
          : List<Specialty>.from(
              json["specialties"]!.map((x) => Specialty.fromJson(x))),
      privateSessionPrice:
          json["private_session_price"].toString().tryParseOrZero,
    );
  }

  factory TrainerModel.fromProfile() {
    return TrainerModel.fromJson(AppProvider.profile.toJson());
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "bio": bio,
        "agreement": agreement,
        "introduction_video": introductionVideo,
        "number_of_plans": numberOfPlans,
        "rating": rating,
        "number_of_private_hours": numberOfPrivateHours,
        "number_of_subscribers": numberOfSubscribers,
        "specialties": specialties.map((x) => x.toJson()).toList(),
        "private_session_price": privateSessionPrice,
      };
}
class Specialty {
  Specialty({
    required this.id,
    required this.type,
    required this.typeId,
    required this.planId,
  });

  final int id;
  final String type;
  final int typeId;
  final int planId;

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json["id"].toString().tryParseOrZeroInt,
      type: json["type"] ?? "",
      typeId: json["type_id"].toString().tryParseOrZeroInt,
      planId: json["plan_id"].toString().tryParseOrZeroInt,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "plan_id": planId,
  };
}
