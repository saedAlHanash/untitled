import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_diet_state.dart';

class DeleteDietCubit extends Cubit<DeleteDietInitial> {
  DeleteDietCubit() : super(DeleteDietInitial.initial());

  Future<void> deleteDiet({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: id));

    final pair = await _deleteDietApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteDietApi() async {
    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteDiet,
      query: {'id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
