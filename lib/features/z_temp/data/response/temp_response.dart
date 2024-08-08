class Temp {
  Temp({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      id: json["id"] ?? "",
    );
  }

//</editor-fold>
}

class Temps {
  final List<Temp> items;

  const Temps({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Temps.fromJson(Map<String, dynamic> json) {
    return Temps(
      items: json['items'] as List<Temp>,
    );
  }
}
