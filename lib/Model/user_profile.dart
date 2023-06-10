class UserProfile {
  String? id;
  String? name;
  String? email;
  String? image;
  String? mobile;
  String? birthDate;
  String? gender;
  FitnessSurvey? fitnessSurvey;

  UserProfile(
      {this.id,
      this.name,
      this.email,
      this.image = '',
      this.mobile,
      this.birthDate,
      this.gender,
      this.fitnessSurvey});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    mobile = json['mobile'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    fitnessSurvey = json['fitness_survey'] != null
        ? FitnessSurvey.fromJson(json['fitness_survey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    // data['image'] = image ?? "";
    data['mobile'] = mobile ?? "09xxxxxxxxxx";
    data['birth_date'] = birthDate ?? "2023-01-01";
    data['gender'] = gender ?? "";
    if (fitnessSurvey != null) {
      data['fitness_survey'] = fitnessSurvey!.toJson();
    }
    return data;
  }
}

class FitnessSurvey {
  int? weight;
  int? height;
  int? dailyExercise;
  int? weeklyExercise;
  String? trainingGoal;
  String? preferredWorkoutLocationId;
  String? trainingLevelId;

  FitnessSurvey(
      {this.weight,
      this.height,
      this.dailyExercise,
      this.weeklyExercise,
      this.trainingGoal,
      this.preferredWorkoutLocationId,
      this.trainingLevelId});

  FitnessSurvey.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    dailyExercise = json['daily_exercise'];
    weeklyExercise = json['weekly_exercise'];
    trainingGoal = json['training_goal'];
    preferredWorkoutLocationId = json['preferred_workout_location_id'];
    trainingLevelId = json['training_level_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight ?? 0;
    data['height'] = height ?? 0;
    data['daily_exercise'] = dailyExercise ?? 0;
    data['weekly_exercise'] = weeklyExercise ?? 0;
    data['training_goal'] = trainingGoal ?? "0";
    data['preferred_workout_location'] = preferredWorkoutLocationId ?? "";
    data['training_level'] = trainingLevelId ?? "";
    return data;
  }
}
