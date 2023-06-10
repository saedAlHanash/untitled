import 'dart:developer';

import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
import 'package:get/get.dart';

import '../../../Model/plan.dart';
import '../../../Model/trainer.dart';

class TrainerTrainerOverviewController extends GetxController {
  final Rx<Trainer> _trainer = Trainer.empty().obs;
  final RxList<Plan> _trainerPlans = <Plan>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isvisible = true.obs;

  Trainer get trainer => _trainer.value;

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

  addPlanToFavorite(int index) async {
    log(index.toString());
    final temp = _trainerPlans[index];
    temp.isBookMarked = !temp.isBookMarked!;
    _trainerPlans.removeAt(index);
    _trainerPlans.refresh();
    _trainerPlans.insert(index, temp);
    _trainerPlans.refresh();
    await addToBookmark(temp.id!, !temp.isBookMarked!);
  }

  addToBookmark(String id, bool isBookMarked) async {
    PlanRepository planRepository = PlanRepository();
    isBookMarked = !isBookMarked;
    if (!isBookMarked) {
      ApiResult apiResult = await planRepository.removeFromBookmark(id);
      if (apiResult.type == ApiResultType.success) {
        // Utils.openSnackBar(message: 'Success');
      }
    } else {
      ApiResult apiResult = await planRepository.addToBookmark(id);
      if (apiResult.type == ApiResultType.success) {
        // Utils.openSnackBar(message: 'Success');
      }
    }
  }
}
