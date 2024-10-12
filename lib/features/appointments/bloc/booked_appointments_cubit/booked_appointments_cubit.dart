import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'booked_appointments_state.dart';

class BookedAppointmentsCubit extends Cubit<BookedAppointmentsInitial> {
  BookedAppointmentsCubit() : super(BookedAppointmentsInitial.initial());

  Future<void> getBookedAppointments({int? trainerId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, trainerId: trainerId));

    final pair = await _bookedAppointmentsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {

      var list = pair.first!.data;
      var serverTime = pair.first!.serverTime;

      final old = <Appointment>[];
      final next = <Appointment>[];

      for (var e in list) {
        if (serverTime.isAfter(e.endTime)) {
          old.add(e);
        } else {
          next.add(e);
        }
      }

      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first?.data,
          next: next,
          old: old,
          activeSession: _getSession(serverTime),
        ),
      );
    }
  }

  Future<Pair<BookedAppointments?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.bookedAppointments,
      query: (state.trainerId != 0)
          ? {
              'trainer_id': state.trainerId,
            }
          : null,
    );

    if (response.statusCode.success) {
      return Pair(
          BookedAppointments.fromJson(response.jsonBodyPure, response.serverTime), null);
    } else {
      return response.getPairError;
    }
  }

 Pair<Appointment?, PrivetSessionState> _getSession(DateTime serverTime)  {
    if (state.result.isEmpty) {
      return Pair(null, PrivetSessionState.noEver);
    } else {

      var list = state.result;

      list.sort((a, b) => a.startTime.compareTo(b.startTime));

      for (var e in list) {
        if (!e.isNow) continue;

        return Pair(e, PrivetSessionState.active);
      }

      if (serverTime.isBefore(list.last.startTime)) {
        return Pair(
          list.firstWhere((e) => serverTime.isBefore(e.startTime)),
          PrivetSessionState.waiting,
        );
      }

      return Pair(null, PrivetSessionState.needBooking);
    }
  }
}
