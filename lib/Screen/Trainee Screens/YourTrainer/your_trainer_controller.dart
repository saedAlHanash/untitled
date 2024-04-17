import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Utils/utils.dart';
import 'Widget/Filter/filter_sheet_widget.dart';
import 'Widget/Sort/sort_bottom_sheet.dart';

class YourTrainerController extends GetxController {
  final RxBool _alphabeticalAZ = false.obs;
  final RxBool _alphabeticalZA = false.obs;
  final RxBool _mostPopular = false.obs;
  final RxBool _playingDaysMoreFirst = false.obs;
  final RxBool _playingDaysLessFirst = false.obs;
  final RxString _sortFilter = ''.obs;
  final RxList<bool> sortFilterControllers = <bool>[].obs;
  late final List<String> sortFilterTypes;

  bool get alphabeticalAZ => _alphabeticalAZ.value;

  bool get alphabeticalZA => _alphabeticalZA.value;

  bool get mostPopular => _mostPopular.value;

  bool get playingDaysMoreFirst => _playingDaysMoreFirst.value;

  bool get playingDaysLessFirst => _playingDaysLessFirst.value;

  String get sortFilter => _sortFilter.value;

  set alphabeticalAZ(value) => _alphabeticalAZ.value = value;

  set alphabeticalZA(value) => _alphabeticalZA.value = value;

  set mostPopular(value) => _mostPopular.value = value;

  set playingDaysMoreFirst(value) => _playingDaysMoreFirst.value = value;

  set playingDaysLessFirst(value) => _playingDaysLessFirst.value = value;

  set sortFilter(value) => _sortFilter.value = value;

  //Filter Controller
  final RxBool _publicController = false.obs;
  final RxBool _privateController = false.obs;
  final RxBool _beginnerController = false.obs;
  final RxBool _intermediateController = false.obs;
  final RxBool _advancedController = false.obs;
  final RxString _trainerType = ''.obs;
  final RxString _trainingType = ''.obs;
  final RxString _trainingLevel = ''.obs;
  final RxMap<String, dynamic> _data = <String, dynamic>{}.obs;

  late final List<String> trainingTypes;
  late final Map<String, String> sortByKeys;
  final RxList<bool> trainingTypesControllers = <bool>[].obs;

  bool get publicController => _publicController.value;

  bool get privateController => _privateController.value;

  bool get beginnerController => _beginnerController.value;

  bool get intermediateController => _intermediateController.value;

  bool get advancedController => _advancedController.value;

  String get trainerType => _trainerType.value;

  String get trainingType => _trainingType.value;

  String get trainingLevel => _trainingLevel.value;

  Map<String, dynamic> get data => _data;

  set publicController(value) => _publicController.value = value;

  set privateController(value) => _privateController.value = value;

  set beginnerController(value) => _beginnerController.value = value;

  set intermediateController(value) => _intermediateController.value = value;

  set advancedController(value) => _advancedController.value = value;

  set trainingLoactionType(value) => _trainerType.value = value;

  set trainingType(value) => _trainingType.value = value;

  set trainingLevel(value) => _trainingLevel.value = value;

  set data(value) => _data.value = value;

  RxList<TrainerModel> trainers = <TrainerModel>[].obs;
  final RxInt pageNumber = 2.obs;
  final Rx<RefreshController> refreshController = RefreshController().obs;
  final RxInt _selectedIndex = 5.obs;
  final RxBool _isLoading = false.obs;

  int get selectedIndex => _selectedIndex.value;

  bool get isLoading => _isLoading.value;

  set selectedIndex(value) => _selectedIndex.value = value;

  set isLoading(value) => _isLoading.value = value;

  final TextEditingController searchTerm = TextEditingController();
  final TrainerRepository _trainerRepository = TrainerRepository();

  @override
  void onInit() async {
    trainers.value = Get.arguments;
    trainingTypes = [
      'Weightlifting',
      'Body Weight',
      'HIIT Training',
      'Strength Training',
      'Functional Training',
      'Mobility Training',
      'Sports Training',
      'Dynamic Training',
      'Follow Along',
      'Body Building',
      'Prenatal Training',
      'Hands-Free',
      'Pilates',
    ];
    sortFilterTypes = [
      'Alphabetical_A-Z'.tr,
      'Alphabetical_Z-A'.tr,
      'Most_Popular'.tr,
      'PlayingـDaysـ(more first)'.tr,
      'PlayingـDaysـ(less first)'.tr
    ];
    sortByKeys = {
      'Alphabetical A-Z': 'aToz',
      'Alphabetical Z-A': 'zToa',
      'Most Popular': '',
      'Playing Days (more first)': 'play_days_more_first',
      'Playing Days (less first)': 'play_days_less_first'
    };

    trainingTypesControllers.value =
        List.filled(trainingTypes.length, false, growable: true);
    sortFilterControllers.value =
        List.filled(sortFilterTypes.length, false, growable: true);
    super.onInit();
  }

  onLoading() async {
    ApiResult result = await _trainerRepository.getSearchTrainer(pageNumber.value, data);
    if (result.type == ApiResultType.success) {
      if (result.data.isNotEmpty) {
        trainers.addAll(result.data);
        refreshController.value.loadComplete();
        pageNumber.value++;
      } else {
        // trainers.value.addAll(temp);
        refreshController.value.loadNoData();
      }
    }
  }

  void toggleSortFilter(int index) {
    for (int i = 0; i < sortFilterControllers.length; i++) {
      if (i == index) {
        //log('sdsds');

        sortFilterControllers[index] = !sortFilterControllers[index];
        if (sortFilterControllers[index]) {
          sortFilter = sortFilterTypes[index];
        } else {
          sortFilter = '';
        }
      } else {
        sortFilterControllers[i] = false;
      }
    }
    sortFilterControllers.refresh();
  }

  void searchBottomSheet(bool aboutTrainer) {
    Utils.openSearchSheet(search, searchTerm, aboutTrainer);
  }

  Future<void> filterBottomSheet() async {
    await showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: Get.context!,
        elevation: 20,
        isDismissible: false,
        backgroundColor: Colors.white.withOpacity(0),
        builder: (BuildContext bc) {
          return FilterSheetWidget(
            onTap: filter,
            resetFilters: resetFilter,
          );
        });
  }

  void sortBottomSheet() {
    Get.bottomSheet(
      SortBottomSheet(onTap: sort),
      elevation: 10,
      // enterBottomSheetDuration: const Duration(seconds: 1),
    );
  }

  Future<void> sort() async {
    selectedIndex = 2;
    Get.back();
    //log('sort');
    isLoading = true;
    await getSortResultPlans();
    isLoading = false;
  }

  Future<void> filter() async {
    selectedIndex = 1;
    Get.back();
    //log('filter');
    result();
    isLoading = true;
    await getFilterResultPlans();
    isLoading = false;
  }

  Future<void> search() async {
    selectedIndex = 0;
    Get.back();
    //log('search');
    isLoading = true;
    await getSearchResultTrainer();
    isLoading = false;
  }

  getSearchResultTrainer() async {
    pageNumber.value = 1;
    ApiResult result = await _trainerRepository
        .getSearchTrainer(pageNumber.value, {'name': searchTerm.text});
    if (result.type == ApiResultType.success) {
      //log('congrats $result');
      trainers = <TrainerModel>[].obs;
      for (var element in result.data) {
        trainers.add(TrainerModel.fromJson(element));
      }
    }
  }

  getSortResultPlans() async {
    pageNumber.value = 1;
    Map<String, dynamic> data = {};
    ApiResult? apiResult;
    for (int i = 0; i < sortFilterControllers.length; i++) {
      if (sortFilterControllers[i]) {
        //log('true ${sortFilterTypes[i]}');
        if (sortFilterTypes[i].isEmpty) {
          data = {};
        } else {
          data = {'sortBy': sortByKeys[sortFilterTypes[i]]};
        }
        apiResult = await _trainerRepository.getSearchTrainer(pageNumber.value, data);
      }
    }
    //log('congrats ${apiResult!.data}');
    trainers = <TrainerModel>[].obs;
    for (var element in apiResult!.data) {
      trainers.add(TrainerModel.fromJson(element));
    }
  }

  getFilterResultPlans() async {
    pageNumber.value = 1;
    //log(data.toString());
    ApiResult apiResult =
        await _trainerRepository.getSearchTrainer(pageNumber.value, data);
    if (apiResult.type == ApiResultType.success) {
      //log('congrats ${apiResult.data}');
      trainers = <TrainerModel>[].obs;
      for (var element in apiResult.data) {
        trainers.add(TrainerModel.fromJson(element));
      }
    }
  }

  void togglePublic() {
    publicController = !publicController;
    if (publicController) {
      trainingLoactionType = 'Public';
      privateController = false;
    } else {
      trainingLoactionType = '';
    }
  }

  void togglePrivate() {
    privateController = !privateController;
    if (privateController) {
      trainingLoactionType = 'Private';
      publicController = false;
    } else {
      trainingLoactionType = '';
    }
  }

  void toggleBeginner() {
    beginnerController = !beginnerController;
    if (beginnerController) {
      trainingLevel = 'Beginner';
      intermediateController = false;
      advancedController = false;
    } else {
      trainingLevel = '';
    }
  }

  void toggleIntermediate() {
    intermediateController = !intermediateController;
    if (intermediateController) {
      trainingLevel = 'Intermediate';
      beginnerController = false;
      advancedController = false;
    } else {
      trainingLevel = '';
    }
  }

  void toggleAdvanced() {
    advancedController = !advancedController;
    if (advancedController) {
      trainingLevel = 'Advanced';
      beginnerController = false;
      intermediateController = false;
    } else {
      trainingLevel = '';
    }
  }

  void toggleTrainingType(int index) {
    for (int i = 0; i < trainingTypesControllers.length; i++) {
      if (i == index) {
        trainingTypesControllers[index] = !trainingTypesControllers[index];
        if (trainingTypesControllers[index]) {
          trainingType = trainingTypes[index];
        } else {
          trainingType = '';
        }
      } else {
        trainingTypesControllers[i] = false;
      }
    }
    trainingTypesControllers.refresh();
  }

  void resetFilter() {
    trainingLoactionType = '';
    trainingType = '';
    trainingLevel = '';
    publicController = false;
    privateController = false;
    beginnerController = false;
    intermediateController = false;
    advancedController = false;
    for (int i = 0; i < trainingTypesControllers.length; i++) {
      trainingTypesControllers[i] = false;
    }
  }

  void result() {
    if (trainerType.isNotEmpty) {
      //TODO this is trainer type not trainingLocation
      data['training_location_type[0]'] = trainerType;
    }
    if (trainingType.isNotEmpty) {
      data['training_type[0]'] = trainingType;
    }
    if (trainingLevel.isNotEmpty) {
      data['training_level[0]'] = trainingLevel;
    }
    //log(data.toString());
  }
}
