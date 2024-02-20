
import 'package:fitness_storm/core/extensions/extensions.dart';

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
  });

  String? id;
  String? name;
  String? email;
  String? image;
  String? mobile;
  DateTime? birthDate;
  String? gender;
  FitnessSurvey fitnessSurvey;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      image: (json["image"] ?? "").toString().fixAvatarImage,
      mobile: json["mobile"] ?? "",
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      gender: json["gender"] ?? "",
      fitnessSurvey:  FitnessSurvey.fromJson(json["fitness_survey"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "birth_date": birthDate?.toIso8601String(),
        "gender": gender,
        "fitness_survey": fitnessSurvey.toJson(),
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
