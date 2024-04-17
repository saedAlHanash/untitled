import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';
import '/Model/exercise.dart';

class LoadingStartTrainingController extends GetxController {
  String title = 'FitnesStorm';

  @override
  void onInit() async {
    String dayId = Get.arguments[0];
    String workoutId = Get.arguments[1];
    List<Exercises> exercises = Get.arguments[2];
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      Get.offNamed(AppRoutes.training,
          arguments: [dayId, workoutId, exercises]);
    });
  }
}
