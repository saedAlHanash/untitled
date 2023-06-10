import 'package:fitness_storm/Screen/Auth/User%20Survey/user_survey_controller.dart';
import 'package:get/instance_manager.dart';

class UserSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSurveyController());
  }
}
