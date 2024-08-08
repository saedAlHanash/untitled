
import '../response/diet_response.dart';

class CreateDietRequest {
  CreateDietRequest({
    required this.id,
  });

  final String id;

  factory CreateDietRequest.fromJson(Map<String, dynamic> json) {
    return CreateDietRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateDietRequest.fromDiet(Diet diet) {
    return CreateDietRequest(
      id: diet.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
