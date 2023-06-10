import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Model/plan_overview.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:get/get.dart';

class FilterResultController extends GetxController {
  RxList<PlanOverview> plansOverviews = <PlanOverview>[].obs;

  final RxBool _isLoading = false.obs;
  final PlanRepository _planRepository = PlanRepository();

  @override
  Future<void> onInit() async {
    final data = Get.arguments;
    isLoading = true;
    final response = await _planRepository.filterPlans(
        data['training_location_type'],
        data['training_type'],
        data['training_level']);

    if (response.type == ApiResultType.success) {
      response.data.forEach((element) {
        plansOverviews.add(PlanOverview.fromJson(element));
      });
    } else {
      Get.back();
      Utils.openSnackBar(message: response.message!);
    }
    isLoading = false;
    super.onInit();
  }

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;
}
