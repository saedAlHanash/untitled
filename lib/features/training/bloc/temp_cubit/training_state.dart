part of 'training_cubit.dart';

class TrainingInitial extends AbstractState<PlanWorkout> {
  final int changeModifier;
  const TrainingInitial({
    required super.result,
    super.error,
    required super.request,
    required this.changeModifier,
    // required this.trainingParam,
    super.statuses,
  });

  factory TrainingInitial.initial() {
    return TrainingInitial(
      result: PlanWorkout.fromJson({}),
      error: '',
      changeModifier: 0,
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
    changeModifier,
    if (request != null) request,
   
  ];

  TrainingInitial copyWith({
    CubitStatuses? statuses,
    PlanWorkout? result,
    String? error,
    String? request,
    int? changeModifier,
    // bool? trainingParam,
  }) {
    return TrainingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      changeModifier: changeModifier ?? this.changeModifier,
      // trainingParam: trainingParam ?? this.trainingParam,
    );
  }
}
