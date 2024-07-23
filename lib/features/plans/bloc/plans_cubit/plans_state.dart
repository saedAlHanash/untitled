part of 'plans_cubit.dart';

class PlansInitial extends AbstractState<List<Plan>> {
  // final PlansRequest request;
  final int id;

  const PlansInitial({
    required super.result,
    super.error,
    // required this.request,
    required this.id,
    super.statuses,
  });

  factory PlansInitial.initial() {
    return const PlansInitial(
      result: [],
      error: '',
      id: 0,
      // request: PlansRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  PlansInitial copyWith({
    CubitStatuses? statuses,
    List<Plan>? result,
    String? error,
    // PlansRequest? request,
    int? id,
  }) {
    return PlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      id: id ?? this.id,
    );
  }
}
