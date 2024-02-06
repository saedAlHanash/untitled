import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_repository.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:get/state_manager.dart';

import '../../../core/models/plan_model.dart';

class TrainerPlansController extends GetxController {
  RxBool _isLoading = false.obs;
  TrainerTrainerRepository _trainerRepository = TrainerTrainerRepository();

  List<PlanModel> get trainerPlans => _trainerPlans;

  RxList<PlanModel> _trainerPlans = <PlanModel>[].obs;

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

  addPlanToFavorite(int index) async {
    await addToBookmark();
  }

  addToBookmark() async {
    PlanRepository planRepository = PlanRepository();

    // if (!isBookMark) {
    //   ApiResult apiResult = await planRepository.removeFromBookmark(id);
    //   if (apiResult.type == ApiResultType.success) {
    //     // Utils.openSnackBar(message: 'Success');
    //   }
    // } else {
    ApiResult apiResult = await planRepository.getMyPlans();
    if (apiResult.type == ApiResultType.success) {
      return apiResult.data;
      // Utils.openSnackBar(message: 'Success');
    }
  }

  //TODO add function to get trainer plans when api ready
  Future<List<PlanModel>> getTrainerPlans() async {
    List<PlanModel> _plans = await _trainerRepository.getTrainerPlans();
    if (_plans.isNotEmpty) {
      _trainerPlans.addAll(_plans);
    }
    return [];
  }
}
