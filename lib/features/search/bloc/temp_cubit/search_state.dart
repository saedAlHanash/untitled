part of 'search_cubit.dart';

class SearchInitial extends AbstractState<List<TrainerModel>> {
  const SearchInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  });

  TrainerFilter get mRequest => request as TrainerFilter;

  factory SearchInitial.initial() {
    return const SearchInitial(
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

  SearchInitial copyWith({
    CubitStatuses? statuses,
    List<TrainerModel>? result,
    String? error,
    TrainerFilter? request,
  }) {
    return SearchInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
