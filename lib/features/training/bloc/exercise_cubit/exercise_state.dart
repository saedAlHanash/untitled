part of 'exercise_cubit.dart';

class ExercisesInitial extends AbstractState<List<Exercise>> {
  const ExercisesInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory ExercisesInitial.initial() {
    return const ExercisesInitial(
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

  ExercisesInitial copyWith({
    CubitStatuses? statuses,
    List<Exercise>? result,
    String? error,
    dynamic request,
  }) {
    return ExercisesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
