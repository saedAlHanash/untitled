import 'package:fitness_storm/core/api_manager/api_service.dart';

import '../../../../core/util/shared_preferences.dart';

class CreateTrainerFileRequest {
  CreateTrainerFileRequest({
    required this.id,
    required this.content,
  });

  String id;
  String content;
  UploadFile? file;

  factory CreateTrainerFileRequest.fromJson(Map<String, dynamic> json) {
    return CreateTrainerFileRequest(
      id: json["id"] ?? "",
      content: json["content"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "trainer_id": AppSharedPreference.getMyId.toString(),
      };
}
