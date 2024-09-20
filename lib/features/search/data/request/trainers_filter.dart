import 'dart:convert';

import 'package:m_cubit/util.dart';

import '../../../../core/strings/enum_manager.dart';

class TrainerFilter {
  TrainerFilter({
    this.name,
    this.fitnessLevel,
    this.trainingType,
  });

  String? name;
  TrainingLevelEnum? fitnessLevel;
  TrainingTypeEnum? trainingType;

  factory TrainerFilter.fromJson(Map<String, dynamic> json) {
    return TrainerFilter();
  }

  String get getKey {

    return jsonEncode(this).getKey;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "fitness_level": fitnessLevel == null
            ? null
            : [fitnessLevel?.nameRequest].map((x) => x).toList(),
        "training_type": trainingType == null
            ? null
            : [trainingType?.nameRequest].map((x) => x).toList(),
      };
}
