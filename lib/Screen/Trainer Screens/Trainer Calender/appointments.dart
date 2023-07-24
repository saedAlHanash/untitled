class Appointment {
  String? id;
  String? startAt;
  String? endAt;
  String? summary;
  String? timeZoneStartAt;
  String? color;
  String? videoCallToken;
  User? user;

  Appointment(
      {this.id,
      this.startAt,
      this.endAt,
      this.summary,
      this.timeZoneStartAt,
      this.color,
      this.videoCallToken,
      this.user});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    summary = json['summary'];
    timeZoneStartAt = json['timeZoneStartAt'];
    color = json['color'];
    videoCallToken = json['video_call_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    data['summary'] = summary;
    data['timeZoneStartAt'] = timeZoneStartAt;
    data['color'] = color;
    data['video_call_token'] = videoCallToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
