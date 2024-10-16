import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'add_time_state.dart';

class AddTimeCubit extends Cubit<AddTimeInitial> {
  AddTimeCubit() : super(AddTimeInitial.initial());

  Future<void> addTime({required DateTime request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _addTimeApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  void setDateTime(DateTime request) {
    emit(state.copyWith(request: request));
  }

  Future<Pair<bool?, String?>> _addTimeApi() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.addTime,
      body: {
        'start_time': state.request.toUtc().formatDateAther,
        'end_time': state.request.toUtc().addFromNow(hour: 1).formatDateAther,
      },
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
