class Conversation {
  int? id;
  String? message;
  String? senderType;
  String? createdAt;

  Conversation({this.id, this.message, this.senderType, this.createdAt});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    senderType = json['sender_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['sender_type'] = senderType;
    data['created_at'] = createdAt;
    return data;
  }
}
