import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'booked_appointments_state.dart';

class BookedAppointmentsCubit extends Cubit<BookedAppointmentsInitial> {
  BookedAppointmentsCubit() : super(BookedAppointmentsInitial.initial());

  Future<void> getBookedAppointments({required int trainerId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, trainerId: trainerId));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.data));
    }
  }

  Future<Pair<BookedAppointments?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.bookedAppointments,
      query: {
        'trainer_id': state.trainerId,
      },
    );

    if (response.statusCode.success) {
      return Pair(BookedAppointments.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
