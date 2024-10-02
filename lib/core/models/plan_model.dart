import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../features/trainer/data/response/trainer.dart';
import '../util/shared_preferences.dart';

class Plans {
  Plans({
    required this.data,
  });

  final List<Plan> data;

  factory Plans.fromJson(Map<String, dynamic> json) {
    return Plans(
      data: json["data"] == null
          ? []
          : List<Plan>.from(
              json["data"]!.map((x) => Plan.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Plan {
  Plan({
    required this.id,
    required this.name,
    required this.image,
    required this.trainingType,
    required this.level,
    required this.trainer,
    required this.trainingLocation,
    required this.totalWeeks,
    required this.isBookmark,
    required this.isActive,
    required this.introductionVideo,
    required this.description,
    required this.workoutFrequency,
  });

  final int workoutFrequency;
  final int id;
  final String name;
  final String image;
  final List<TrainingType> trainingType;
  final List<TrainingLevel> level;
  final TrainerModel trainer;
  final List<TrainingLocation> trainingLocation;
  final int totalWeeks;
  bool isBookmark;
  final bool isActive;
  final String introductionVideo;
  final String description;

  bool get isCurrent => AppSharedPreference.getCurrentPlanId == '$id';

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json["id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      image: (json["image"] ?? "").toString().fixAvatarImage,
      trainingType: json["training_type"] == null
          ? []
          : List<TrainingType>.from(
              json["training_type"]!.map((x) => TrainingType.fromJson(x))),
      level: json["level"] == null
          ? []
          : List<TrainingLevel>.from(
              json["level"]!.map((x) => TrainingLevel.fromJson(x))),
      trainer: TrainerModel.fromJson(json["trainer"] ?? {}),
      trainingLocation: json["training_location"] == null
          ? []
          : List<TrainingLocation>.from(json["training_location"]!
              .map((x) => TrainingLocation.fromJson(x))),
      totalWeeks: json["total_weeks"].toString().tryParseOrZeroInt,
      workoutFrequency: json["workout_frequency"].toString().tryParseOrZeroInt,
      isBookmark: (json["is_bookmark"]).toString().getBool ,
      isActive: (json["is_active"] ).toString().getBool,
      introductionVideo: json["introduction_video"] ?? '',
      description: json["description"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "training_type": trainingType.map((x) => x.toJson()).toList(),
        "level": level.map((x) => x.toJson()).toList(),
        "trainer": trainer.toJson(),
        "training_location": trainingLocation.map((x) => x.toJson()).toList(),
        "total_weeks": totalWeeks,
        "is_bookmark": isBookmark,
        "is_active": isActive,
        "introduction_video": introductionVideo,
        "description": description,
      };
}

class TrainingLevel {
  TrainingLevel({
    required this.id,
    required this.type,
    required this.pivot,
  });

  final int id;
  final String type;
  final LevelPivot? pivot;

  factory TrainingLevel.fromJson(Map<String, dynamic> json) {
    return TrainingLevel(
      id: json["id"].toString().tryParseOrZeroInt,
      type: json["type"] ?? "",
      pivot: json["pivot"] == null ? null : LevelPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "pivot": pivot?.toJson(),
      };
}

class LevelPivot {
  LevelPivot({
    required this.planId,
    required this.trainingLevelId,
  });

  final int planId;
  final int trainingLevelId;

  factory LevelPivot.fromJson(Map<String, dynamic> json) {
    return LevelPivot(
      planId: json["plan_id"].toString().tryParseOrZeroInt,
      trainingLevelId: json["training_level_id"].toString().tryParseOrZeroInt,
    );
  }

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "training_level_id": trainingLevelId,
      };
}

class TrainingLocation {
  TrainingLocation({
    required this.id,
    required this.type,
    required this.pivot,
  });

  final int id;
  final String type;
  final TrainingLocationPivot? pivot;

  factory TrainingLocation.fromJson(Map<String, dynamic> json) {
    return TrainingLocation(
      id: json["id"].toString().tryParseOrZeroInt,
      type: json["type"] ?? "",
      pivot: json["pivot"] == null
          ? null
          : TrainingLocationPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "pivot": pivot?.toJson(),
      };
}

class TrainingLocationPivot {
  TrainingLocationPivot({
    required this.planId,
    required this.trainingLocationId,
  });

  final int planId;
  final int trainingLocationId;

  factory TrainingLocationPivot.fromJson(Map<String, dynamic> json) {
    return TrainingLocationPivot(
      planId: json["plan_id"].toString().tryParseOrZeroInt,
      trainingLocationId:
          json["training_location_id"].toString().tryParseOrZeroInt,
    );
  }

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "training_location_id": trainingLocationId,
      };
}

class TrainingType {
  TrainingType({
    required this.id,
    required this.type,
    required this.pivot,
  });

  final int id;
  final String type;
  final TrainingTypePivot? pivot;

  factory TrainingType.fromJson(Map<String, dynamic> json) {
    return TrainingType(
      id: json["id"].toString().tryParseOrZeroInt,
      type: json["type"] ?? "",
      pivot: json["pivot"] == null
          ? null
          : TrainingTypePivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "pivot": pivot?.toJson(),
      };
}

class TrainingTypePivot {
  TrainingTypePivot({
    required this.planId,
    required this.trainingTypeId,
  });

  final int planId;
  final int trainingTypeId;

  factory TrainingTypePivot.fromJson(Map<String, dynamic> json) {
    return TrainingTypePivot(
      planId: json["plan_id"].toString().tryParseOrZeroInt,
      trainingTypeId: json["training_type_id"].toString().tryParseOrZeroInt,
    );
  }

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "training_type_id": trainingTypeId,
      };
}
