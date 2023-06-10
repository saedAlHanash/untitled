import 'package:fitness_storm/Model/trainer.dart';
import 'package:fitness_storm/Model/training_level.dart';
import 'package:fitness_storm/Model/training_location.dart';
import 'package:fitness_storm/Model/training_type.dart';

class Plan {
  String? id;
  String? image;
  String? name;
  int? totalWeeks;
  int? workoutFrequency;
  Trainer? trainer;
  List<TrainingType>? trainingType;
  List<TrainingLevel>? trainingLevel;
  List<TrainingLocation>? trainingLocation;
  bool? isBookMarked;
  bool? currentActivatedPlan;

  Plan({
    this.id,
    this.image,
    this.name,
    this.totalWeeks,
    this.workoutFrequency,
    this.trainer,
    this.trainingType,
    this.trainingLocation,
    this.trainingLevel,
    this.currentActivatedPlan,
    this.isBookMarked,
  });

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    totalWeeks = json['total_weeks'];
    workoutFrequency = json['workout_frequency'];
    trainer =
        json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null;
    currentActivatedPlan = json['current_activated_plan'];
    isBookMarked = json['is_bookmark'];
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
    data['image'] = image;
    data['name'] = name;
    data['total_weeks'] = totalWeeks;
    data['workout_frequency'] = workoutFrequency;
    data['trainer'] = trainer!.toJson();
    data['training_type'] = trainingType;
    data['training_location'] = trainingLocation;
    data['level'] = trainingLevel;
    data['current_activated_plan'] = currentActivatedPlan;
    data['is_bookmark'] = isBookMarked;
    return data;
  }
}
