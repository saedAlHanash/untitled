import 'package:fitness_storm/Model/exercise.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

class WorkoutModel {
  String? id;
  String? workoutId;
  String? name;
  String? image;
  int? dayNumber;
  int? totalMinutes;
  String? type;
  int? count;
  int? break_after_set;


  List<Exercises>? exercises;

  WorkoutModel({
    required this.id,
    required this.workoutId,
    required this.name,
    required this.image,
    required this.dayNumber,
    required this.totalMinutes,
    required this.type,
    required this.exercises,
    required this.count,

    required this.break_after_set,
  });

  WorkoutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workout_id'];
    name = json['name'];
    image = json['image'].toString().fixAvatarImage;
    dayNumber = json['day_number'];
    totalMinutes = json['total_minutes'];
    type = json['type'];
    count = json['count'];
    break_after_set = json['break'];

    if (json['exercises'] != null) {
      exercises = [];
      json['exercises'].forEach((element) {
        exercises!.add(Exercises.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['workout_id'] = workoutId;
    data['name'] = name;
    data['image'] = image;
    data['day_number'] = dayNumber;
    data['total_minutes'] = totalMinutes;
    data['type'] = type;
    data['break'] = break_after_set;
    data['count'] = count;
    return data;
  }
}
