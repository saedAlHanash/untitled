part of 'diet_cubit.dart';

class DietInitial extends AbstractState<Diet> {
  const DietInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory DietInitial.initial() {
    return DietInitial(
      result: Diet.fromJson({}),
      error: '',
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

  DietInitial copyWith({
    CubitStatuses? statuses,
    Diet? result,
    String? error,
    String? request,
  }) {
    return DietInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
