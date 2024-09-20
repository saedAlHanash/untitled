import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';
import '../../../trainer/data/response/trainer.dart';
import '../../data/request/available_times_request.dart';
import '../../data/response/available_times_response.dart';

part 'available_times_state.dart';

class AvailableTimesCubit extends Cubit<AvailableTimesInitial> {
  AvailableTimesCubit() : super(AvailableTimesInitial.initial());

  Future<void> getAvailableTimes({
    TrainerModel? trainer,
    AvailableTimesRequest? request,
  }) async {
    emit(
      state.copyWith(
        statuses: CubitStatuses.loading,
        trainer: trainer,
        request: request,
      ),
    );
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first,
          events: _getMapEvent(pair.first!),
        ),
      );
      sl<AnalyticService>().trainingSessionView(
        trainer: state.trainer,
        numberOfAvailable: state.result.length,
      );
    }
  }

  Future<Pair<List<Appointment>?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(
        type: ApiType.get,
        url: GetUrl.availableTimes(state.trainer.id),
        query: state.request.toJson(),
        header: innerHeader..addAll({'lang': 'en'}));

    if (response.statusCode.success) {
      final model = AvailableTimesResponse.fromJson(response.jsonBody).getAllTimes
        ..removeWhere(
          (e) {
            return e.startTime.isBefore(DateTime.now());
          },
        );

      return Pair(model, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> getTrainerAvailableTimes({AvailableTimesRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _getTrainerAvailableTimes();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first,
          events: _getMapEvent(pair.first!),
        ),
      );
    }
  }

  Future<Pair<List<Appointment>?, String?>> _getTrainerAvailableTimes() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.availableTimesTrainer,
      query: state.request.toJson(),
    );

    if (response.statusCode.success) {
      final model = AvailableTimesResponseList.fromJson(response.jsonBodyPure).data
        ..removeWhere(
          (e) {
            return e.startTime.isBefore(DateTime.now());
          },
        );
      return Pair(model, null);
    } else {
      return response.getPairError;
    }
  }

  Map<int, List<Appointment>> _getMapEvent(List<Appointment> list) {
    var map = <int, List<Appointment>>{};
    for (var e in list) {
      var key = e.startTime.hashDate ?? 0;

      if (map[key] == null) {
        map[key] = [e];
      } else {
        map[key]?.add(e);
      }
    }
    return map;
  }
}
