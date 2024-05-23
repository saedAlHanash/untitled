import 'package:fitness_storm/features/trainer/data/response/trainer.dart';

class BundlesResponse {
  BundlesResponse({
    required this.data,
  });

  final List<Bundle> data;

  factory BundlesResponse.fromJson(Map<String, dynamic> json) {
    return BundlesResponse(
      data: json["data"] == null
          ? []
          : List<Bundle>.from(json["data"]!.map((x) => Bundle.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Bundle {
  Bundle({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sessions,
    required this.trainer,
  });

  final int id;
  final String name;
  final String description;
  final num price;
  final num sessions;
  final TrainerModel trainer;

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0,
      sessions: json["sessions"] ?? 0,
      trainer: TrainerModel.fromJson(json["trainer"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "sessions": sessions,
        "trainer": trainer.toJson(),
      };
}
