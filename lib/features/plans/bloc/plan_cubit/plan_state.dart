part of 'plan_cubit.dart';

class PlanInitial extends AbstractState<Plan> {
  const PlanInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  Plan get mRequest => request;

  factory PlanInitial.initial() {
    return PlanInitial(
      result: Plan.fromJson({}),
      error: '',
      // tempParam: false,
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

  PlanInitial copyWith({
    CubitStatuses? statuses,
    Plan? result,
    String? error,
    Plan? request,
    // bool? tempParam,
  }) {
    return PlanInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
