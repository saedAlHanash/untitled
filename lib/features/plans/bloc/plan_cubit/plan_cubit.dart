import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Data/Repositories/exercise_repository.dart';
import '../../../../Data/Repositories/trainee_repository.dart';
import '../../../../Screen/Trainee Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../helperClass.dart';
import '../../../../services/chat_service/chat_service_core.dart';
import '../../../../services/chat_service/core/firebase_chat_core.dart';
import '../../data/response/plan_workout_response.dart';

part 'plan_state.dart';

class PlanCubit extends MCubit<PlanInitial> {
  PlanCubit() : super(PlanInitial.initial());

  @override
  String get nameCache => 'plan';

  @override
  String get filter => state.request?.toString() ?? '';

  Future<void> getPlan({bool newData = false, required int planId}) async {
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

  void setVideoController(PodPlayerController videoController) {
    emit(state.copyWith(videoController: videoController));
  }

  subscribeToPlan() async {
    Utils.openLoadingDialog();
    var response = await TraineeRepository()
        .subscribePlan(planId: state.request.toString());
    if (response.type == ApiResultType.success) {
      try {
        final chatUser = await ChatServiceCore.getUser(
          state.result.trainer.id.toString(),
          trainer: state.result.trainer,
        );

        if (chatUser != null) {
          await FirebaseChatCore.instance.createRoom(chatUser);
        }
      } catch (e) {
        loggerObject.e(e);
      }

      Utils.closeDialog();
      GetStorage getStorage = GetStorage();
      await getStorage.write('currentPlan', state.result.name);
      Utils.openSnackBar(
          title: 'successfully_subscribed'.tr,
          message: 'enjoy_your_fitness_storm'.tr,
          second: 5);
      // Get.offAllNamed(AppRoutes.mainHome);
      Get.context?.read<RefreshHomePlanCubit>().refresh();
      Get.back();
      startPlanPage(state.result.id.toString());
    } else {
      if (response.statusCode == 451) {
        Utils.closeDialog();
        if (AppControl.isAppleAccount) return;
        state.videoController?.pause();
        Get.toNamed(AppRoutes.subscriptionScreen)!.then((value) async {
          if (HelperClass.successfullySubscription) {
            Utils.openLoadingDialog();
            var response = await TraineeRepository()
                .subscribePlan(planId: state.result.id.toString());

            if (response.type == ApiResultType.success) {
              Utils.closeDialog();
              GetStorage getStorage = GetStorage();
              await getStorage.write('currentPlan', state.result.name);
              Utils.openSnackBar(
                  title: 'Successfully subscribed!',
                  message: 'enjoy_your_fitness_storm'.tr,
                  second: 5);
              // Get.offAllNamed(AppRoutes.mainHome);
              Get.context?.read<RefreshHomePlanCubit>().refresh();
              Get.back();
              startPlanPage(state.result.id.toString());
            } else {
              Utils.closeDialog();
            }
          } else {
            Utils.openSnackBar(
              title: 'not_successfully_subscription'.tr,
              message: "not_complete_process_payment".tr,
            );
          }
        });
      } else {
        Utils.openSnackBar(title: response.message!);
      }
    }
  }

  startTraining(PlanWorkout planWorkout, int i) async {
    Utils.openLoadingDialog();
    final apiResult =
        await ExerciseRepository().startDay(planWorkout.id.toString());

    if ((AppProvider.isTrainer) ||
        apiResult.type == ApiResultType.success ||
        apiResult.statusCode == 402) {
      Get.back();
      state.videoController?.pause();
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
    } else {
      Utils.closeDialog();
      if (apiResult.statusCode == 401) {
        String? prevPlan = GetStorage().read('currentPlan');
        if (prevPlan != null) {
          Utils.showAlertDialog(subscribeToPlan,
              '''${'Your_subscription_to_plan'.tr} $prevPlan''');
        } else {
          Utils.showAlertDialog(() {}, apiResult.message!,
              textContinue: 'okay'.tr);
        }
      } else if (apiResult.statusCode == 451) {
        if (AppControl.isAppleAccount) return;

        Get.toNamed(AppRoutes.subscriptionScreen);
      } else if (apiResult.statusCode == 402) {
        //TODO: saed see mahmood form server to fix it
        Utils.showAlertDialog(() {}, "finished_this_day".tr,
            textContinue: 'okay'.tr);
      }
    }
  }
}
