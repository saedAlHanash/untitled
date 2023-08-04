 

import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Model/plan.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/app_controller.dart';
import '../FeaturedPlan/featured_plan_controller.dart';
import 'Widget/Filter/filter_sheet_widget.dart';
import 'Widget/Sort/sort_bottom_sheet.dart';

class BookmarkedScreenController extends GetxController {
  final RxList<Plan> _plans = <Plan>[].obs;
  final RxInt _selectedIndex = (-1).obs;
  final RxBool _isLoading = false.obs;
  final RxList<bool> _sortFilterControllers = <bool>[].obs;
  final RxList<bool> _trainingTypesControllers = <bool>[].obs;
  final RxMap<String, dynamic> _data = <String, dynamic>{}.obs;
  final RxString _trainingLoactionType = ''.obs;
  final RxString _trainingType = ''.obs;
  final RxString _trainingLevel = ''.obs;
  final RxString _sortFilter = ''.obs;

  final RxBool _homeController = false.obs;
  final RxBool _gymController = false.obs;
  final RxBool _beginnerController = false.obs;
  final RxBool _intermediateController = false.obs;
  final RxBool _advancedController = false.obs;

  int get selectedIndex => _selectedIndex.value;

  bool get isLoading => _isLoading.value;

  String get trainingLoactionType => _trainingLoactionType.value;

  String get trainingType => _trainingType.value;

  String get trainingLevel => _trainingLevel.value;

  String get sortFilter => _sortFilter.value;

  Map<String, dynamic> get data => _data;

  List<Plan> get plans => _plans;

  List<bool> get sortFilterControllers => _sortFilterControllers;

  List<bool> get trainingTypesControllers => _trainingTypesControllers;

  bool get homeController => _homeController.value;

  bool get gymController => _gymController.value;

  bool get beginnerController => _beginnerController.value;

  bool get intermediateController => _intermediateController.value;

  bool get advancedController => _advancedController.value;

  set selectedIndex(value) => _selectedIndex.value = value;

  set isLoading(value) => _isLoading.value = value;

  set data(value) => _data.value = value;

  set plans(value) => _plans.value = value;

  set sortFilterControllers(value) => _sortFilterControllers.value = value;

  set trainingTypesControllers(value) =>
      _trainingTypesControllers.value = value;

  set trainingLoactionType(value) => _trainingLoactionType.value = value;

  set trainingType(value) => _trainingType.value = value;

  set trainingLevel(value) => _trainingLevel.value = value;

  set homeController(value) => _homeController.value = value;

  set gymController(value) => _gymController.value = value;

  set beginnerController(value) => _beginnerController.value = value;

  set intermediateController(value) => _intermediateController.value = value;

  set advancedController(value) => _advancedController.value = value;

  set sortFilter(value) => _sortFilter.value = value;

  PlanRepository planRepository = PlanRepository();
  final TextEditingController searchTerm = TextEditingController();
  late final List<String> sortFilterTypes;
  late final Map<String, String> sortByKeys;
  late final List<String> trainingTypes;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
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
      'Alphabetical A-Z',
      'Alphabetical Z-A',
      'Most Popular',
      'Playing Days (more first)',
      'Playing Days (less first)'
    ];
    sortByKeys = {
      'Alphabetical A-Z': 'aToz',
      'Alphabetical Z-A': 'zToa',
      'Most Popular': '',
      'Playing Days (more first)': 'play_days_more_first',
      'Playing Days (less first)': 'play_days_less_first'
    };

    trainingTypesControllers =
        List.filled(trainingTypes.length, false, growable: true);
    sortFilterControllers =
        List.filled(sortFilterTypes.length, false, growable: true);
    await getBookmarkedPlan();
    isLoading = false;
  }

  getBookmarkedPlan() async {
    final result = await planRepository.getAllBookmarked();
    if (result.isNotEmpty) {
      plans.addAll(result);
    }
  }

  void searchBottomSheet(bool isTrainer) {
    Utils.openSearchSheet(search, searchTerm, isTrainer);
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
    await getSearchResultPlans();
    isLoading = false;
  }

  Future<void> filterBottomSheet() async {
    var appController = Get.put(AppController());
    var filterContoller = Get.put(FeaturedPlanController());
    filterContoller.trainingTypesControllers.value =
        List.filled(appController.trainingTypes.length, false, growable: true);
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

    // Get.bottomSheet(
    //   FilterSheetWidget(onTap: filter),
    //   elevation: 10,
    //   enterBottomSheetDuration: const Duration(seconds: 1),
    // );
  }

  void sortBottomSheet() {
    Get.bottomSheet(
      SortBottomSheet(onTap: sort),
      elevation: 10,
      // enterBottomSheetDuration: const Duration(seconds: 1),
    );
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
    _sortFilterControllers.refresh();
  }

  getSearchResultPlans() async {
    List<Plan> result =
        await planRepository.getTrendingPlan({'name': searchTerm.text});
   //log('congrats $result');
    plans = <Plan>[].obs;
    for (var element in result) {
      plans.add(element);
    }
  }

  getSortResultPlans() async {
    List<Plan> result = [];
    for (int i = 0; i < sortFilterControllers.length; i++) {
      if (sortFilterControllers[i]) {
       //log('true ${sortFilterTypes[i]}');
        if (sortFilterTypes[i].isEmpty) {
          result = await planRepository.getTrendingPlan({});
        } else {
          result = await planRepository
              .getTrendingPlan({'sortBy': sortByKeys[sortFilterTypes[i]]});
        }
      }
    }
   //log('congrats $result');
    plans = <Plan>[].obs;
    for (var element in result) {
      plans.add(element);
    }
  }

  getFilterResultPlans() async {
    List<Plan> result = [];
   //log(data.toString());
    result = await planRepository.getTrendingPlan(data);
   //log('congrats $result');
    plans = <Plan>[].obs;
    for (var element in result) {
      plans.add(element);
    }
  }

  void toggleHome() {
    homeController = !homeController;
    if (homeController) {
      trainingLoactionType = 'Home';
      gymController = false;
    } else {
      trainingLoactionType = '';
    }
  }

  void toggleGym() {
    gymController = !gymController;
    if (gymController) {
      trainingLoactionType = 'Gym';
      homeController = false;
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
    _trainingTypesControllers.refresh();
  }

  void resetFilter() {
    trainingLoactionType = '';
    trainingType = '';
    trainingLevel = '';
    gymController = false;
    homeController = false;
    beginnerController = false;
    intermediateController = false;
    advancedController = false;
    for (int i = 0; i < trainingTypesControllers.length; i++) {
      trainingTypesControllers[i] = false;
    }
  }

  void result() {
    if (trainingLoactionType.isNotEmpty) {
      data['training_location_type[0]'] = trainingLoactionType.toLowerCase();
    }
    if (trainingType.isNotEmpty) {
      data['training_type[0]'] = trainingType;
    }
    if (trainingLevel.isNotEmpty) {
      data['training_level[0]'] = trainingLevel;
    }
   //log(data.toString());
  }

  addPlanToFavorite(int index) async {
   //log(index.toString());
    final temp = plans[index];
    temp.isBookMarked = !temp.isBookMarked!;
    plans.removeAt(index);
    _plans.refresh();
    plans.insert(index, temp);
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
