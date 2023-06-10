import 'package:fitness_storm/Model/specialties_model.dart';

class Trainer {
  String? id;
  String? profilePic;
  String? name;
  String? bio;
  String? introductionVideo;
  String? numberOfPlans;
  String? numberOfPrivateHours;
  String? numberOfSubscribers;
  double? privateSessionPrice;
  List<Specialties>? specialties;

  Trainer({this.id, this.profilePic, this.name, this.bio, this.numberOfPlans});

  Trainer.empty();

  Trainer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePic = json['image'];
    name = json['name'];
    bio = json['bio'];
    introductionVideo = json['introduction_video'];
    numberOfPlans = json['number_of_plans'];
    numberOfPrivateHours = json['number_of_private_hours'].toString();
    numberOfSubscribers = json['number_of_subscribers'].toString();
    specialties = [];
    if (json['specialties'] != null) {
      json['specialties'].forEach((element) {
        specialties!.add(Specialties.fromJson(element));
      });
    }
    privateSessionPrice = json['private_session_price'] != null
        ? double.parse(json['private_session_price'].toString())
        : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = profilePic;
    data['name'] = name;
    data['bio'] = bio;
    data['introduction_video'] = introductionVideo;
    data['number_of_plans'] = numberOfPlans;
    data['number_of_private_hours'] = numberOfPrivateHours;
    data['number_of_subscribers'] = numberOfSubscribers;
    data['specialties'] = specialties;
    data['private_session_price'] = privateSessionPrice;
    return data;
  }
}
