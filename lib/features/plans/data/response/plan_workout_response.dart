import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class PlanWorkouts {
  PlanWorkouts({
    required this.data,
  });

  final List<PlanWorkout> data;

  factory PlanWorkouts.fromJson(Map<String, dynamic> json) {
    return PlanWorkouts(
      data: json["data"] == null
          ? []
          : List<PlanWorkout>.from(
              json["data"]!.map((x) => PlanWorkout.fromJson(x))),
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
   GlobalKey key = GlobalKey();

  factory PlanWorkout.fromJson(Map<String, dynamic> json) {
    return PlanWorkout(
      id: json["id"].toString().tryParseOrZeroInt,
      workoutId: json["workout_id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      image: (json["image"] ?? "").toString().fixAvatarImage,
      dayNumber: json["day_number"] ?? 0,
      totalMinutes: json["total_minutes"] ?? 0,
      exercises: json["exercises"] == null
          ? []
          : List<Exercise>.from(
              json["exercises"]!.map((x) => Exercise.fromJson(x))),
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

class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.setCount,
    required this.notes,
    required this.secondBased,
    required this.repetitions,
  });

  final int id;
  final String name;
  final num setCount;
  final String notes;
  final bool secondBased;
  final List<Repetition> repetitions;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      setCount: json["set_count"] ?? 0,
      notes: json["notes"] ?? "",
      secondBased: json["second_based"] ?? false,
      repetitions: json["repetitions"] == null
          ? []
          : List<Repetition>.from(
              json["repetitions"]!.map((x) => Repetition.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "set_count": setCount,
        "notes": notes,
        "second_based": secondBased,
        "repetitions": repetitions.map((x) => x.toJson()).toList(),
      };
}

class Repetition {
  Repetition({
    required this.count,
  });

  final num count;

  factory Repetition.fromJson(Map<String, dynamic> json) {
    return Repetition(
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
