part of 'bookmarked_cubit.dart';

class BookmarkedInitial extends AbstractCubit<List<PlanModel>> {
  // final BookmarkedRequest request;
  // final  bool tempParam;
  const BookmarkedInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });//

  factory BookmarkedInitial.initial() {
    return const BookmarkedInitial(
      result: [],
      error: '',
      // tempParam: false,
      // request: BookmarkedRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BookmarkedInitial copyWith({
    CubitStatuses? statuses,
    List<PlanModel>? result,
    String? error,
    // BookmarkedRequest? request,
    // bool? tempParam,
  }) {
    return BookmarkedInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
