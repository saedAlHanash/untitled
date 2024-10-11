import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../generated/assets.dart';
import '../../../trainer/data/response/trainer.dart';


class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.mobile,
    required this.birthDate,
    required this.gender,
    required this.fitnessSurvey,
    required this.bio,
    required this.agreement,
    required this.introductionVideo,
    required this.numberOfPlans,
    required this.numberOfPrivateHours,
    required this.numberOfSubscribers,
    required this.specialties,
    required this.privateSessionPrice,
    required this.wallet,
  });

  int? id;
  String? name;
  String? email;
  String? image;
  String? mobile;
  DateTime? birthDate;
  String? gender;
  FitnessSurvey fitnessSurvey;

  //---------------

  final String bio;
  final String agreement;
  final String introductionVideo;
  final num numberOfPlans;
  final num numberOfPrivateHours;
  final num numberOfSubscribers;
  final List<Specialty> specialties;
  final num privateSessionPrice;
  final num? wallet;
  //---------------
  UploadFile? avatar;

  dynamic get avatarImage {
    if(avatar==null)return image;
    return avatar?.initialImage ?? avatar?.fileBytes ?? Assets.imagesUser;
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: (json["id"] ?? "").toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      image: (json["image"] ?? "").toString().fixAvatarImage,
      mobile: json["mobile"] ?? "",
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      gender: json["gender"] ?? "",
      fitnessSurvey: FitnessSurvey.fromJson(json["fitness_survey"] ?? {}),
      bio: json["bio"] ?? "",
      agreement: (json["agreement"] ?? "").toString().fixAvatarImage,
      introductionVideo: json["introduction_video"] ?? "",
      numberOfPlans: json["number_of_plans"].toString().tryParseOrZero,
      numberOfPrivateHours: json["number_of_private_hours"].toString().tryParseOrZero,
      numberOfSubscribers: json["number_of_subscribers"].toString().tryParseOrZero,
      specialties: json["specialties"] == null
          ? []
          : List<Specialty>.from(json["specialties"]!.map((x) => Specialty.fromJson(x))),
      privateSessionPrice: json["private_session_price"].toString().tryParseOrZero,
      wallet: json["payments_cubit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "mobile": mobile,
    "birth_date": birthDate?.toIso8601String(),
    "gender": gender,
    "fitness_survey": fitnessSurvey.toJson(),
    "bio": bio,
    "agreement": agreement,
    "introduction_video": introductionVideo,
    "number_of_plans": numberOfPlans,
    "number_of_private_hours": numberOfPrivateHours,
    "number_of_subscribers": numberOfSubscribers,
    "specialties": specialties.map((x) => x.toJson()).toList(),
    "private_session_price": privateSessionPrice,
    "payments_cubit": wallet,
  };

  Future<Map<String, dynamic>> toJsonChatApp() async => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "mobile": mobile,
    "birth_date": birthDate?.toIso8601String(),
    "gender": gender,
    "fitness_survey": fitnessSurvey.toJson(),
    "bio": bio,
    "agreement": agreement,
    "introduction_video": introductionVideo,
    "number_of_plans": numberOfPlans,
    "number_of_private_hours": numberOfPrivateHours,
    "number_of_subscribers": numberOfSubscribers,
    "specialties": specialties.map((x) => x.toJson()).toList(),
    "private_session_price": privateSessionPrice,
    "payments_cubit": wallet,
    'fcm': await FirebaseMessaging.instance.getToken(),
  };

  Map<String, dynamic> toJsonForUpdate() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "birth_date": birthDate?.toIso8601String(),
        "gender": 'M',
      };

}


class FitnessSurvey {
  FitnessSurvey({
    required this.weight,
    required this.height,
    required this.dailyExercise,
    required this.weeklyExercise,
    required this.trainingGoal,
    required this.preferredWorkoutLocationId,
    required this.trainingLevelId,
  });

  num? weight;
  num? height;
  num? dailyExercise;
  num? weeklyExercise;
  String? trainingGoal;
  String? preferredWorkoutLocationId;
  String? trainingLevelId;

  factory FitnessSurvey.fromJson(Map<String, dynamic> json) {
    return FitnessSurvey(
      weight: json["weight"] ?? 0,
      height: json["height"] ?? 0,
      dailyExercise: json["daily_exercise"] ?? 0,
      weeklyExercise: json["weekly_exercise"] ?? 0,
      trainingGoal: json["training_goal"] ?? "null",
      preferredWorkoutLocationId: json["preferred_workout_location_id"] ?? "",
      trainingLevelId: json["training_level_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "height": height,
        "daily_exercise": dailyExercise,
        "weekly_exercise": weeklyExercise,
        "training_goal": trainingGoal,
        "preferred_workout_location": preferredWorkoutLocationId,
        "training_level": trainingLevelId,
      };
}
