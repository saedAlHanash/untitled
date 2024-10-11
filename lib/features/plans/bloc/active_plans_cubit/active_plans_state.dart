part of 'active_plans_cubit.dart';

class ActivePlansInitial extends AbstractState<List<Plan>> {
  const ActivePlansInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory ActivePlansInitial.initial() {
    return const ActivePlansInitial(
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

  ActivePlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    dynamic request,
  }) {
    return ActivePlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
