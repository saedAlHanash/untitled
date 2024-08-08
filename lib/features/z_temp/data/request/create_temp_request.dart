import '../response/temp_response.dart';

class CreateTempRequest {
  CreateTempRequest({
    required this.id,
  });

  final String id;

  factory CreateTempRequest.fromJson(Map<String, dynamic> json) {
    return CreateTempRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateTempRequest.fromTemp(Temp temp) {
    return CreateTempRequest(
      id: temp.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
