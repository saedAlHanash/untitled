import 'package:fitness_storm/core/models/plan_model.dart';


class BookmarkedResponse {
  BookmarkedResponse({
    required this.data,
  });

  final List<PlanModel> data;

  factory BookmarkedResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkedResponse(
      data: json["data"] == null
          ? []
          : List<PlanModel>.from(
              json["data"]!.map((x) => PlanModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}
