part of 'booked_appointments_cubit.dart';

class BookedAppointmentsInitial extends AbstractCubit<List<Appointment>> {
  final int trainerId;
  final List<Appointment> old;
  final List<Appointment> next;

  const BookedAppointmentsInitial({
    required super.result,
    super.error,
    required this.trainerId,
    required this.old,
    required this.next,
    super.statuses,
  });

  factory BookedAppointmentsInitial.initial() {
    return const BookedAppointmentsInitial(
      result: [],
      old: [],
      next: [],
      error: '',
      trainerId: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BookedAppointmentsInitial copyWith({
    CubitStatuses? statuses,
    List<Appointment>? result,
    List<Appointment>? old,
    List<Appointment>? next,
    String? error,
    int? trainerId,
  }) {
    return BookedAppointmentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      old: old ?? this.old,
      next: next ?? this.next,
      error: error ?? this.error,
      trainerId: trainerId ?? this.trainerId,
    );
  }

  Pair<Appointment?, PrivetSessionState> getSession() {
    if (result.isEmpty) {
      return Pair(null, PrivetSessionState.noEver);
    } else {
      var list = result;

      list.sort((a, b) => a.startTime.compareTo(b.startTime));

      final dateTimeNow = DateTime.now();

      for (var e in list) {
        if (!e.isNow) continue;

        return Pair(e, PrivetSessionState.active);
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
