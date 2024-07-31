part of 'training_cubit.dart';

class TrainingInitial extends AbstractState<PlanWorkout> {
  const TrainingInitial({
    required super.result,
    super.error,
    required super.request,
    // required this.trainingParam,
    super.statuses,
  });

  factory TrainingInitial.initial() {
    return TrainingInitial(
      result: PlanWorkout.fromJson({}),
      error: '',
      // trainingParam: false,
      request: '',
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

  TrainingInitial copyWith({
    CubitStatuses? statuses,
    PlanWorkout? result,
    String? error,
    String? request,
    // bool? trainingParam,
  }) {
    return TrainingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // trainingParam: trainingParam ?? this.trainingParam,
    );
  }
}
