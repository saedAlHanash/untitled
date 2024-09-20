import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/reating_request.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingInitial> {
  RatingCubit() : super(RatingInitial.initial());

  Future<void> rate({required RatingRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.rate,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
