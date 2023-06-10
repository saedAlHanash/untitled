class AvailableTime {
  String? id;
  String? startTime;
  String? endTime;

  AvailableTime({this.id, this.startTime, this.endTime});

  AvailableTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
