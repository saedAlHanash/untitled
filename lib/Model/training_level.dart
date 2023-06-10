class TrainingLevel {
  String? id;
  String? type;

  TrainingLevel({this.id, this.type});

  TrainingLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;

    return data;
  }
}
