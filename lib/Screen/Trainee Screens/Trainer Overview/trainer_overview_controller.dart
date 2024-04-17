// import 'package:fitness_storm/Data/Api/api_result.dart';
// import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
// import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
// import 'package:get/get.dart';
//
// import '../../../Model/plan.dart';
// import '../../../Model/trainer.dart';
// import '../../../core/models/plan_model.dart';
//
// class TrainerOverviewController extends GetxController {
//   final RxBool _isLoading = false.obs;
//   final RxBool _isvisible = true.obs;
//   final Rx<TrainerModel> _trainer = TrainerModel.fromJson({}).obs;
//   final RxList<PlanModel> _trainerPlans = <PlanModel>[].obs;
//   final TrainerRepository _trainerRepository = TrainerRepository();
//
//   @override
//   Future<void> onInit() async {
//     String id = Get.arguments;
//     isLoading = true;
//     trainer = await _trainerRepository.getTrainerById(id);
//     // if (trainer == null) {}
//     trainerPlans = await _trainerRepository.getTrainerPlans(id);
//     isLoading = false;
//     super.onInit();
//   }
//
//   TrainerModel get trainer => _trainer.value;
//
//   List<PlanModel> get trainerPlans => _trainerPlans;
//
//   bool get isLoading => _isLoading.value;
//
//   bool get isVisible => _isvisible.value;
//
//   set trainer(value) => _trainer.value = value;
//
//   set trainerPlans(value) => _trainerPlans.value = value;
//
//   set isLoading(value) => _isLoading.value = value;
//
//   set isVisible(value) => _isvisible.value = value;
//
//   addPlanToFavorite(int index) async {
//     // //log(index.toString());
//     // final temp = _trainerPlans[index];
//     // temp.isBookMark = !temp.isBookMark!;
//     // _trainerPlans.removeAt(index);
//     // _trainerPlans.refresh();
//     // _trainerPlans.insert(index, temp);
//     // _trainerPlans.refresh();
//     // await addToBookmark(temp.id!, !temp.isBookMark!);
//   }
//
//   addToBookmark(String id, bool isBookMark) async {
//     PlanRepository planRepository = PlanRepository();
//     isBookMark = !isBookMark;
//     if (!isBookMark) {
//       ApiResult apiResult = await planRepository.removeFromBookmark(id);
//       if (apiResult.type == ApiResultType.success) {
//         // Utils.openSnackBar(message: 'Success');
//       }
//     } else {
//       ApiResult apiResult = await planRepository.addToBookmark(id);
//       if (apiResult.type == ApiResultType.success) {
//         // Utils.openSnackBar(message: 'Success');
//       }
//     }
//   }
// }
