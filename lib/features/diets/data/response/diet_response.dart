import 'package:fitness_storm/core/extensions/extensions.dart';

class Diets {
  Diets({
    required this.data,
  });

  final List<Diet> data;

  factory Diets.fromJson(Map<String, dynamic> json) {
    return Diets(
      data: json["data"] == null
          ? []
          : List<Diet>.from(json["data"]!.map((x) => Diet.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Diet {
  Diet({
    required this.id,
    required this.title,
    required this.content,
    required this.isFree,
    required this.price,
    required this.file,
    required this.image,
    required this.isActive,
  });

  final String id;
  final String title;
  final String content;
  final bool isFree;
  final String price;
  final String file;
  final String image;
  final bool isActive;

  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      isFree: (json["is_free"] ?? '').toString().tryParseBoolOrFalse,
      price: json["price"] ?? "",
      file: (json["file"] ?? "").toString().fixAvatarImage,
      image: (json["image"] ?? "").toString().fixAvatarImage,
      isActive: (json["is_active"] ?? '').toString().tryParseBoolOrFalse,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "is_free": isFree,
        "price": price,
        "file": file,
        "image": image,
        "is_active": isActive,
      };
}
