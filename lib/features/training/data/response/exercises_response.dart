import 'package:fitness_storm/core/extensions/extensions.dart';

class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.setCount,
    required this.notes,
    required this.video,
    required this.secondBased,
    required this.repetitions,
  });

  final int id;
  final String name;
  final num setCount;
  final String notes;
  final String video;
  final bool secondBased;
  final List<Repetition> repetitions;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      setCount: (json["set_count"]).toString().tryParseOrZeroInt,
      notes: json["notes"] ?? "",
      video: json["video"] ?? "",
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
        "video": video,
        "second_based": secondBased,
        "repetitions": repetitions.map((x) => x.toJson()).toList(),
      };
}

class Repetition {
  Repetition({
    required this.count,
    required this.restSeconds,
  });

  final num count;
  final num restSeconds;

  factory Repetition.fromJson(Map<String, dynamic> json) {
    return Repetition(
      count: json["count"] ?? 0,
      restSeconds: json["rest_seconds"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "rest_seconds": restSeconds,
      };
}
