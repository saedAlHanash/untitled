part of 'booked_appointments_cubit.dart';

class BookedAppointmentsInitial extends AbstractCubit<List<Appointments>> {
  // final LoginRequest request;
  const BookedAppointmentsInitial({
    required super.result,
    super.error,
    // required this.request,
    super.statuses,
  });

  factory BookedAppointmentsInitial.initial() {
    return const BookedAppointmentsInitial(
      result: [],
      error: '',
      // request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BookedAppointmentsInitial copyWith({
    CubitStatuses? statuses,
    List<Appointments>? result,
    String? error,
    // LoginRequest? request,
  }) {
    return BookedAppointmentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
    );
  }

  Pair<Appointments?, PrivetSessionState> getSession(int trainerId) {
    if (result.isEmpty) {
      return Pair(null, PrivetSessionState.noEver);
    } else {
      var list = <Appointments>[];

      for (var e in result) {
        if (e.trainer.id == trainerId) list.add(e);
      }

      if (list.isEmpty) return Pair(null, PrivetSessionState.noEver);

      list.sort((a, b) => a.startTime.compareTo(b.startTime));

      final dateTimeNow = DateTime.now().subtract(DateTime.now().timeZoneOffset);

      for (var e in list) {

        final b = dateTimeNow.isAfter(e.startTime);
        final a = dateTimeNow.isBefore(e.endTime);

        if (b && a) {
          return Pair(e, PrivetSessionState.active);
        } else {
          continue;
        }
      }

      if (dateTimeNow.isBefore(list.last.startTime)) {
        return Pair(
          list.firstWhere((e) => dateTimeNow.isBefore(e.startTime)),
          PrivetSessionState.waiting,
        );
      }

      return Pair(null, PrivetSessionState.needBooking);
    }
  }
}
