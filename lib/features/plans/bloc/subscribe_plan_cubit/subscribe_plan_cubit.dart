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

part 'subscribe_plan_state.dart';

class SubscribePlanCubit extends Cubit<SubscribePlanInitial> {
  SubscribePlanCubit() : super(SubscribePlanInitial.initial());

  Future<void> subscribe({required int planId}) async {
    emit(state.copyWith(request: planId, statuses: CubitStatuses.loading));
    final pair = await _subscribe();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));

      showErrorFromApi(state);
    } else {
      createRoomWithTrainer();
      GetStorage getStorage = GetStorage();

      await getStorage.write('currentPlan', planId);

      Utils.openSnackBar(
          title: 'successfully_subscribed'.tr,
          message: 'enjoy_your_fitness_storm'.tr,
          second: 5);

      Get.context?.read<RefreshHomePlanCubit>().refresh();

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<void> createRoomWithTrainer() async {
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
  }

  Future<Pair<Plan?, String?>> _subscribe() async {
    final response = await APIService()
        .callApi(type: ApiType.post, url: PostUrl.subscribePlan, body: {
      "plan_id": state.request.toString(),
    });

    if (response.statusCode.success) {
      return Pair(Plan.fromJson(response.jsonBody), null);
    } else {
      if (response.statusCode == 451 && !AppControl.isAppleAccount) {}
      return response.getPairError;
    }
  }
}
