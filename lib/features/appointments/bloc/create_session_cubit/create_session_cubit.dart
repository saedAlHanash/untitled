import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'create_session_state.dart';

class CreateSessionCubit extends Cubit<CreateSessionInitial> {
  CreateSessionCubit() : super(CreateSessionInitial.initial());

  Future<void> createSession({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().postApi(
      url: PostUrl.createSession,
      query: {'trainer_time_id': state.id},
    );

    if (response.statusCode.success) {
      return Pair(response.jsonBodyPure['url'] ?? '', null);
    } else {
      return response.getPairError;
    }
  }
}
