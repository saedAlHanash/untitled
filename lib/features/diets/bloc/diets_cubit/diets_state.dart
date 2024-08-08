part of 'diets_cubit.dart';

class DietsInitial extends AbstractState<List<Diet>> {
  const DietsInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory DietsInitial.initial() {
    return const DietsInitial(
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

  DietsInitial copyWith({
    CubitStatuses? statuses,
    List<Diet>? result,
    String? error,
    dynamic request,
  }) {
    return DietsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
