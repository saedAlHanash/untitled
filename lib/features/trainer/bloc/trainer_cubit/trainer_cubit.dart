import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'trainer_state.dart';

class TrainerCubit extends Cubit<TrainerInitial> {
  TrainerCubit() : super(TrainerInitial.initial());

  Future<void> getTrainer({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      sl<FirebaseAnalyticService>().trainingProfileView(trainer: pair.first!);
    }
  }

  Future<Pair<TrainerModel?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(type: ApiType.get,
      url: GetUrl.getTrainer,
      path: state.id.toString(),
    );

    if (response.statusCode.success) {
      return Pair(TrainerModel.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
