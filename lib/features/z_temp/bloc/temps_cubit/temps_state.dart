part of 'temps_cubit.dart';

class TempsInitial extends AbstractCubit<List<Temp>> {
  // final TempRequest request;
  // final  bool tempParam;
  const TempsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });//

  factory TempsInitial.initial() {
    return const TempsInitial(
      result: [],
      error: '',
      // tempParam: false,
      // request: TempRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TempsInitial copyWith({
    CubitStatuses? statuses,
    List<Temp>? result,
    String? error,
    // TempRequest? request,
    // bool? tempParam,
  }) {
    return TempsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
