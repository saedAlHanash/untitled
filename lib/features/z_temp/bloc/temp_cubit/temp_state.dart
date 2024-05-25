part of 'temp_cubit.dart';

class TempInitial extends AbstractCubit<Temp> {
  // final TempRequest request;
  // final bool tempParam;

  const TempInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });

  factory TempInitial.initial() {
    return TempInitial(
      result: Temp.fromJson({}),
      error: '',
      // tempParam: false,
      // request: TempRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TempInitial copyWith({
    CubitStatuses? statuses,
    Temp? result,
    String? error,
    // TempRequest? request,
    // bool? tempParam,
  }) {
    return TempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
