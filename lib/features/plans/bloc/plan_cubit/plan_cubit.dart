import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:get/get.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Data/Repositories/exercise_repository.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/plan_workout_response.dart';

part 'plan_state.dart';

class PlanCubit extends MCubit<PlanInitial> {
  PlanCubit() : super(PlanInitial.initial());

  @override
  String get nameCache => 'plan';

  @override
  String get filter => state.request?.toString() ?? '';

  Future<void> getPlan({bool newData = false, int? planId}) async {
    emit(state.copyWith(request: planId));
    final checkData = await checkCashed1(
        state: state, fromJson: Plan.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getPlan();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Plan?, String?>> _getPlan() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.plan,
      path: state.request.toString(),
    );

    if (response.statusCode.success) {
      return Pair(Plan.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }


  startTraining(PlanWorkout planWorkout, int i) async {

    Utils.openLoadingDialog();

    final apiResult =
        await ExerciseRepository().startDay(planWorkout.id.toString());


    if (apiResult.statusCode == 451 && !AppControl.isAppleAccount) {
      Get.toNamed(AppRoutes.subscriptionScreen);
      AwesomeDialog(
        context: ctx!,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: 'oops',
        desc: state.error.replaceAll('451', ''),
      ).show();
      return;
    }

    if ((AppProvider.isTrainer) ||
        apiResult.type == ApiResultType.success ||
        apiResult.statusCode == 402) {

      Get.back();

      startTrainingPage(planWorkout, apiResult.statusCode == 402);

      // Get.toNamed(AppRoutes.userTraining, arguments: [
      //   i + 1,
      //   planWorkout.name,
      //   planWorkout.workoutId.toString(),
      //   planWorkout.id.toString(),
      //   (planWorkout.type == 'Loop All'),
      //   planWorkout.type,
      //   planWorkout.count.toInt(),
      //   planWorkout.workoutBreak.toInt(),
      //   apiResult.statusCode == 402
      // ]);
      // Future.delayed(
      //   const Duration(seconds: 1),
      //   () => ctx?.readOrNull<ChangeVideoCubit>()?.changeVideo(),
      // );
      Utils.closeDialog();
    }
  }

}
