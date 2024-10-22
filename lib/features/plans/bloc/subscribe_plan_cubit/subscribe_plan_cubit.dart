import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/chat_service/chat_service_core.dart';
import '../../../../services/chat_service/core/firebase_chat_core.dart';
import '../active_plans_cubit/active_plans_cubit.dart';

part 'subscribe_plan_state.dart';

class SubscribePlanCubit extends Cubit<SubscribePlanInitial> {
  SubscribePlanCubit() : super(SubscribePlanInitial.initial());

  Future<void> subscribe({required int planId}) async {
    emit(state.copyWith(request: planId, statuses: CubitStatuses.loading));

    final pair = await _subscribe();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      if (state.error.startsWith('451')) {
        AwesomeDialog(
          context: ctx!,
          dialogType: DialogType.warning,
          animType: AnimType.scale,
          title: 'oops',
          desc: state.error.replaceAll('451', ''),
        ).show();
        return;
      }
      showErrorFromApi(state);
    } else {
      sl<AnalyticService>().subscribePlan(pair.first!);
      await createRoomWithTrainer();

      await AppSharedPreference.setCurrentPlanId(planId.toString());

      NoteMessage.showSnakeBar(message: 'successfully_subscribed'.tr, context: ctx!);

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
    final response =
        await APIService().callApi(type: ApiType.post, url: PostUrl.subscribePlan, body: {
      "plan_id": state.request.toString(),
    });

    if (response.statusCode.success) {
      ctx?.readOrNull<ActivePlansCubit>()?.getActivePlans(newData: true);

      await AppSharedPreference.setCurrentPlanId(state.request);

      return Pair(Plan.fromJson(response.jsonBody), null);
    } else {
      if (response.statusCode == 451 && !AppControl.isAppleAccount) {
        Get.toNamed(AppRoutes.subscriptionScreen);
        return Pair(null, '451${ErrorManager.getApiError(response)}');
      }
      return response.getPairError;
    }
  }
}
