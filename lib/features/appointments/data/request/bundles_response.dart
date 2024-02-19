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
    required this.price,
    required this.sessions,
    required this.trainer,
  });

  final int id;
  final String name;
  final num price;
  final num sessions;
  final Trainer trainer;

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      sessions: json["sessions"] ?? 0,
      trainer: Trainer.fromJson(json["trainer"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sessions": sessions,
        "trainer": trainer.toJson(),
      };
}

class Trainer {
  Trainer({
    required this.id,
    required this.image,
    required this.name,
    required this.bio,
    required this.gender,
    required this.status,
  });

  final String id;
  final String image;
  final String name;
  final String bio;
  final String gender;
  final bool status;

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json["id"] ?? "",
      image: json["image"] ?? "",
      name: json["name"] ?? "",
      bio: json["bio"] ?? "",
      gender: json["gender"] ?? "",
      status: json["status"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "bio": bio,
        "gender": gender,
        "status": status,
      };
}
