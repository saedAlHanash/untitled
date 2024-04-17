import 'package:fitness_storm/core/extensions/extensions.dart';

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
