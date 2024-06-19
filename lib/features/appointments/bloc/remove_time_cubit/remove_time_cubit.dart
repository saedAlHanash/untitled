import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'remove_time_state.dart';

class RemoveTimeCubit extends Cubit<RemoveTimeInitial> {
  RemoveTimeCubit() : super(RemoveTimeInitial.initial());

  Future<void> removeTime({required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _removeApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _removeApi() async {
    final response = await APIService().callApi(type: ApiType.delete,
      url: DeleteUrl.removeTime,
      path: state.id.toString(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
