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
    data['id'] = this.id;
    data['startAt'] = this.startAt;
    data['endAt'] = this.endAt;
    data['summary'] = this.summary;
    data['timeZoneStartAt'] = this.timeZoneStartAt;
    data['color'] = this.color;
    data['video_call_token'] = this.videoCallToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
