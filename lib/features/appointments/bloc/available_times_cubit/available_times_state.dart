part of 'available_times_cubit.dart';

class AvailableTimesInitial extends AbstractState<List<Appointment>> {
  final AvailableTimesRequest request;
  final Map<int, List<Appointment>> events;

  final TrainerModel trainer;

  const AvailableTimesInitial({
    required super.result,
    required this.request,
    required this.trainer,
    required this.events,
    super.error,
    super.statuses,
  });

  factory AvailableTimesInitial.initial() {
    return AvailableTimesInitial(
      result: const [],
      error: '',
      events: const {},
      trainer: TrainerModel.fromJson({}),
      request: AvailableTimesRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AvailableTimesInitial copyWith({
    CubitStatuses? statuses,
    List<Appointment>? result,
    String? error,
    AvailableTimesRequest? request,
    Map<int, List<Appointment>>? events,
    TrainerModel? trainer,
  }) {
    return AvailableTimesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      trainer: trainer ?? this.trainer,
      events: events ?? this.events,
    );
  }
}
