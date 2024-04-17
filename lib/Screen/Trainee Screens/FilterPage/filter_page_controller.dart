import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:get/get.dart';

class FilterPageController extends GetxController {
  late final List<String> trainingTypes;
  final RxList<bool> trainingTypesControllers = <bool>[].obs;

  final RxBool _advancedController = false.obs;
  final RxBool _beginnerController = false.obs;
  final RxMap<String, String> _data = <String, String>{}.obs;
  final RxBool _gymController = false.obs;
  final RxBool _homeController = false.obs;
  final RxBool _intermediateController = false.obs;
  final RxString _trainingLevel = ''.obs;
  final RxString _trainingLoactionType = ''.obs;
  final RxString _trainingType = ''.obs;

  @override
  void onInit() {
    trainingTypes = [
      'Weightlifting',
      'BodyWeight',
      'HIIT Training',
      'Strength Training',
      'Functional Training',
      'Mobility Training',
      'Sports Training',
      'Dynamic Training',
      'Follow Along',
      'Bodybuilding',
      'Prenatal Training',
      'Hands-Free',
      'Pilates',
    ];
    trainingTypesControllers.value =
        List.filled(trainingTypes.length, false, growable: true);
    data = {
      'training_location_type': '',
      'training_type': '',
      'training_level': '',
      'total_weeks': ''
    };
    super.onInit();
  }

  bool get homeController => _homeController.value;

  bool get gymController => _gymController.value;

  bool get beginnerController => _beginnerController.value;

  bool get intermediateController => _intermediateController.value;

  bool get advancedController => _advancedController.value;

  String get trainingLoactionType => _trainingLoactionType.value;

  String get trainingType => _trainingType.value;

  String get trainingLevel => _trainingLevel.value;

  Map<String, String> get data => _data;

  set homeController(value) => _homeController.value = value;

  set gymController(value) => _gymController.value = value;

  set beginnerController(value) => _beginnerController.value = value;

  set intermediateController(value) => _intermediateController.value = value;

  set advancedController(value) => _advancedController.value = value;

  set trainingLoactionType(value) => _trainingLoactionType.value = value;

  set trainingType(value) => _trainingType.value = value;

  set trainingLevel(value) => _trainingLevel.value = value;

  set data(value) => _data.value = value;

  resetAllFilter() {
    trainingTypesControllers.value =
        List.filled(trainingTypes.length, false, growable: true);
    homeController = false;
    gymController = false;
    beginnerController = false;
    intermediateController = false;
    advancedController = false;
    for (int i = 0; i < trainingTypesControllers.length; i++) {
      trainingTypesControllers[i] = false;
    }
    data = {
      'training_location_type': '',
      'training_type': '',
      'training_level': '',
      'total_weeks': ''
    };
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
      trainingLevel = 'intermediate';
      beginnerController = false;
      advancedController = false;
    } else {
      trainingLevel = '';
    }
  }

  void toggleAdvanced() {
    advancedController = !advancedController;
    if (advancedController) {
      trainingLevel = 'advanced';
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

  void result() {
    data['training_location_type'] = trainingLoactionType;
    data['training_type'] = trainingType;
    data['training_level'] = trainingLevel;
    // data['total_weeks']
    Get.toNamed(AppRoutes.filterResult, arguments: data);
  }
}
