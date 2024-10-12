part of 'booked_appointments_cubit.dart';

class BookedAppointmentsInitial extends AbstractState<List<Appointment>> {
  final int trainerId;
  final List<Appointment> old;
  final List<Appointment> next;

  final Pair<Appointment?, PrivetSessionState> activeSession;

  const BookedAppointmentsInitial({
    required super.result,
    super.error,
    required this.trainerId,
    required this.activeSession,
    required this.old,
    required this.next,
    super.statuses,
  });

  factory BookedAppointmentsInitial.initial() {
    return  BookedAppointmentsInitial(
      result: [],
      old: [],
      next: [],
      error: '',
      trainerId: 0,
      activeSession: Pair(null,PrivetSessionState.noEver),
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
    Pair<Appointment?, PrivetSessionState>? activeSession,
  }) {
    return BookedAppointmentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      old: old ?? this.old,
      next: next ?? this.next,
      error: error ?? this.error,
      trainerId: trainerId ?? this.trainerId,
      activeSession: activeSession ?? this.activeSession,
    );
  }

}
