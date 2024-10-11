part of 'trainer_plans_cubit.dart';

class TrainerPlansInitial extends AbstractState<List<Plan>> {
  // final PlansRequest request;
  final int id;

  const TrainerPlansInitial({
    required super.result,
    super.error,
    // required this.request,
    required this.id,
    super.statuses,
  });

  factory TrainerPlansInitial.initial() {
    return const TrainerPlansInitial(
      result: [],
      error: '',
      id: 0,
      // request: PlansRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TrainerPlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    // PlansRequest? request,
    int? id,
  }) {
    return TrainerPlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      id: id ?? this.id,
    );
  }
}
