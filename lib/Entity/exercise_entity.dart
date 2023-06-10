class ExerciseEntity {
  String? exerciseName;
  int? sets;
  int? reps;

  ExerciseEntity({
    required this.exerciseName,
    required this.sets,
    required this.reps,
  });

  ExerciseEntity.fromJson(Map<String, dynamic> json) {
    exerciseName = json['name'];
    sets = json['sets'];
    reps = json['reps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = exerciseName;
    data['sets'] = sets;
    data['reps'] = reps;
    return data;
  }
}
