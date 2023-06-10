import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Data/Api/api_result.dart';
import '../../../Data/Repositories/Trainer Repository/plan_repository.dart';
import '../../../Data/Repositories/Trainer Repository/trainer_repository.dart';
import '../../../Data/Repositories/plan_repository.dart';
import '../../../Model/plan.dart';
import '../../../Model/trainer.dart';

class TrainerSearchResultController extends GetxController {
  final TrainerTrainerRepository _trainerRepository =
      TrainerTrainerRepository();
  final TrainerPlanRepository _planRepository = TrainerPlanRepository();
  late final String searchTerm;

  final RxInt _selectedIndex = 0.obs;
  final RxList<Trainer> _trainers = <Trainer>[].obs;
  final RxList<Plan> _plans = <Plan>[].obs;
  final RxInt _trainersPageNumber = 1.obs;
  final RxInt _trainersNumberOfResults = 0.obs;
  final RxInt _plansPageNumber = 1.obs;
  final RxInt _plansNumberOfResults = 0.obs;
  final RxBool _isLoadingTrainer = false.obs;
  final RxBool _isLoadingPlans = false.obs;
  final RxBool _isTrainerSort = false.obs;
  final RxBool _isPlanSort = false.obs;
  final Rx<RefreshController> _trainerRefreshController =
      RefreshController().obs;
  final Rx<RefreshController> _planRefreshController = RefreshController().obs;

  int get selectedIndex => _selectedIndex.value;

  List<Trainer> get trainers => _trainers;

  List<Plan> get plans => _plans;

  int get trainersPageNumber => _trainersPageNumber.value;

  int get trainersNumberOfResults => _trainersNumberOfResults.value;

  int get plansPageNumber => _plansPageNumber.value;

  int get plansNumberOfResults => _plansNumberOfResults.value;

  bool get isLoadingTrainer => _isLoadingTrainer.value;

  bool get isLoadingPlans => _isLoadingPlans.value;

  bool get isTrainerSort => _isTrainerSort.value;

  bool get isPlanSort => _isPlanSort.value;

  RefreshController get trainerRefreshController =>
      _trainerRefreshController.value;

  RefreshController get planRefreshController => _planRefreshController.value;

  set selectedIndex(value) => _selectedIndex.value = value;

  set trainers(value) => _trainers.value = value;

  set plans(value) => _plans.value = value;

  set trainersPageNumber(value) => _trainersPageNumber.value = value;

  set trainersNumberOfResults(value) => _trainersNumberOfResults.value = value;

  set plansPageNumber(value) => _plansPageNumber.value = value;

  set plansNumberOfResults(value) => _plansNumberOfResults.value = value;

  set isLoadingTrainer(value) => _isLoadingTrainer.value = value;

  set isLoadingPlans(value) => _isLoadingPlans.value = value;

  set isTrainerSort(value) => _isTrainerSort.value = value;

  set isPlanSort(value) => _isPlanSort.value = value;

  set trainerRefreshController(value) =>
      _trainerRefreshController.value = value;

  set planRefreshController(value) => _planRefreshController.value = value;

  @override
  Future<void> onInit() async {
    searchTerm = Get.arguments;
    isLoadingTrainer = true;
    await getSearchResultTrainer();
    isLoadingTrainer = false;
    isLoadingPlans = true;
    await getSearchResultPlans();
    isLoadingPlans = false;
    super.onInit();
  }

  onSort() async {
    if (selectedIndex == 0) {
      await onSortTrainer();
    } else {
      await onSortPlan();
    }
  }

  onSortTrainer() async {
    isTrainerSort = !isTrainerSort;
    trainersPageNumber = 1;
    Map<String, dynamic> queryParameters = {
      'name': searchTerm,
      "sortBy": 'aToz',
      'page': trainersPageNumber
    };
    isLoadingTrainer = true;
    ApiResult apiResult =
        await _trainerRepository.getSearchTrainer(queryParameters);
    if (apiResult.type == ApiResultType.success) {
      trainers = <Trainer>[];
      apiResult.data.forEach((element) {
        trainers.add(Trainer.fromJson(element));
      });
    }
    isLoadingTrainer = false;
  }

  onSortPlan() async {
    log('plannnnnnnnnnnnnnn');
    isPlanSort = !isPlanSort;
    plansPageNumber = 1;
    Map<String, dynamic> queryParameters;
    if (isPlanSort) {
      queryParameters = {
        'name': searchTerm,
        'sortBy': 'aToz',
        'page': plansPageNumber
      };
    } else {
      queryParameters = {'name': searchTerm, 'page': plansPageNumber};
    }
    isLoadingPlans = true;
    ApiResult apiResult = await _planRepository.getSearchPlans(queryParameters);
    if (apiResult.type == ApiResultType.success) {
      plans = <Plan>[];
      apiResult.data.forEach((element) {
        plans.add(Plan.fromJson(element));
      });
    }
    isLoadingPlans = false;
  }

  onLoadingTrainer() async {
    var temp = await getPagenationTrainer();
    if (temp.isNotEmpty) {
      trainers.addAll(temp);
      trainerRefreshController.loadComplete();
      trainersPageNumber++;
    } else {
      trainerRefreshController.loadNoData();
    }
  }

  onLoadingPlan() async {
    var temp = await getPagenationPlans();
    if (temp.isNotEmpty) {
      plans.addAll(temp);
      planRefreshController.loadComplete();
      plansPageNumber++;
    } else {
      planRefreshController.loadNoData();
    }
  }

  Future<List<Trainer>> getPagenationTrainer() async {
    ApiResult result = await _trainerRepository
        .getSearchTrainer({'name': searchTerm, 'page': trainersPageNumber});
    if (result.type == ApiResultType.success) {
      List<Trainer> tempTrainers = [];
      result.data.forEach((element) {
        tempTrainers.add(Trainer.fromJson(element));
      });
      return tempTrainers;
    }
    throw (e) {
      log(e.toString());
    };
  }

  Future<List<Plan>> getPagenationPlans() async {
    ApiResult result =
        await _planRepository.getSearchPlans({'name': searchTerm});
    if (result.type == ApiResultType.success) {
      List<Plan> tempPlans = [];
      result.data.forEach((element) {
        tempPlans.add(Plan.fromJson(element));
      });
      return tempPlans;
    }
    throw (e) {
      log(e.toString());
    };
  }

  getSearchResultTrainer() async {
    ApiResult result = await _trainerRepository
        .getSearchTrainer({'name': searchTerm, 'page': trainersPageNumber});
    if (result.type == ApiResultType.success) {
      result.data.forEach((element) {
        trainers.add(Trainer.fromJson(element));
      });
      trainersNumberOfResults = result.numberOfResults;
      trainersPageNumber++;
    }
  }

  getSearchResultPlans() async {
    ApiResult result =
        await _planRepository.getSearchPlans({'name': searchTerm});
    if (result.type == ApiResultType.success) {
      result.data.forEach((element) {
        plans.add(Plan.fromJson(element));
      });
      plansNumberOfResults = result.numberOfResults;
      plansPageNumber++;
    }
  }

  onTrainerSearch() {
    selectedIndex = 0;
  }

  onPlanSearch() {
    selectedIndex = 1;
  }

  addPlanToFavorite(int index) async {
    log(index.toString());
    final temp = plans[index];
    temp.isBookMarked = !temp.isBookMarked!;
    _plans.removeAt(index);
    _plans.refresh();
    _plans.insert(index, temp);
    _plans.refresh();
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
