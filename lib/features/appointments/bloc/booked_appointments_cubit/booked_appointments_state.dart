part of 'booked_appointments_cubit.dart';

class BookedAppointmentsInitial extends AbstractCubit<List<Appointments>> {
  final int trainerId;
  const BookedAppointmentsInitial({
    required super.result,
    super.error,
    required this.trainerId,
    super.statuses,
  });

  factory BookedAppointmentsInitial.initial() {
    return const BookedAppointmentsInitial(
      result: [],
      error: '',
      trainerId: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BookedAppointmentsInitial copyWith({
    CubitStatuses? statuses,
    List<Appointments>? result,
    String? error,
    int? trainerId,
  }) {
    return BookedAppointmentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      trainerId: trainerId ?? this.trainerId,
    );
  }

  Pair<Appointments?, PrivetSessionState> getSession() {
    if (result.isEmpty) {
      return Pair(null, PrivetSessionState.noEver);
    } else {
      var list = result;

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
