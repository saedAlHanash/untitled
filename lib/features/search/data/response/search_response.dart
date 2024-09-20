import 'package:fitness_storm/features/trainer/data/response/trainer.dart';

class Searchs {
  Searchs({
    required this.data,
  });

  final List<TrainerModel> data;

  factory Searchs.fromJson(Map<String, dynamic> json){
    return Searchs(
      data: json["data"] == null ? [] : List<TrainerModel>.from(json["data"]!.map((x) => TrainerModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

