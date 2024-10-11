part of 'free_plans_cubit.dart';

class FreePlansInitial extends AbstractState<List<Plan>> {
  const FreePlansInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory FreePlansInitial.initial() {
    return const FreePlansInitial(
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

  FreePlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    dynamic request,
  }) {
    return FreePlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
