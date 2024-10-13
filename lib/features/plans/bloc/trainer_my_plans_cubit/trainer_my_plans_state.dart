part of 'trainer_my_plans_cubit.dart';

class TrainerMyPlansInitial extends AbstractState<List<Plan>> {
  const TrainerMyPlansInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory TrainerMyPlansInitial.initial() {
    return const TrainerMyPlansInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
      ];

  TrainerMyPlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    dynamic request,
  }) {
    return TrainerMyPlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
