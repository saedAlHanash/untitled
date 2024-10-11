part of 'trending_plans_cubit.dart';

class TrendingPlansInitial extends AbstractState<List<Plan>> {
  const TrendingPlansInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory TrendingPlansInitial.initial() {
    return const TrendingPlansInitial(
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

  TrendingPlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    dynamic request,
  }) {
    return TrendingPlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
