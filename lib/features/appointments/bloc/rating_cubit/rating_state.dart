part of 'rating_cubit.dart';

class RatingInitial extends AbstractState<bool> {
  final RatingRequest request;

  // final bool tempParam;

  const RatingInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.tempParam,
    super.statuses,
  });

  factory RatingInitial.initial() {
    return RatingInitial(
      result: false,
      error: '',
      // tempParam: false,
      request: RatingRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RatingInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    RatingRequest? request,
    // bool? tempParam,
  }) {
    return RatingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
