class Specialties {
  String? id;
  String? type;
  String? typeId;
  String? planId;

  Specialties({this.id, this.type, this.typeId, this.planId});

  Specialties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    planId = json['plan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['plan_id'] = this.planId;
    return data;
  }
}
