import 'package:fitness_storm/core/extensions/extensions.dart';

class WelcomeMessageResponse {
  WelcomeMessageResponse({
    required this.data,
  });

  final List<WelcomeMessage> data;

  factory WelcomeMessageResponse.fromJson(Map<String, dynamic> json) {
    return WelcomeMessageResponse(
      data: json["data"] == null
          ? []
          : List<WelcomeMessage>.from(
              json["data"]!.map((x) => WelcomeMessage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class WelcomeMessage {
  WelcomeMessage({
    required this.id,
    required this.image,
    required this.message,
    required this.order,
  });

  final int id;
  final String image;
  final String message;
  final num order;

  factory WelcomeMessage.fromJson(Map<String, dynamic> json) {
    return WelcomeMessage(
      id: json["id"] ?? 0,
      image: json["image"].toString().fixAvatarImage,
      message: json["message"]??'',
      order: json["order"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "message": message,
        "order": order,
      };
}
