class SubscribedPlan {
  String? id;
  String? name;
  String? image;
  double? userProgress;
  bool? currentActivatedPlan;
  List<Days>? days;

  SubscribedPlan(
      {this.id,
      this.name,
      this.image,
      this.userProgress,
      this.currentActivatedPlan,
      this.days});

  SubscribedPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    userProgress = double.parse(json['user_progress'].toString());
    currentActivatedPlan = json['current_activated_plan'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['user_progress'] = userProgress;
    data['current_activated_plan'] = currentActivatedPlan;
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? id;
  int? dayNumber;
  bool? completed;

  Days({this.id, this.dayNumber, this.completed});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayNumber = json['day_number'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day_number'] = dayNumber;
    data['completed'] = completed;
    return data;
  }
}
