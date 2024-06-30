import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/exercise_repository.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Data/Repositories/trainee_repository.dart';
import 'package:fitness_storm/Data/Repositories/workout_repository.dart';
import 'package:fitness_storm/Model/plan_workout.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/helperClass.dart';
import 'package:fitness_storm/services/chat_service/chat_service_core.dart';
import 'package:fitness_storm/services/chat_service/core/firebase_chat_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pod_player/pod_player.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../core/app/app_provider.dart';
import '../../../core/models/plan_model.dart';
import '../HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';

class PlanOverviewController extends GetxController {
  late String id;
  late final List<GlobalKey> keys;
  late String nameWorkout;
  RxList<WorkoutModel> planWorkouts = <WorkoutModel>[].obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();

  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  final RxBool _isActivated = true.obs;
  final RxBool _isLoading = false.obs;
  final Rx<PlanModel> _planOverview = PlanModel.fromJson({}).obs;
  final PlanRepository _planRepository = PlanRepository();
  final TraineeRepository _traineeRepository = TraineeRepository();
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  PodPlayerController? videoController;

  @override
  Future<void> onInit() async {
    super.onInit();
    // if (ConstantData.idPlan != null) {
    //   id = ConstantData.idPlan!;
    // } else {
    id = (Get.arguments ?? '').toString();
    // }

    //log('plan overview id ${id}');
    isLoading = true;
    planOverview = await _planRepository.getPlanOverview(id);
    planWorkouts.value = await _workoutRepository.getPlanWorkout(id);
    keys = List.generate(planWorkouts.length, (i) => GlobalKey());
    isActivated = planOverview.isActive;

    isLoading = false;
  }

  bool get isActivated => _isActivated.value;

  bool get isLoading => _isLoading.value;

  PlanModel get planOverview => _planOverview.value;

  set isActivated(value) => _isActivated.value = value;

  set isLoading(value) => _isLoading.value = value;

  set planOverview(value) => _planOverview.value = value;

  subscribeToPlan() async {
    Utils.openLoadingDialog();
    var response = await _traineeRepository.subscribePlan(
        planId: planOverview.id.toString());
    if (response.type == ApiResultType.success) {
      try {
        final chatUser = await ChatServiceCore.getUser(
          planOverview.trainer.id.toString(),
          trainer: planOverview.trainer,
        );

        if (chatUser != null) {
          await FirebaseChatCore.instance.createRoom(chatUser);
        }
      } catch (e) {
        loggerObject.e(e);
      }

      Utils.closeDialog();
      GetStorage getStorage = GetStorage();
      await getStorage.write('currentPlan', planOverview.name);
      Utils.openSnackBar(
          title: 'successfully_subscribed'.tr,
          message: 'enjoy_your_fitness_storm'.tr,
          second: 5);
      // Get.offAllNamed(AppRoutes.mainHome);
      Get.context?.read<RefreshHomePlanCubit>().refresh();
      Get.offNamed(AppRoutes.planOverview, arguments: id);
      isActivated = true;
    } else {
      if (response.statusCode == 451) {
        Utils.closeDialog();
        if (AppControl.isAppleAccount) return;
        videoController?.pause();
        Get.toNamed(AppRoutes.subscriptionScreen)!.then((value) async {
          if (HelperClass.successfullySubscription) {
            Utils.openLoadingDialog();
            var response = await _traineeRepository.subscribePlan(planId: id);

            if (response.type == ApiResultType.success) {
              Utils.closeDialog();
              GetStorage getStorage = GetStorage();
              await getStorage.write('currentPlan', planOverview.name);
              Utils.openSnackBar(
                  title: 'Successfully subscribed!',
                  message: 'enjoy_your_fitness_storm'.tr,
                  second: 5);
              // Get.offAllNamed(AppRoutes.mainHome);
              Get.context?.read<RefreshHomePlanCubit>().refresh();
              Get.offNamed(AppRoutes.planOverview, arguments: id);
              isActivated = true;
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

  startTraining(int i) async {
    Utils.openLoadingDialog();
    final apiResult = await _exerciseRepository.startDay(planWorkouts[i].id!);

    if ((AppProvider.isTrainer) ||
        apiResult.type == ApiResultType.success ||
        apiResult.statusCode == 402) {
      Get.back();
      Get.delete<UserTrainingController>();
      videoController?.pause();
      Get.toNamed(AppRoutes.userTraining, arguments: [
        i + 1,
        planWorkouts[i].name,
        planWorkouts[i].workoutId,
        planWorkouts[i].id!,
        (planWorkouts[i].type == 'Loop All'),
        planWorkouts[i].type!,
        planWorkouts[i].count,
        planWorkouts[i].break_after_set,
        apiResult.statusCode == 402
      ]);
    } else {
      Utils.closeDialog();
      if (apiResult.statusCode == 401) {
        GetStorage getStorage = GetStorage();
        String? prevPlan = getStorage.read('currentPlan');
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
