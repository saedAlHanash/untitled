
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_repository.dart';
import 'package:get/state_manager.dart';

import '../../../core/models/plan_model.dart';

class TrainerPlansController extends GetxController {
  final RxBool _isLoading = false.obs;
  final TrainerTrainerRepository _trainerRepository = TrainerTrainerRepository();

  List<Plan> get trainerPlans => _trainerPlans;

  final RxList<Plan> _trainerPlans = <Plan>[].obs;

  set trainerPlans(value) => _trainerPlans.value = value;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    await getTrainerPlans();
    isLoading = false;
  }
  //TODO add function to get trainer plans when api ready
  Future<List<Plan>> getTrainerPlans() async {
    List<Plan> plans = await _trainerRepository.getTrainerPlans();
    if (plans.isNotEmpty) {
      _trainerPlans.addAll(plans);
    }
    return [];
  }
}
