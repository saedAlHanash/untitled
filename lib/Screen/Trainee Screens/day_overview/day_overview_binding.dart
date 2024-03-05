import 'package:fitness_storm/Screen/Trainee%20Screens/day_overview/day_overview_controller.dart';
import 'package:get/get.dart';

class DayOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DayOverviewController());
  }
}


class CreateResponse {
  CreateResponse({
    required this.id,
    required this.userId,
    required this.userName,
  });

  final int id;
  final num userId;
  final String userName;

  factory CreateResponse.fromJson(Map<String, dynamic> json){
    return CreateResponse(
      id: json["id"] ?? 0,
      userId: json["userId"] ?? 0,
      userName: json["userName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "userName": userName,
  };

}
