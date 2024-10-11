 

import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
import 'package:get/get.dart';

import '../../../core/models/plan_model.dart';
import '../../../features/trainer/data/response/trainer.dart';

class TrainerTrainerOverviewController extends GetxController {
  final Rx<TrainerModel> _trainer = TrainerModel.fromJson({}).obs;
  final RxList<Plan> _trainerPlans = <Plan>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isvisible = true.obs;

  TrainerModel get trainer => _trainer.value;

  List<Plan> get trainerPlans => _trainerPlans;

  bool get isLoading => _isLoading.value;

  bool get isVisible => _isvisible.value;

  set trainer(value) => _trainer.value = value;

  set trainerPlans(value) => _trainerPlans.value = value;

  set isLoading(value) => _isLoading.value = value;

  set isVisible(value) => _isvisible.value = value;

  final TrainerRepository _trainerRepository = TrainerRepository();

  @override
  Future<void> onInit() async {
    String id = Get.arguments;
    isLoading = true;
    trainer = await _trainerRepository.getTrainerById(id);
    trainerPlans = await _trainerRepository.getTrainerPlans(id);
    isLoading = false;
    super.onInit();
  }




}
