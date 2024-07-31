import 'package:fitness_storm/core/extensions/extensions.dart';

class TrainerFiles {
  TrainerFiles({
    required this.data,
  });

  final List<TrainerFile> data;

  factory TrainerFiles.fromJson(Map<String, dynamic> json) {
    return TrainerFiles(
      data: json["data"] == null
          ? []
          : List<TrainerFile>.from(
              json["data"]!.map((x) => TrainerFile.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TrainerFile {
  TrainerFile({
    required this.id,
    required this.content,
    required this.isOpen,
    required this.file,
  });

  final int id;
  final String content;
  final num isOpen;
  final String file;

  factory TrainerFile.fromJson(Map<String, dynamic> json) {
    return TrainerFile(
      id: json["id"].toString().tryParseOrZeroInt,
      content: json["content"] ?? "",
      isOpen: json["is_open"] ?? 0,
      file: (json["file"] ?? "").toString().fixAvatarImage,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "is_open": isOpen,
        "file": file,
      };
}
