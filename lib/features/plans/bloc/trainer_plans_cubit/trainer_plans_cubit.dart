import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'trainer_plans_state.dart';

class TrainerPlansCubit extends Cubit<TrainerPlansInitial> {
  TrainerPlansCubit() : super(TrainerPlansInitial.initial());

  Future<void> getPlans({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.data));
    }
  }

  Future<Pair<Plans?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.trainerPlans(state.id),
    );

    if (response.statusCode.success) {
      return Pair(Plans.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
