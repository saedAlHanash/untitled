part of 'plans_cubit.dart';

class PlansInitial extends AbstractState<List<Plan>> {
  const PlansInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory PlansInitial.initial() {
    return const PlansInitial(
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

  PlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    dynamic request,
  }) {
    return PlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
