// import 'package:fitness_storm/Model/repetition.dart';
//
// import '../features/training/data/response/exercises_response.dart';
//
// class Exercises {
//   String? id;
//   String? name;
//   String? video;
//   String? notes;
//   int? totalRestSeconds;
//   int? setCount;
//   bool? secondsBased;
//   List<Repetition>? repetitions;
//
//   Exercises(
//       {this.id,
//       this.name,
//       this.video,
//       this.totalRestSeconds,
//       this.setCount,
//       this.notes,
//       this.secondsBased,
//       this.repetitions});
//
//   Exercises.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     video = json['video'];
//     notes = json['notes'] ?? "";
//     totalRestSeconds = json['total_rest_seconds'];
//     setCount = json['set_count'];
//     secondsBased = json['second_based'];
//     if (json['repetitions'] != null) {
//       repetitions = <Repetition>[];
//       json['repetitions'].forEach((v) {
//         repetitions!.add(Repetition.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['video'] = video;
//     data['notes'] = notes ?? "";
//     data['total_rest_seconds'] = totalRestSeconds;
//     data['set_count'] = setCount;
//     data['second_based'] = secondsBased;
//     if (repetitions != null) {
//       data['repetitions'] = repetitions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
