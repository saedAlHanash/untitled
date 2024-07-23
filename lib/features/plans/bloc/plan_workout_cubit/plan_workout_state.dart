part of 'plan_workout_cubit.dart';

class PlanWorkoutsInitial extends AbstractState<List<PlanWorkout>> {
  const PlanWorkoutsInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory PlanWorkoutsInitial.initial() {
    return const PlanWorkoutsInitial(
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

  PlanWorkoutsInitial copyWith({
    CubitStatuses? statuses,
    List<PlanWorkout>? result,
    String? error,
    dynamic request,
  }) {
    return PlanWorkoutsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
