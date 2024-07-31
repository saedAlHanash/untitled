class CreateTrainingRequest {
  CreateTrainingRequest({
    required this.id,
  });

  final String id;

  factory CreateTrainingRequest.fromJson(Map<String, dynamic> json){
    return CreateTrainingRequest(
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
