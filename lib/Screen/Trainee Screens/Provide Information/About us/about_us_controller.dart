import 'package:fitness_storm/Data/Repositories/trainee_repository.dart';
import 'package:get/state_manager.dart';

import '../../../../Model/about_us.dart';

class AboutUsController extends GetxController {
  TraineeRepository traineeRepository = TraineeRepository();
  AboutUsModel aboutUsModel = AboutUsModel();
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    await getUserProgress();
    isLoading.value = false;
  }

  getUserProgress() async {
    aboutUsModel = AboutUsModel(text: 'test');
    // await traineeRepository.about_us();
  }
}
