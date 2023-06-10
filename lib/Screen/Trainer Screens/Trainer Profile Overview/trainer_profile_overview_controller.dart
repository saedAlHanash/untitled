import 'package:fitness_storm/Model/trainer.dart';
import 'package:get/get.dart';

class TrainerProfileOverviewController extends GetxController {
  late Trainer trainer;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  void onInit() {
    super.onInit();
    trainer = Get.arguments;
  }
}
