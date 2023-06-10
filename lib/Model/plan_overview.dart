import 'package:fitness_storm/Model/training_level.dart';
import 'package:fitness_storm/Model/training_location.dart';
import 'package:fitness_storm/Model/training_type.dart';

import 'trainer.dart';

class PlanOverview {
  String? id;
  String? name;
  String? image;
  int? totalWeeks;
  int? workoutFrequency;
  String? introductionVideo;
  String? description;
  Trainer? trainer;
  List<TrainingType>? trainingType;
  List<TrainingLocation>? trainingLocation;
  List<TrainingLevel>? trainingLevel;
  bool? isActivated;

  PlanOverview({
    this.id,
    this.name,
    this.image,
    this.totalWeeks,
    this.workoutFrequency,
    this.introductionVideo,
    this.description,
    this.trainingLevel,
    this.trainer,
    this.trainingType,
    this.trainingLocation,
    this.isActivated,
  });

  PlanOverview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ?? '';
    totalWeeks = json['total_weeks'];
    workoutFrequency = json['workout_frequency'];
    introductionVideo = json['introduction_video'];
    description = json['description'];
    trainer =
        json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null;
    isActivated = json['current_activated_plan'];

    if (json['training_type'] != null) {
      trainingType = <TrainingType>[];
      json['training_type'].forEach((v) {
        trainingType!.add(TrainingType.fromJson(v));
      });
    }
    if (json['level'] != null) {
      trainingLevel = <TrainingLevel>[];
      json['level'].forEach((v) {
        trainingLevel!.add(TrainingLevel.fromJson(v));
      });
    }
    if (json['training_location'] != null) {
      trainingLocation = <TrainingLocation>[];
      json['training_location'].forEach((v) {
        trainingLocation!.add(TrainingLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_weeks'] = totalWeeks;
    data['workout_frequency'] = workoutFrequency;
    data['introduction_video'] = introductionVideo;
    data['description'] = description;
    data['level'] = trainingLevel;
    if (trainer != null) {
      data['trainer'] = trainer!.toJson();
    }
    data['training_type'] = trainingType;
    data['training_location'] = trainingLocation;
    data['current_activated_plan'] = isActivated;
    return data;
  }
}
