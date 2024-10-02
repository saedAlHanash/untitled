import '../../../../core/strings/enum_manager.dart';

class PlansRequest {
  PlansRequest({
    required this.name,
    required this.trainingType,
    required this.trainingLocationType,
    required this.totalWeeks,
    required this.trainingLevel,
    required this.sortBy,
    required this.isBookmark,
  });

  final String name;
  final TrainingTypeEnum trainingType;
  final TrainingLocationType trainingLocationType;
  final num totalWeeks;
  final TrainingLevelEnum trainingLevel;
  final SortTypes sortBy;
  final String isBookmark;

  factory PlansRequest.fromJson(Map<String, dynamic> json){
    return PlansRequest(
      name: json["name"] ?? "",
      trainingType: json["training_type"] ?? 0,
      trainingLocationType: json["training_location_type"] ?? 0,
      totalWeeks: json["total_weeks"] ?? 0,
      trainingLevel: json["training_level"] ?? 0,
      sortBy: json["sortBy"] ?? 0,
      isBookmark: json["is_bookmark"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "training_type": trainingType,
    "training_location_type": trainingLocationType,
    "total_weeks": totalWeeks,
    "training_level": trainingLevel,
    "sortBy": sortBy,
    "is_bookmark": isBookmark,
  };

}
