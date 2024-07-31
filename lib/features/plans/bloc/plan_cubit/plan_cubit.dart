import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/change_video_cubit/change_video_cubit.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

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
    pausePlayer();
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

  Future<void> setVideoController(PodPlayerController videoController) async {
    state.videoController?.dispose();
    emit(state.copyWith(videoController: videoController));
  }

  startTraining(PlanWorkout planWorkout, int i) async {
    Utils.openLoadingDialog();
    final apiResult =
        await ExerciseRepository().startDay(planWorkout.id.toString());

    if ((AppProvider.isTrainer) ||
        apiResult.type == ApiResultType.success ||
        apiResult.statusCode == 402 ||
        apiResult.statusCode == 451) {
      Get.back();
      pausePlayer();
      Get.toNamed(AppRoutes.userTraining, arguments: [
        i + 1,
        planWorkout.name,
        planWorkout.workoutId.toString(),
        planWorkout.id.toString(),
        (planWorkout.type == 'Loop All'),
        planWorkout.type,
        planWorkout.count.toInt(),
        planWorkout.workoutBreak.toInt(),
        apiResult.statusCode == 402
      ]);
      // Future.delayed(
      //   const Duration(seconds: 1),
      //   () => ctx?.readOrNull<ChangeVideoCubit>()?.changeVideo(),
      // );
      Utils.closeDialog();
    }
  }

  void pausePlayer() {
    if (state.videoController == null) {
      Future.delayed(
        const Duration(seconds: 3),
        pausePlayer,
      );
      return;
    }
    state.videoController
      ?..pause()
      ..setAutoPlay = false;
  }
}
