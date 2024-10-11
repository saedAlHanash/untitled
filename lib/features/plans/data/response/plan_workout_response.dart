import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../../training/data/response/exercises_response.dart';

class PlanWorkouts {
  PlanWorkouts({
    required this.data,
  });

  final List<PlanWorkout> data;

  factory PlanWorkouts.fromJson(Map<String, dynamic> json) {
    return PlanWorkouts(
      data: json["data"] == null
          ? []
          : List<PlanWorkout>.from(json["data"]!.map((x) => PlanWorkout.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class PlanWorkout {
  PlanWorkout({
    required this.id,
    required this.workoutId,
    required this.name,
    required this.image,
    required this.dayNumber,
    required this.totalMinutes,
    required this.exercises,
    required this.type,
    required this.count,
    required this.workoutBreak,
    required this.key,
  });

  final int id;
  final int workoutId;
  final String name;
  final String image;
  final num dayNumber;
  final num totalMinutes;
  final List<Exercise> exercises;
  final String type;
  final num count;
  final num workoutBreak;
  final GlobalKey key;

  bool get isRestDay =>
      (name.toLowerCase() == 'rest day') || (totalMinutes == 0 && exercises.isEmpty);


  factory PlanWorkout.fromJson(Map<String, dynamic> json) {
    return PlanWorkout(
      key: GlobalKey(),
      id: json["id"].toString().tryParseOrZeroInt,
      workoutId: json["workout_id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      image: (json["image"] ?? "").toString().fixAvatarImage,
      dayNumber: json["day_number"] ?? 0,
      totalMinutes: json["total_minutes"] ?? 0,
      exercises: json["exercises"] == null
          ? []
          : List<Exercise>.from(json["exercises"]!.map((x) => Exercise.fromJson(x))),
      type: json["type"] ?? "",
      count: json["count"] ?? 0,
      workoutBreak: json["break"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "workout_id": workoutId,
        "name": name,
        "image": image,
        "day_number": dayNumber,
        "total_minutes": totalMinutes,
        "exercises": exercises.map((x) => x.toJson()).toList(),
        "type": type,
        "count": count,
        "break": workoutBreak,
      };
}
