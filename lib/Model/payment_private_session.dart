class PaymentPrivateSession {
  String? id;
  String? startTime;
  String? endTime;
  String? videoCallToken;
  String? status;
  int? price;
  Trainer? trainer;

  PaymentPrivateSession(
      {this.id,
      this.startTime,
      this.endTime,
      this.videoCallToken,
      this.status,
      this.price,
      this.trainer});

  PaymentPrivateSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    videoCallToken = json['video_call_token'];
    status = json['status'];
    price = json['price'];
    trainer =
        json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['video_call_token'] = videoCallToken;
    data['status'] = status;
    data['price'] = price;
    if (trainer != null) {
      data['trainer'] = trainer!.toJson();
    }
    return data;
  }
}

class Trainer {
  Null? id;
  Null? name;

  Trainer({this.id, this.name});

  Trainer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
